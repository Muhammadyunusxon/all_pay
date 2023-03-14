import 'package:flutter/material.dart';

class MyFormField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final TextInputAction textInputAction;
  final TextInputType inputType;
  final ValueChanged onChange;
  final FormFieldValidator<String>? validator;

  const MyFormField({
    Key? key,
    required this.controller,
    required this.title,
    required this.textInputAction,
    this.inputType = TextInputType.text,
    required this.onChange,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(title),
          ),
          const SizedBox(height: 7),
          TextFormField(
            validator: validator,
            style: Theme.of(context).textTheme.displaySmall,
            keyboardType: inputType,
            onChanged: onChange,
            textInputAction: textInputAction,
            controller: controller,
            decoration: InputDecoration(
              hintText: title,
              hintStyle:
                  Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Theme.of(context).cardColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Theme.of(context).cardColor)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Theme.of(context).cardColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
