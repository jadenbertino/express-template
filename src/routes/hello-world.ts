import { Request, Response } from 'express'
import { z } from 'zod'
import { CustomError } from '../utils.js'

async function helloWorld(req: Request, res: Response) {
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
}

export default helloWorld