import 'package:app/util/intensity_color.dart';
import 'package:flutter/material.dart';

/// 震度カラー凡例（右下に表示する小型ウィジェット）
class IntensityLegendWidget extends StatelessWidget {
  const IntensityLegendWidget({super.key});

  static const _items = [
    ('7', IntensityColor.shindo7),
    ('6強', IntensityColor.shindo6Upper),
    ('6弱', IntensityColor.shindo6Lower),
    ('5強', IntensityColor.shindo5Upper),
    ('5弱', IntensityColor.shindo5Lower),
    ('4', IntensityColor.shindo4),
    ('3', IntensityColor.shindo3),
    ('2', IntensityColor.shindo2),
    ('1', IntensityColor.shindo1),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '震度',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ..._items.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: item.$2,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    item.$1,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
