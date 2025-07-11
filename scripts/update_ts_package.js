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

function generateTsPackage(rootPkg) {
  return {
    name: rootPkg.name ? rootPkg.name + '-ts' : '@spounge/proto-ts',
    version: rootPkg.version || '1.0.0',
    main: './index.js',
    types: './index.d.ts',
    sideEffects: false,
    private: false,
    files: ['*.js', '*.d.ts', 'common', 'google', 'polykey'],
    dependencies: {
      protobufjs: rootPkg.dependencies?.protobufjs || '^7.2.5',
      long: rootPkg.dependencies?.long || '^5.2.3',
      rxjs: rootPkg.dependencies?.rxjs || '^7.8.2',
    },
  };
}

function writeTsPackage(pkg, filePath) {
  try {
    fs.writeFileSync(filePath, JSON.stringify(pkg, null, 2) + '\n', 'utf-8');
    console.log('✅ Generated:', filePath);
  } catch (err) {
    console.error('Error writing package.json:', err);
    process.exit(1);
  }
}

const rootPkg = loadRootPackage();
const tsPkg = generateTsPackage(rootPkg);
writeTsPackage(tsPkg, tsPkgPath);
