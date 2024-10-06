// Imports - Middleware
import { catchAsyncErrors, handleErrors } from '@/error.js'
import cors from 'cors'
import express from 'express'

// Imports - Route Handlers
import handleGetStatus from '@/routes/status.js'

// App Setup
const app = express()
app.use(cors())
app.use(express.json())

// Route Handlers
app.get('/status', catchAsyncErrors(handleGetStatus))

// Error Handling - must come after all routes
app.use(handleErrors)

// Export App - call app.listen() in a separate file
// Must structure it this way to allow for importing app into test file
export { app }
