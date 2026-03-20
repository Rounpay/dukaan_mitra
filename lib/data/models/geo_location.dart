/// @Created by akash on 20-02-2026.
/// Know more about author at https://akash.cloudemy.in
import 'dart:collection';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class GeoLocation {
  /// --- Position fields ---
  final double latitude;
  final double longitude;
  final double accuracy;
  final double altitude;
  final double heading;
  final double speed;
  final double speedAccuracy;
  final DateTime timestamp;

  /// --- Placemark fields ---
  final String? name;
  final String? street;
  final String? isoCountryCode;
  final String? country;
  final String? postalCode;
  final String? administrativeArea; // State
  final String? subAdministrativeArea;
  final String? locality; // City
  final String? subLocality; // Area
  final String? thoroughfare;
  final String? subThoroughfare;

  const GeoLocation({
    required this.latitude,
    required this.longitude,
    required this.accuracy,
    required this.altitude,
    required this.heading,
    required this.speed,
    required this.speedAccuracy,
    required this.timestamp,
    this.name,
    this.street,
    this.isoCountryCode,
    this.country,
    this.postalCode,
    this.administrativeArea,
    this.subAdministrativeArea,
    this.locality,
    this.subLocality,
    this.thoroughfare,
    this.subThoroughfare,
  });

  /// ✅ Factory from Position + Placemark
  factory GeoLocation.from({
    required Position position,
    Placemark? placemark,
  }) {
    return GeoLocation(
      latitude: position.latitude,
      longitude: position.longitude,
      accuracy: position.accuracy,
      altitude: position.altitude,
      heading: position.heading,
      speed: position.speed,
      speedAccuracy: position.speedAccuracy,
      timestamp: position.timestamp ?? DateTime.now(),

      name: placemark?.name,
      street: placemark?.street,
      isoCountryCode: placemark?.isoCountryCode,
      country: placemark?.country,
      postalCode: placemark?.postalCode,
      administrativeArea: placemark?.administrativeArea,
      subAdministrativeArea: placemark?.subAdministrativeArea,
      locality: placemark?.locality,
      subLocality: placemark?.subLocality,
      thoroughfare: placemark?.thoroughfare,
      subThoroughfare: placemark?.subThoroughfare,
    );
  }

  /// ✅ Helper: Full address
  String get fullAddress {
    final values = [
      name,
      thoroughfare,
      subThoroughfare,
      street,
      subLocality,
      locality,
    //  subAdministrativeArea,
      administrativeArea,
      postalCode,
      country
    ]
        .where((e) => e != null && e.trim().isNotEmpty)
        .map((e) => e!.trim());

    final unique = LinkedHashSet<String>.from(values);

    return unique.join(', ');
  }

  /// ✅ Helper: short address (good for overlay)
  String get shortAddress {
    return [
      subLocality,
      locality,
      administrativeArea,
    ].where((e) => e != null && e!.isNotEmpty).join(', ');
  }
  /// ✅ Helper: short address (good for overlay)
  String get addressWithPosition {
    return 'Lat: $latitude, Long: $longitude\n$fullAddress';
  }

  /// ✅ Convert to JSON (for API / storage)
  Map<String, dynamic> toJson() {
    return {
      "latitude": latitude,
      "longitude": longitude,
      "accuracy": accuracy,
      "altitude": altitude,
      "heading": heading,
      "speed": speed,
      "speedAccuracy": speedAccuracy,
      "timestamp": timestamp.toIso8601String(),

      "name": name,
      "street": street,
      "isoCountryCode": isoCountryCode,
      "country": country,
      "postalCode": postalCode,
      "administrativeArea": administrativeArea,
      "subAdministrativeArea": subAdministrativeArea,
      "locality": locality,
      "subLocality": subLocality,
      "thoroughfare": thoroughfare,
      "subThoroughfare": subThoroughfare,
    };
  }
}