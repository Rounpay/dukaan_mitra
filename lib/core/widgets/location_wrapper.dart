/// @Created by akash on 20-02-2026.
/// Know more about author at https://akash.cloudemy.in

import 'dart:async';

import 'package:flutter_demo/data/models/geo_location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../utils/extensions.dart';

GeoLocation? savedGeoLocation;

class LocationWrapper extends StatefulWidget {
  const LocationWrapper({
    super.key,
    required this.child,
    this.realtime = false,
    this.onLocation,
    this.distanceFilter = 5,
  });

  final Widget Function(GeoLocation position, Function(bool)? refresh) child;
  final bool realtime;
  final int distanceFilter;
  final Function(GeoLocation position)? onLocation;

  @override
  State<LocationWrapper> createState() => _LocationWrapperState();
}

class _LocationWrapperState extends State<LocationWrapper> {
  String? _error;
  bool _loading = true;

  StreamSubscription<Position>? _subscription;

  @override
  void initState() {
    super.initState();
    _init(false);
  }

  Future<void> _init(bool refresh ) async {
    debugPrint("==============> LocationWrapper: _init");
    try {
      setState(() {
        if(refresh) {
          savedGeoLocation=null;
        }
        _loading = true;
        _error = null;
      });

      /// 1. Check service (GPS ON?)
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        serviceEnabled = await Geolocator.isLocationServiceEnabled();

        if (!serviceEnabled) {
          throw 'Location services are disabled';
        }
      }

      /// 2. Check permission
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        throw 'Location permission denied';
      }

      if (permission == LocationPermission.deniedForever) {
        await Geolocator.openAppSettings();
        throw 'Location permission permanently denied';
      }

      /// 3. Fetch location
      if (widget.realtime) {
        _subscription =
            Geolocator.getPositionStream(
              locationSettings: LocationSettings(
                accuracy: LocationAccuracy.high,
                distanceFilter: widget.distanceFilter,
              ),
            ).listen((position) async {
              savedGeoLocation = await position.toGeoLocation();
              debugPrint("==============> new Location ${savedGeoLocation?.fullAddress}");
              setState(() {
                savedGeoLocation = savedGeoLocation;
                _loading = false;
              });
              widget.onLocation?.call(savedGeoLocation!);
            });
      } else {
        final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        savedGeoLocation = await position.toGeoLocation();
        debugPrint("==============> new Location ${savedGeoLocation?.fullAddress}");
        setState(() {
          savedGeoLocation = savedGeoLocation;
          _loading = false;
        });

        widget.onLocation?.call(savedGeoLocation!);
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (savedGeoLocation != null && _error == null) {
      return widget.child(savedGeoLocation!,widget.realtime?null: _init);
    }
    if (_loading) {
      return Center(
        child: Text(
          'Fetching location...',
          textAlign: TextAlign.center,
          style: context.textStyle.bodySmall,
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            _error!,
            textAlign: TextAlign.center,
            style: context.textStyle.bodySmall,
          ),
        ),
      );
    }

    return const SizedBox();
  }
}
