import 'package:flutter/material.dart';

class CardInfo extends StatelessWidget {
  const CardInfo({
    Key? key,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  final String title, subTitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.white54,
        child: Icon(
          Icons.person_outline,
          color: Colors.white,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        subTitle,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
