// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class InputTextField extends StatefulWidget {
  final TextEditingController? textEditingController;
  final String? labelText;
  final String? hintText;
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  final String? inititalValue;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final bool isMandatory;
  final int maxLines;
  final Widget? suffix;
  const InputTextField({
    this.maxLines = 1,
    this.textEditingController,
    this.labelText,
    this.hintText = "",
    required this.onChanged,
    this.validator,
    this.inititalValue,
    this.keyboardType,
    this.readOnly,
    this.isMandatory = false,
    this.suffix,
    Key? key,
  }) : super(key: key);

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  @override
  void initState() {
    // if (widget.textEditingController == null) {
    // controller = TextEditingController(text: widget.inititalValue);
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.labelText != null
              ? Row(
                  children: [
                    Text(widget.labelText ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        )),
                    widget.isMandatory
                        ? const Text("*",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.red,
                            ))
                        : Container(),
                  ],
                )
              : Container(),
          TextFormField(
            maxLines: widget.maxLines,
            key: widget.key,
            readOnly: widget.readOnly ?? false,
            keyboardType: widget.keyboardType,
            controller: widget.textEditingController,
            onChanged: widget.onChanged,
            validator: widget.validator,
            initialValue: widget.inititalValue,
            decoration: InputDecoration(hintText: "Enter", hintStyle: const TextStyle(color: Colors.black), suffix: widget.suffix),
          ),
        ],
      ),
    );
  }
}
