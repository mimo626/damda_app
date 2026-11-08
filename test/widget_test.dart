import 'package:damda_app/main.dart';
import 'package:damda_app/widgets/letter_card.dart';
import 'package:damda_app/widgets/person_letter_filter_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('메인 보관함의 핵심 요소를 표시한다', (tester) async {
    tester.view.physicalSize = const Size(402, 874);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const DamdaApp());

    expect(find.text('총 28통'), findsOneWidget);
    expect(find.text('2026'), findsOneWidget);
    expect(find.text('받은 마음'), findsOneWidget);
    expect(find.text('전한 마음'), findsOneWidget);
    expect(find.byType(PersonLetterFilterIcon), findsOneWidget);
    expect(find.byType(LetterCard), findsNWidgets(15));
    expect(find.text('보관함'), findsOneWidget);
  });

  testWidgets('전한 마음 토글로 편지함을 전환한다', (tester) async {
    tester.view.physicalSize = const Size(402, 874);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const DamdaApp());
    await tester.tap(find.text('전한 마음'));
    await tester.pumpAndSettle();

    expect(find.text('총 18통'), findsOneWidget);
    expect(find.byType(LetterCard), findsNWidgets(6));
  });

  testWidgets('연도 선택 바텀 시트를 연다', (tester) async {
    tester.view.physicalSize = const Size(402, 874);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const DamdaApp());
    await tester.tap(find.text('2026'));
    await tester.pumpAndSettle();

    expect(find.text('연도 선택'), findsOneWidget);
    expect(find.text('2025년'), findsOneWidget);
  });
}
