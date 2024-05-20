import { app } from './app.js'
import { ENV } from './env.js'
import { logger } from './utils.js'

const PORT = process.env['PORT'] || 8080

const server = app.listen(PORT, () => {
  logger.info(`App listening on port ${PORT} in ${ENV.ENVIRONMENT} mode.`)
})

function handleGracefulShutdown(signal: string) {
  return () => {
    logger.info(`Received ${signal}. Shutting down gracefully...`)
    server.close(() => {
      logger.info('Server shut down successfully.')
      process.exit(0)
    })
  }
}
process.on('SIGINT', handleGracefulShutdown('SIGINT'))
process.on('SIGTERM', handleGracefulShutdown('SIGTERM'))
