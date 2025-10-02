import 'package:flutter/material.dart';
import '../../../config/constants/string_constants.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringConstants.weatherAndAlerts),
      ),
      body: const Center(
        child: Text('Weather Screen - Under Development'),
      ),
    );
  }
}
