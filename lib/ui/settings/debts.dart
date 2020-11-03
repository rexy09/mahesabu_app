import 'package:flutter/material.dart';
import 'package:shared_preferences_settings/shared_preferences_settings.dart';


class DebtsPage extends StatefulWidget {
  DebtsPage({Key key}) : super(key: key);

  @override
  _DebtsPageState createState() => _DebtsPageState();
}

class _DebtsPageState extends State<DebtsPage> {
  @override
  Widget build(BuildContext context) {
    return SettingsScreen(
      title: "Debts Settings",
      children: [
        CheckboxSettingsTile(
            settingKey: 'debts',
            title: 'Debts',
        ),        
      ],
    );
  }
}