import 'package:flight_app/flight_app_concept/flight_form.dart';
import 'package:flutter/material.dart';

import 'flight_app_concept/flight_timeline.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum FlightView {
  form,
  timeline,
}

class _MyHomePageState extends State<MyHomePage> {
  FlightView flightView = FlightView.form;

  void _onFlightPressed() {
    setState(() {
      flightView = FlightView.timeline;
    });
  }

  @override
  Widget build(BuildContext context) {
    final headerHeight = MediaQuery.of(context).size.height * 0.32;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
              height: headerHeight,
              left: 0,
              right: 0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFE04148),
                      Color(0xFFd85774),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Air Asia',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          HeaderButton(
                            title: 'One Way',
                          ),
                          HeaderButton(
                            title: 'Round',
                          ),
                          HeaderButton(
                            title: 'Multicity',
                            selected: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 10,
              right: 10,
              top: headerHeight / 2,
              bottom: 0,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TabButton(
                            title: 'Flight',
                            selected: true,
                          ),
                        ),
                        Expanded(
                          child: TabButton(
                            title: 'Train',
                          ),
                        ),
                        Expanded(
                          child: TabButton(
                            title: 'Bus',
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: flightView == FlightView.form
                          ? FlightForm(
                              onTap: _onFlightPressed,
                            )
                          : FlightTimeline(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabButton extends StatelessWidget {
  final String title;
  final bool selected;

  const TabButton({Key key, this.title, this.selected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              title,
              style: TextStyle(color: selected ? Colors.black : Colors.grey),
            ),
          ),
          if (selected) Container(height: 2, color: Colors.red),
        ],
      ),
    );
  }
}

class HeaderButton extends StatelessWidget {
  final String title;
  final bool selected;

  const HeaderButton({Key key, this.title, this.selected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: selected ? Colors.white : null,
          border: Border.all(
            color: Colors.white,
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 13),
        child: Center(
          child: Text(
            title.toUpperCase(),
            style: TextStyle(color: selected ? Colors.red : Colors.white),
          ),
        ),
      ),
    );
  }
}
