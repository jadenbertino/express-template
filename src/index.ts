import express, { NextFunction, Request, Response } from 'express'
import { ENV } from './env.js'
import { CustomError, catchAsyncErrors, logger } from './utils.js'
import cors from 'cors'
import { z } from 'zod'

const app = express()
app.use(cors());
app.use(express.json())
const PORT = process.env['PORT'] || 8080

// TODO: Add route handler here
app.get('/', catchAsyncErrors(async (req: Request, res: Response) => {
  // Validate Request
  const requestSchema = z.object({ })
  const requestValidation = requestSchema.safeParse(req.body)
  if (!requestValidation.success) {
    throw new CustomError({
      statusCode: 400,
      message: 'Invalid request body.',
      errors: requestValidation.error.errors,
      received: req.body,
    })
  }
  // const body = requestValidation.data
  
  res.status(200).send('Hello World!')
}))

// TODO: Handle errors here
app.use((err: Error, _req: Request, res: Response, _next: NextFunction) => {
  const errorString = err instanceof CustomError ? err.toString() : JSON.stringify(err, Object.getOwnPropertyNames(err))
  logger.error(errorString)
  res.status(500).send('Internal Server Error.')
})

// Start the server
app.listen(PORT, () => {
  logger.info(`App listening on port ${PORT} in ${ENV.ENVIRONMENT} mode.`)
})
