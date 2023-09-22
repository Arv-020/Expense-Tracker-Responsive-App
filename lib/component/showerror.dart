import 'package:flutter/material.dart';

void ShowError(BuildContext context, String? txt) {
  showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
            title: const Text('Invalid Information'),
            content: Text(txt!),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Center(
                  child: Text('Ok'),
                ),
              )
            ],
          ));
}
