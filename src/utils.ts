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
