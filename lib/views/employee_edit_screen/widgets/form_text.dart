import 'package:flutter/material.dart';

import '../../../controllers/employee_edit_screen_validation.dart';

class EditScreenTextForm extends StatelessWidget {
  const EditScreenTextForm({
    super.key,
    required this.controller,
    required this.labelText,
  });

  final TextEditingController controller;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        return Validation.employeeEditScreenValidation(labelText: labelText, value: value);
      },
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
    );
  }
}
