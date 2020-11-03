import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './ui/home/home.dart';
import './ui/data/data.dart';
import './ui/chart/chart.dart';
import 'package:after_layout/after_layout.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Routes extends StatefulWidget {
  Routes({Key key}) : super(key: key);

  @override
  _RoutesState createState() => _RoutesState();
}

class _RoutesState extends State<Routes> with AfterLayoutMixin<Routes> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  final List<Widget> _children = <Widget>[
    HomePage(),
    DataPage(),
    ChartPage(),
  ];

  final List<Widget> _listTitle = <Widget>[
    Text(
      'Home',
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
    ),
    Text(
      'Data',
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
    ),
    Text(
      'Trend',
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
    )
  ];

  Future<void> checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _introSeen = (prefs.getBool('intro-seen') ?? false);

    if (_introSeen == false) {
      await prefs.setBool('intro-seen', true);
      Navigator.pushNamed(context, '/intro_screen');
    }
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // Calling the same function "after layout" to resolve the issue.
    checkFirstSeen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.notes,
            color: Colors.black,
          ),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
        title: _listTitle[_selectedIndex],
        toolbarHeight: 100,
        // shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        // backgroundColor: Color.fromRGBO(135, 31, 120, 1),
        backgroundColor: Colors.grey[50],
        // shadowColor: Color.fromRGBO(87, 20, 77, 1),
        // bottomOpacity: 0,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[50],
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/img/tpesa-logo.jpg'),
                      radius: 30,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'MAUREEN KILUWA COMPANY',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                   Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'MAUREEN KILUWA',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '+255 654 457 899',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Color.fromRGBO(151, 35, 133, 1),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
            ListTile(
              leading: Icon(Icons.arrow_back),
              title: Text('Back'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: _children[_selectedIndex],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/calc');
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
        backgroundColor: Color.fromRGBO(151, 35, 133, 0.8),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(.1),
          )
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
                color: Colors.grey,
                gap: 8,
                activeColor: Colors.white,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                duration: Duration(milliseconds: 800),
                tabBackgroundColor: Color.fromRGBO(151, 35, 133, 1),
                tabs: [
                  GButton(
                    icon: Icons.home_rounded,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.date_range_rounded,
                    text: 'Data',
                  ),
                  GButton(
                    icon: Icons.trending_up_rounded,
                    text: 'Trend',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }),
          ),
        ),
      ),
    );
  }
}
