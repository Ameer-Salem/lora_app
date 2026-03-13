import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';

final locationProvider = StateNotifierProvider<LocationNotifier, Position?>(
  (ref) => LocationNotifier(),
);

class LocationNotifier extends StateNotifier<Position?> {
  final _ready = Completer<Position>();

  Future<Position> get firstPosition => _ready.future;

  LocationNotifier() : super(null) {
    _init();
  }

  void _init() async {
    await Geolocator.requestPermission();

    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 1,
      ),
    ).listen((pos) {
      state = pos;

      if (!_ready.isCompleted) {
        _ready.complete(pos);
      }
    });
  }
}
