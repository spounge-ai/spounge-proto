#!/usr/bin/env node
const fs = require('fs');
const path = require('path');

// Define paths for the root package.json, generated TypeScript directory, and the new package.json.
const rootPkgPath = path.resolve(__dirname, '../package.json');
const tsGenDir = path.resolve(__dirname, '../gen/ts');
const tsPkgPath = path.join(tsGenDir, 'package.json');

/**
 * Loads the root package.json file.
 * @returns {object} The parsed content of the root package.json.
 */
function loadRootPackage() {
  try {
    return JSON.parse(fs.readFileSync(rootPkgPath, 'utf-8'));
  } catch (err) {
    console.error('Error reading root package.json:', err);
    process.exit(1); // Exit if the root package.json cannot be read.
  }
}

/**
 * Gets a list of top-level directories within the generated TypeScript directory.
 * @param {string} genDir - The path to the generated TypeScript directory.
 * @returns {string[]} An array of directory names.
 */
function getGeneratedDirectories(genDir) {
  try {
    // Read directory contents and filter for directories.
    return fs.readdirSync(genDir, { withFileTypes: true })
      .filter(dirent => dirent.isDirectory())
      .map(dirent => dirent.name);
  } catch (err) {
    console.warn('Could not read generated directories:', err.message);
    return []; // Return an empty array if the directory cannot be read.
  }
}

/**
 * Generates the content for the package.json file for the generated TypeScript code.
 * This includes basic package metadata and dependencies.
 * @param {object} rootPkg - The parsed content of the root package.json.
 * @returns {object} The generated package.json content.
 */
function generateTsPackage(rootPkg) {
  const generatedDirs = getGeneratedDirectories(tsGenDir);
  
  return {
    // Set the package name, appending '-ts' to the root package name or using a default.
    name: rootPkg.name ? rootPkg.name + '-ts' : '@spounge/proto-ts',
    version: rootPkg.version || '1.0.0', // Inherit version or default.
    description: 'TypeScript protobuf generated code for Spounge',
    main: './index.js', // Main entry point for JavaScript.
    types: './index.d.ts', // Main entry point for TypeScript declarations.
    sideEffects: false, // Indicates that this package has no side effects (good for tree-shaking).
    private: false, // Make the package public by default.
    files: [
      '*.js', 
      '*.d.ts', 
      ...generatedDirs, // Dynamically include all top-level generated directories.
    ].filter((item, index, arr) => arr.indexOf(item) === index), // Remove any duplicate entries.
    dependencies: {
      // Define protobuf and Connect-RPC related runtime dependencies.
      // Prioritize versions from the root package.json if available, otherwise use defaults.
      '@bufbuild/protobuf': rootPkg.dependencies?.['@bufbuild/protobuf'] || '^2.6.0',
      '@connectrpc/connect': rootPkg.dependencies?.['@connectrpc/connect'] || '^2.0.2',
      '@connectrpc/connect-web': rootPkg.dependencies?.['@connectrpc/connect-web'] || '^2.0.2',
      // Keep legacy dependencies for compatibility if needed.
      protobufjs: rootPkg.dependencies?.protobufjs || '^7.2.5',
      long: rootPkg.dependencies?.long || '^5.2.3',
      rxjs: rootPkg.dependencies?.rxjs || '^7.8.2',
    },
    devDependencies: {
      // Define development dependencies, primarily for TypeScript compilation and protobuf generation.
      typescript: rootPkg.devDependencies?.typescript || '^5.0.0',
      '@types/node': rootPkg.devDependencies?.['@types/node'] || '^20.0.0',
      '@bufbuild/protoc-gen-es': rootPkg.devDependencies?.['@bufbuild/protoc-gen-es'] || '2.6.0',
    },
    scripts: {
      build: 'tsc', // Standard build script using TypeScript compiler.
      test: 'echo "Error: no test specified" && exit 1' // Placeholder test script.
    },
    repository: rootPkg.repository, // Inherit repository info.
    author: rootPkg.author, // Inherit author info.
    license: rootPkg.license || 'MIT', // Inherit license or default to MIT.
    publishConfig: {
      access: 'public' // Ensure the package can be published publicly.
    }
  };
}

/**
 * Writes the generated package.json content to a file.
 * @param {object} pkg - The package.json content to write.
 * @param {string} filePath - The path where the package.json should be written.
 */
function writeTsPackage(pkg, filePath) {
  try {
    // Ensure the target directory exists, creating it recursively if necessary.
    const dir = path.dirname(filePath);
    if (!fs.existsSync(dir)) {
      fs.mkdirSync(dir, { recursive: true });
    }
    
    // Write the package.json content, formatted with 2-space indentation.
    fs.writeFileSync(filePath, JSON.stringify(pkg, null, 2) + '\n', 'utf-8');
    console.log('✅ Generated:', filePath);
  } catch (err) {
    console.error('Error writing package.json:', err);
    process.exit(1); // Exit if writing fails.
  }
}

/**
 * Generates the tsconfig.json file for the generated TypeScript code.
 * This configures the TypeScript compiler settings.
 */
function generateTsConfig() {
  const tsConfigPath = path.join(tsGenDir, 'tsconfig.json');
  const tsConfig = {
    compilerOptions: {
      target: 'ES2020', // Target ECMAScript 2020.
      module: 'commonjs', // Use CommonJS module system.
      lib: ['ES2020'], // Include ES2020 library types.
      declaration: true, // Generate declaration files (.d.ts).
      outDir: '.', // Output files to the current directory.
      rootDir: '.', // Root directory for source files.
      strict: true, // Enable all strict type-checking options.
      esModuleInterop: true, // Enable interoperability between CommonJS and ES modules.
      skipLibCheck: true, // Skip type checking of declaration files.
      forceConsistentCasingInFileNames: true, // Ensure consistent file casing.
      moduleResolution: 'node', // Use Node.js module resolution strategy.
      allowSyntheticDefaultImports: true, // Allow synthetic default imports.
      // Add path resolution for Google API types if needed.
      baseUrl: '.',
      paths: {
        'google/*': ['google/*']
      }
    },
    include: ['**/*.ts'], // Include all .ts files.
    exclude: ['node_modules', '**/*.test.ts'] // Exclude node_modules and test files.
  };
  
  try {
    // Write the tsconfig.json content, formatted with 2-space indentation.
    fs.writeFileSync(tsConfigPath, JSON.stringify(tsConfig, null, 2) + '\n', 'utf-8');
    console.log('✅ Generated:', tsConfigPath);
  } catch (err) {
    console.error('Error writing tsconfig.json:', err);
  }
}

// The `generateIndexFile` function has been removed from this script.
// Its functionality is now solely handled by the `ts_imports_script` (bash script),
// which provides more robust and conflict-aware index file generation.

// Main execution flow of the script.
const rootPkg = loadRootPackage(); // Load the root package.json.
const tsPkg = generateTsPackage(rootPkg); // Generate the new package.json content.
writeTsPackage(tsPkg, tsPkgPath); // Write the generated package.json file.
generateTsConfig(); // Generate the tsconfig.json file.

// The call to generateIndexFile() has been removed.
