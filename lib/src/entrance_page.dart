import 'package:flutter/material.dart';
import 'package:scutum_test_assignment/src/houses/houses_list_page.dart';

class EntrancePage extends StatelessWidget {
  const EntrancePage({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Text(
              'Test Task',
              style: TextStyle(fontSize: 20),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 30, 0, 20),
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.red,
                  width: 2,
                ),
              ),
              child: const Image(
                  image: AssetImage('assets/images/flutter_logo.png')),
            ),
            OutlinedButton(
              style: ButtonStyle(
                  minimumSize:
                      MaterialStateProperty.all<Size>(const Size(220, 40)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)))),
              child: const Text(
                'Enter',
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(
                    context, HousesListPage.routeName);
              },
            ),
            const Spacer(),
            const Align(
              alignment: Alignment.bottomRight,
              child: Text('designed by Sassha5'),
            )
          ],
        ),
      ),
    );
  }
}
