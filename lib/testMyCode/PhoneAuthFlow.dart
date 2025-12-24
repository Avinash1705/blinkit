import 'package:firebase_auth/firebase_auth.dart';
import 'OtpScreen.dart';
import 'PhoneScreen.dart';
import 'package:flutter/material.dart';


class PhoneAuthFlow extends StatefulWidget {
  const PhoneAuthFlow({super.key});

  @override
  State<PhoneAuthFlow> createState() => _PhoneAuthFlowState();
}

class _PhoneAuthFlowState extends State<PhoneAuthFlow> {
  String verificationId = "";
  FirebaseAuth auth = FirebaseAuth.instance;

  void sendOtp(String phone) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phone,
      codeSent: (id, _) {
        verificationId = id;
        print("verification id my" + verificationId);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OtpScreen(onVerify: verifyOtp),
          ),
        );
      },
      verificationFailed: (e) {
        print("Error: ${e.message}");
      },
      verificationCompleted: (cred) {
        print("verificationCompleted my ${cred.smsCode}");
        auth.signInWithCredential(cred);
      },
      codeAutoRetrievalTimeout: (id) {
        verificationId = id;
      },
    );
  }

  void verifyOtp(String otp) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );

    await auth.signInWithCredential(credential);

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login Successful!")));
  }

  @override
  Widget build(BuildContext context) {
    return PhoneScreen(onSendOtp: sendOtp);
  }
}
