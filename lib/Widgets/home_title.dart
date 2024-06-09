import 'package:flutter/material.dart';
import '../Utils/search_input.dart';
import '../Utils/spaces.dart';
import '../Utils/colors.dart';
import '../Utils/strings.dart';
import '../Utils/date_time.dart';

class HomeTitle extends StatefulWidget {
  final TextEditingController controller;
  final Function(String value)? onChanged;
  const HomeTitle({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  State<HomeTitle> createState() => _HomeTitleState();
}

class _HomeTitleState extends State<HomeTitle> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.appName,
              style: const TextStyle(
                color: CustomColor.primary,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SpaceHeight(
              4.0,
            ),
            Text(
              DateTime.now().toFormattedDate(),
              style: const TextStyle(
                color: CustomColor.subtitle,
                fontSize: 10,
              ),
            ),
          ],
        ),
        SizedBox(
          width: 300.0,
          child: SearchInput(
            controller: widget.controller,
            onChanged: widget.onChanged,
            hintText: Strings.search,
          ),
        ),
      ],
    );
  }
}
