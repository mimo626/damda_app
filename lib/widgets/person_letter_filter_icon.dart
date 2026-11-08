import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import 'letter_envelope_icon.dart';

/// Combines a person and a small letter into one compact filter symbol.
class PersonLetterFilterIcon extends StatelessWidget {
  const PersonLetterFilterIcon({
    super.key,
    this.color = AppColors.textPrimary,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28,
      height: 25,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Icon(
              Icons.person_outline_rounded,
              size: 25,
              color: color,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 1,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(1.5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(1.2),
                child: LetterEnvelopeIcon(
                  color: color,
                  width: 12,
                  height: 8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
