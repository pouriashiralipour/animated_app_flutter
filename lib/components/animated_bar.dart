import 'package:flutter/material.dart';

class AnimatedNavBar extends StatelessWidget {
  const AnimatedNavBar({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(microseconds: 200),
      margin: const EdgeInsets.only(bottom: 2),
      width: isActive ? 20 : 0,
      height: 4,
      decoration: const BoxDecoration(
          color: Color(0xFF81B4FF),
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }
}
