import 'package:flutter/material.dart';

class EmployeeDetailsTextView extends StatelessWidget {
  const EmployeeDetailsTextView({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        text,
        style: const TextStyle(
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
