import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../models/letter_preview.dart';
import 'letter_envelope_icon.dart';

class LetterCard extends StatelessWidget {
  const LetterCard({
    super.key,
    required this.letter,
    this.onTap,
  });

  final LetterPreview letter;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: letter.direction == LetterDirection.received
          ? '${letter.date}, ${letter.person}에게 받은 편지'
          : '${letter.date}, ${letter.person}에게 전한 편지',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              letter.date,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 10,
                height: 1.2,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 4),
            LetterEnvelopeIcon(color: letter.color),
            const SizedBox(height: 6),
            Text(
              letter.person,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 12,
                height: 1.25,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
