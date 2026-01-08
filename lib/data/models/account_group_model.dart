import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imagine_3d/data/models/transaction_model.dart';

class AccountGroup {
  final String id;
  final String title;
  final int order;
  final List<AccountItem> accounts;

  AccountGroup({
    required this.id,
    required this.title,
    required this.order,
    required this.accounts,
  });

  factory AccountGroup.fromMap(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>;

    return AccountGroup(
      id: doc.id,
      title: map['title'] ?? '',
      order: map['order'] ?? 0,
      accounts: (map['accounts'] as List<dynamic>? ?? [])
          .map((e) => AccountItem.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'order': order,
      'accounts': accounts.map((e) => e).toList(),
    };
  }
}

class AccountItem {
  final String id;
   String name;
   String number;
  double amount; // 🔥 mutable
  List<AccountTransaction> transactions;

  AccountItem({
    required this.id,
    required this.name,
    required this.number,
    required this.amount,
    required this.transactions,
  });

  factory AccountItem.fromMap(Map<String, dynamic> map) {
    return AccountItem(
      id: map['id'] ?? '',
      name: (map['name'] ?? '').toString(),
      number: (map['number'] ?? '').toString(),
      amount: (map['amount'] as num).toDouble(),
      transactions: (map['transactions'] as List<dynamic>? ?? [])
          .map((e) => AccountTransaction.fromMap(e))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'number': number,
      'amount': amount,
      'transactions': transactions.map((e) => e.toMap()).toList(),
    };
  }
}
