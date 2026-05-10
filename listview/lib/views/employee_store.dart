import 'employee_model.dart';

class EmployeeStore {
  EmployeeStore._();

  static final EmployeeStore instance = EmployeeStore._();

  final List<Employee> employees = [];

  void add(Employee employee) => employees.add(employee);
}

