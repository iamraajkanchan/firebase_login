import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  String name, email, password;

  checkAuthenticataion() async {
    _firebaseAuth.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.pushReplacementNamed(context, '/');
      }
    });
  }

  navigateToSignInScreen() async {
    Navigator.pushReplacementNamed(context, '/signIn');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.checkAuthenticataion();
  }

  showErrorMethod(String errorMessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(errorMessage),
            actions: <Widget>[
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              )
            ],
          );
        });
  }

  signUp() async {
    if (_globalKey.currentState.validate()) {
      _globalKey.currentState.save();
      try {
        UserCredential _userCredential = await _firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);
            if(_userCredential != null){
              User _user = _firebaseAuth.currentUser;
              _user.updateProfile(displayName: name);
            }
      } catch (e) {
        showErrorMethod(e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Container(
        child: Center(
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 50.0),
                child: Image(
                  image: AssetImage('assets/mascot.png'),
                  width: 100.0,
                  height: 100.0,
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _globalKey,
                  child: Column(
                    children: <Widget>[
                      // For Name
                      Container(
                        padding: EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'Please write your Name';
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onSaved: (input) => name = input,
                        ),
                      ),
                      // For Email
                      Container(
                        padding: EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'Please provide an email address';
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onSaved: (input) => email = input,
                        ),
                      ),
                      // For Password
                      Container(
                        padding: EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'Please provide the password';
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onSaved: (input) => password = input,
                          obscureText: true,
                        ),
                      ),
                      // For Button
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: MaterialButton(
                          padding:
                              EdgeInsets.fromLTRB(100.0, 20.0, 100.0, 20.0),
                          color: Colors.purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          onPressed: signUp,
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: navigateToSignInScreen,
                        child: Text('Have an account? Login!'),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
