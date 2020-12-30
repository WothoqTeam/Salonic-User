// import 'package:flutter/material.dart';
// import 'package:rxdart/subjects.dart';
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:salonic/Custom_Widgets/export_file.dart';
import 'package:salonic/View/Notifications/notification_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPushNotifications {
  FirebaseMessaging _firebaseMessaging;
  GlobalKey<NavigatorState> navigatorKey;

  //list contain all notifications
  String notifications;
  static List<NotificationModel> notifications_list =
      new List<NotificationModel>();

  //  MainModel model = MainModel();

  static StreamController<Map<String, dynamic>> _onMessageStreamController =
      StreamController.broadcast();
  static StreamController<Map<String, dynamic>> _streamController =
      StreamController.broadcast();

  static final Stream<Map<String, dynamic>> onFcmMessage =
      _streamController.stream;

  void notificationSetup(GlobalKey<NavigatorState> navigatorKey) {
    _firebaseMessaging = FirebaseMessaging();
    this.navigatorKey = navigatorKey;
    ("===================================");
    requestPermissions();
    getFcmToken();
    notificationListeners();
  }

  StreamController<Map<String, dynamic>> get notificationSubject {
    return _onMessageStreamController;
  }

  void requestPermissions() {
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, alert: true, badge: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings setting) {
      ('IOS Setting Registed');
    });
  }

  Future<String> getFcmToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('msgToken', await _firebaseMessaging.getToken());
    ('firebase token => ${await _firebaseMessaging.getToken()}');
    ("_____________" + await _firebaseMessaging.getToken());
    return await _firebaseMessaging.getToken();
  }

  void notificationListeners() {
    _firebaseMessaging.configure(
        onMessage: _onNotificationMessage,
        onResume: _onNotificationResume,
        onLaunch: _onNotificationLaunch);
  }

  Future<dynamic> _onNotificationMessage(Map<String, dynamic> message) async {
    ("------- ON MESSAGE -------- $message");

    _onMessageStreamController.add(message);
  }

  Future<dynamic> _onNotificationResume(Map<String, dynamic> message) async {
    ("------- ON RESUME --------- $message");

    notificationAction(message["data"]["title"]);
    _streamController.add(message);
  }

  Future<dynamic> _onNotificationLaunch(Map<String, dynamic> message) async {
    ("------- ON LAUNCH -------- $message");

    _streamController.add(message);
    notificationAction(message["notification"]["title"]);
  }

  void killNotification() {
    _onMessageStreamController.close();
    _streamController.close();
  }

  void notificationAction(String messagee) async {
    if (messagee != null) {
      navigatorKey.currentState
          .push(PageRouteBuilder(pageBuilder: (_, __, ___) {
        return Notifications();
      }));
    }
  }
}
