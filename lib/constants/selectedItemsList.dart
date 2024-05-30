import 'package:firefriday/constants/colors.dart';
import 'package:flutter/material.dart';

class SelectedItemList extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isChecked;
  final ValueChanged<bool>? onCheckboxChanged;

  const SelectedItemList({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isChecked = false,
    this.onCheckboxChanged,
  }) : super(key: key);

  @override
  State<SelectedItemList> createState() => _SelectedItemListState();
}

class _SelectedItemListState extends State<SelectedItemList> {
  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        widget.onPressed();
      },
      style: TextButton.styleFrom(
        backgroundColor: _isSelected ? Colors.grey : blueGrey,
        padding: const EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.text, style: const TextStyle(color: Colors.white)),
          Checkbox(
            value: _isSelected,
            onChanged: (value) {
              setState(() {
                _isSelected = value!;
                if (widget.onCheckboxChanged != null) {
                  widget.onCheckboxChanged!(value);
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
