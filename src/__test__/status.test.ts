import { sendGetRequest } from '@test/utils.js'

it(`'/status' endpoint returns 200 status code`, async () => {
  const response = await sendGetRequest('/status')
  expect(response.status).toBe(200)
})
