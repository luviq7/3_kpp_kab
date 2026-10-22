/// Напрямок передачі речі.
enum LoanDirection {
  /// Я позичив річ комусь (мені винні).
  lent,

  /// Мені позичили річ.
  borrowed,
}

enum LoanStatus { active, overdue, returned }

/// Запис про річ (Borrowed Item) зі специфікації лабораторної №2.
class BorrowedItem {
  final String id;
  final String title;
  final String contactName;
  final LoanDirection direction;
  final DateTime handedOverAt;
  final DateTime returnDueAt;
  final LoanStatus status;

  const BorrowedItem({
    required this.id,
    required this.title,
    required this.contactName,
    required this.direction,
    required this.handedOverAt,
    required this.returnDueAt,
    required this.status,
  });
}
