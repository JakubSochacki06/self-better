import 'package:flutter/material.dart';

class NoteTile extends StatelessWidget {
  final String noteTitle;
  final String noteDescription;
  final int feeling;
  NoteTile({required this.noteTitle, required this.noteDescription, required this.feeling});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      child: Column(
        children: [
          Text(noteTitle),
          Text(noteDescription),
          Text(feeling.toString()),
        ],
      ),
    );
  }
}
