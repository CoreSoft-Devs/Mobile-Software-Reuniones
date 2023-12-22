import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  final String label;
  final String value;
  final Widget? leading;

  ProfileInfo({required this.label, required this.value, this.leading});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double availableWidth = constraints.maxWidth;

        double labelFontSize = availableWidth * 0.04; 
        double valueFontSize = availableWidth * 0.05;

        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                if (leading != null)
                  Container(
                    margin: const EdgeInsets.only(right: 12),
                    child: leading,
                  ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: labelFontSize,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        value,
                        style: TextStyle(fontSize: valueFontSize),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
