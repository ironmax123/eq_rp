import type { Earthquake } from '../types/earthquake';

/** 擬似地震データ */
const earthquakes: Earthquake[] = [
  {
    id: '20260427140000',
    occurredAt: '2026-04-27T14:00:00+09:00',
    epicenter: {
      name: '茨城県南部',
      latitude: 36.1,
      longitude: 140.1,
      depth: 50,
    },
    magnitude: 4.5,
    maxIntensity: '4',
    tsunami: false,
    areas: [
      { name: '茨城県', intensity: '4' },
      { name: '栃木県', intensity: '3' },
      { name: '埼玉県', intensity: '2' },
    ],
  },
  {
    id: '20260427120000',
    occurredAt: '2026-04-27T12:00:00+09:00',
    epicenter: {
      name: '東京湾',
      latitude: 35.5,
      longitude: 139.8,
      depth: 30,
    },
    magnitude: 3.2,
    maxIntensity: '2',
    tsunami: false,
    areas: [
      { name: '東京都', intensity: '2' },
      { name: '神奈川県', intensity: '2' },
      { name: '千葉県', intensity: '1' },
    ],
  },
  {
    id: '20260427100000',
    occurredAt: '2026-04-27T10:00:00+09:00',
    epicenter: {
      name: '熊本地方',
      latitude: 32.8,
      longitude: 130.7,
      depth: 10,
    },
    magnitude: 5.1,
    maxIntensity: '5-',
    tsunami: false,
    areas: [
      { name: '熊本県', intensity: '5-' },
      { name: '大分県', intensity: '3' },
      { name: '福岡県', intensity: '2' },
    ],
  },
  {
    id: '20260427080000',
    occurredAt: '2026-04-27T08:00:00+09:00',
    epicenter: {
      name: '宮城県沖',
      latitude: 38.3,
      longitude: 142.0,
      depth: 60,
    },
    magnitude: 4.0,
    maxIntensity: '3',
    tsunami: false,
    areas: [
      { name: '宮城県', intensity: '3' },
      { name: '岩手県', intensity: '2' },
      { name: '福島県', intensity: '2' },
    ],
  },
  {
    id: '20260427060000',
    occurredAt: '2026-04-27T06:00:00+09:00',
    epicenter: {
      name: '大阪府北部',
      latitude: 34.8,
      longitude: 135.6,
      depth: 15,
    },
    magnitude: 3.8,
    maxIntensity: '3',
    tsunami: false,
    areas: [
      { name: '大阪府', intensity: '3' },
      { name: '京都府', intensity: '2' },
      { name: '兵庫県', intensity: '2' },
    ],
  },
  {
    id: '20260427030000',
    occurredAt: '2026-04-27T03:00:00+09:00',
    epicenter: {
      name: '北海道胆振地方',
      latitude: 42.7,
      longitude: 141.9,
      depth: 35,
    },
    magnitude: 4.2,
    maxIntensity: '4',
    tsunami: false,
    areas: [
      { name: '北海道', intensity: '4' },
    ],
  },
];

/** 全データ取得 */
export const getAll = (): Earthquake[] => {
  return earthquakes;
};

/**
 * 指定日時以前のデータを取得
 * @param time - "20260427153000" 形式の14桁日時文字列
 */
export const getByTimeBefore = (time: string): Earthquake[] => {
  return earthquakes.filter((eq) => eq.id <= time);
};
