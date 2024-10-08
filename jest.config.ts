import type { JestConfigWithTsJest } from 'ts-jest'
import { pathsToModuleNameMapper } from 'ts-jest'
import tsconfig from './tsconfig.json'

const jestConfig: JestConfigWithTsJest = {
  moduleNameMapper: {
    ...pathsToModuleNameMapper(tsconfig.compilerOptions.paths, {
      prefix: '<rootDir>',
    }),
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
  // moduleDirectories: ['node_modules', '<rootDir>'],
}

export default jestConfig
