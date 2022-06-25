import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:massege_me/login.dart';
import 'package:massege_me/register.dart';
import 'package:massege_me/widgets/mybutton.dart';

class welcome extends StatelessWidget {
  static const String screenRoute = 'Welcome_screen';

  const welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              width: 200.0,
              height: 200.0,
              child: Image.asset('images/logo.png')),
          SizedBox(
            height: 20.0,
          ),
          Center(
              child: Text(
            "MessageMe",
            style: TextStyle(
              color: Color(0xff2e386b),
              fontSize: 40.0,
              fontWeight: FontWeight.w900,
            ),
          )),
          SizedBox(
            height: 20.0,
          ),
          mybutton(
            color: Colors.yellow[900]!,
            onPressed: () {
              Navigator.pushNamed(context, login.screenRoute);
            },
            title: "Sign In",
          ),
          SizedBox(
            height: 20.0,
          ),
          mybutton(
              color: Color(0xff2e386b),
              onPressed: () {
                Navigator.pushNamed(context, register.screenRoute);
              },
              title: "Register")
        ],
      ),
    );
  }
}
