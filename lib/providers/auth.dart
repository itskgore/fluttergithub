import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/followers.dart';
import '../models/following.dart';
import '../models/user.dart';
import '../models/userdetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

String _clientid = 'Client_Id';
String _clientSecrete = 'Client_Secrete';
final String url = 'https://api.github.com/';
final String query = "?client_id=${_clientid}&client_secret=${_clientSecrete}";

class Auth extends ChangeNotifier {
  bool isLoading = false;

  List<UserDetails> _userdetails = [];
  List<UserDetails> get userdetails {
    return [..._userdetails];
  }

  List<User> _userdata = [];
  List<User> get userdata {
    return [..._userdata];
  }

  List<Following> _following = [];
  List<Following> get following {
    return [..._following];
  }

  List<Followers> _followers = [];
  List<Followers> get followers {
    return [..._followers];
  }

  set loading(bool data) {
    isLoading = data;
  }

  Future<bool> get loader async {
    return isLoading;
  }

  String username;
  Future<bool> login(String username) async {
    final res = await http.get(url + 'users/' + username + query);
    _userdata.clear();
    final data = json.decode(res.body) as Map<String, dynamic>;
    _userdata.add(User(
        id: data['id'].toString(),
        node_id: data['node_id'].toString(),
        userhtmlurl: data['html_url'].toString(),
        userimage: data['avatar_url'].toString(),
        followerurl: data['followers_url'].toString(),
        followingurl: data['following_url'].toString(),
        bio: data['bio'].toString(),
        company: data['company'].toString(),
        created_at: data['created_at'].toString(),
        email: data['email'].toString(),
        location: data['location'].toString(),
        name: data['name'].toString(),
        updated_at: data['updated_at'].toString(),
        username: data['login'].toString()));
    this.username = username;
    if (res.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      prefs.setInt('login', 1); //1 = Login 0= Logut
      prefs.setString('username', username);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> get isLogin async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('login')) {
      if (prefs.getInt('login') == 1) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> logout() async {
    _userdata.clear();
    _followers.clear();
    _following.clear();
    _userdetails.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.clear();
  }

  Future<void> getData2([GlobalKey<AnimatedListState> listKey]) async {
    _following.clear();
    String url = 'https://api.github.com/users/' +
        this.userdata[0].username +
        '/following';
    final res = await http.get(url + query);
    final data = json.decode(res.body);
    _following.clear();
    data.forEach((data) {
      _following.add(Following(
          id: data['id'].toString(),
          node_id: data['node_id'].toString(),
          userhtmlurl: data['html_url'].toString(),
          userimage: data['avatar_url'].toString(),
          followerurl: data['followers_url'].toString(),
          followingurl: data['following_url'].toString(),
          username: data['login'].toString()));
    });
  }

  Future<void> getData([GlobalKey<AnimatedListState> listKey]) async {
    _followers.clear();
    String url = 'https://api.github.com/users/' +
        this.userdata[0].username +
        '/followers';
    final res = await http.get(url + query);
    final data = json.decode(res.body);
    _followers.clear();
    data.forEach((data) {
      _followers.add(Followers(
          id: data['id'].toString(),
          node_id: data['node_id'].toString(),
          userhtmlurl: data['html_url'].toString(),
          userimage: data['avatar_url'].toString(),
          followerurl: data['followers_url'].toString(),
          followingurl: data['following_url'].toString(),
          username: data['login'].toString()));
    });
  }

  Future<void> check() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('username')) {
      final String username = prefs.getString('username');
      final res = await http.get(url + 'users/' + username + query);
      _userdata.clear();
      final data = json.decode(res.body) as Map<String, dynamic>;
      if (res.statusCode == 200) {
        _userdata.add(User(
            id: data['id'].toString(),
            node_id: data['node_id'].toString(),
            userhtmlurl: data['html_url'].toString(),
            userimage: data['avatar_url'].toString(),
            followerurl: data['followers_url'].toString(),
            followingurl: data['following_url'].toString(),
            bio: data['bio'].toString(),
            company: data['company'].toString(),
            created_at: data['created_at'].toString(),
            email: data['email'].toString(),
            location: data['location'].toString(),
            name: data['name'].toString(),
            updated_at: data['updated_at'].toString(),
            username: data['login'].toString()));
        return true;
      } else {
        return false;
      }
    } else {
      return;
    }
  }

  Future<void> getUserDetails(String username) async {
    final res = await http.get(url + 'users/' + username + query);
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      _userdetails.clear();
      _userdetails.add(UserDetails(
          bio: data['bio'].toString(),
          updated_at: data['updated_at'],
          public_gists: data['public_gists'].toString(),
          public_repos: data['public_repos'].toString(),
          company: data['company'].toString(),
          created_at: data['created_at'].toString(),
          email: data['email'].toString(),
          id: data['id'].toString(),
          location: data['location'].toString(),
          name: data['name'].toString(),
          following: data['following'].toString(),
          follwers: data['followers'].toString(),
          userhtmlurl: data['html_url'].toString(),
          userimage: data['avatar_url'].toString(),
          username: data['login'].toString()));
      return true;
    } else {
      return false;
    }
  }
}
