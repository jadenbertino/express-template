import w from 'winston'

export const logger = w.createLogger({
  level: getLogLevel(process.env['ENVIRONMENT']),
  format: w.format.printf(({ level, message, ...metadata }) => {
    const metadataString = metadata && Object.keys(metadata).length ? JSON.stringify(metadata) : ''
    return `[${level.toUpperCase()}] ${message} ${metadataString}`
  }),
  transports: [new w.transports.Console()],
})

type LogLevel = 'error' | 'warn' | 'info' | 'verbose' | 'debug' | 'silly' | 'silent'
function getLogLevel(environment: string | undefined): LogLevel {
  switch (environment) {
    case 'production':
      return 'verbose'
    case 'testing':
      return 'silent' // disable logs during testing
    default:
      return 'debug'
  }
}
