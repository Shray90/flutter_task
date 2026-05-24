import 'package:flutter/material.dart';

class SiScreen extends StatefulWidget {
  const SiScreen({super.key});

  @override
  State<SiScreen> createState() => _SiScreenState();
}

class _SiScreenState extends State<SiScreen> {
  final _inputController = TextEditingController();
  String _fromUnit = 'm';
  String _toUnit = 'cm';
  String _output = '';

  // Simple length conversion: all converted via meters.
  double _toMeters(double value, String unit) {
    switch (unit) {
      case 'm':
        return value;
      case 'cm':
        return value / 100;
      case 'mm':
        return value / 1000;
      case 'km':
        return value * 1000;
      default:
        return value;
    }
  }

  double _fromMeters(double meters, String unit) {
    switch (unit) {
      case 'm':
        return meters;
      case 'cm':
        return meters * 100;
      case 'mm':
        return meters * 1000;
      case 'km':
        return meters / 1000;
      default:
        return meters;
    }
  }

  void _convert() {
    final input = double.tryParse(_inputController.text.trim());
    if (input == null) {
      setState(() => _output = 'Enter a valid number');
      return;
    }

    final meters = _toMeters(input, _fromUnit);
    final converted = _fromMeters(meters, _toUnit);

    setState(() {
      _output = '$input $_fromUnit = ${converted.toString()} $_toUnit';
    });
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const units = ['km', 'm', 'cm', 'mm'];

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Length conversion (via meters)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _inputController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Value',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _fromUnit,
                    decoration: const InputDecoration(
                      labelText: 'From',
                      border: OutlineInputBorder(),
                    ),
                    items: units
                        .map((u) => DropdownMenuItem(value: u, child: Text(u)))
                        .toList(),
                    onChanged: (v) {
                      if (v == null) return;
                      setState(() => _fromUnit = v);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _toUnit,
                    decoration: const InputDecoration(
                      labelText: 'To',
                      border: OutlineInputBorder(),
                    ),
                    items: units
                        .map((u) => DropdownMenuItem(value: u, child: Text(u)))
                        .toList(),
                    onChanged: (v) {
                      if (v == null) return;
                      setState(() => _toUnit = v);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _convert,
              icon: const Icon(Icons.swap_horiz),
              label: const Text('Convert'),
            ),
            const SizedBox(height: 18),
            Card(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Text(
                  _output.isEmpty ? 'Converted result will appear here' : _output,
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

