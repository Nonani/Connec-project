import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/pages/login/login_page.dart';
import 'package:connec/pages/main_page.dart';
import 'package:connec/services/Job.dart';
import 'package:connec/services/service_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.getInitialMessage();
  kakao.KakaoSdk.init(nativeAppKey: 'd148d9781b59a5bbd68bf9d38a8195c7');

  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ServiceClass()),
        ChangeNotifierProvider(create: (_) => JobProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('ko', ''),
      ],
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "EchoDream"),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final logger = Logger();

  final database = FirebaseFirestore.instance;
  final messaging = FirebaseMessaging.instance;
  @override
  void initState(){
    super.initState();
    requestPermission();
    initInfo();
  }
  initInfo() {
    var androidInitialize = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(android:  androidInitialize, iOS: iOSInitialize);
    FlutterLocalNotificationsPlugin().initialize(initializationSettings, onDidReceiveNotificationResponse: (NotificationResponse response) async{
      try {
        if (response.payload != null && (response.payload!).isNotEmpty){
          logger.w("payload exist");
        } else{
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MainPage(),),(route) => false);
        }
      }catch(e) {

      }
      return;
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async{
      AndroidNotificationDetails androidChannelSpecifics = AndroidNotificationDetails(
          'request',
          'request arrived',
          importance: Importance.high,
          priority: Priority.high,
          playSound: true
      );
      NotificationDetails channelSpecifics = NotificationDetails(
          android: androidChannelSpecifics,
      );
      await FlutterLocalNotificationsPlugin().show(0, message.notification?.title, message.notification?.body,
      channelSpecifics);
    });
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) =>
            (!snapshot.hasData) ? LoginPage() : MainPage());
  }

  void requestPermission() async{
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      logger.w("user granted permission");
    } else if(settings.authorizationStatus == AuthorizationStatus.provisional) {
      logger.w('user granted provisional permissions');
    } else {
      logger.w('user declined permission grant');
    }
  }

}
