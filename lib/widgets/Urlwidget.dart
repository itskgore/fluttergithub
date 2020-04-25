import 'package:url_launcher/url_launcher.dart';
import 'package:maps_launcher/maps_launcher.dart';

Future<void> lunchMap(String loca) {
  MapsLauncher.launchQuery(loca);
}

Future<void> launchInBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    );
  } else {
    throw 'Could not launch $url';
  }
}

void launchURL(String mail) async {
  final Uri params = Uri(
    scheme: 'mailto',
    path: mail,
  );
  String url = params.toString();
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('Could not launch $url');
  }
}
