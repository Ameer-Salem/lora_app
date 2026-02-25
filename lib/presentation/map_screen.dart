import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_mbtiles/flutter_map_mbtiles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:lora_app/logic/providers.dart';
import 'package:lora_app/model/neighbor.dart';
import 'package:lora_app/utilities/colors.dart';

class MapScreen extends ConsumerWidget {
  final List<Neighbor> neighbors;

  const MapScreen({super.key, required this.neighbors});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = ref.watch(locationProvider)!;
    return Scaffold(
      appBar: AppBar(title: const Text('Map')),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(position.latitude, position.longitude),
          initialZoom: 13,
        ),
        children: [
          TileLayer(
            tileProvider: MbTilesTileProvider.fromPath(
              path: 'assets/maps/najaf.mbtiles',
            ),
          ),

          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(position.latitude, position.longitude),
                child: const Icon(Icons.location_on, color: MyColors.purple),
              ),
              ...(neighbors.where((n) => n.lat != null && n.lon != null).map((
                n,
              ) {
                return Marker(
                  width: 20,
                  height: 20,
                  point: LatLng(n.lat!, n.lon!),
                  child: const Icon(Icons.location_on, color: MyColors.yellow),
                );
              }).toList()),
            ],
          ),
        ],
      ),
    );
  }
}
