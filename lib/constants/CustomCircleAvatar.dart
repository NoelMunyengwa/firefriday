import 'package:flutter/material.dart';

class CustomeCirleAvatar extends StatelessWidget {
  final String imageUrl;
  CustomeCirleAvatar({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 30.0,
      child: CircleAvatar(
        backgroundImage: AssetImage(imageUrl),
        radius: 20.0,
      ),
    );
  }
}
