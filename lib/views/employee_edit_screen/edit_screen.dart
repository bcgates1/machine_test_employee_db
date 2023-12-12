import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/edit_screen_provider.dart';
import '../../controllers/home_screen_provider.dart';
import '../../models/employee_model.dart';
import '../../utils/globals.dart';
import 'widgets/form_text.dart';

class EditEmployeeScreen extends StatelessWidget {
  final EmployeeModel employee;

  const EditEmployeeScreen({Key? key, required this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditEmployeeProvider(employee),
      child: _EditEmployeeScreenContent(),
    );
  }
}

class _EditEmployeeScreenContent extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var editEmployeeProvider = Provider.of<EditEmployeeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Employee'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {
                    await editEmployeeProvider.pickImage();
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.transparent,
                      backgroundImage: editEmployeeProvider.imageFile != null
                          ? FileImage(File(editEmployeeProvider.imageFile!)) as ImageProvider
                          : NetworkImage(editEmployeeProvider.networkImageAvatar!),
                    ),
                  ),
                ),
                SizedBox(height: Globals.kheight * 0.03),
                EditScreenTextForm(
                  labelText: 'First Name',
                  controller: editEmployeeProvider.firstNameController,
                ),
                SizedBox(height: Globals.kheight * 0.03),
                EditScreenTextForm(
                  labelText: 'Last Name',
                  controller: editEmployeeProvider.lastNameController,
                ),
                SizedBox(height: Globals.kheight * 0.03),
                EditScreenTextForm(
                  labelText: 'Email',
                  controller: editEmployeeProvider.emailController,
                ),
                SizedBox(height: Globals.kheight * 0.03),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await editEmployeeProvider.saveChanges();
                      if (context.mounted) {
                        Provider.of<HomeScreenProvider>(context, listen: false).fetchEmployees();
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: const Text('Save Changes'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
