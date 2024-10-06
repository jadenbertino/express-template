import type { Request, Response } from 'express'

async function handleGetStatus(_req: Request, res: Response) {
  return res.status(200).json({ status: 'ok' })
}

export default handleGetStatus
