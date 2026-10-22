import 'package:borrowed_items_manager/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('вхід відкриває головний екран, а звідти — профіль', (tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const BorrowedItemsApp());
    expect(find.text('Вхід у систему'), findsOneWidget);

    await tester.tap(find.text('Увійти'));
    await tester.pumpAndSettle();
    expect(find.text('Всі речі'), findsWidgets);
    expect(find.text('Перфоратор Bosch GBH 2-26 RE'), findsOneWidget);

    await tester.tap(find.text('Taras Kabachok'));
    await tester.pumpAndSettle();
    expect(find.text('Керування профілем'), findsOneWidget);
  });

  testWidgets('форма редагування відкривається і закривається', (tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const BorrowedItemsApp());
    await tester.tap(find.text('Увійти'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Редагувати').first);
    await tester.pumpAndSettle();
    expect(find.text('Редагування запису про річ'), findsOneWidget);

    await tester.tap(find.text('Видалити запис'));
    await tester.pumpAndSettle();
    expect(find.text('Видалити запис?'), findsOneWidget);
  });

  testWidgets('з форми можна відкрити екран фотофіксації і повернутися', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const BorrowedItemsApp());
    await tester.tap(find.text('Увійти'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Редагувати').first);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Фотофіксація стану речі'));
    await tester.pumpAndSettle();
    expect(find.text('Додав: Taras Kabachok'), findsOneWidget);
    expect(find.text('Розмір: 2.4 МБ'), findsOneWidget);

    await tester.tap(find.byTooltip('Видалити фото'));
    await tester.pump();
    expect(find.text('Розмір: 2.4 МБ'), findsNothing);

    await tester.tap(find.text('Повернутися до редагування'));
    await tester.pumpAndSettle();
    expect(find.text('Редагування запису про річ'), findsOneWidget);
  });
}
