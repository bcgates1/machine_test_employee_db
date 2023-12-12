import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/home_screen_provider.dart';
import 'employee_tab_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final employeeProviderCtrl = Provider.of<HomeScreenProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      employeeProviderCtrl.fetchEmployees();
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              await employeeProviderCtrl.fetchEmployees(refresh: true);
            },
          ),
        ],
      ),
      body: const EmployeeTabView(),
    );
  }
}
