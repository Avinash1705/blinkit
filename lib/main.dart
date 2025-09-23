import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiggy/controllers/addressController.dart';
import 'package:swiggy/controllers/cartController.dart';
import 'package:swiggy/controllers/printController.dart';
// import 'package:swiggy/services/notificationService.dart';
import 'package:swiggy/services/notify.dart';
import 'package:swiggy/ui/bottomNav/bottomNavScreen.dart';
import 'package:swiggy/ui/customerProfile/LoginCustomerProfileScreen.dart';
import 'package:swiggy/ui/screens/splash/splashScreen.dart';
import 'dependency/dependency.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CartController()),
      ChangeNotifierProvider(create: (_) => AddressController()),
      ChangeNotifierProvider(create: (_) => Printcontroller()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // Firebase initialization future
  final Future<FirebaseApp> _firebaseInitialization = Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flux-it',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: _firebaseInitialization,
        builder: (context, snapshot) {
          // Error initializing Firebase
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text(
                  'Error initializing Firebase\n${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red, fontSize: 18),
                ),
              ),
            );
          }

          // Firebase initialized successfully
          if (snapshot.connectionState == ConnectionState.done) {
            return FutureBuilder<bool>(
              future: isUserLoggedIn(), // Check login AFTER Firebase init
              builder: (context, loginSnapshot) {
                if (loginSnapshot.connectionState == ConnectionState.waiting) {
                  return Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                }
                if(loginSnapshot.connectionState == ConnectionState.done){

                  print("Firebase Initialized and login check done");
                  FirebaseMessaging messaging = FirebaseMessaging.instance;
                  print("FCM Token Remote: ${messaging.getToken().then((value) => print(value))}");

                  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
                    if (message.notification != null) {
                      showNotification(message.notification!.body ?? "No body");
                    }
                  });
                  //register background handler
                  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
                }

                if (loginSnapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text(
                        'Error checking login\n${loginSnapshot.error}',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  );
                }

                final loggedIn = loginSnapshot.data ?? false;

                // Show the correct screen based on login status
                return loggedIn
                    ? BottomNavScreen(index: 0):SplashScreen(); // or SplashScreen
              },
            );
          }

          // Loading Firebase
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }

  // Example login check
  Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    loadUserData(prefs); // Your existing function
    return prefs.containsKey('customer_id');
  }
  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    // Re-initialize Firebase (required in background isolates)
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    if (message.notification != null) {
      showNotification(message.notification!.body ?? "No body");
    }
  }

}
