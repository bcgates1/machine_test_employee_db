class Validation {
  static String? employeeEditScreenValidation({required String labelText, required String? value}) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    value = value.trim();
    if (labelText == 'First Name' && !value.contains(RegExp(r'^[a-zA-Z]+$'))) {
      return 'Please enter a valid first name';
    }
    if (labelText == 'Last Name' && !value.contains(RegExp(r'^[a-zA-Z]+$'))) {
      return 'Please enter a valid last name';
    }
    if (labelText == 'Email' && !value.contains('@')) {
      return 'Please enter a valid email address';
    }

    return null;
  }
}
