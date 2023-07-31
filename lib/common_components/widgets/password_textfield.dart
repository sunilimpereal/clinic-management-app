// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:clinic_app/utils/constants/color_konstants.dart';

class PasswordTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  TextEditingController textEditingController;
  final Function(String) onchanged;
  final String? Function(String?) validator;
  PasswordTextField(
      {Key? key,
      required this.labelText,
      required this.textEditingController,
      required this.hintText,
      required this.onchanged,
      required this.validator})
      : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _showPassword = false;

  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.labelText,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: ColorKonstants.labelTextColor,
            ),
          ),
          TextFormField(
            controller: widget.textEditingController,
            obscureText: !_showPassword,
            onChanged: widget.onchanged,
            validator: widget.validator,
            decoration: InputDecoration(
              hintText: "Enter",
              hintStyle: TextStyle(color: ColorKonstants.hintTextColor),
              suffixIcon: IconButton(
                icon: Icon(
                  _showPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  color: Colors.blue,
                ),
                onPressed: _togglePasswordVisibility,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
