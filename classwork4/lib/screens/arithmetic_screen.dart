import 'package:flutter/material.dart';

class ArithmeticScreen extends StatefulWidget {
  const ArithmeticScreen({super.key});

  @override
  State<ArithmeticScreen> createState() => _ArithmeticScreenState();
}

class _ArithmeticScreenState extends State<ArithmeticScreen> {
  final _aController = TextEditingController();
  final _bController = TextEditingController();
  String _result = '';

  double? _parse(String s) {
    final value = double.tryParse(s.trim());
    return value;
  }

  void _compute(String op) {
    final a = _parse(_aController.text);
    final b = _parse(_bController.text);
    if (a == null || b == null) {
      setState(() => _result = 'Enter valid numbers');
      return;
    }

    double? out;
    String label;

    switch (op) {
      case '+':
        out = a + b;
        label = 'Sum';
        break;
      case '-':
        out = a - b;
        label = 'Difference';
        break;
      case '*':
        out = a * b;
        label = 'Product';
        break;
      case '/':
        if (b == 0) {
          setState(() => _result = 'Division by zero');
          return;
        }
        out = a / b;
        label = 'Quotient';
        break;
      default:
        out = null;
        label = '';
    }

    if (out == null) {
      setState(() => _result = 'Error');
      return;
    }

    setState(() {
      _result = '$label: ${out!.toString()}';
    });
  }

  @override
  void dispose() {
    _aController.dispose();
    _bController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Enter two numbers and choose an operation',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _aController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Number A',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _bController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Number B',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 18),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ElevatedButton(
                  onPressed: () => _compute('+'),
                  child: const Text('+'),
                ),
                ElevatedButton(
                  onPressed: () => _compute('-'),
                  child: const Text('-'),
                ),
                ElevatedButton(
                  onPressed: () => _compute('*'),
                  child: const Text('*'),
                ),
                ElevatedButton(
                  onPressed: () => _compute('/'),
                  child: const Text('/'),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Card(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Text(
                  _result.isEmpty ? 'Result will appear here' : _result,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

