import 'dart:async';
import 'package:carihio/pages/PhoneAuth_With_Firebase/phone_auth.dart';
import 'package:carihio/pages/initialPages/select_location.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:carihio/pages/map/maptesting.dart';
import 'package:carihio/pages/PhoneAuth_With_Firebase/simplephonelogin.dart';
import 'package:carihio/pages/initialPages/splashcreen.dart';
import 'package:carihio/pages/PhoneAuth_With_Firebase/Otppage.dart';
import 'firebase_options.dart';
import 'package:carihio/pages/map/appConst.dart';
import 'package:carihio/pages/map/DIsplayNearestTowers.dart';
import 'NotificationService.dart';
import 'package:rxdart/rxdart.dart';

// used to pass messages from event handler to the UI
final _messageStreamController = BehaviorSubject<RemoteMessage>();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
    print('Message data: ${message.data}');
    print('Message notification: ${message.notification?.title}');
    print('Message notification: ${message.notification?.body}');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load();
  final messaging = FirebaseMessaging.instance;

  final settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (kDebugMode) {
    print('Permission granted: ${settings.authorizationStatus}');
  }
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (kDebugMode) {
      print('Handling a foreground message: ${message.messageId}');
      print('Message data: ${message.data}');
      print('Message notification: ${message.notification?.title}');
      print('Message notification: ${message.notification?.body}');
    }

    _messageStreamController.sink.add(message);
  });

  /// It requests a registration token for sending messages to users from your App server or other trusted server environment.
  String? token = await messaging.getToken();

  if (kDebugMode) {
    print('Registration Token=$token');
  }
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getToken().then((String? token) {
      assert(token != null);
      print("FCM Registration Token: $token");
      AppConstants.token = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TowPal',
      home: splash(),
      routes: {
        "otp": (context) => otp(),
        "phonesignein": (context) => PhoneSignIn(),
        "MapPage": (context) => MapPage(),
        "selecteposition": (context) => selecte_location(),
        "checking": (context) => CheckUserLoggedInOrNot(),
      },
    );
  }
}

class CheckUserLoggedInOrNot extends StatefulWidget {
  const CheckUserLoggedInOrNot({super.key});

  @override
  State<CheckUserLoggedInOrNot> createState() => _CheckUserLoggedInOrNotState();
}

class _CheckUserLoggedInOrNotState extends State<CheckUserLoggedInOrNot> {
  @override
  void initState() {
    super.initState();
    checking();
  }

  Future<void> checking() async {
    bool isLoggedin = await AuthServic.isLoggedIn();
    print("${isLoggedin}");
    if (isLoggedin) {
      Navigator.pushReplacementNamed(context, "selecteposition");
    } else {
      Navigator.pushReplacementNamed(context, "phonesignein");
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
