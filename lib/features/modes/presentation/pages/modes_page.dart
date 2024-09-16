import 'package:flutter/material.dart';

class ModesPage extends StatelessWidget {
  const ModesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Modes')),
      body: const Center(
        child: Text('Modes'),
      ),
    );
  }
}
