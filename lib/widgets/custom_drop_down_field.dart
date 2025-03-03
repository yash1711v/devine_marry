import 'package:devine_marry/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class CustomDropdownField extends StatelessWidget {
  final String hintText; // Placeholder text for the dropdown
  final String? selectedValue; // Currently selected value
  final List<String> options; // List of options for the dropdown
  final Function(String?) onChanged; // Callback when the value changes
  final bool showBorder; // Whether to show border
  final bool showTitle; // Whether to show title
  final bool required; // Whether the field is required for validation
  final String? Function(String?)? validator; // Validation function

  const CustomDropdownField({
    Key? key,
    required this.hintText,
    this.selectedValue,
    required this.options,
    required this.onChanged,
    this.showBorder = true,
    this.showTitle = false,
    this.required = false, // Default to not required
    this.validator, // Optional validation function
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showTitle)
          Text(
            hintText,
            style: DmSansRegular.copyWith(fontSize: Dimensions.fontSize12),
          ),
        SizedBox(height: showTitle ? 5 : 0),
        DropdownButtonFormField<String>(
          value: selectedValue,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                width: 1.5,
                color: Colors.black.withOpacity(0.30000001192092896),
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Colors.black.withOpacity(0.30000001192092896),
              ),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                width: 1.5,
                color: Colors.red,
              ),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Colors.red,
              ),
            ),
            hintText: hintText,
            hintStyle: DmSansRegular.copyWith(
              fontSize: Dimensions.fontSize14,
              color: Theme.of(context).hintColor,
            ),
            filled: true,
            fillColor: Theme.of(context).cardColor,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          ),
          items: options.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: (newValue) {
            onChanged(newValue); // Update the value when changed
          },
          isExpanded: true, // Makes the dropdown full width
          validator: (value) {
            if (required && (value == null || value.isEmpty)) {
              return 'This field is required';
            }
            return validator?.call(value);
          },
        ),
      ],
    );
  }
}