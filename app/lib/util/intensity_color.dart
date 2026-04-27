import 'package:flutter/material.dart';

/// 震度に応じた基本配色（気象庁公表のRGB値）を管理するクラス
class IntensityColor {
  // インスタンス化させないためのプライベートコンストラクタ
  IntensityColor._();

  /// 震度7
  static const Color shindo7 = Color.fromRGBO(180, 0, 104, 1);

  /// 震度6強
  static const Color shindo6Upper = Color.fromRGBO(165, 0, 33, 1);

  /// 震度6弱
  static const Color shindo6Lower = Color.fromRGBO(255, 40, 0, 1);

  /// 震度5強
  static const Color shindo5Upper = Color.fromRGBO(255, 153, 0, 1);

  /// 震度5弱
  static const Color shindo5Lower = Color.fromRGBO(255, 230, 0, 1);

  /// 震度4
  static const Color shindo4 = Color.fromRGBO(250, 230, 150, 1);

  /// 震度3
  static const Color shindo3 = Color.fromRGBO(0, 65, 255, 1);

  /// 震度2
  static const Color shindo2 = Color.fromRGBO(0, 170, 255, 1);

  /// 震度1
  static const Color shindo1 = Color.fromRGBO(242, 242, 255, 1);

  /// 文字列や数値から色を取得したい場合のヘルパーメソッド
  static Color fromIntensity(String intensity) {
    switch (intensity) {
      case '7':
        return shindo7;
      case '6+':
      case '6強':
        return shindo6Upper;
      case '6-':
      case '6弱':
        return shindo6Lower;
      case '5+':
      case '5強':
        return shindo5Upper;
      case '5-':
      case '5弱':
        return shindo5Lower;
      case '4':
        return shindo4;
      case '3':
        return shindo3;
      case '2':
        return shindo2;
      case '1':
        return shindo1;
      default:
        return Colors.grey; // 該当なし
    }
  }
}
