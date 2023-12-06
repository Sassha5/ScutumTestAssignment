import 'package:flutter/material.dart';
import 'package:scutum_test_assignment/src/houses/house.dart';

class FloorsController with ChangeNotifier {
  FloorsController(this.house);

  final House house;

  int _currentFloor = 0;
  int get currentFloor => _currentFloor;

  bool _isMoving = false;
  bool get isMoving => _isMoving;

  Future<void> moveLift(int targetFloor) async {
    if (targetFloor >= 0 &&
        targetFloor <= house.floors &&
        targetFloor != currentFloor) {
      _isMoving = true;
      var direction = currentFloor < targetFloor ? 1 : -1;

      while (currentFloor != targetFloor) {
        notifyListeners();
        _currentFloor += direction;
        await Future.delayed(const Duration(seconds: 1));
      }

      _isMoving = false;
      notifyListeners();
    }
  }
}
