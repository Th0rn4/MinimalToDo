import 'package:flutter/material.dart';
import 'package:todo_list/utils/mybutton.dart';
import 'package:todo_list/utils/theme.dart';

// ignore: must_be_immutable
class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
   DialogBox({super.key,required this.controller, required this.onSave, required this.onCancel});
//Add pop up for adding a new task
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: appBarBackgroundColor,
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //get user input
            TextField(
              controller: controller,
              decoration: InputDecoration(border: OutlineInputBorder(
              ),
              hintText:"Add a new task"
              ),
            ),

            //buttons save/cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //Save
                MyButton(text: "Save", onPressed: onSave),

                const SizedBox(width: 8,),

                //Cancel
                MyButton(text: "Cancel", onPressed: onCancel),
              ],
            )
          ],
        ),
      ),
    );
  }
}
