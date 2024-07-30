import { logger } from '@/logs.js'
import { CustomError } from '@/utils.js'
import type { NextFunction, Request, Response } from 'express'

async function handleErrors(err: Error, _req: Request, res: Response, _next: NextFunction) {
  const errorString =    err instanceof CustomError
      ? err.toString()
      : JSON.stringify(err, Object.getOwnPropertyNames(err))
  const errorStatus = err instanceof CustomError ? err.statusCode : 500
  logger.error(errorString)
  res.status(errorStatus).json({ error: errorString })
}

function catchAsyncErrors(asyncFunction: Function) {
  return async (req: Request, res: Response, next: NextFunction) => {
    try {
      await asyncFunction(req, res)
    } catch (err) {
      next(err)
    }
  }
}

export { catchAsyncErrors, handleErrors }
