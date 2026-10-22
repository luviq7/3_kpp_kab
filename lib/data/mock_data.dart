import 'models/borrowed_item.dart';
import 'models/user_profile.dart';

/// Hardcoded-дані замість бекенду: у лабораторній №3 бізнес-логіку не реалізуємо.
abstract final class MockData {
  static const UserProfile currentUser = UserProfile(
    fullName: 'Taras Kabachok',
    email: 'taras.kabachok@example.com',
  );

  static final List<BorrowedItem> items = [
    BorrowedItem(
      id: '1',
      title: 'Перфоратор Bosch GBH 2-26 RE',
      contactName: 'Олександр Шевченко',
      direction: LoanDirection.lent,
      handedOverAt: DateTime(2026, 4, 2),
      returnDueAt: DateTime(2026, 5, 18),
      status: LoanStatus.active,
    ),
    BorrowedItem(
      id: '2',
      title: 'Книга «Чистий Код» — Роберт Мартін',
      contactName: 'Дмитро Коваленко',
      direction: LoanDirection.lent,
      handedOverAt: DateTime(2026, 3, 10),
      returnDueAt: DateTime(2026, 4, 22),
      status: LoanStatus.overdue,
    ),
    BorrowedItem(
      id: '3',
      title: 'Настільна гра «Тераформування Марса»',
      contactName: 'Ірина Петренко',
      direction: LoanDirection.borrowed,
      handedOverAt: DateTime(2026, 4, 20),
      returnDueAt: DateTime(2026, 5, 25),
      status: LoanStatus.active,
    ),
    BorrowedItem(
      id: '4',
      title: "Об'єктив Sony FE 50mm f/1.8",
      contactName: 'Максим Кравченко',
      direction: LoanDirection.lent,
      handedOverAt: DateTime(2026, 5, 1),
      returnDueAt: DateTime(2026, 6, 2),
      status: LoanStatus.active,
    ),
    BorrowedItem(
      id: '5',
      title: 'Фотоапарат Fujifilm X100V',
      contactName: 'Олексій Бондар',
      direction: LoanDirection.borrowed,
      handedOverAt: DateTime(2026, 9, 18),
      returnDueAt: DateTime(2026, 10, 2),
      status: LoanStatus.overdue,
    ),
    BorrowedItem(
      id: '6',
      title: 'Палатка Naturehike Cloud Up 2',
      contactName: 'Андрій Мельник',
      direction: LoanDirection.borrowed,
      handedOverAt: DateTime(2026, 6, 12),
      returnDueAt: DateTime(2026, 6, 30),
      status: LoanStatus.returned,
    ),
  ];
}
