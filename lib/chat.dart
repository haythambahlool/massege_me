import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
late User signedinuser;

class chat extends StatefulWidget {
  static const String screenRoute = 'Chat_screen';
  const chat({Key? key}) : super(key: key);

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  final _auth = FirebaseAuth.instance;
  late String message;
  late final contrll = TextEditingController();
  @override
  void initState() {
    super.initState();
    getcurrentuser();
  }

  void getcurrentuser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedinuser = user;
        print(signedinuser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  void getmessages() async {
    final messages = await _firestore.collection("messages").get();
    for (var message in messages.docs) {}
    ;
  }

  void getstream() async {
    await for (var snapshot in _firestore.collection("messages").snapshots()) {
      for (var message in snapshot.docs) {}
    }
    ;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[900],
        title: Row(
          children: [
            Container(
              width: 30.0,
              height: 30.0,
              child: Image.asset('images/logo.png'),
            ),
            SizedBox(
              width: 10.0,
            ),
            Text("MessageMe")
          ],
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              })
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Streambuil(),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.orange,
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: contrll,
                      onChanged: (value) {
                        message = value;
                      },
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 20.0),
                          hintText: "Write your message here ...",
                          border: InputBorder.none),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        _firestore.collection("messages").add({
                          "message": message,
                          "sender": signedinuser.email,
                          "time": FieldValue.serverTimestamp(),
                        });
                        contrll.clear();
                      },
                      child: Text(
                        "send",
                        style: TextStyle(
                            color: Colors.blue[800],
                            fontWeight: FontWeight.w700,
                            fontSize: 18.0),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Streambuil extends StatelessWidget {
  const Streambuil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection("messages").orderBy("time").snapshots(),
        builder: (context, snapshot) {
          List<messageline> messagewidgets = [];
          if (!snapshot.hasData) {}
          ;
          final messages = snapshot.data!.docs.reversed;
          for (var message in messages) {
            final messagetext = message.get("message");
            final messagesender = message.get("sender");
            final currentuser = signedinuser.email;
            final messagewidget = messageline(
              isme: messagesender == currentuser,
              sender: messagesender,
              textmes: messagetext,
            );
            messagewidgets.add(messagewidget);
          }
          ;
          return Expanded(
            flex: 7,
            child: ListView(
              reverse: true,
              padding: EdgeInsets.all(10.0),
              children: messagewidgets,
            ),
          );
        });
  }
}

class messageline extends StatelessWidget {
  const messageline({this.textmes, this.sender, required this.isme, Key? key})
      : super(key: key);
  final String? textmes;
  final String? sender;
  final bool isme;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment:
            isme ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            "$sender",
            style: TextStyle(color: Colors.grey, fontSize: 12.0),
          ),
          Material(
            color: isme ? Colors.blue[800] : Colors.yellow[900],
            borderRadius: isme
                ? BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
            elevation: 5.0,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
              child: Text(
                "$textmes",
                style: TextStyle(color: Colors.white, fontSize: 17.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
