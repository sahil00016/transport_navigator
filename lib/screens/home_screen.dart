import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../services/route_service.dart';
import '../services/firebase_service.dart';
import '../widgets/route_card.dart';
import '../widgets/preference_slider.dart';
import '../utils/constants.dart';
import '../models/route_model.dart';
import '../models/preference_model.dart'; // Added import for PreferenceModel

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RouteService _routeService = RouteService();
  final FirebaseService _firebaseService = FirebaseService();
  double _sliderValue = 0.5;
  bool _showRoute = false;
  RouteModel? _currentRoute;

  void _calculateRoute() async {
    final route = _routeService.calculateOptimalRoute(_sliderValue);
    setState(() {
      _currentRoute = route;
      _showRoute = true;
    });
    await _firebaseService.saveRoute(route);
    await _firebaseService.savePreference('anonymous_user', _sliderValue);
    Get.snackbar('Route Calculated', 'Optimal route found!', backgroundColor: Colors.black54);
  }

  @override
  void initState() {
    super.initState();
    _loadPreference();
  }

  Future<void> _loadPreference() async {
    final pref = await _firebaseService.getPreference('anonymous_user');
    if (pref != null && mounted) {
      setState(() {
        _sliderValue = pref.speedVsCost;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Smart Navigator',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: FlutterMap(
                  options: const MapOptions(
                    initialCenter: LatLng(51.509364, -0.128928),
                    initialZoom: 12,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: const ['a', 'b', 'c'],
                    ),
                    if (_showRoute)
                      PolylineLayer(
                        polylines: [
                          Polyline(
                            points: [
                              const LatLng(51.509364, -0.128928),
                              const LatLng(51.513, -0.135),
                              const LatLng(51.515, -0.140),
                            ],
                            strokeWidth: 4,
                            color: const Color(0xFF4FC3F7),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'AI-Optimized Route',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              AnimatedOpacity(
                opacity: _showRoute ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: _currentRoute != null
                    ? RouteCard(route: _currentRoute!)
                    : const SizedBox.shrink(),
              ),
              const SizedBox(height: 20),
              PreferenceSlider(
                value: _sliderValue,
                onChanged: (value) {
                  setState(() {
                    _sliderValue = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0288D1),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: _calculateRoute,
                  child: Text(
                    'Find Route',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}