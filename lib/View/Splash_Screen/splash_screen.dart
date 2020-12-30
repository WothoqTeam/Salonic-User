import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:salonic/Custom_Widgets/export_file.dart';
import 'package:salonic/Model/Search/search_by_location_model.dart';
import 'package:salonic/Presenter/static_methods.dart';
import 'package:salonic/View/Home/Search/search_class.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  final GlobalKey<NavigatorState> navKey = GlobalKey();
  AppPushNotifications appPushNotifications = AppPushNotifications();
  SharedPreferences sharedPrefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        sharedPrefs = prefs;
      });
    });
    setState(() {
      appPushNotifications.notificationSetup(navKey);
    });
    Future<PermissionStatus> permissionStatus =
        NotificationPermissions.getNotificationPermissionStatus();
    permissionStatus.then((status) {
    });

    Timer(Duration(seconds: 2), () {
      try {
        checkAuthentication(sharedPrefs.getString('user_access_token'));
      } catch (e) {
        checkAuthentication(null);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Image(
          image: AssetImage('images/splash_screen/saloniclogo.png'),
          height: 200,
          width: 200,
        ),
      ),
    );
  }

  void checkAuthentication(String token) async {
    if (token == null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => UserSignIn()));
    } else {
      new CircularProgressIndicator();

      //we use here to getSalonsByName
      StaticMethods.search_salons_list = ApiProvider.getAllSalons(
          sharedPrefs.getString('user_access_token'), context);

      //we use here to get favourites salons to get its id to detect favourits salons in salonList
      await ApiProvider.getAllFavourits(
          sharedPrefs.getString('user_access_token'),
          sharedPrefs.getInt('user_id'),
          context);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    user_id: sharedPrefs.getInt('user_id'),
                    token: sharedPrefs.getString('user_access_token'),
                    email: sharedPrefs.getString('user_email'),
                    mobile: sharedPrefs.getString('user_mobile'),
                    name: sharedPrefs.getString('user_name'),
                  )));
    }
  }
}
