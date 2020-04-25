import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/CustomDialog.dart';
import '../widgets/Urlwidget.dart';

class ListTileData extends StatelessWidget {
  final String username;
  final String htmlurl;
  final String imageurl;
  const ListTileData({
    this.htmlurl,
    this.imageurl,
    this.username,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => CustomDialog(
            username: username,
          ),
        );
      },
      trailing: IconButton(
          color: Colors.lightBlue,
          icon: Icon(FontAwesomeIcons.globe),
          onPressed: () {
            launchInBrowser(htmlurl);
          }),
      subtitle: GestureDetector(
        child: Text(
          htmlurl,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.blue),
        ),
      ),
      title: Text(
        username,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      ),
      leading: CircleAvatar(
        maxRadius: 25,
        backgroundColor: Colors.grey,
        backgroundImage: NetworkImage(imageurl),
      ),
    );
  }
}
