import 'package:app/ui/home/widget/intensity_legend.dart';
import 'package:app/ui/home/widget/list.dart';
import 'package:app/util/intensity_color.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:japan_maps/japan_maps.dart';

import '../../util/prefecture_color_builder.dart';
import 'view_model.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeScreenViewModelProvider);
    final vm = ref.read(homeScreenViewModelProvider.notifier);

    final selected = state.selectedEarthquake;

    final mapColor = const Color.fromARGB(255, 20, 121, 32).withAlpha(128);
    final prefecture = buildPrefectureColors(
      earthquakes: selected != null ? [selected] : [],
      defaultColor: mapColor,
    );

    return Scaffold(
      backgroundColor: const Color(0xff1a1a2e),
      body: SafeArea(
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: EqListWidget(
                    earthquakes: state.earthquakeResponse?.earthquakes,
                    selectedId: state.selectedEarthquake?.id,
                    onTap: (eq) {
                      if (state.selectedEarthquake?.id == eq.id) {
                        vm.clearSelection();
                      } else {
                        vm.selectEarthquake(eq);
                      }
                    },
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Stack(
                    children: [
                      AbsorbPointer(
                        absorbing: selected != null,
                        child: ClipRect(
                          child: JapanColorMapsWidget(
                            key: ValueKey(
                              '${selected?.epicenter.latitude ?? 0}_${selected?.epicenter.longitude ?? 0}',
                            ),
                            center: LatLng(
                              latitude: selected?.epicenter.latitude ?? 36.0,
                              longitude: selected?.epicenter.longitude ?? 138.0,
                            ),
                            backgroundColor: const Color.fromARGB(
                              255,
                              137,
                              169,
                              236,
                            ),
                            otherCountryColor: const Color.fromARGB(
                              255,
                              1,
                              57,
                              52,
                            ),
                            mapColor: const Color.fromARGB(
                              255,
                              20,
                              121,
                              32,
                            ).withAlpha(128),
                            prefecture: prefecture,
                            onPrefectureTap: (pref) {
                              vm.selectPrefecture(pref.key);
                            },
                          ),
                        ),
                      ),
                      // 震源ピン（選択中の地震がある時に表示）
                      if (selected != null)
                        Center(
                          child: Transform.translate(
                            offset: const Offset(0, -16),
                            child: Icon(
                              Icons.location_on,
                              size: 36,
                              color: IntensityColor.fromIntensity(
                                selected.maxIntensity,
                              ),
                            ),
                          ),
                        ),
                      // 選択解除ボタン（右上）
                      if (selected != null)
                        Positioned(
                          top: 16,
                          right: 16,
                          child: FloatingActionButton.small(
                            onPressed: () => vm.clearSelection(),
                            backgroundColor: Colors.black54,
                            foregroundColor: Colors.white,
                            child: const Icon(Icons.close),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            // 震度凡例（右下）
            const Positioned(
              right: 8,
              bottom: 8,
              child: IntensityLegendWidget(),
            ),
            // ローディング表示
            if (state.earthquakeResponse == null && state.errorMessage == null)
              const Center(child: CircularProgressIndicator()),
            // エラー表示
            if (state.errorMessage != null)
              Center(
                child: Text(
                  state.errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
