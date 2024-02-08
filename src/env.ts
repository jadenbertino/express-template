import { z } from 'zod'

const envVars = {
  GOOGLE_APPLICATION_CREDENTIALS: z.string(),
  ENVIRONMENT: z.enum(['development', 'staging', 'production']),
}

const EnvSchema = z.object(envVars)

const environmentValidation = EnvSchema.safeParse(process.env)
if (!environmentValidation.success) {
  console.error('Invalid environment variables, check the errors below!')
  console.error(environmentValidation.error.issues)
  process.exit(-1)
}

const ENV = environmentValidation.data

// Only log env var confirmation in non-production environments
if (ENV.ENVIRONMENT !== 'production') {
  console.info(`All environment variables are valid! (i.e. ${Object.keys(envVars).join(', ')})`)
}

export { ENV }