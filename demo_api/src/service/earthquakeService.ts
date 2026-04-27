import type { EarthquakeResponse } from '../types/earthquake';
import { getAll, getByTimeBefore } from '../repository/earthquakeRepository';

/**
 * 地震データを取得する
 * @param requestTime - ヘッダから取得した日時文字列（省略時は全件）
 */
export const getEarthquakes = (requestTime?: string): EarthquakeResponse => {
  const earthquakes = requestTime
    ? getByTimeBefore(requestTime)
    : getAll();

  return { earthquakes };
};
