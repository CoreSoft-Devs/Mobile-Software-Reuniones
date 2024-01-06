import 'package:core_soft_meeting/config/constants/index.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final IconData? leftIcon;
  final bool isPassword;
  final String? placeholder;
  final String? errorText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;

  const CustomTextField({
    Key? key,
    this.leftIcon,
    this.isPassword = false,
    this.placeholder,
    this.errorText,
    this.controller,
    this.onChanged, // Agregado
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          style: const TextStyle(fontSize: 14, color: black),
          controller: widget.controller,
          obscureText: widget.isPassword && isObscureText,
          onChanged: widget.onChanged, // Pasar onChanged al TextField
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: black),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: black),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: black),
            ),
            labelText: widget.placeholder,
            labelStyle: const TextStyle(fontSize: 14, color: black),
            prefixIcon: widget.leftIcon != null ? Icon(widget.leftIcon) : null,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      isObscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        isObscureText = !isObscureText;
                      });
                    },
                  )
                : null,
            errorText: widget.errorText,
          ),
        ),
      ],
    );
  }
}
