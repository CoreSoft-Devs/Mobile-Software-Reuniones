import 'package:core_soft_meeting/config/constants/index.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function onTap;

  const MyButton({Key? key, required this.label, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: black,
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: white,
            ),
          ),
        ),
      ),
    );
  }
}
