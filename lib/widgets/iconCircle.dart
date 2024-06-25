import 'package:flutter/material.dart'; 

Widget iconCircle(Color color, String text, IconData icon) {
  return Column(
    children: <Widget>[
      Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Icon(
          icon,
          size: 32,
          color: Colors.white,
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        text,
        style: TextStyle(
            color: Colors.black87, fontSize: 14, fontWeight: FontWeight.bold),
      )
    ],
  );
}