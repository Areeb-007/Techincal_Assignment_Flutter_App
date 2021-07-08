import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_assignment_flutter_app/providers/authentication.dart';
import 'package:technical_assignment_flutter_app/screens/login_screen.dart';
import 'package:technical_assignment_flutter_app/screens/register_screen.dart';
// import 'package:technical_assignment_flutter_app/widgets/drawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider.value(value: Auth())],
        child: MaterialApp(
          home: MyHome(),
          theme: ThemeData(
            primarySwatch: Colors.pink,
            accentColor: Colors.amber,
            canvasColor: Color.fromRGBO(255, 254, 229, 1),
            fontFamily: 'Raleway',
            textTheme: ThemeData.light().textTheme.copyWith(
                  bodyText2: TextStyle(
                    color: Color.fromRGBO(20, 51, 51, 1),
                  ),
                ),
          ),
          debugShowCheckedModeBanner: false,
        ));
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  bool buffering = false;
  void changeBufferingStateToTrue() {
    setState(() {
      buffering = true;
    });
  }

  @override
  void initState() {
    super.initState();
    buffering = false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
            ),
      ),
      home: buffering
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
              appBar: AppBar(
                  centerTitle: true,
                  title: Text(
                    'Technical App',
                    style: TextStyle(
                        leadingDistribution: TextLeadingDistribution.even),
                    textAlign: TextAlign.center,
                  )),
              body: Center(
                  child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(20),
                  height: 600,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(blurRadius: 10),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(18))),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(12),
                        padding: EdgeInsets.all(12),
                        child: Text(
                          'Welcome',
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontSize: 40),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      LoginScreen(changeBufferingStateToTrue),
                      Text(
                        'or',
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                buffering = false;
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()));
                            },
                            child: Text('Register yourself')),
                      )
                    ],
                  ),
                ),
              ))),
      debugShowCheckedModeBanner: false,
    );
  }
}
