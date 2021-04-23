import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User user;
  bool isSignedIn = false;

  checkAuthentication() async {
    _firebaseAuth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushReplacementNamed(context, '/signIn');
      }
    });
  }

  getUser() async {
    User _user = await _firebaseAuth.currentUser;
    await _user?.reload();
    _user = await _firebaseAuth.currentUser;
    if (_user != null) {
      setState(() {
        this.user = _user;
        this.isSignedIn = true;
      });
    }
    print(this.user);
  }

  signOut() async {
    _firebaseAuth.signOut();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.checkAuthentication();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        child: Center(
          child: !isSignedIn
              ? CircularProgressIndicator()
              : Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(50.0),
                      child: Image(
                        image: AssetImage('assets/mascot.png'),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(50.0),
                      child: Text(
                        'Hello, ${user.displayName}, you are logged in as ${user.email}',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: MaterialButton(
                        color: Colors.purple,
                        padding: EdgeInsets.fromLTRB(100.0, 20.0, 100.0, 20.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        onPressed: signOut,
                        child: Text(
                          'Sign Out',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ), 
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
