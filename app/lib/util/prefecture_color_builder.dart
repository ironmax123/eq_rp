import 'package:flutter/material.dart';
import 'package:japan_maps/japan_maps.dart';

import '../model/earthquake.dart';
import 'intensity_color.dart';

/// 地震データから都道府県ごとの震度Colorを構築する
Prefecture buildPrefectureColors({
  required List<Earthquake> earthquakes,
  required Color defaultColor,
}) {
  // 都道府県名 → 最大震度を集約
  final intensityMap = <String, String>{};

  for (final eq in earthquakes) {
    for (final area in eq.areas) {
      final name = _normalize(area.name);
      if (name == null) continue;
      final current = intensityMap[name];
      if (current == null ||
          _intensityRank(area.intensity) > _intensityRank(current)) {
        intensityMap[name] = area.intensity;
      }
    }
  }

  Color get(String key) {
    final intensity = intensityMap[key];
    if (intensity == null) return defaultColor;
    return IntensityColor.fromIntensity(intensity);
  }

  return Prefecture(
    hokkaido: get('hokkaido'),
    aomori: get('aomori'),
    iwate: get('iwate'),
    miyagi: get('miyagi'),
    akita: get('akita'),
    yamagata: get('yamagata'),
    fukushima: get('fukushima'),
    ibaraki: get('ibaraki'),
    tochigi: get('tochigi'),
    gunma: get('gunma'),
    saitama: get('saitama'),
    chiba: get('chiba'),
    tokyo: get('tokyo'),
    kanagawa: get('kanagawa'),
    niigata: get('niigata'),
    toyama: get('toyama'),
    ishikawa: get('ishikawa'),
    fukui: get('fukui'),
    yamanashi: get('yamanashi'),
    nagano: get('nagano'),
    gifu: get('gifu'),
    shizuoka: get('shizuoka'),
    aichi: get('aichi'),
    mie: get('mie'),
    shiga: get('shiga'),
    kyoto: get('kyoto'),
    osaka: get('osaka'),
    hyogo: get('hyogo'),
    nara: get('nara'),
    wakayama: get('wakayama'),
    tottori: get('tottori'),
    shimane: get('shimane'),
    okayama: get('okayama'),
    hiroshima: get('hiroshima'),
    yamaguchi: get('yamaguchi'),
    tokushima: get('tokushima'),
    kagawa: get('kagawa'),
    ehime: get('ehime'),
    kochi: get('kochi'),
    fukuoka: get('fukuoka'),
    saga: get('saga'),
    nagasaki: get('nagasaki'),
    kumamoto: get('kumamoto'),
    oita: get('oita'),
    miyazaki: get('miyazaki'),
    kagoshima: get('kagoshima'),
    okinawa: get('okinawa'),
  );
}

/// 震度を数値ランクに変換（比較用）
int _intensityRank(String intensity) {
  const ranks = {
    '1': 1,
    '2': 2,
    '3': 3,
    '4': 4,
    '5-': 5,
    '5弱': 5,
    '5+': 6,
    '5強': 6,
    '6-': 7,
    '6弱': 7,
    '6+': 8,
    '6強': 8,
    '7': 9,
  };
  return ranks[intensity] ?? 0;
}

/// 日本語都道府県名 → Prefectureフィールドキー
String? _normalize(String name) {
  const map = {
    '北海道': 'hokkaido',
    '青森県': 'aomori',
    '岩手県': 'iwate',
    '宮城県': 'miyagi',
    '秋田県': 'akita',
    '山形県': 'yamagata',
    '福島県': 'fukushima',
    '茨城県': 'ibaraki',
    '栃木県': 'tochigi',
    '群馬県': 'gunma',
    '埼玉県': 'saitama',
    '千葉県': 'chiba',
    '東京都': 'tokyo',
    '神奈川県': 'kanagawa',
    '新潟県': 'niigata',
    '富山県': 'toyama',
    '石川県': 'ishikawa',
    '福井県': 'fukui',
    '山梨県': 'yamanashi',
    '長野県': 'nagano',
    '岐阜県': 'gifu',
    '静岡県': 'shizuoka',
    '愛知県': 'aichi',
    '三重県': 'mie',
    '滋賀県': 'shiga',
    '京都府': 'kyoto',
    '大阪府': 'osaka',
    '兵庫県': 'hyogo',
    '奈良県': 'nara',
    '和歌山県': 'wakayama',
    '鳥取県': 'tottori',
    '島根県': 'shimane',
    '岡山県': 'okayama',
    '広島県': 'hiroshima',
    '山口県': 'yamaguchi',
    '徳島県': 'tokushima',
    '香川県': 'kagawa',
    '愛媛県': 'ehime',
    '高知県': 'kochi',
    '福岡県': 'fukuoka',
    '佐賀県': 'saga',
    '長崎県': 'nagasaki',
    '熊本県': 'kumamoto',
    '大分県': 'oita',
    '宮崎県': 'miyazaki',
    '鹿児島県': 'kagoshima',
    '沖縄県': 'okinawa',
  };
  return map[name];
}
