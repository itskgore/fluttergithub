import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../navigatorAnimation/bouncinganagivation.dart';
import '../providers/auth.dart';
import '../screens/home_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Map<String, String> _authData22 = {
    'username': '',
  };
  bool isLoading = false;
  Future<void> _submit(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      // Invalid! test
      return;
    }
    _formKey.currentState.save();
    setState(() {
      isLoading = true;
    });

    final data = await Provider.of<Auth>(context, listen: false)
        .login(_authData22['username']);
    setState(() {
      isLoading = false;
    });
    if (data) {
      Navigator.pushReplacement(context, FadeNavigation(widget: HomeScreen()));
    } else {
      final snackBar = new SnackBar(
        content: new Text('Invalid Username'),
        action: new SnackBarAction(
          label: 'OK',
          onPressed: () async {},
        ),
        duration: new Duration(seconds: 3),
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: SafeArea(
          child: ListView(
            primary: false,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.10),
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius:
                                  20.0, // has the effect of softening the shadow
                              spreadRadius:
                                  5.0, // has the effect of extending the shadow
                              offset: Offset(
                                0.0, // horizontal, move right 10
                                15.0, // vertical, move down 10
                              ),
                            )
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  ExactAssetImage("assets/images/logo.png")))),
                ],
              ),
              SizedBox(height: 1),
              Text(
                'Github',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.10,
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        autocorrect: true,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          labelText: 'User name',
                          labelStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 2.0)),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: Colors.teal, width: 2)),
                        ),
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (val) {
                          if (val.isNotEmpty) {
                            _submit(context);
                          }
                        },
                        validator: (value) {
                          value = value.trim();

                          if (value.isEmpty) {
                            return 'Username is requried!';
                          }
                        },
                        onSaved: (value) {
                          _authData22['username'] = value;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      isLoading
                          ? CircularProgressIndicator()
                          : Container(
                              width: MediaQuery.of(context).size.width * 0.50,
                              padding: const EdgeInsets.all(8.0),
                              child: OutlineButton(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.white),
                                onPressed: () {
                                  _submit(context);
                                },
                                padding: EdgeInsets.symmetric(vertical: 13),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                child: Text(
                                  'Hop In!',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                            ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
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
