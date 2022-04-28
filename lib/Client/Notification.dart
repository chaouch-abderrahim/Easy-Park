import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class Noti extends StatefulWidget {
  const Noti({Key? key}) : super(key: key);

  @override
  State<Noti> createState() => _NotiState();
}

class _NotiState extends State<Noti> {
  late int _totalNotifications;
  late final FirebaseMessaging _messaging;
  PushNotification? _notificationInfo;


  void registerNotification() async {
    // 1. Initialize the Firebase app
    await Firebase.initializeApp();

    // 2. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );


    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      // For handling the received notifications
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // Parse the message received
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
        );

        setState(() {
          _notificationInfo = notification;
          _totalNotifications++;
        });
        if (_notificationInfo != null) {
          // For displaying the notification as an overlay
          showSimpleNotification(
            Text(_notificationInfo!.title!),
            leading: NotificationBadge(totalNotifications: _totalNotifications),
            subtitle: Text(_notificationInfo!.body!),
            background: Colors.cyan.shade700,
            duration: Duration(seconds: 2),
          );
        }
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }
  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      PushNotification notification = PushNotification(
        title: initialMessage.notification?.title,
        body: initialMessage.notification?.body,
      );
      setState(() {
        _notificationInfo = notification;
        _totalNotifications++;
      });
    }
  }
  getToken() async {
  String a=await FirebaseMessaging.instance.getToken() as String ;
  print(a);
  }

  @override
  void initState() {
    getToken();
    _totalNotifications = 0;
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotification notification = PushNotification(
        title: message.notification?.title,
        body: message.notification?.body,
        dataTitle: message.data['title'],
        dataBody: message.data['body'],
      );

      setState(() {
        _notificationInfo = notification;
        _totalNotifications++;
      });
    });
    // Call here
    checkForInitialMessage();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      backgroundColor: Colors.amberAccent,
      appBar: AppBar( backgroundColor: Colors.amber,
      title: const Text("Notification"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        const Text(
        'App for capturing Firebase Push Notifications',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
          const SizedBox(height: 16.0),
          NotificationBadge(totalNotifications: _totalNotifications),
          const SizedBox(height: 16.0),
          // TODO: add the notification text here
          _notificationInfo != null
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
          'Titre: ${_notificationInfo!.dataTitle ?? _notificationInfo!.title}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'BODY: ${_notificationInfo!.dataBody ?? _notificationInfo!.body}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ],
          )
              : Container(),
        ],
      ),
    );
  }
}
class NotificationBadge extends StatelessWidget {
  final int totalNotifications;

  const NotificationBadge({required this.totalNotifications});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: new BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '$totalNotifications',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
class PushNotification {
  PushNotification({
    this.title,
    this.body,
    this.dataTitle,
    this.dataBody,
  });

  String? title;
  String? body;
  String? dataTitle;
  String? dataBody;
}
Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}