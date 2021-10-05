import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class UserInfoFormTextField extends StatelessWidget {
  final TextEditingController formController;
  final String labelText;
  final String? initialValue;

  UserInfoFormTextField(this.labelText, this.formController, this.initialValue);

  @override
  Widget build(BuildContext context) {
    if (initialValue != null) formController.text = initialValue!;

    var maskFormatter = new MaskTextInputFormatter(
        mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});

    return TextFormField(
      inputFormatters: labelText == 'CPF' ? [maskFormatter] : [],
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2.0,
          ),
        ),
        filled: true,
        hintStyle: TextStyle(color: Theme.of(context).primaryColor),
      ),
      textInputAction: TextInputAction.done,
      validator: (value) {
        if (value!.isEmpty) return 'Este campo é obrigatório.';
        return null;
      },
      controller: formController,
      readOnly: initialValue != null,
    );
  }
}
