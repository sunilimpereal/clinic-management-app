import 'package:flutter/material.dart';

class PhoneNumberDropdownMenu extends StatefulWidget {
  const PhoneNumberDropdownMenu({super.key});

  @override
  State<PhoneNumberDropdownMenu> createState() =>
      _PhoneNumberDropdownMenuState();
}

class _PhoneNumberDropdownMenuState extends State<PhoneNumberDropdownMenu> {
  List<String> countryCodes = [
    // '🇺🇸',
    // '🇬🇧',
    '🇮🇳',
  ];
  String selectedCountryCode = '🇮🇳';

  List<DropdownMenuItem<String>> _buildDropdownMenuItems() {
    return countryCodes
        .map(
          (code) => DropdownMenuItem(
            value: code,
            child: Row(
              children: [
                Text(
                  code,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(width: 6),
                // Text(code),
              ],
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 55,
      height: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          DropdownButton(
            // isDense: true,
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down),
            value: selectedCountryCode,
            onChanged: (value) {
              setState(() {
                selectedCountryCode = value!;
              });
            },
            items: _buildDropdownMenuItems(),
          ),
        ],
      ),
    );
  }
}
