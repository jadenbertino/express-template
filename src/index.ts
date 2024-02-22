import cors from 'cors'
import express from 'express'
import { ENV } from './env.js'
import handleErrors from './error.js'
import helloWorld from './routes/hello-world.js'
import { catchAsyncErrors, logger } from './utils.js'

const app = express()
app.use(cors())
app.use(express.json())
const PORT = process.env['PORT'] || 8080

// TODO: Add route handler here
app.get('/', catchAsyncErrors(helloWorld))

// Error Handling
app.use(handleErrors)

// Start The Server
app.listen(PORT, () => {
  logger.info(`App listening on port ${PORT} in ${ENV.ENVIRONMENT} mode.`)
})
