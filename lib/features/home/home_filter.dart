import 'package:flutter/material.dart';

import '../../data/models/borrowed_item.dart';

/// Категорії бічної панелі головного вікна.
enum HomeFilter {
  all('Всі речі', Icons.inventory_2_outlined),
  lent('Я позичив', Icons.north_east),
  // Підпис із макета; відповідає вкладці «Мені позичили» у формі запису.
  borrowed('Мені винні', Icons.south_west),
  overdue('Протерміновано', Icons.alarm_outlined);

  final String title;
  final IconData icon;

  const HomeFilter(this.title, this.icon);

  bool matches(BorrowedItem item) => switch (this) {
    HomeFilter.all => true,
    HomeFilter.lent => item.direction == LoanDirection.lent,
    HomeFilter.borrowed => item.direction == LoanDirection.borrowed,
    HomeFilter.overdue => item.status == LoanStatus.overdue,
  };
}

/// Варіанти сортування списку речей у тулбарі.
enum HomeSort {
  returnDate('За датою повернення'),
  handOverDate('За датою передачі'),
  title('За назвою');

  final String label;

  const HomeSort(this.label);

  int compare(BorrowedItem a, BorrowedItem b) => switch (this) {
    HomeSort.returnDate => a.returnDueAt.compareTo(b.returnDueAt),
    HomeSort.handOverDate => b.handedOverAt.compareTo(a.handedOverAt),
    HomeSort.title => a.title.compareTo(b.title),
  };
}
