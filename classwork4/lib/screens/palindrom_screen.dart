import 'package:flutter/material.dart';

class PalindromScreen extends StatefulWidget {
  const PalindromScreen({super.key});

  @override
  State<PalindromScreen> createState() => _PalindromScreenState();
}

class _PalindromScreenState extends State<PalindromScreen> {
  final _controller = TextEditingController();
  String _message = '';

  bool _isPalindrome(String s) {
    final normalized = s.replaceAll(RegExp(r'\s+'), '').toLowerCase();
    if (normalized.isEmpty) return false;
    return normalized == normalized.split('').reversed.join();
  }

  void _check() {
    final input = _controller.text;
    final ok = _isPalindrome(input);

    setState(() {
      if (input.trim().isEmpty) {
        _message = 'Enter text to check';
      } else {
        _message = ok ? 'Palindrome' : 'Not Palindrome';
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
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
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter a word/sentence',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _check,
              icon: const Icon(Icons.search),
              label: const Text('Check'),
            ),
            const SizedBox(height: 18),
            Card(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Text(
                  _message.isEmpty ? 'Result will appear here' : _message,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

