import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hiwaygo/core/constants/app_colors.dart';
import 'package:hiwaygo/core/constants/app_strings.dart';
import 'package:hiwaygo/core/widgets/loader_widget.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PageBusTrackingMap extends StatefulWidget {
  static const String routeName = '/page_bus_tracking_map';
  const PageBusTrackingMap({super.key});

  @override
  State<PageBusTrackingMap> createState() => _PageBusTrackingMapState();
}

class _PageBusTrackingMapState extends State<PageBusTrackingMap> {
  final MapController _mapController = MapController();
  LatLng? _currentLocation;
  List<LatLng> _busLocations = [];
  Timer? _busUpdateTimer;
  double _rotation = 0; // For compass

  bool _isLoading = true;
  String _pageContent = AppStrings.loadingPleaseWait;

  Future<void> _loadData() async {
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      setState(() {
        _pageContent = AppStrings.loadingCompleted;
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
    _determinePosition();
    _fetchBusLocationsPeriodically();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return Future.error('Location services disabled.');

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions permanently denied.');
    }

    final position = await Geolocator.getCurrentPosition();
    if (!mounted) return;
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  void _fetchBusLocationsPeriodically() {
    _busUpdateTimer =
        Timer.periodic(const Duration(seconds: 2), (timer) async {
          if (!mounted) return;

          final List<String> apiResponse = [
            "7.071224,80.049834",
            "7.072322,80.048822",
            "7.073323,80.046628",
            "7.075224,80.044834",
            "7.077322,80.043822",
            "7.079323,80.041628",
          ];

          List<LatLng> busList = apiResponse.map((loc) {
            final parts = loc.split(',');
            return LatLng(double.parse(parts[0]), double.parse(parts[1]));
          }).toList();

          if (!mounted) return;
          setState(() {
            _busLocations = busList;
          });
        });
  }

  @override
  void dispose() {
    _busUpdateTimer?.cancel();
    super.dispose();
  }

  /// ✅ Center map on current location
  void _centerOnUser() {
    if (_currentLocation != null) {
      _mapController.move(_currentLocation!, 15);
    }
  }
  /// Resets the map rotation to 0 degrees (North up).
  void _resetRotationToNorth() {
    _mapController.rotate(0);
    // Note: The rotation state (_rotation) will update automatically
    // via the onPositionChanged callback in FlutterMap.
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Hi-Way-Go Tracker"),
          backgroundColor: const Color(0xFF21899C),
        ),
        body: _isLoading ?
          const LoaderWidget()
            : Stack(
          children: [
            /// ✅ The Map
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _currentLocation!,
                initialZoom: 13,
                onPositionChanged: (pos, hasGesture) {
                  final newRotation = _mapController.rotate(10);
                  if (mounted && newRotation != _rotation) {
                    setState(() {
                      _rotation = newRotation as double;
                    });
                  }
                },
              ),
              children: [
                TileLayer(
                  urlTemplate:
                  'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                  userAgentPackageName: 'com.hiwaygo.app',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _currentLocation!,
                      width: 40,
                      height: 40,
                      child: SvgPicture.asset(
                        'assets/person_icon.svg',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
                MarkerLayer(
                  markers: _busLocations.map((busLoc) {
                    return Marker(
                      point: busLoc,
                      width: 40,
                      height: 40,
                      child: SvgPicture.asset(
                        'assets/bus_icon.svg',
                        fit: BoxFit.contain,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),

            /// ✅ Compass widget
            Positioned(
              top: 20,
              right: 20,
              child: GestureDetector( // 👈 1. Wrap with GestureDetector
                onTap: _resetRotationToNorth, // 👈 2. Call the new method on tap
                child: Transform.rotate(
                  angle: -_rotation * math.pi / 180,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                        )
                      ],
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                        Icons.explore,
                        color: AppColors.colorGoogleButton,
                    ),
                  ),
                ),
              ),
            ),
            /// ✅ My Location button
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                heroTag: 'locate',
                onPressed: _centerOnUser,
                backgroundColor: AppColors.colorBackground,
                child: Icon(
                  Icons.my_location,
                  color: AppColors.colorGoogleButton,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
