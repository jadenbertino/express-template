import type { JestConfigWithTsJest } from 'ts-jest'

const jestConfig: JestConfigWithTsJest = {
  moduleNameMapper: {
    '^(\\.{1,2}/.*)\\.js$': '$1', // remove .js extension
  },
  extensionsToTreatAsEsm: ['.ts'],
  transform: {
    '^.+\\.m?[tj]sx?$': [
      // transform .ts, .tsx, .js, .jsx files
      'ts-jest',
      {
        useESM: true,
      },
    ],
  },
  verbose: true,
  testTimeout: 30000, // Set the global timeout to 30 seconds (30000 milliseconds)
}

export default jestConfig
