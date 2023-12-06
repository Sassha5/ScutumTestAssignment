import 'package:flutter/material.dart';
import 'package:scutum_test_assignment/src/floors/floors_controller.dart';

import '../houses/house.dart';

/// Displays list of floors of a specific house.
class FloorsListPage extends StatelessWidget {
  const FloorsListPage({super.key, required this.house});

  static const routeName = '/floors';

  final House house;

  @override
  Widget build(BuildContext context) {
    var controller = FloorsController(house);

    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 90, left: 40),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Floors',
                  style: TextStyle(fontSize: 16),
                )),
          ),
          const Divider(
            height: 1,
            thickness: 2,
            indent: 30,
            endIndent: 30,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: house.floors == 0
                  ? const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('This house has no floors'),
                  )
                  : ListenableBuilder(
                      listenable: controller,
                      builder: (context, data) => ListView.builder(
                          itemCount: house.floors,
                          itemBuilder: (context, index) {
                            return FloorWidget(
                                index: index, controller: controller);
                          }),
                    ),
            ),
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () async => await controller.cancelNotification(),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('designed by Sassha5'),
                ),
              ),
            )
        ],
      ),
    );
  }
}

class FloorWidget extends StatelessWidget {
  const FloorWidget({
    super.key,
    required this.index,
    required this.controller,
  });

  final int index;
  final FloorsController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: ListTile(
          tileColor: _getColor(),
          dense: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          title: Center(
            child: Text('Floor ${index + 1}',
                style: const TextStyle(fontSize: 16)),
          ),
          onTap: () {
            controller.moveLift(index);
          }),
    );
  }

  _getColor() {
    if (controller.currentFloor == index) {
      return controller.isMoving ? Colors.yellow : Colors.green;
    } else {
      return Colors.transparent;
    }
  }
}
