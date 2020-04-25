import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:nitorinfotech/providers/auth.dart';
import 'package:nitorinfotech/widgets/Urlwidget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 56.0;
}

class CustomDialog extends StatefulWidget {
  final String username;

  CustomDialog({this.username});

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  Future<void> getDetails() async {
    await Provider.of<Auth>(context, listen: false)
        .getUserDetails(widget.username);
  }

  var formatter = new DateFormat('yyyy-MM-dd');

  dialogContent(BuildContext context) {
    return FutureBuilder(
      future: getDetails(),
      builder: (ctx, snap) => snap.connectionState == ConnectionState.waiting
          ? Shimmer.fromColors(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      top: Consts.avatarRadius + Consts.padding,
                      bottom: Consts.padding,
                      left: Consts.padding,
                      right: Consts.padding,
                    ),
                    margin: EdgeInsets.only(top: Consts.avatarRadius),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(Consts.padding),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          offset: const Offset(0.0, 10.0),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize:
                          MainAxisSize.min, // To make the card compact
                      children: <Widget>[
                        Text(
                          'Username',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Container(
                          child: Text(
                            '                ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              backgroundColor: Colors.grey,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 24.0),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: FlatButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pop(); // To close the dialog
                            },
                            child: Text('OKAY'),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    left: Consts.padding,
                    right: Consts.padding,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: Consts.avatarRadius,
                    ),
                  ),
                  //...top circlular image part,
                ],
              ),
              baseColor: Colors.grey,
              highlightColor: Colors.black)
          : Consumer<Auth>(
              builder: (ctx, auth, _) => Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      top: Consts.avatarRadius + Consts.padding,
                      bottom: Consts.padding,
                      left: Consts.padding,
                      right: Consts.padding,
                    ),
                    margin: EdgeInsets.only(top: Consts.avatarRadius),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(Consts.padding),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          offset: const Offset(0.0, 10.0),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize:
                          MainAxisSize.min, // To make the card compact
                      children: <Widget>[
                        auth.userdetails[0].name.isNotEmpty
                            ? Text(
                                auth.userdetails[0].name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            : Container(),
                        SizedBox(height: 10.0),
                        auth.userdetails[0].bio == 'null'
                            ? Container()
                            : Tooltip(
                                message: auth.userdetails[0].bio,
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.grey[300], width: 1)),
                                  child: Text(
                                    auth.userdetails[0].bio,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                              ),
                        SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  'Following',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  auth.userdetails[0].following,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  'Followers',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  auth.userdetails[0].follwers,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            )
                          ],
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Tooltip(
                                message: auth.userdetails[0].email != 'null'
                                    ? auth.userdetails[0].email
                                    : 'Not Mentioned',
                                child: GestureDetector(
                                    onTap: () {
                                      if (auth.userdetails[0].email != null) {
                                        launchURL(auth.userdetails[0].email);
                                      }
                                    },
                                    child: Icon(FontAwesomeIcons.at))),
                            Tooltip(
                                message: auth.userdetails[0].location != 'null'
                                    ? auth.userdetails[0].location
                                    : 'Not Mentioned',
                                child: GestureDetector(
                                    onTap: () {
                                      if (auth.userdetails[0].location !=
                                          'null') {
                                        lunchMap(auth.userdetails[0].location);
                                      }
                                    },
                                    child: Icon(FontAwesomeIcons.globeAsia))),
                          ],
                        ),
                        Divider(color: Colors.grey),
                        SizedBox(height: 10.0),
                        auth.userdetails[0].company != 'null'
                            ? Tooltip(
                                message: auth.userdetails[0].company,
                                child: RichText(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: 'Company: ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    children: <TextSpan>[
                                      TextSpan(
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400),
                                        text: '${auth.userdetails[0].company}',
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                        SizedBox(
                          height: 5,
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Create Date: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                style: TextStyle(fontWeight: FontWeight.w400),
                                text:
                                    '${formatter.format(DateTime.parse(auth.userdetails[0].created_at))}',
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  'Public Repo',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  auth.userdetails[0].public_repos,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  'Public Gists',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  auth.userdetails[0].public_gists,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 24.0),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: FlatButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pop(); // To close the dialog
                            },
                            child: Text('OKAY'),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    left: Consts.padding,
                    right: Consts.padding,
                    child: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      radius: Consts.avatarRadius,
                      child: ClipOval(
                        child: FadeInImage.assetNetwork(
                          image: auth.userdetails[0].userimage,
                          placeholder: 'assets/images/logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  //...top circlular image part,
                ],
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetAnimationDuration: Duration(seconds: 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 10.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}
