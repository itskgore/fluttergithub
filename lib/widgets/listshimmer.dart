import 'package:flutter/material.dart';

class ListShimmer extends StatelessWidget {
  const ListShimmer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      itemBuilder: (ctx, i) => Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey, width: 1)),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.black,
            maxRadius: 25,
          ),
          title: Text('username'),
          subtitle: Text('url'),
        ),
      ),
    );
  }
}
