import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showWarningDialog(BuildContext context, String content) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      // title: Text("ERRO!"),
      content: Text(content),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text("Ok"))
      ],
    ),
  );
}

bool isValidEmail(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

bool isValidCPF(String cpf) {
  return RegExp(r"(^\d{3}\x2E\d{3}\x2E\d{3}\x2D\d{2}$)").hasMatch(cpf);
}
