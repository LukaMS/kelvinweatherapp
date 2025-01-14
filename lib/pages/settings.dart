import 'package:flutter/material.dart';
import 'package:weatherapp/services/settingsProvider.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context, true); // Pass true to indicate settings changed
          },
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 65, 13, 161),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            tiles: [
              SettingsTile.switchTile(
                title: const Text('Use Kelvin Units'),
                leading: const Icon(Icons.thermostat_outlined),
                initialValue: Provider.of<SettingsProvider>(context).unit == 'Kelvin',
                onToggle: (bool value) {
                  Provider.of<SettingsProvider>(context, listen: false)
                      .setUnit(value ? 'Kelvin' : 'Celsius');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
