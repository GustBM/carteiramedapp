import 'package:flutter/material.dart';

class UserInfoFormList extends StatefulWidget {
  final TextEditingController formController;
  final String labelText;
  final String? initialValue;

  UserInfoFormList(this.labelText, this.formController, this.initialValue);

  @override
  _UserInfoFormListState createState() => _UserInfoFormListState();
}

class _UserInfoFormListState extends State<UserInfoFormList> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
