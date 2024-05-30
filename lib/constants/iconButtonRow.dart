import 'package:firefriday/constants/colors.dart';
import 'package:flutter/material.dart';

class IconButtonRow extends StatefulWidget {
  final IconData icon;
  final String text;
  final Widget trailingWidget;
  final VoidCallback onPressed;

  const IconButtonRow({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed,
    this.trailingWidget = const SizedBox(),
  }) : super(key: key);

  @override
  State<IconButtonRow> createState() => _IconButtonRowState();
}

class _IconButtonRowState extends State<IconButtonRow> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        widget.onPressed();
        setState(() {
          _isPressed = true;
        });
        Future.delayed(const Duration(milliseconds: 100), () {
          setState(() {
            _isPressed = false;
          });
        });
      },
      style: TextButton.styleFrom(
        // maximumSize: const Size(double.infinity, 200.0),
        backgroundColor: _isPressed ? Colors.blue.shade700 : blueGrey,
        padding: const EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(widget.icon, color: Colors.white),
              const SizedBox(width: 16.0),
              Text(widget.text, style: const TextStyle(color: Colors.white)),
            ],
          ),
          // widget.trailingWidget,
          const SizedBox(width: 16.0),
          const Icon(Icons.arrow_forward_ios_outlined, color: Colors.green),
        ],
      ),
    );
  }
}
