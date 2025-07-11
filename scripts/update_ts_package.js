#!/usr/bin/env node
const fs = require('fs');
const path = require('path');

const rootPkgPath = path.resolve(__dirname, '../package.json');
const tsGenDir = path.resolve(__dirname, '../gen/ts');
const tsPkgPath = path.join(tsGenDir, 'package.json');

function loadJson(filePath) {
  try {
    return JSON.parse(fs.readFileSync(filePath, 'utf-8'));
  } catch (err) {
    if (err.code === 'ENOENT') {
      // File not found — return null to create new package.json later
      return null;
    }
    console.error(`Error reading JSON file at ${filePath}:`, err);
    process.exit(1);
  }
}

function generateTsPackage(rootPkg, tsPkg) {
  return {
    name: (tsPkg && tsPkg.name) || (rootPkg.name ? rootPkg.name + '-ts' : '@spounge/proto-ts'),
    version: (tsPkg && tsPkg.version) || rootPkg.version || '1.0.0',
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

function writeJson(filePath, json) {
  try {
    fs.writeFileSync(filePath, JSON.stringify(json, null, 2) + '\n', 'utf-8');
    console.log('✅ Updated:', filePath);
  } catch (err) {
    console.error(`Error writing JSON file at ${filePath}:`, err);
    process.exit(1);
  }
}

const rootPkg = loadJson(rootPkgPath);
const tsPkg = loadJson(tsPkgPath);
const updatedTsPkg = generateTsPackage(rootPkg, tsPkg);
writeJson(tsPkgPath, updatedTsPkg);
