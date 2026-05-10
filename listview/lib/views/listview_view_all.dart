import 'package:flutter/material.dart';

import 'employee_model.dart';
import 'employee_store.dart';

class ListviewViewAll extends StatelessWidget {
  const ListviewViewAll({super.key});

  @override
  Widget build(BuildContext context) {
    final store = EmployeeStore.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Employees'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: store.employees.isEmpty
              ? const Center(
                  child: Text('No data found'),
                )
              : ListView.separated(
                  itemCount: store.employees.length,
                  separatorBuilder: (context, index) => const Divider(height: 24),
                  itemBuilder: (context, index) {
                    final e = store.employees[index];
                    return Card(
                      elevation: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: _EmployeeCardBody(employee: e),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}

class _EmployeeCardBody extends StatelessWidget {
  final Employee employee;

  const _EmployeeCardBody({required this.employee});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          employee.fullName,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6),
        _kv('Employee ID', employee.employeeId),
        _kv('Gender', employee.gender),
        _kv('Department', employee.department),
        _kv('User Name', employee.userName),
        _kv('Password', employee.password),
      ],
    );
  }
}

Widget _kv(String key, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$key: ',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        Expanded(
          child: Text(value, overflow: TextOverflow.ellipsis),
        ),
      ],
    ),
  );
}

