import 'package:flutter/material.dart';

class Instructions extends StatelessWidget {
  const Instructions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [Text("Tap to toggle state - Long press to delete")],
        ),
      ),
    );
  }
}
