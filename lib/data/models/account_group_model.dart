import 'package:cloud_firestore/cloud_firestore.dart';

class AccountGroup {
  final String id;
  final String title;
  final int order;




  final List<AccountItem> accounts;

  AccountGroup({required this.title, required this.accounts, required this.order, required this.id});

  factory AccountGroup.fromMap(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>;
    return AccountGroup(
        id: doc.id,
      title: map['title'] ?? '',
      order: map['order'] ?? 0,

      accounts: (map['accounts'] as List<dynamic>? ?? [])
          .map((e) => AccountItem.fromMap(e))
          .toList(),
    );
  }
}

class AccountItem {
  final String name;
  final String number;
  final double amount;

  AccountItem({required this.name, required this.number, required this.amount});

  factory AccountItem.fromMap(Map<String, dynamic> map) {
    return AccountItem(
      name: (map['name'] ?? '').toString(),
      number: (map['number'] ?? '').toString(),
      amount: double.parse(map['amount'].toString()),

    );
  }
}
