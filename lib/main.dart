import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Location',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  LocationData _location;
  StreamSubscription<LocationData> _locationSubscription;

  Location _locationService = new Location();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('My Location'),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(12.0),
                  width: width * 0.4,
                  child: Text(
                    'Lattitude:',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                Expanded(
                  child: Text(
                    '0',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.display2,
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.1),
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(12.0),
                  width: width * 0.4,
                  child: Text(
                    'Longitude:',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                Expanded(
                  child: Text(
                    '0',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.display2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
