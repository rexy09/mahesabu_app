import 'package:flutter/material.dart';
import 'package:shared_preferences_settings/shared_preferences_settings.dart';

class MobileNetworksPage extends StatefulWidget {
  MobileNetworksPage({Key key}) : super(key: key);

  @override
  _MobileNetworksPageState createState() => _MobileNetworksPageState();
}

class _MobileNetworksPageState extends State<MobileNetworksPage> {
  @override
  Widget build(BuildContext context) {
    return SettingsScreen(
      title: "Mobile Networks Settings",
      children: [
        CheckboxSettingsTile(
          settingKey: 'mpesa',
          title: 'M-Pesa',
        ),
        CheckboxSettingsTile(
          settingKey: 'tigopesa',
          title: 'Tigo Pesa',
        ),
        CheckboxSettingsTile(
          settingKey: 'airtelmoney',
          title: 'Airtel Money',
        ),
        CheckboxSettingsTile(
          settingKey: 'halopesa',
          title: 'Halo Pesa',
        ),
        CheckboxSettingsTile(
          settingKey: 'tpesa',
          title: 'T-Pesa',
        ),
        CheckboxSettingsTile(
          settingKey: 'ezypesa',
          title: 'EzyPesa',
        ),
      ],
    );
  }
}
