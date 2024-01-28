import 'package:flutter/cupertino.dart';

Future errorDialog(context, String error) {
  return showCupertinoDialog(
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: const Text('Error!'),
        content: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(error),
        ),
        actions: <Widget>[
          CupertinoButton(
            child: const Text('Seen'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      );
    },
    context: context,
  );
}
