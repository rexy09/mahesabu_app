import 'package:flutter/material.dart';
import 'package:mahesabu/ui/calculation/calculation.dart';
import './routes.dart';
import './ui/home/home.dart';
import './ui/data/data.dart';
import './ui/settings/settings.dart';
import './ui/settings/mobile_networks.dart';
import './ui/settings/banks.dart';
import './ui/calculation/calculation.dart';
import './ui/settings/debts.dart';
import './ui/settings/payment_agent.dart';
import './ui/introduction_screen/introduction_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mahesabu',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/home': (context) => HomePage(),
        '/data': (context) => DataPage(),
        '/settings': (context) => SettingsPage(),
        '/mobile_networks': (context) => MobileNetworksPage(),
        '/banks': (context) => BanksPage(),
        '/calc': (context) => CalculationPage(),
        '/payment_agent': (context) => PaymentAgentPage(),
        '/debts': (context) => DebtsPage(),
        '/intro_screen': (context) => IntroductionScreenPage(),
      },
      home: Routes(),
    );
  }
}
