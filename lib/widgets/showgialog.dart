import 'package:flutter/material.dart';

showLoading(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return const AlertDialog(
        title: Text(
          "انتظر قليلا",
          style: TextStyle(color: Colors.black),
        ),
        content: SizedBox(
          height: 50,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    },
  );
}
