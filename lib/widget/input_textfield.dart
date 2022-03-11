import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputTextField extends StatelessWidget {
  const InputTextField(
      {Key? key,
      required this.controller,
      required this.label,
      required this.hintText})
      : super(key: key);
  final TextEditingController controller;
  final String label;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.lato(fontSize: 28.0),
        ),
        TextField(
          controller: controller,
          cursorColor: colorScheme.secondary,
          keyboardType: TextInputType.multiline,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 18),
          maxLines: null,
          decoration: InputDecoration(
            hintText: hintText,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black54),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colorScheme.secondary),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: colorScheme.primary),
            ),
          ),
        )
      ],
    );
  }
}
