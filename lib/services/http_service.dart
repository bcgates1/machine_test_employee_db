import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/employee_model.dart';
import '../utils/globals.dart';
import '../views/common/alert_widget.dart';

class ApiServices {
  Future<List<EmployeeModel>> fetchAllEmployees() async {
    final uri = Globals.employeesUri;

    try {
      final response = await http.get(
        Uri.parse(uri),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> users = data['data'];

        return users.map((user) => EmployeeModel.fromJson(user)).toList();
      }
    } catch (e) {
      AlertDialogWidget.showToast(e.toString());
      return [];
    }
    return [];
  }
}
