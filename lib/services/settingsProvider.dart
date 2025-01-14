import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  String _unit = 'Kelvin'; // Default value

  String get unit => _unit;

  void setUnit(String newUnit) async {
    _unit = newUnit;
    notifyListeners(); // Notify listeners about the change
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('unit', newUnit);
  }

  Future<void> loadUnitPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _unit = prefs.getString('unit') ?? 'Celsius';
    notifyListeners(); // This is not strictly necessary here unless the value can change outside of setUnit
  }
}