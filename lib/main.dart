import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiggy/controllers/addressController.dart';
import 'package:swiggy/controllers/cartController.dart';
import 'package:swiggy/controllers/printController.dart';
import 'package:swiggy/pay/PhonePayScreen.dart';
import 'package:swiggy/pay/RazorpayPaymentScreen.dart';
import 'package:swiggy/pay/UpiPaymentScreen.dart';

// import 'package:swiggy/services/notificationService.dart';
import 'package:swiggy/services/notify.dart';
import 'package:swiggy/testMyCode/OtpFrontendMsg91.dart';
import 'package:swiggy/testMyCode/PhoneAuthFlow.dart';
import 'package:swiggy/testMyCode/OtpMsg91.dart';
import 'package:swiggy/ui/bottomNav/bottomNavScreen.dart';
import 'package:swiggy/ui/customerProfile/LoginCustomerProfileScreen.dart';
import 'package:swiggy/ui/login/loginScreen.dart';
import 'package:swiggy/ui/login/roleBasedLogin/PhoneNumberPage.dart';
import 'package:swiggy/ui/login/roleBasedLogin/RoleSelectionPage.dart';
import 'package:swiggy/ui/screens/splash/splashScreen.dart';
import 'package:swiggy/vender/ui/vender_dashboard.dart';
import 'PhoneAuthScreen.dart';
import 'controllers/appSecretKey/getAppSecretKeyController.dart';
import 'controllers/notificationSendController.dart';
import 'dependency/dependency.dart';
import 'domain/AppConstant.dart';
import 'firebase_options.dart';
import '2factorOpt/otpScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CartController()),
      ChangeNotifierProvider(create: (_) => AddressController()..loadAddress()),
      ChangeNotifierProvider(create: (_) => Printcontroller()),
      ChangeNotifierProvider(create: (_) => ConfigController())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // Firebase initialization future
  final Future<FirebaseApp> _firebaseInitialization =
      Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  @override
  Widget build(BuildContext context) {
    //call secret key api
    context.read<ConfigController>().fetchConfig();

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
                  'Error initializing 78\n${snapshot.error}',
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
                if (loginSnapshot.connectionState == ConnectionState.done) {
                  //firebase
                  // FirebaseMessaging messaging =   FirebaseMessaging.instance;
                  // messaging.getToken().then((token) {
                  //   print("Firebase Messaging Token main: $token");
                  // });
                  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
                    if (message.notification != null) {
                      showNotificationMessage(message.notification!.title??"No title",message.notification!.body ?? "No body");
                    }
                  });
                  //register background handler
                  FirebaseMessaging.onBackgroundMessage(
                      _firebaseMessagingBackgroundHandler);

                  //notification
                  // NotificationController().sendVendorNotification(vendorId: "4", orderId: 'gituOrderId', title: 'gitu titke', body: 'gitu body');
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
                // return PhoneMsg91UI();
                // return OtpMsg91();
                return const SplashScreen();
                // return RegistrationCustomerProfilePage();
                // return const PhoneAuthFlow();    // no
                // return  OtpScreen();
                // return RazorpayPaymentScreen();
                // return loggedIn
                //     ? BottomNavScreen(index: 0)
                //     : SplashScreen(); // or SplashScreen
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
    // print("loginDetail ${prefs.getString('customer_id')}");
    // print("loginDetail ven${prefs.getString(AppConstant.vendorDetails)}");
    return prefs.containsKey('customer_id')|| prefs.containsKey(AppConstant.vendorDetails);
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // Re-initialize Firebase (required in background isolates)
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    if (message.notification != null) {
      showNotificationMessage(message.notification!.title??"No title",message.notification!.body ?? "No body");
    }
  }
}
