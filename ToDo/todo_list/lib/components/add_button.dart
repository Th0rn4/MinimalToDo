import 'package:flutter/material.dart';
import 'package:todo_list/utils/theme.dart';
//Add circular add button, to add task
class AddButton extends StatelessWidget {
  // Add a constructor to optionally specify the button's onPressed callback
  const AddButton({super.key, required this.onPressed});

  final VoidCallback onPressed; // Callback function for button press

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed, // Call the provided onPressed function
      child: const Icon(Icons.add),
      backgroundColor: appBarBackgroundColor, // Set the icon for the button
      shape: CircleBorder(),
    );
  }
}
