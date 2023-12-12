import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/home_screen_provider.dart';
import '../../models/employee_model.dart';
import '../../utils/globals.dart';
import 'employee_details.dart';

class EmployeeTabView extends StatelessWidget {
  const EmployeeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
      builder: (context, employeeDetails, child) {
        if (employeeDetails.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (employeeDetails.employees.isNotEmpty) {
          final List<EmployeeModel> employeeList = employeeDetails.employees;
          return DefaultTabController(
            length: employeeList.length,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TabBar(
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Colors.blue,
                    labelColor: Colors.black,
                    indicatorWeight: 5,
                    tabs: employeeDetails.employees
                        .map(
                          (e) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              border: Border.all(),
                            ),
                            child: SizedBox(
                              width: Globals.kwidth * 0.25,
                              child: Tab(
                                text: '${e.firstName} ${e.lastName}',
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                const Divider(
                  thickness: 2,
                  color: Colors.black,
                ),
                Expanded(
                  child: Card(
                    elevation: 5,
                    shape: Border.all(),
                    margin: EdgeInsets.symmetric(
                      horizontal: Globals.kwidth * 0.03,
                      vertical: Globals.kheight * 0.15,
                    ),
                    child: TabBarView(
                      children: employeeDetails.employees
                          .map(
                            (e) => EmployeeDetails(employee: e),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return const Center(
            child: Text(
          'No employees found click refresh',
          style: TextStyle(fontSize: 20),
        ));
      },
    );
  }
}
