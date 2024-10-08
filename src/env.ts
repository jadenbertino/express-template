import { z } from 'zod'

const EnvironmentSchema = z.enum([
  'development',
  'staging',
  'production',
  'testing',
])

const envVars = {
  VERSION: z.string(),
  ENVIRONMENT: EnvironmentSchema,
  // GOOGLE_APPLICATION_CREDENTIALS: z.string(), // for authenticating to google apis
}

const EnvSchema = z.object(envVars)

const environmentValidation = EnvSchema.safeParse(process.env)
if (!environmentValidation.success) {
  console.error('Invalid environment variables, check the errors below!')
  console.error(environmentValidation.error.issues)
  process.exit(-1)
}

const ENV = environmentValidation.data

export { ENV }
