import 'package:app/model/earthquake.dart';
import 'package:app/util/intensity_color.dart';
import 'package:flutter/material.dart';

String _formatTime(String timeString) {
  // yyyyMMddHHmmss 形式 (14文字) の場合の処理
  if (timeString.length == 14 && int.tryParse(timeString) != null) {
    final y = timeString.substring(0, 4);
    final m = timeString.substring(4, 6);
    final d = timeString.substring(6, 8);
    final h = timeString.substring(8, 10);
    final min = timeString.substring(10, 12);
    return '$y/$m/$d $h:$min';
  }

  try {
    final dt = DateTime.parse(timeString).toLocal();
    final y = dt.year.toString().padLeft(4, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    final h = dt.hour.toString().padLeft(2, '0');
    final min = dt.minute.toString().padLeft(2, '0');
    return '$y/$m/$d $h:$min';
  } catch (e) {
    return timeString;
  }
}

class EqListWidget extends StatelessWidget {
  final List<Earthquake>? earthquakes;
  final ValueChanged<Earthquake>? onTap;
  final String? selectedId;

  const EqListWidget({
    super.key,
    required this.earthquakes,
    this.onTap,
    this.selectedId,
  });

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
        final bgColor = IntensityColor.fromIntensity(eq.maxIntensity);
        final isSelected = selectedId == eq.id;
        return GestureDetector(
          onTap: () => onTap?.call(eq),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: bgColor.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected ? Colors.white : Colors.white12,
                width: isSelected ? 2.0 : 1.0,
              ),
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
                            fontSize: 24,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '震度${eq.maxIntensity}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
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
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 2),
                  // M + 津波
                  Row(
                    children: [
                      Text(
                        'M${eq.magnitude.toStringAsFixed(1)}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                      if (eq.tsunami) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.cyanAccent.shade700,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: const Text(
                            '津波',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
