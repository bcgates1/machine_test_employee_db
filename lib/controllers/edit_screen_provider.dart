import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/database_helper.dart';
import '../models/employee_model.dart';

class EditEmployeeProvider extends ChangeNotifier {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  String? imageFile;
  String? networkImageAvatar;
  EmployeeModel employee;

  EditEmployeeProvider(this.employee) {
    firstNameController = TextEditingController(text: employee.firstName);
    lastNameController = TextEditingController(text: employee.lastName);
    emailController = TextEditingController(text: employee.email);
    if (employee.avatar.contains('https')) {
      networkImageAvatar = employee.avatar;
    } else {
      imageFile = employee.avatar;
    }
  }

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageFile = pickedFile.path;
      notifyListeners();
    }
  }

  Future<void> saveChanges() async {
    employee.firstName = firstNameController.text.trim();
    employee.lastName = lastNameController.text.trim();
    employee.email = emailController.text.trim();
    if (imageFile != null) {
      employee.avatar = imageFile!;
    }

    await DatabaseHelper.instance.updateEmployee(employee);
  }
}
