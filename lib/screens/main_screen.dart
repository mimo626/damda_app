import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../models/letter_preview.dart';
import '../widgets/archive_toolbar.dart';
import '../widgets/damda_bottom_navigation.dart';
import '../widgets/damda_logo_header.dart';
import '../widgets/letter_card.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static const _totalLettersByDirection = <LetterDirection, Map<int, int>>{
    LetterDirection.received: {
      2024: 12,
      2025: 19,
      2026: 28,
    },
    LetterDirection.sent: {
      2024: 8,
      2025: 13,
      2026: 18,
    },
  };

  static const _letters = <LetterPreview>[
    LetterPreview(
      date: '12.16',
      person: '수빈',
      color: AppColors.letterOlive,
      year: 2026,
      direction: LetterDirection.received,
    ),
    LetterPreview(
      date: '12.03',
      person: '수빈',
      color: AppColors.letterDustyRose,
      year: 2026,
      direction: LetterDirection.received,
    ),
    LetterPreview(
      date: '11.01',
      person: '수빈',
      color: AppColors.letterDeepNavy,
      year: 2026,
      direction: LetterDirection.received,
    ),
    LetterPreview(
      date: '10.26',
      person: '수빈',
      color: AppColors.letterWalnut,
      year: 2026,
      direction: LetterDirection.received,
    ),
    LetterPreview(
      date: '10.13',
      person: '수빈',
      color: AppColors.letterBlueGray,
      year: 2026,
      direction: LetterDirection.received,
    ),
    LetterPreview(
      date: '10.04',
      person: '수빈',
      color: AppColors.letterBlush,
      year: 2026,
      direction: LetterDirection.received,
    ),
    LetterPreview(
      date: '09.20',
      person: '수빈',
      color: AppColors.letterBurgundy,
      year: 2026,
      direction: LetterDirection.received,
    ),
    LetterPreview(
      date: '09.01',
      person: '수빈',
      color: AppColors.letterPlum,
      year: 2026,
      direction: LetterDirection.received,
    ),
    LetterPreview(
      date: '08.15',
      person: '수빈',
      color: AppColors.letterForest,
      year: 2026,
      direction: LetterDirection.received,
    ),
    LetterPreview(
      date: '07.04',
      person: '수빈',
      color: AppColors.letterMoss,
      year: 2026,
      direction: LetterDirection.received,
    ),
    LetterPreview(
      date: '06.26',
      person: '수빈',
      color: AppColors.letterSilver,
      year: 2026,
      direction: LetterDirection.received,
    ),
    LetterPreview(
      date: '05.05',
      person: '수빈',
      color: AppColors.letterSage,
      year: 2026,
      direction: LetterDirection.received,
    ),
    LetterPreview(
      date: '04.12',
      person: '수빈',
      color: AppColors.letterTaupe,
      year: 2026,
      direction: LetterDirection.received,
    ),
    LetterPreview(
      date: '03.25',
      person: '수빈',
      color: AppColors.letterCharcoal,
      year: 2026,
      direction: LetterDirection.received,
    ),
    LetterPreview(
      date: '02.11',
      person: '수빈',
      color: AppColors.letterStoneBrown,
      year: 2026,
      direction: LetterDirection.received,
    ),
    LetterPreview(
      date: '11.20',
      person: '수빈',
      color: AppColors.letterAntiqueGold,
      year: 2026,
      direction: LetterDirection.sent,
    ),
    LetterPreview(
      date: '09.18',
      person: '지민',
      color: AppColors.letterMauve,
      year: 2026,
      direction: LetterDirection.sent,
    ),
    LetterPreview(
      date: '07.11',
      person: '수빈',
      color: AppColors.letterSlate,
      year: 2026,
      direction: LetterDirection.sent,
    ),
    LetterPreview(
      date: '05.23',
      person: '지민',
      color: AppColors.letterClay,
      year: 2026,
      direction: LetterDirection.sent,
    ),
    LetterPreview(
      date: '03.14',
      person: '수빈',
      color: AppColors.letterRoseMist,
      year: 2026,
      direction: LetterDirection.sent,
    ),
    LetterPreview(
      date: '01.08',
      person: '지민',
      color: AppColors.letterEvergreen,
      year: 2026,
      direction: LetterDirection.sent,
    ),
  ];

  int _selectedYear = 2026;
  LetterDirection _direction = LetterDirection.received;
  String? _selectedPerson;
  int _navigationIndex = 0;

  List<LetterPreview> get _visibleLetters {
    return _letters.where((letter) {
      final matchesYear = letter.year == _selectedYear;
      final matchesDirection = letter.direction == _direction;
      final matchesPerson =
          _selectedPerson == null || letter.person == _selectedPerson;
      return matchesYear && matchesDirection && matchesPerson;
    }).toList(growable: false);
  }

  int get _totalLetters {
    return _totalLettersByDirection[_direction]?[_selectedYear] ??
        _visibleLetters.length;
  }

  Future<void> _selectYear() async {
    final selected = await showModalBottomSheet<int>(
      context: context,
      backgroundColor: AppColors.background,
      showDragHandle: true,
      builder: (context) => _SelectionSheet<int>(
        title: '연도 선택',
        values: _totalLettersByDirection[_direction]!.keys.toList()
          ..sort((a, b) => b.compareTo(a)),
        selectedValue: _selectedYear,
        labelBuilder: (year) => '$year년',
      ),
    );

    if (selected == null || selected == _selectedYear) return;
    setState(() {
      _selectedYear = selected;
      _selectedPerson = null;
    });
  }

  Future<void> _selectPerson() async {
    final people = _letters
        .where(
          (letter) =>
              letter.year == _selectedYear && letter.direction == _direction,
        )
        .map((letter) => letter.person)
        .toSet()
        .toList()
      ..sort();
    final result = await showModalBottomSheet<_PersonFilterResult>(
      context: context,
      backgroundColor: AppColors.background,
      showDragHandle: true,
      builder: (context) => _PersonSelectionSheet(
        people: people,
        direction: _direction,
        selectedPerson: _selectedPerson,
      ),
    );

    if (!mounted || result == null) return;
    setState(() => _selectedPerson = result.person);
  }

  void _showLetter(LetterPreview letter) {
    final action = letter.direction == LetterDirection.received ? '받은' : '전한';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${letter.date} ${letter.person}에게 $action 편지')),
    );
  }

  void _changeDirection(LetterDirection direction) {
    if (direction == _direction) return;
    setState(() {
      _direction = direction;
      _selectedPerson = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final letters = _visibleLetters;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const DamdaLogoHeader(),
          ArchiveToolbar(
            totalLetters: _totalLetters,
            year: _selectedYear,
            direction: _direction,
            selectedPerson: _selectedPerson,
            onYearPressed: _selectYear,
            onDirectionChanged: _changeDirection,
            onPersonFilterPressed: _selectPerson,
          ),
          Expanded(
            child: letters.isEmpty
                ? const _EmptyArchive()
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(31, 30, 31, 92),
                    itemCount: letters.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 24,
                      childAspectRatio: 1.02,
                    ),
                    itemBuilder: (context, index) {
                      final letter = letters[index];
                      return LetterCard(
                        key: ValueKey(
                          '${letter.year}-${letter.direction}-${letter.date}-${letter.person}',
                        ),
                        letter: letter,
                        onTap: () => _showLetter(letter),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: '편지 작성',
        elevation: 0,
        highlightElevation: 0,
        backgroundColor: AppColors.navigation,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add_rounded, size: 31),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: DamdaBottomNavigation(
        currentIndex: _navigationIndex,
        onSelected: (index) => setState(() => _navigationIndex = index),
      ),
    );
  }
}

class _SelectionSheet<T> extends StatelessWidget {
  const _SelectionSheet({
    required this.title,
    required this.values,
    required this.selectedValue,
    required this.labelBuilder,
  });

  final String title;
  final List<T> values;
  final T selectedValue;
  final String Function(T value) labelBuilder;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            for (final value in values)
              ListTile(
                title: Text(labelBuilder(value)),
                trailing: value == selectedValue
                    ? const Icon(
                        Icons.check_rounded,
                        color: AppColors.navigation,
                      )
                    : null,
                onTap: () => Navigator.pop(context, value),
              ),
          ],
        ),
      ),
    );
  }
}

class _PersonSelectionSheet extends StatelessWidget {
  const _PersonSelectionSheet({
    required this.people,
    required this.direction,
    required this.selectedPerson,
  });

  final List<String> people;
  final LetterDirection direction;
  final String? selectedPerson;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              direction == LetterDirection.received ? '마음을 전한 사람' : '마음을 받을 사람',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            ListTile(
              title: const Text('전체'),
              trailing: selectedPerson == null
                  ? const Icon(
                      Icons.check_rounded,
                      color: AppColors.navigation,
                    )
                  : null,
              onTap: () => Navigator.pop(
                context,
                const _PersonFilterResult(null),
              ),
            ),
            for (final person in people)
              ListTile(
                title: Text(person),
                trailing: person == selectedPerson
                    ? const Icon(
                        Icons.check_rounded,
                        color: AppColors.navigation,
                      )
                    : null,
                onTap: () => Navigator.pop(
                  context,
                  _PersonFilterResult(person),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _PersonFilterResult {
  const _PersonFilterResult(this.person);

  final String? person;
}

class _EmptyArchive extends StatelessWidget {
  const _EmptyArchive();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '아직 보관된 편지가 없어요',
        style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
      ),
    );
  }
}
