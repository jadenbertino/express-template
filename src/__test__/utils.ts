import request from 'supertest'
import { app } from '../app.js'

async function sendPostRequest(payload: any) {
  return await request(app) // listens on port 0 (first available one it finds)
    .post('/')
    // .set('Authorization', getBasicAuthHeader(ENV.CHARGEBEE_USERNAME, ENV.CHARGEBEE_PASSWORD))
    .send(payload)
}

/*
function getBasicAuthHeader(username: string, password: string): string {
  const credentials = `${username}:${password}`
  const base64Credentials = Buffer.from(credentials).toString('base64')
  return `Basic ${base64Credentials}`
}
*/

export { sendPostRequest }
