import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PreferenceSlider extends StatelessWidget {
  final double value;
  final Function(double) onChanged;

  const PreferenceSlider({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Speed vs. Cost',
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
        Slider(
          value: value,
          onChanged: onChanged, // Corrected from onChnaged
          activeColor: const Color(0xFF4FC3F7),
          inactiveColor: Colors.white12,
          min: 0.0,
          max: 1.0,
          label: value < 0.5 ? 'Cost' : 'Speed',
        ),
      ],
    );
  }
}