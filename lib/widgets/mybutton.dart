import 'package:flutter/material.dart';

class mybutton extends StatelessWidget {
  mybutton(
      {Key? key,
      required this.color,
      required this.onPressed,
      required this.title})
      : super(key: key);
  final String title;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(7.0),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: onPressed,
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}
