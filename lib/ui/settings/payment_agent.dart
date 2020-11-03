import 'package:flutter/material.dart';
import 'package:shared_preferences_settings/shared_preferences_settings.dart';


class PaymentAgentPage extends StatefulWidget {
  PaymentAgentPage({Key key}) : super(key: key);

  @override
  _PaymentAgentPageState createState() => _PaymentAgentPageState();
}

class _PaymentAgentPageState extends State<PaymentAgentPage> {
  @override
  Widget build(BuildContext context) {
    return SettingsScreen(
      title: "Payment Agent Settings",
      children: [
        CheckboxSettingsTile(
            settingKey: 'selcom',
            title: 'Selcom',
        ),        
      ],
    );
  }
}