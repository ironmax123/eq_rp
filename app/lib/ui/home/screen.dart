import 'package:app/ui/home/widget/intensity_legend.dart';
import 'package:app/ui/home/widget/list.dart';
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

    // 地震データから都道府県カラーを構築（最新1件のみ）
    final latestEq = state.earthquakeResponse?.earthquakes.firstOrNull;
    final prefecture = latestEq != null
        ? buildPrefectureColors(
            earthquakes: [latestEq],
            defaultColor: const Color(0x00000000),
          )
        : null;

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
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: ClipRect(
                    child: JapanColorMapsWidget(
                      center: LatLng(
                        latitude: latestEq?.epicenter.latitude ?? 36.0,
                        longitude: latestEq?.epicenter.longitude ?? 138.0,
                      ),
                      backgroundColor: const Color.fromARGB(255, 137, 169, 236),
                      otherCountryColor: const Color.fromARGB(255, 1, 81, 28),
                      mapColor: Colors.blueAccent.withAlpha(128),
                      prefecture: prefecture,
                      onPrefectureTap: (pref) {
                        vm.selectPrefecture(pref.key);
                      },
                    ),
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
