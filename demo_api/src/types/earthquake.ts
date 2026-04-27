/** 震源情報 */
export type Epicenter = {
  name: string;
  latitude: number;
  longitude: number;
  depth: number;
};

/** 観測地域ごとの震度 */
export type Area = {
  name: string;
  intensity: string;
};

/** 地震データ */
export type Earthquake = {
  id: string;
  occurredAt: string;
  epicenter: Epicenter;
  magnitude: number;
  maxIntensity: string;
  tsunami: boolean;
  areas: Area[];
};

/** APIレスポンス */
export type EarthquakeResponse = {
  earthquakes: Earthquake[];
};
