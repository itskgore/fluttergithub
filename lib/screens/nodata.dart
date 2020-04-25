import 'package:flutter/material.dart';

class NoneWidget extends StatelessWidget {
  final String title;
  NoneWidget(
    this.title, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        Container(
          height: 150,
          width: 150,
          child: Image.asset(
            'assets/images/none.gif',
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ],
    );
  }
}
