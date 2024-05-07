import { ENV } from './env.js'
import { logger } from './utils.js'

// Imports - Middleware
import cors from 'cors'
import express from 'express'
import { catchAsyncErrors, handleErrors } from './error.js'

// Imports - Route Handlers
import helloWorld from './routes/hello-world.js'

// Express Config
const app = express()
app.use(cors())
app.use(express.json())
const PORT = process.env['PORT'] || 8080

// Route Handlers
app.get('/', catchAsyncErrors(helloWorld))

// Error Handling
app.use(handleErrors)

// Start The Server
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

// Handle shutdown
process.on('SIGINT', handleGracefulShutdown('SIGINT'))
process.on('SIGTERM', handleGracefulShutdown('SIGTERM'))
