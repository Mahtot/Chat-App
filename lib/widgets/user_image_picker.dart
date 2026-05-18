import 'package:flutter/material.dart';

class UserImagePicker extends StatefulWidget {
  UserImagePicker({super.key});

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          foregroundImage:...,
          backgroundColor: Colors.grey
        ), 
        TextButton.icon(label: Text('Add Image', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
        onPressed:(){},
        icon: Icon(Icons.image)) 
      ]
    );
  }
}
