import { Request, Response, NextFunction } from 'express'
import { CustomError, logger } from './utils'

async function handleErrors(err: Error, _req: Request, res: Response, _next: NextFunction) {
  const errorString = err instanceof CustomError ? err.toString() : JSON.stringify(err, Object.getOwnPropertyNames(err))
  logger.error(errorString)
  res.status(500).send('Internal Server Error.')
}

export default handleErrors