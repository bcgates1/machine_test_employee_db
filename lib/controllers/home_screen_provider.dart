import 'package:flutter/material.dart';

import '../models/database_helper.dart';
import '../models/employee_model.dart';
import '../services/http_service.dart';
import '../views/common/alert_widget.dart';

class HomeScreenProvider extends ChangeNotifier {
  List<EmployeeModel> employees = [];
  bool dbExists = false;
  bool isLoading = false;

  Future<void> fetchEmployees({bool refresh = false}) async {
    isLoading = true; // to show loading in home screen
    notifyListeners();
    await dbCheck();
    if (dbExists && !refresh) {
      //if db is not empty then fetch data from db and not from refresh
      employees = await DatabaseHelper.instance.getAllEmployees();
    } else if (refresh) {
      //fetch data from api if from refresh
      final apiData = await ApiServices().fetchAllEmployees();
      DatabaseHelper.instance.addAllEmployees(apiData).then((value) => dbExists = true);
      employees = await DatabaseHelper.instance.getAllEmployees();
    } else {
      employees = [];
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> dbCheck() async {
    dbExists = await DatabaseHelper.instance.hasEmployees();
  }

  Future<void> deleteEmployee({required int id}) async {
    await DatabaseHelper.instance.deleteEmployee(id);
    AlertDialogWidget.showToast("Employee deleted successfully");
    await dbCheck(); //after deleting db is empty then no need to fetch data
    if (!dbExists) {
      employees.clear();
      notifyListeners();
      return; //to show no employees otherwise it will call fetchEmployees
    }
    employees.clear();
    await fetchEmployees();
  }
  


}
