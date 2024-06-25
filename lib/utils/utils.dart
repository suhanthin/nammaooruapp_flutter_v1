import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void showSnackBar(BuildContext context, String text, {Color? backgroundColor}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor ?? Colors.red, // If no color is provided, default to red
      content: Text(text),
    ),
  );
}

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200 || 201:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, jsonDecode(response.body)['message'],backgroundColor: Colors.red);
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['error'],backgroundColor: Colors.red);
      break;
    default:
      showSnackBar(context, response.body,backgroundColor: Colors.red);
  }
}
