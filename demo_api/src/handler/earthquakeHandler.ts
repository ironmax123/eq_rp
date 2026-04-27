import type { Context } from 'hono';
import { getEarthquakes } from '../service/earthquakeService';

/** 地震データ取得ハンドラ */
export const getEarthquakesHandler = (c: Context) => {
  const requestTime = c.req.header('X-Request-Time');
  const data = getEarthquakes(requestTime ?? undefined);

  return c.json(data);
};
