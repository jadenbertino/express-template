import { Request, Response, NextFunction } from 'express'
import { CustomError, logger } from './utils.js'

async function handleErrors(err: Error, _req: Request, res: Response, _next: NextFunction) {
  const errorString = err instanceof CustomError ? err.toString() : JSON.stringify(err, Object.getOwnPropertyNames(err))
  logger.error(errorString)
  res.status(500).send('Internal Server Error.')
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

export { handleErrors, catchAsyncErrors }