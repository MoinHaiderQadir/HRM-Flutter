import 'package:hive/hive.dart';
import '../models/employee_model.dart';

class Boxes {
  static Box<Employee> getEmployees() => Hive.box<Employee>('employeesBox');
}
