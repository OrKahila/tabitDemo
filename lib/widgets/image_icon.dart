import 'package:flutter/material.dart';

class MyImageIcon extends StatelessWidget {
  const MyImageIcon({
    super.key,
    required this.icon,
    this.color,
    this.size,
    this.isGif,
  });

  final String icon;
  final Color? color;
  final double? size;
  final bool? isGif;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ?? 15,
      height: size ?? 15,
      decoration: BoxDecoration(
        image: color != null
            ? null
            : DecorationImage(
                image: AssetImage(
                    'assets/icons/$icon.${isGif != null && isGif! ? 'gif' : 'png'}'),
                fit: BoxFit.cover,
              ),
      ),
      child: color != null
          ? ImageIcon(
              AssetImage(
                  'assets/icons/$icon.${isGif != null && isGif! ? 'gif' : 'png'}'),
              color: color,
            )
          : null,
    );
  }
}
