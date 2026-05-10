import 'package:flutter/material.dart';

import 'employee_model.dart';
import 'employee_store.dart';
import 'listview_view_all.dart';



class EmployeeListSeparatedView extends StatefulWidget {
  const EmployeeListSeparatedView({super.key});

  @override
  State<EmployeeListSeparatedView> createState() => _EmployeeListSeparatedViewState();
}

class _EmployeeListSeparatedViewState extends State<EmployeeListSeparatedView> {
  final _formKey = GlobalKey<FormState>();

  final _employeeIdCtrl = TextEditingController();
  final _fullNameCtrl = TextEditingController();
  final _genderCtrl = TextEditingController();
  final _departmentCtrl = TextEditingController();
  final _userNameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  final EmployeeStore _store = EmployeeStore.instance;

  bool _showEmployees = true;


  @override
  void dispose() {
    _employeeIdCtrl.dispose();
    _fullNameCtrl.dispose();
    _genderCtrl.dispose();
    _departmentCtrl.dispose();
    _userNameCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _addEmployee() {
    final formOk = _formKey.currentState?.validate() ?? false;
    if (!formOk) return;

    final e = Employee(
      employeeId: _employeeIdCtrl.text.trim(),
      fullName: _fullNameCtrl.text.trim(),
      gender: _genderCtrl.text.trim(),
      department: _departmentCtrl.text.trim(),
      userName: _userNameCtrl.text.trim(),
      password: _passwordCtrl.text,
    );

    setState(() {
      _store.add(e);
      _showEmployees = true;
    });


    _employeeIdCtrl.clear();
    _fullNameCtrl.clear();
    _genderCtrl.clear();
    _departmentCtrl.clear();
    _userNameCtrl.clear();
    _passwordCtrl.clear();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employees'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _field(
                        controller: _employeeIdCtrl,
                        label: 'Employee ID',
                        nextAction: TextInputAction.next,
                        validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                      ),
                      const SizedBox(height: 12),
                      _field(
                        controller: _fullNameCtrl,
                        label: 'Full Name',
                        nextAction: TextInputAction.next,
                        validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        initialValue: _genderCtrl.text.isEmpty ? null : _genderCtrl.text,
                        decoration: const InputDecoration(
                          labelText: 'Gender',
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(value: 'Male', child: Text('Male')),
                          DropdownMenuItem(value: 'Female', child: Text('Female')),
                          DropdownMenuItem(value: 'Other', child: Text('Other')),
                        ],
                        onChanged: (v) {
                          setState(() {
                            _genderCtrl.text = v ?? '';
                          });
                        },
                        validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                      ),
                      const SizedBox(height: 12),
                      _field(
                        controller: _departmentCtrl,
                        label: 'Department',
                        nextAction: TextInputAction.next,
                        validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                      ),
                      const SizedBox(height: 12),
                      _field(
                        controller: _userNameCtrl,
                        label: 'User Name',
                        nextAction: TextInputAction.next,
                        validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                      ),
                      const SizedBox(height: 12),
                      _field(
                        controller: _passwordCtrl,
                        label: 'Password',
                        obscure: true,
                        nextAction: TextInputAction.done,
                        validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
                        onSubmit: () => _addEmployee(),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _addEmployee,
                              icon: const Icon(Icons.person_add),
                              label: const Text('Add Employee'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                          child: OutlinedButton.icon(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const ListviewViewAll(),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.visibility),
                              label: const Text('View All'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              if (!_showEmployees)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Text('Press "View All" to see employees.'),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _store.employees.length,
                  separatorBuilder: (context, index) => const Divider(height: 24),
                  itemBuilder: (context, index) {
                    final e = _store.employees[index];

                    return Card(
                      elevation: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.fullName,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 6),
                            _kv('Employee ID', e.employeeId),
                            _kv('Gender', e.gender),
                            _kv('Department', e.department),
                            _kv('User Name', e.userName),
                            _kv('Password', e.password),
                          ],
                        ),
                      ),
                    );
                  },
                ),

              if (_store.employees.isEmpty && _showEmployees)

                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Text('No employees added yet.'),
                ),
            ],
          ),
        ),
      ),
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

Widget _field({
  required TextEditingController controller,
  required String label,
  required TextInputAction nextAction,
  required String? Function(String?) validator,
  bool obscure = false,
  VoidCallback? onSubmit,
}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
    ),
    obscureText: obscure,
    validator: validator,
    textInputAction: nextAction,
    onFieldSubmitted: (_) => onSubmit?.call(),
  );
}



