import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restomaknyus/Utils/colors.dart';

import 'spaces.dart';

class ColumnButton extends StatelessWidget {
  final String label;
  final String iconPath;
  final VoidCallback onPressed;
  final Color color;
  const ColumnButton({
    super.key,
    required this.label,
    required this.iconPath,
    required this.onPressed,
    this.color = const Color(0xFF3949AB),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            height: 40.0,
            width: 40.0,
            decoration: BoxDecoration(
              color: CustomColor.white,
              border: Border.all(
                color: CustomColor.primary,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  8.0,
                ),
              ),
            ),
            child: SvgPicture.asset(
              iconPath,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
          ),
          const SpaceHeight(
            8.0,
          ),
          Text(
            label,
            style: const TextStyle(
              color: CustomColor.primary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
