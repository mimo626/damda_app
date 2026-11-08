import 'package:flutter/material.dart';

enum LetterDirection {
  received,
  sent,
}

extension LetterDirectionLabel on LetterDirection {
  String get label => switch (this) {
        LetterDirection.received => '받은 마음',
        LetterDirection.sent => '전한 마음',
      };
}

class LetterPreview {
  const LetterPreview({
    required this.date,
    required this.person,
    required this.color,
    required this.year,
    required this.direction,
  });

  final String date;
  final String person;
  final Color color;
  final int year;
  final LetterDirection direction;
}
