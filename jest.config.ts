import type { JestConfigWithTsJest } from 'ts-jest'

const jestConfig: JestConfigWithTsJest = {
  moduleNameMapper: {
    '^@/(.*)$': '<rootDir>/src/$1', // @ -> src
    '^(\\.{1,2}/.*)\\.js$': '$1', // remove .js extension
  },
  extensionsToTreatAsEsm: ['.ts'],
  transform: {
    '^.+\\.m?[tj]sx?$': [
      'ts-jest',
      {
        useESM: true,
      },
    ],
  },
  resolver: 'ts-jest-resolver',
  verbose: true,
  testTimeout: 30000,
  moduleDirectories: ['node_modules', '<rootDir>'],
}

export default jestConfig
