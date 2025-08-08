import 'package:flutter/material.dart';

class BillsShell extends StatelessWidget {
  final Widget child;
  const BillsShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bills')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: child, // <- outlet ("hole") for all /reps/* pages
      ),
    );
  }
}
