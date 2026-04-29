import 'package:app/model/earthquake.dart';
import 'package:flutter/material.dart';

/// 震度文字列 → 背景色
Color _intensityColor(String intensity) {
  switch (intensity) {
    case '1':
      return const Color(0xFF4a90d9);
    case '2':
      return const Color(0xFF3a7abf);
    case '3':
      return const Color(0xFF2e8b57);
    case '4':
      return const Color(0xFFe6c229);
    case '5弱':
      return const Color(0xFFe07b39);
    case '5強':
      return const Color(0xFFd45500);
    case '6弱':
      return const Color(0xFFc0392b);
    case '6強':
      return const Color(0xFF922b21);
    case '7':
      return const Color(0xFF6c1a3d);
    default:
      return const Color(0xFF2a2a4a);
  }
}

String _formatTime(String isoString) {
  try {
    final dt = DateTime.parse(isoString).toLocal();
    final y = dt.year.toString().padLeft(4, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    final h = dt.hour.toString().padLeft(2, '0');
    final min = dt.minute.toString().padLeft(2, '0');
    return '$y/$m/$d $h:$min';
  } catch (e) {
    return isoString;
  }
}

class EqListWidget extends StatelessWidget {
  final List<Earthquake>? earthquakes;
  const EqListWidget({super.key, required this.earthquakes});

  @override
  Widget build(BuildContext context) {
    if (earthquakes == null || earthquakes!.isEmpty) {
      return const Center(
        child: Text('データなし', style: TextStyle(color: Colors.white54)),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 4),
      itemCount: earthquakes!.length,
      itemBuilder: (context, index) {
        final eq = earthquakes![index];
        final bgColor = _intensityColor(eq.maxIntensity);
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(
            color: bgColor.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 震源名 + 最大震度バッジ
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        eq.epicenter.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '震度${eq.maxIntensity}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // 発生日時
                Text(
                  _formatTime(eq.occurredAt),
                  style: const TextStyle(color: Colors.white70, fontSize: 11),
                ),
                const SizedBox(height: 2),
                // M + 津波
                Row(
                  children: [
                    Text(
                      'M${eq.magnitude.toStringAsFixed(1)}',
                      style: const TextStyle(
                          color: Colors.white70, fontSize: 11),
                    ),
                    if (eq.tsunami) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 1),
                        decoration: BoxDecoration(
                          color: Colors.cyanAccent.shade700,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: const Text(
                          '津波',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
