import 'package:flutter/material.dart';

class FilterDialog extends StatelessWidget {
  final String initialFilter;
  final Function(String) onFilterSelected;

  const FilterDialog({
    super.key,
    required this.initialFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> statuses = ['Alive', 'Dead', 'unknown'];

    return AlertDialog(
      title: const Text(
        'Filter by Status',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w300,
          fontFamily: 'Rubik',
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...statuses.map(
            (status) {
              return RadioListTile<String>(
                title: Text(
                  status,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Rubik',
                  ),
                ),
                value: status,
                groupValue: initialFilter,
                onChanged: (value) {
                  if (value != null) {
                    onFilterSelected(value);
                    Navigator.of(context).pop();
                  }
                },
              );
            },
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                onFilterSelected(''); // Reset the filter to an empty string
                Navigator.of(context).pop();
              },
              child: const Text(
                'Reset',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Rubik',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
