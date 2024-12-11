import 'package:flutter/material.dart';

class Utils {
  static Color getStatusColor(String status) {
    switch (status) {
      case 'Alive':
        return Colors.purple;
      case 'unknown':
        return Colors.orange[900]!;
      case 'Dead':
        return Colors.red[900]!;
      default:
        return Colors.grey;
    }
  }
}
