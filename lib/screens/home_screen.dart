import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../navigatorAnimation/bouncinganagivation.dart';
import '../providers/auth.dart';
import '../screens/login_screen.dart';
import '../screens/nodata.dart';
import '../widgets/CustomDialog.dart';
import '../widgets/listData.dart';
import '../widgets/listshimmer.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  bool isLoading = false;
  bool loader = false;
  TabController tabController;

  Future<void> getFollowing(BuildContext con) async {
    await Provider.of<Auth>(context, listen: false).getData2();
  }

  Future<void> getFollower(BuildContext con) async {
    await Provider.of<Auth>(context, listen: false).getData();
  }

  Future<void> check() async {
    print('intt');
    setState(() {
      loader = true;
    });
    await Provider.of<Auth>(context, listen: false).check();
    setState(() {
      loader = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(vsync: this, length: 2);

    check();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildItem(
      BuildContext context, String item, Animation<double> animation) {
    TextStyle textStyle = new TextStyle(fontSize: 20);
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizeTransition(
        sizeFactor: animation,
        axis: Axis.vertical,
        child: SizedBox(
          height: 50.0,
          child: Card(
            child: Center(
              child: Text(item, style: textStyle),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(28, 28, 28, 1),
      floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: BorderSide(color: Colors.grey, width: 1)),
          elevation: 10,
          focusElevation: 5,
          highlightElevation: 15,
          isExtended: true,
          backgroundColor: Colors.black,
          child: isLoading
              ? CircularProgressIndicator()
              : Icon(FontAwesomeIcons.powerOff),
          onPressed: () async {
            final data =
                await Provider.of<Auth>(context, listen: false).logout();

            if (data) {
              Navigator.pushReplacement(
                  context, DownSlideNavigation(widget: LoginScreen()));
            } else {
              final snackBar = new SnackBar(
                content: new Text('Something went wrong!!'),
                duration: new Duration(seconds: 3),
                action: SnackBarAction(
                    label: 'Ok',
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              );
              Scaffold.of(context).showSnackBar(snackBar);
            }
          }),
      appBar: AppBar(
        title: loader
            ? Shimmer.fromColors(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                        // backgroundImage:
                        //     NetworkImage(auth.userdata[0].userimage),
                        ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Username',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                baseColor: Colors.grey,
                highlightColor: Colors.black)
            : Consumer<Auth>(
                builder: (ctx, auth, _) => GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => CustomDialog(
                        username: auth.userdata[0].username,
                      ),
                    );
                  },
                  child: Container(
                      // color: Colors.red,
                      alignment: Alignment.center,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(auth.userdata[0].userimage),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            auth.userdata[0].username,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      )),
                ),
              ),
        bottom: TabBar(
          tabs: [
            Tab(
              child: Text("Following"),
            ),
            Tab(
              child: Text("Followers"),
            ),
          ],
          indicatorColor: Colors.white,
          controller: tabController,
        ),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: TabBarView(
          controller: tabController,
          children: [
            RefreshIndicator(
              onRefresh: () => getFollowing(context),
              child: Column(
                children: <Widget>[
                  loader
                      ? Shimmer.fromColors(
                          child: ListShimmer(),
                          baseColor: Colors.grey,
                          highlightColor: Colors.black)
                      : FutureBuilder(
                          future: getFollowing(context),
                          builder: (ctx, snap) => snap.connectionState ==
                                  ConnectionState.waiting
                              ? Shimmer.fromColors(
                                  child: ListShimmer(),
                                  baseColor: Colors.grey,
                                  highlightColor: Colors.black)
                              : Consumer<Auth>(
                                  builder: (ctx, auth, _) => Expanded(
                                      child: ListView.builder(
                                    itemCount: auth.following.length,
                                    itemBuilder: (ctx, i) => auth
                                                .following.length ==
                                            0
                                        ? NoneWidget(
                                            'Your not following anyone!')
                                        : Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                side: BorderSide(
                                                    color: Colors.grey,
                                                    width: 1)),
                                            elevation: 5,
                                            color:
                                                Color.fromRGBO(23, 23, 23, 1),
                                            child: ListTileData(
                                              htmlurl:
                                                  auth.following[i].userhtmlurl,
                                              imageurl:
                                                  auth.following[i].userimage,
                                              username:
                                                  auth.following[i].username,
                                            ),
                                          ),
                                  )),
                                ),
                        ),
                ],
              ),
            ),
            RefreshIndicator(
              onRefresh: () => getFollower(context),
              child: Column(
                children: <Widget>[
                  loader
                      ? ListShimmer()
                      : FutureBuilder(
                          future: getFollower(context),
                          builder: (ctx, snap) => snap.connectionState ==
                                  ConnectionState.waiting
                              ? ListShimmer()
                              : Consumer<Auth>(
                                  builder: (ctx, auth, _) => auth
                                          .followers.isEmpty
                                      ? NoneWidget('No Followers')
                                      : Expanded(
                                          child: ListView.builder(
                                          itemCount: auth.followers.length,
                                          itemBuilder: (ctx, i) => Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                side: BorderSide(
                                                    color: Colors.grey,
                                                    width: 1)),
                                            elevation: 5,
                                            color:
                                                Color.fromRGBO(23, 23, 23, 1),
                                            child: ListTileData(
                                              htmlurl:
                                                  auth.followers[i].userhtmlurl,
                                              imageurl:
                                                  auth.followers[i].userimage,
                                              username:
                                                  auth.followers[i].username,
                                            ),
                                          ),
                                        )),
                                ),
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
