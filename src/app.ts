// Imports - Middleware
import cors from 'cors'
import express from 'express'
import { catchAsyncErrors, handleErrors } from './error.js'

// Imports - Route Handlers
import helloWorld from './routes/hello-world.js'

const app = express()

// Middleware
app.use(cors())
app.use(express.json())
app.use(handleErrors)

// Route Handlers
app.get('/', catchAsyncErrors(helloWorld))

export { app } // call app.listen() in a separate file in case you want to run tests