import { NextFunction, Request, Response } from 'express'
import w from 'winston'

export class CustomError extends Error {
  statusCode: number;
  [key: string]: any

  constructor({
    statusCode,
    message,
    ...extraProperties
  }: {
    statusCode: number
    message: string
    [key: string]: any
  }) {
    super(message)
    this.statusCode = statusCode

    // Assign any extra properties to the instance
    Object.assign(this, extraProperties)
  }

  override toString() {
    let errorString = `CustomError: ${this.message}, statusCode: ${this.statusCode}`
    for (const key in this) {
      if (this.hasOwnProperty(key) && !['message', 'statusCode', 'name', 'stack'].includes(key)) {
        errorString += `, ${key}: ${JSON.stringify(this[key])}`
      }
    }
    errorString += `, stack: ${this.stack}`
    return errorString
  }
}

export function catchAsyncErrors(asyncFunction: Function) {
  return async (req: Request, res: Response, next: NextFunction) => {
    try {
      await asyncFunction(req, res)
    } catch (err) {
      next(err)
    }
  }
}

export const logger = w.createLogger({
  // uses npm log levels by default: 'error', 'warn', 'info', 'verbose', 'debug', 'silly'
  level: process.env['ENVIRONMENT'] === 'production' ? 'verbose': 'debug',
  format: w.format.printf(({ level, message, ...metadata }) => {
    const metadataString = metadata && Object.keys(metadata).length ? JSON.stringify(metadata) : ''
    return `[${level.toUpperCase()}] ${message} ${metadataString}`
  }),
  transports: [
    new w.transports.Console(),
  ]
})