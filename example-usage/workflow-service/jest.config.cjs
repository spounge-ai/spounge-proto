module.exports = {
  preset: 'ts-jest',
  testEnvironment: 'node',
  roots: ['<rootDir>/src/__tests__'],
  testMatch: ['**/*.test.ts'],
  moduleFileExtensions: ['ts', 'js', 'json', 'node'],

  transformIgnorePatterns: [
    "/node_modules/(?!(?:@spounge/proto-ts)/)"
  ],
};
