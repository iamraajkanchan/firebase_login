import 'package:firebase_login/homepage.dart';
import 'package:firebase_login/signin.dart';
import 'package:firebase_login/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(
                "Something Went Wrong, We are not able to connect the database");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              title: 'Firebase Login',
              theme: ThemeData(
                primarySwatch: Colors.deepPurple,
              ),
              routes: {
                '/': (context) => HomePage(),
                '/signIn': (context) => SignIn(),
                '/signUp': (context) => SignUp()
              },
              initialRoute: '/',
            );
          }
          return SpinKitRotatingCircle(
            color: Colors.white,
            size: 50.0,
          );
        });
  }
}
