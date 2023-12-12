import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/home_screen_provider.dart';
import '../../models/employee_model.dart';
import '../common/alert_widget.dart';
import '../employee_edit_screen/edit_screen.dart';
import 'widgets/employee_details_text.dart';

class EmployeeDetails extends StatelessWidget {
  final EmployeeModel employee;

  const EmployeeDetails({Key? key, required this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditEmployeeScreen(
                          employee: employee,
                        ),
                      ),
                    );
                  },
                  child: const Text('Edit'),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<HomeScreenProvider>(context, listen: false)
                        .deleteEmployee(id: employee.id);
                  },
                  child: const Text('Delete'),
                ),
                const Spacer(
                  flex: 7,
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: 80,
              backgroundColor: Colors.transparent,
              backgroundImage: employee.avatar.contains('https')
                  ? NetworkImage(
                      employee.avatar,
                    )
                  : FileImage(File(employee.avatar)) as ImageProvider,
              onBackgroundImageError: (exception, stackTrace) {
                AlertDialogWidget.showToast('Error loading the image: $exception');
              },
            ),
          ),
          const Spacer(),
          Row(
            children: [
              const Spacer(
                flex: 3,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: ['First Name', 'Last Name', 'Email']
                    .map(
                      (e) => EmployeeDetailsTextView(
                        text: e,
                      ),
                    )
                    .toList(),
              ),
              const Spacer(),
              Column(
                children: [':', ':', ':']
                    .map(
                      (e) => EmployeeDetailsTextView(
                        text: e,
                      ),
                    )
                    .toList(),
              ),
              const Spacer(),
              Flexible(
                flex: 8,
                fit: FlexFit.tight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [employee.firstName, employee.lastName, employee.email]
                      .map(
                        (e) => EmployeeDetailsTextView(
                          text: e,
                        ),
                      )
                      .toList(),
                ),
              )
            ],
          ),
          const Spacer(
            flex: 7,
          )
        ],
      ),
    );
  }
}
