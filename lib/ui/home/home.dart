import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   color: Color.fromRGBO(135, 31, 120, 1),
      //   borderRadius: BorderRadius.vertical(
      //     top: Radius.circular(30),
      //   ),
      // ),
      // padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
            child: Text(
              'Welcome!',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 28,
                color: Color.fromRGBO(23, 5, 21, 1),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(135, 31, 120, 1),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),
            padding: EdgeInsets.fromLTRB(20,25,20,80),
            height: 600,
            child: GridView.count(
              scrollDirection: Axis.vertical,
              crossAxisCount: 2,
              children: List.generate(10, (index) {
                return Container(
                  child: Card(
                    color: Colors.white,
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
