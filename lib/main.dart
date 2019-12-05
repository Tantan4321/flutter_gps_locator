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
  void initState() {
    super.initState();
    initPlatformState();
  }

  initPlatformState() async {
    await _locationService.changeSettings(accuracy: LocationAccuracy.HIGH, interval: 1000);

    LocationData location;

    try {
      bool serviceStatus = await _locationService.serviceEnabled();
      if (serviceStatus) {
        bool perm = await _locationService.requestPermission();
        if (perm) {
          location = await _locationService.getLocation();

          _locationSubscription = _locationService.onLocationChanged().listen((LocationData result) async {
            if(mounted){
              setState(() {
                _location = result;
              });
            }
          });
        }
      } else {
        bool serviceStatusResult = await _locationService.requestService();
        print("Service status activated after request: $serviceStatusResult");
        if(serviceStatusResult){
          initPlatformState();
        }
      }
    } on Exception catch (e) {
      print(e);
      location = null;
    }

    setState(() {
    });

  }

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
            Icon(Icons.location_on,
            color: _location != null  ? Colors.blue : Colors.grey,
            size: width * 0.5,
            ),
            SizedBox(height: height * 0.1),
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(12.0),
                  width: width * 0.4,
                  child: Text(
                    'Latitude:',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                Expanded(
                  child: Text(
                    _location != null  ? _location.latitude.toStringAsPrecision(7) : "",
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
                    _location != null ? _location.longitude.toStringAsPrecision(7) : "",
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
