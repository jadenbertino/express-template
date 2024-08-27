// Imports - Middleware
import { catchAsyncErrors, handleErrors } from '@/error.js'
import cors from 'cors'
import express from 'express'

// Imports - Route Handlers
import helloWorld from '@/routes/hello-world.js'

const app = express()

// Middleware
app.use(cors())
app.use(express.json())

// Route Handlers
app.get('/', catchAsyncErrors(helloWorld))

app.use(handleErrors) // must come after all routes

export { app } // call app.listen() in a separate file in case you want to run tests
