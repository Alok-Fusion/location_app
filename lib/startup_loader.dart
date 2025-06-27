import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import 'locale_provider.dart';
import 'screens/home_screen.dart';

class StartupLoader extends StatefulWidget {
  const StartupLoader({super.key});

  @override
  State<StartupLoader> createState() => _StartupLoaderState();
}

class _StartupLoaderState extends State<StartupLoader> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _detectLocale();
  }

  Future<void> _detectLocale() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled
        _setDefaultsAndNavigate();
        return;
      }

      // Check for permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _setDefaultsAndNavigate();
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever
        _setDefaultsAndNavigate();
        return;
      }

      // Get current position
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      final countryCode = placemarks.first.isoCountryCode ?? 'US';
      final languageCode = _mapCountryToLanguage(countryCode);
      final currencySymbol = _mapCountryToCurrency(countryCode);

      if (!mounted) return;

      final userAgreed = await _askPermissionDialog(languageCode);

      final provider = Provider.of<LocaleProvider>(context, listen: false);
      if (userAgreed) {
        provider.setLocale(languageCode);
      } else {
        provider.setLocale('en');
      }
      provider.setCurrencySymbol(currencySymbol);
    } catch (e) {
      debugPrint("Location detection failed: $e");
      _setDefaultsAndNavigate();
      return;
    }

    // Navigate to home screen after everything done
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
  }

  void _setDefaultsAndNavigate() {
    final provider = Provider.of<LocaleProvider>(context, listen: false);
    provider.setLocale('en');
    provider.setCurrencySymbol('\$');

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
  }

  Future<bool> _askPermissionDialog(String languageCode) async {
    const languageNames = {
      'en': 'English',
      'fr': 'French',
      'es': 'Spanish',
      'de': 'German',
      'hi': 'Hindi',
      'ja': 'Japanese',
    };

    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('Change Language?'),
            content: Text(
                'We detected your region prefers ${languageNames[languageCode] ?? languageCode}. Would you like to switch the app language to that?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  String _mapCountryToLanguage(String code) {
    const map = {
      'US': 'en',
      'FR': 'fr',
      'ES': 'es',
      'DE': 'de',
      'IN': 'hi',
      'JP': 'ja',
    };
    return map[code] ?? 'en';
  }

  String _mapCountryToCurrency(String code) {
    const map = {
      'US': '\$',
      'FR': '€',
      'ES': '€',
      'DE': '€',
      'IN': '₹',
      'JP': '¥',
    };
    return map[code] ?? '\$';
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
