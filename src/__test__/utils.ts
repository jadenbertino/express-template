import request from 'supertest'
import { app } from '../app.js'

async function sendPostRequest(path: string, payload: any) {
  return await request(app)
    .post(path)
    // .set('Authorization', getBasicAuthHeader(ENV.CHARGEBEE_USERNAME, ENV.CHARGEBEE_PASSWORD))
    .send(payload)
}

async function sendGetRequest(path: string) {
  return await request(app)
    // .set('Authorization', getBasicAuthHeader(ENV.CHARGEBEE_USERNAME, ENV.CHARGEBEE_PASSWORD))
    .get(path)
}

/*
function getBasicAuthHeader(username: string, password: string): string {
  const credentials = `${username}:${password}`
  const base64Credentials = Buffer.from(credentials).toString('base64')
  return `Basic ${base64Credentials}`
}
*/

export { sendGetRequest, sendPostRequest }
