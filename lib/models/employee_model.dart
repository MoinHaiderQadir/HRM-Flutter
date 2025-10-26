import 'package:hive/hive.dart';

part 'employee_model.g.dart'; // This will be generated automatically

@HiveType(typeId: 0)
class Employee extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String email;

  @HiveField(2)
  String phone;

  @HiveField(3)
  String designation;

  @HiveField(4)
  double salary;

  Employee({
    required this.name,
    required this.email,
    required this.phone,
    required this.designation,
    required this.salary,
  });
}
