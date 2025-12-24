// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class Freesubscriptionservice extends StatefulWidget {
//   const Freesubscriptionservice({super.key});
//
//   @override
//   State<Freesubscriptionservice> createState() =>
//       _FreesubscriptionserviceState();
// }
//
// class _FreesubscriptionserviceState extends State<Freesubscriptionservice> {
//   @override
//   void initState() {
//     super.initState();
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       showAlert(context);
//     });
//   }
//
//   void showAlert(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: true,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("🎉 Early User"),
//           content: const Text("Free subscription activated (demo)"),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text("OK"),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text("Welcome"),
//       ),
//     );
//   }
// }
