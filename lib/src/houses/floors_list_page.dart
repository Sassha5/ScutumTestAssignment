import 'package:flutter/material.dart';

/// Displays list of floors of a specific house.
class FloorsListPage extends StatelessWidget {
  const FloorsListPage({super.key});

  static const routeName = '/floors';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Floors'),
      ),
      body: const Center(
        child: Text('List Here'),
      ),
    );
  }
}
