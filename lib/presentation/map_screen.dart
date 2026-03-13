import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_mbtiles/flutter_map_mbtiles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:lora_app/logic/providers.dart';
import 'package:lora_app/logic/location_controller.dart';
import 'package:lora_app/logic/neighbors_controller.dart';
import 'package:lora_app/utilities/colors.dart';

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = ref.watch(locationProvider)!;
    final neighbors = ref.watch(neighborsProvider);
    final mbtilesPathAsync = ref.watch(mbtilesPathProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Map')),
      body: mbtilesPathAsync.when(
        data: (mbtilesPath) => FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(position.latitude, position.longitude),
            initialZoom: 13,
          ),
          children: [
            TileLayer(
              tileProvider: MbTilesTileProvider.fromPath(path: mbtilesPath),
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(position.latitude, position.longitude),
                  child: const Icon(Icons.location_on, color: MyColors.purple),
                ),
                ...neighbors.where((n) => n.lat != null && n.lon != null).map((
                  n,
                ) {
                  return Marker(
                    width: 20,
                    height: 20,
                    point: LatLng(n.lat!, n.lon!),
                    child: const Icon(
                      Icons.location_on,
                      color: MyColors.yellow,
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Center(child: Text('Failed to load map')),
      ),
    );
  }
}
