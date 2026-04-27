import { Hono } from 'hono'
import earthquakeRoute from './route/earthquakeRoute'

const app = new Hono()

app.get('/', (c) => {
  return c.text('Hello Hono!')
})

app.route('/earthquakes', earthquakeRoute)

export default app
