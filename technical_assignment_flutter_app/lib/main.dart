import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_assignment_flutter_app/providers/authentication.dart';
import 'package:technical_assignment_flutter_app/screens/login_screen.dart';
import 'package:technical_assignment_flutter_app/screens/register_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: Auth())],
      child: MaterialApp(
        home: MyHome(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home page')),
      drawer: Drawer(
        child: Container(
          color: Color.fromRGBO(50, 75, 205, 1),
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              const SizedBox(
                height: 38,
              ),
              // DrawerHeader(
              //   decoration: BoxDecoration(
              //     color: Colors.blue,
              //   ),
              //   child: Text('Techinal Application'),
              // ),
              ListTile(
                title: Text('Login Screen'),
                onTap: () {
                  // Update the state of the app
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Register Screen'),
                onTap: () {
                  // Update the state of the app
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(20),
          height: 300,
          width: 200,
          decoration: BoxDecoration(
              color: Colors.lime,
              boxShadow: const [
                BoxShadow(blurRadius: 10),
              ],
              borderRadius: BorderRadius.all(Radius.circular(18))),
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "Login Here",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen())),
                    ),
                  ),
                  Center(
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "Register Here",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen())),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
