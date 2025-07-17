#!/usr/bin/env node
const fs = require('fs');
const path = require('path');

const rootPkgPath = path.resolve(__dirname, '../package.json');
const tsGenDir = path.resolve(__dirname, '../gen/ts');
const tsPkgPath = path.join(tsGenDir, 'package.json');

function loadRootPackage() {
  try {
    return JSON.parse(fs.readFileSync(rootPkgPath, 'utf-8'));
  } catch (err) {
    console.error('Error reading root package.json:', err);
    process.exit(1);
  }
}

function getGeneratedDirectories(genDir) {
  try {
    return fs.readdirSync(genDir, { withFileTypes: true })
      .filter(dirent => dirent.isDirectory())
      .map(dirent => dirent.name);
  } catch (err) {
    console.warn('Could not read generated directories:', err.message);
    return [];
  }
}

function generateTsPackage(rootPkg) {
  const generatedDirs = getGeneratedDirectories(tsGenDir);
  
  return {
    name: rootPkg.name ? rootPkg.name + '-ts' : '@spounge/proto-ts',
    version: rootPkg.version || '1.0.0',
    description: 'TypeScript protobuf generated code for Spounge',
    main: './index.js',
    types: './index.d.ts',
    sideEffects: false,
    private: false,
    files: [
      '*.js', 
      '*.d.ts', 
      ...generatedDirs,
      // Common proto directories
      'common',
      'google',  // Important: include google directory for API annotations
      'api',
      'v1'
    ].filter((item, index, arr) => arr.indexOf(item) === index), // Remove duplicates
    dependencies: {
      '@bufbuild/protobuf': rootPkg.dependencies?.['@bufbuild/protobuf'] || '^1.4.2',
      '@connectrpc/connect': rootPkg.dependencies?.['@connectrpc/connect'] || '^1.1.4',
      '@connectrpc/connect-web': rootPkg.dependencies?.['@connectrpc/connect-web'] || '^1.1.4',
      // Keep legacy dependencies for compatibility
      protobufjs: rootPkg.dependencies?.protobufjs || '^7.2.5',
      long: rootPkg.dependencies?.long || '^5.2.3',
      rxjs: rootPkg.dependencies?.rxjs || '^7.8.2',
    },
    devDependencies: {
      typescript: rootPkg.devDependencies?.typescript || '^5.0.0',
      '@types/node': rootPkg.devDependencies?.['@types/node'] || '^20.0.0',
      '@bufbuild/protoc-gen-es': rootPkg.devDependencies?.['@bufbuild/protoc-gen-es'] || '^2.6.0',
    },
    scripts: {
      build: 'tsc',
      test: 'echo "Error: no test specified" && exit 1'
    },
    repository: rootPkg.repository,
    author: rootPkg.author,
    license: rootPkg.license || 'MIT',
    publishConfig: {
      access: 'public'
    }
  };
}

function writeTsPackage(pkg, filePath) {
  try {
    // Ensure directory exists
    const dir = path.dirname(filePath);
    if (!fs.existsSync(dir)) {
      fs.mkdirSync(dir, { recursive: true });
    }
    
    fs.writeFileSync(filePath, JSON.stringify(pkg, null, 2) + '\n', 'utf-8');
    console.log('✅ Generated:', filePath);
  } catch (err) {
    console.error('Error writing package.json:', err);
    process.exit(1);
  }
}

function generateTsConfig() {
  const tsConfigPath = path.join(tsGenDir, 'tsconfig.json');
  const tsConfig = {
    compilerOptions: {
      target: 'ES2020',
      module: 'commonjs',
      lib: ['ES2020'],
      declaration: true,
      outDir: '.',
      rootDir: '.',
      strict: true,
      esModuleInterop: true,
      skipLibCheck: true,
      forceConsistentCasingInFileNames: true,
      moduleResolution: 'node',
      allowSyntheticDefaultImports: true,
      // Add resolution for Google API types
      baseUrl: '.',
      paths: {
        'google/*': ['google/*']
      }
    },
    include: ['**/*.ts'],
    exclude: ['node_modules', '**/*.test.ts']
  };
  
  try {
    fs.writeFileSync(tsConfigPath, JSON.stringify(tsConfig, null, 2) + '\n', 'utf-8');
    console.log('✅ Generated:', tsConfigPath);
  } catch (err) {
    console.error('Error writing tsconfig.json:', err);
  }
}

function fileExists(filePath) {
  try {
    return fs.existsSync(filePath);
  } catch (err) {
    return false;
  }
}

function generateIndexFile() {
  const indexPath = path.join(tsGenDir, 'index.ts');
  const generatedDirs = getGeneratedDirectories(tsGenDir);
  
  let indexContent = '// Auto-generated index file\n\n';
  
  // Handle conflicts by using namespace exports for Google
  const hasCommon = generatedDirs.includes('common');
  const hasGoogle = generatedDirs.includes('google');
  
  if (hasCommon && hasGoogle) {
    indexContent += '// Export common types first (takes precedence)\n';
    indexContent += `export * from './common';\n\n`;
    
    indexContent += '// Export Google types under namespace to avoid conflicts\n';
    indexContent += `export * as Google from './google';\n\n`;
    
    // Export other directories normally
    generatedDirs.forEach(dir => {
      if (dir !== 'common' && dir !== 'google') {
        indexContent += `export * from './${dir}';\n`;
      }
    });
  } else {
    // Generate exports for each directory normally
    generatedDirs.forEach(dir => {
      const dirPath = path.join(tsGenDir, dir);
      try {
        const files = fs.readdirSync(dirPath, { withFileTypes: true });
        
        // Check if directory has an index file or direct exports
        const hasIndex = fileExists(path.join(dirPath, 'index.ts'));
        
        if (hasIndex) {
          indexContent += `export * from './${dir}';\n`;
        } else {
          // Handle nested directories (like v1 subdirectories)
          files.forEach(file => {
            if (file.isDirectory()) {
              const subDirPath = path.join(dirPath, file.name);
              try {
                const subFiles = fs.readdirSync(subDirPath)
                  .filter(subFile => subFile.endsWith('.ts') && !subFile.endsWith('.d.ts'))
                  .map(subFile => subFile.replace('.ts', ''));
                
                subFiles.forEach(subFile => {
                  if (fileExists(path.join(subDirPath, subFile + '.ts'))) {
                    indexContent += `export * from './${dir}/${file.name}/${subFile}';\n`;
                  }
                });
              } catch (err) {
                console.warn(`Could not read subdirectory ${dir}/${file.name}:`, err.message);
              }
            } else if (file.name.endsWith('.ts') && !file.name.endsWith('.d.ts')) {
              const fileName = file.name.replace('.ts', '');
              indexContent += `export * from './${dir}/${fileName}';\n`;
            }
          });
        }
      } catch (err) {
        console.warn(`Could not read directory ${dir}:`, err.message);
      }
    });
  }
  
  try {
    fs.writeFileSync(indexPath, indexContent, 'utf-8');
    console.log('✅ Generated:', indexPath);
  } catch (err) {
    console.error('Error writing index.ts:', err);
  }
}

// Main execution
const rootPkg = loadRootPackage();
const tsPkg = generateTsPackage(rootPkg);
writeTsPackage(tsPkg, tsPkgPath);
generateTsConfig();
generateIndexFile();