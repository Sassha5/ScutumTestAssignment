import 'package:flutter/material.dart';

import '../houses/house.dart';

/// Displays list of floors of a specific house.
class FloorsListPage extends StatelessWidget {
   const FloorsListPage({super.key, required this.house});

  static const routeName = '/floors';

  final House house;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Floors'),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: house.floors,
            itemBuilder: (context, index) {
              return Text('data');
            }),
      ),
    );
  }
}
