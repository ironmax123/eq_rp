import { Hono } from 'hono';
import { getEarthquakesHandler } from '../handler/earthquakeHandler';

const earthquakeRoute = new Hono();

earthquakeRoute.get('/', getEarthquakesHandler);

export default earthquakeRoute;
