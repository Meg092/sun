import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sun_record/db_sun/db_sun.dart';
import 'package:sun_record/db_sun/sun_entity.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class SunMainLogic extends GetxController {

  DBSun dbSun = Get.find();

  var typeStr = 'Sunny'.obs;
  var c = 22.0.obs;
  var weatherIcon = WeatherIcons.day_sunny.obs;

  CalendarFormat calendarFormat = CalendarFormat.month;

  var list = <SunEntity>[];
  var currentDate = DateTime.now();

  void getData() async {
    final result = await dbSun.getSunAllData();
    list.clear();
    list = result.where((element) {
      return element.startTime.year == currentDate.year &&
          element.startTime.month == currentDate.month &&
          element.startTime.day == currentDate.day;
    }).toList();
    update();
  }

  bool isValidCoordinate(double lat, double lng) {
    return (lat >= -90 && lat <= 90) && (lng >= -180 && lng <= 180);
  }

  IconData _getIconByCondition(String condition) {
    switch (condition.toLowerCase()) {
      case 'sunny':
      case 'clear':
        return Icons.wb_sunny;
      case 'cloudy':
      case 'partly cloudy':
        return Icons.cloud;
      case 'rain':
      case 'showers':
        return Icons.grain;
      default:
        return Icons.sunny;
    }
  }

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final url = Uri.parse('http://wttr.in/$city?format=j1');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load weather');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<void> _checkLocationPermission() async {
    final status = await Permission.locationWhenInUse.request();
    if (status.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
          distanceFilter: 1000,
        ),
      );

      String? city = '';
      if (isValidCoordinate(position.latitude, position.longitude)) {
        try {
          List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude,
            position.longitude,
          );

          if (placemarks.isEmpty) {
            return;
          }

          Placemark place = placemarks.first;
          city = place.locality;
          if (city == null || city.isEmpty) {
            city = place.subAdministrativeArea ?? place.administrativeArea;
          }
        } catch (_) {}
        if (city == null || city.isEmpty) {
          city = 'Beijing';
        }
        final data = await fetchWeather(city!);
        final current = data['current_condition'][0];
        final weatherDec = '${current['weatherDesc'][0]['value']}';
        final weatherC = '${current['temp_C']}';
        c.value = double.parse(weatherC);
        typeStr.value = 'Sunny';
        weatherIcon.value = _getIconByCondition(typeStr.value);
      }
    } else {
      _showPermissionDialog();
    }
  }

  void _showPermissionDialog() {
    showDialog(
      context: Get.context!,
      builder: (ctx) => AlertDialog(
        title: const Text('Location permissions required'),
        content: const Text('Please grant location permission to get distance'),
        actions: [
          TextButton(
            onPressed: () => openAppSettings(),
            child: const Text('Setting'),
          ),
        ],
      ),
    );
  }

  @override
  void onInit() {
    // TODO: implement onInit
    _checkLocationPermission();
    getData();
    super.onInit();
  }
}
