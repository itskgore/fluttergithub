import 'package:flutter/material.dart';
import 'package:nitorinfotech/providers/auth.dart';
import 'package:nitorinfotech/screens/home_screen.dart';
import 'package:nitorinfotech/screens/login_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Consumer<Auth>(
          builder: (ctx, auth, _) => FutureBuilder(
              future: auth.isLogin,
              builder: (ctx, snap) =>
                  snap.connectionState == ConnectionState.waiting
                      ? CircularProgressIndicator()
                      : snap.data ? HomeScreen() : LoginScreen()),
        ),
      ),
    );
  }
}
