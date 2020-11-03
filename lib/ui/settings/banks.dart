import 'package:flutter/material.dart';
import 'package:shared_preferences_settings/shared_preferences_settings.dart';


class BanksPage extends StatefulWidget {
  BanksPage({Key key}) : super(key: key);

  @override
  _BanksPageState createState() => _BanksPageState();
}

class _BanksPageState extends State<BanksPage> {
  @override
  Widget build(BuildContext context) {
    return SettingsScreen(
      title: "Banks Settings",
      children: [
        CheckboxSettingsTile(
            settingKey: 'crdb',
            title: 'CRDB Bank',
        ),
        CheckboxSettingsTile(
            settingKey: 'nmb',
            title: 'NMB Bank',
        ),
        CheckboxSettingsTile(
            settingKey: 'equity',
            title: 'EQUITY Bank',
        ),
        CheckboxSettingsTile(
            settingKey: 'nbc',
            title: 'NBC Bank',
        ),
        CheckboxSettingsTile(
            settingKey: 'tpb',
            title: 'TPB Bank',
        ),
        CheckboxSettingsTile(
            settingKey: 'access',
            title: 'Access Bank',
        ),
        CheckboxSettingsTile(
            settingKey: 'azania',
            title: 'Azania Bank',
        ),
      ],
    );
  }
}