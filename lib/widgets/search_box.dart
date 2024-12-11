import 'package:flutter/material.dart';
import 'image_icon.dart';

class SearchBox extends StatelessWidget {
  final Function(String) onSearchChanged;
  final VoidCallback onFilterPressed;

  const SearchBox({
    super.key,
    required this.onSearchChanged,
    required this.onFilterPressed,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          const MyImageIcon(
            icon: 'search',
            size: 25,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              onChanged: onSearchChanged,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                fontFamily: 'Rubik',
              ),
              decoration: const InputDecoration(
                hintText: 'Search character',
                hintStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Rubik',
                  color: Colors.grey,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            onPressed: onFilterPressed,
            icon: const MyImageIcon(
              icon: 'filter',
              size: 25,
            ),
          ),
        ],
      ),
    );
  }
}
