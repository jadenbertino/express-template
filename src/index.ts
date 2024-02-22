import { ENV } from './env.js'
import { logger } from './utils.js'

// Imports - Middleware
import cors from 'cors'
import express from 'express'
import { handleErrors, catchAsyncErrors } from './error.js'

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
app.listen(PORT, () => {
  logger.info(`App listening on port ${PORT} in ${ENV.ENVIRONMENT} mode.`)
})
