import 'package:flutter/material.dart';
import 'package:massege_me/chat.dart';
import 'package:massege_me/widgets/mybutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class register extends StatefulWidget {
  static const String screenRoute = 'register_screen';

  const register({Key? key}) : super(key: key);
  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showspinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showspinner,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 200.0,
              height: 200.0,
              child: Image.asset('images/logo.png'),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              height: 50.0,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                    labelText: "Enter your email",
                    labelStyle: TextStyle(
                      color: Colors.yellow[900],
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff2e386b),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.yellow[900]!,
                      ),
                    )),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              height: 50.0,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.yellow[900],
                    ),
                    labelText: "Enter your password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff2e386b),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.yellow[900]!,
                      ),
                    )),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            mybutton(
                color: Color(0xff2e386b),
                onPressed: () async {
                  setState(() {
                    showspinner = true;
                  });
                  try {
                    final newuser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    Navigator.pushNamed(context, chat.screenRoute);
                    setState(() {
                      showspinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                  ;
                },
                title: "Register")
          ],
        ),
      ),
    );
  }
}
