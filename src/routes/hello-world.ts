import { Request, Response } from 'express'
import { z } from 'zod'

const RequestSchema = z.object({ })

async function helloWorld(req: Request, res: Response) {
  // Validate Request
  const requestValidation = RequestSchema.safeParse(req.body)
  if (!requestValidation.success) {
    if (!requestValidation.success) {
      return res.status(400).json({
        message: 'Invalid request body.',
        errors: requestValidation.error.errors,
        received: req.body,
      })
    }
  }
  // const body = requestValidation.data
  
  return res.status(200).send('Hello World!')
}

export default helloWorld