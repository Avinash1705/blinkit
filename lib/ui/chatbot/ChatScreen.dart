import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:swiggy/domain/ApiConstants.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<types.Message> _messages = [];

  final _user = const types.User(id: 'user');
  final _bot = const types.User(id: 'bot');
  // final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String chatId = "chat_123"; // dynamic later
  void _handleSendPressed(types.PartialText message) async {
    final userMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: DateTime.now().toString(),
      text: message.text,
    );

    setState(() => _messages.insert(0, userMessage));

    final botReply = await sendToBackend(message.text);

    final botMessage = types.TextMessage(
      author: _bot,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: DateTime.now().toString(),
      text: botReply,
    );

    setState(() => _messages.insert(0, botMessage));
  }
  // void _handleSendPressed(types.PartialText message) async {
  //   await _db.collection("messages").add({
  //     "chatId": chatId,
  //     "senderId": _user.id,
  //     "text": message.text,
  //     "timestamp": DateTime.now().millisecondsSinceEpoch,
  //   });
  //   // 2. Call bot (optional)
  //   final botReply = await sendToBackend(message.text);
  //   // 3. Save bot reply
  //   await _db.collection("messages").add({
  //     "chatId": chatId,
  //     "senderId": _bot.id,
  //     "text": botReply,
  //     "timestamp": DateTime.now().millisecondsSinceEpoch,
  //   });
  // }

  Future<String> sendToBackend(String text) async {
    final response = await http.post(
      Uri.parse(ApiConstants.aiChat),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"message": text}),
    );

    final data = jsonDecode(response.body);
    return data["reply"];
  }
  @override
  void initState() {
    // final ref = FirebaseDatabase.instance.ref("chats/user123");
    _messages.add(types.TextMessage(
      author: _bot,
      id: "welcome",
      createdAt: DateTime.now().millisecondsSinceEpoch,
      text: "Hi 👋 I’m FluxKart Assistant. How can I help you?",
    ));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FluxKart Assistant")),
      body: Column(
        children: [

          // 🔥 QUICK ACTION BUTTONS
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8,
              children: [
                _quickButton("Track Order"),
                _quickButton("Refund"),
                _quickButton("Food"),
                // _quickButton("Connect to agent"),
                ElevatedButton(onPressed: () async => {
                  openWhatsApp()
                }, child: Text("Connect to agent"))
              ],
            ),
          ),

          // 🔥 CHAT UI
          Expanded(
            child: Chat(
              messages: _messages,
              onSendPressed: _handleSendPressed,
              user: _user,
            ),
          ),
        ],
      ),
    );
  }
  Widget _quickButton(String text) {
    return ElevatedButton(
      onPressed: () {
        _handleSendPressed(types.PartialText(text: text));
      },
      child: Text(text),
    );
  }
  void openWhatsApp() async {
    final phone = "918700056622"; // 👈 your support number (with country code)
    final message = Uri.encodeComponent("Hi, I need help with my order in Fluxkart");

    final url = "https://wa.me/$phone?text=$message";

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw "Could not open WhatsApp";
    }
  }
}
