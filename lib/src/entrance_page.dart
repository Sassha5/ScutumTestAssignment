import 'package:flutter/material.dart';
import 'package:scutum_test_assignment/src/houses/houses_list_page.dart';

class EntrancePage extends StatelessWidget {
  const EntrancePage({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello!'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: TextButton(
            child: const Text('Enter'),
            onPressed: () {
              Navigator.restorablePushNamed(context, HousesListPage.routeName);
            },
          )),
    );
  }
}
