import 'package:flutter/material.dart';


class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              ListTile(
              title: Text('Select mobile networks'),
              onTap: () {
                 Navigator.pushNamed(context, '/mobile_networks');
              },
            ),
            ListTile(
              title: Text('Select Banks'),
              onTap: () {
                 Navigator.pushNamed(context, '/banks');
              },
            ),
            ListTile(
              title: Text('Select Payment Agent'),
              onTap: () {
                 Navigator.pushNamed(context, '/payment_agent');
              },
            ),
            ListTile(
              title: Text('Select Debts'),
              onTap: () {
                 Navigator.pushNamed(context, '/debts');
              },
            ),
            ],
            )

        ),
      ),

    );
  }
}