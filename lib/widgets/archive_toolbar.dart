import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../models/letter_preview.dart';
import 'person_letter_filter_icon.dart';

class ArchiveToolbar extends StatelessWidget {
  const ArchiveToolbar({
    super.key,
    required this.totalLetters,
    required this.year,
    required this.direction,
    required this.onYearPressed,
    required this.onDirectionChanged,
    required this.onPersonFilterPressed,
    this.selectedPerson,
  });

  final int totalLetters;
  final int year;
  final LetterDirection direction;
  final VoidCallback onYearPressed;
  final ValueChanged<LetterDirection> onDirectionChanged;
  final VoidCallback onPersonFilterPressed;
  final String? selectedPerson;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 106,
      padding: const EdgeInsets.fromLTRB(24, 14, 24, 12),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(
          bottom: BorderSide(color: AppColors.divider, width: 0.7),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: _YearButton(year: year, onPressed: onYearPressed),
                ),
              ),
              LetterDirectionToggle(
                value: direction,
                onChanged: onDirectionChanged,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: _PersonFilterButton(
                    selectedPerson: selectedPerson,
                    onPressed: onPersonFilterPressed,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            '총 $totalLetters통',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
              letterSpacing: -0.2,
            ),
          ),
        ],
      ),
    );
  }
}

class LetterDirectionToggle extends StatelessWidget {
  const LetterDirectionToggle({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final LetterDirection value;
  final ValueChanged<LetterDirection> onChanged;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '편지함 종류',
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0xFFEEF0E9),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final option in LetterDirection.values)
                _DirectionSegment(
                  direction: option,
                  selected: option == value,
                  onTap: () => onChanged(option),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DirectionSegment extends StatelessWidget {
  const _DirectionSegment({
    required this.direction,
    required this.selected,
    required this.onTap,
  });

  final LetterDirection direction;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: selected ? AppColors.navigation : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            direction.label,
            style: TextStyle(
              color: selected ? Colors.white : AppColors.textSecondary,
              fontSize: 11,
              height: 1,
              fontWeight: selected ? FontWeight.w500 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

class _YearButton extends StatelessWidget {
  const _YearButton({required this.year, required this.onPressed});

  final int year;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '$year년 변경',
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 9),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$year',
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 17,
                    letterSpacing: 3.2,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(width: 1),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 18,
                  color: AppColors.textPrimary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PersonFilterButton extends StatelessWidget {
  const _PersonFilterButton({
    required this.selectedPerson,
    required this.onPressed,
  });

  final String? selectedPerson;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final semanticsLabel =
        selectedPerson == null ? '사람별로 편지 보기' : '$selectedPerson의 편지 필터 변경';

    return Semantics(
      button: true,
      label: semanticsLabel,
      child: Tooltip(
        message: selectedPerson ?? '사람별로 보기',
        child: InkResponse(
          onTap: onPressed,
          radius: 24,
          child: const SizedBox.square(
            dimension: 44,
            child: Center(child: PersonLetterFilterIcon()),
          ),
        ),
      ),
    );
  }
}
