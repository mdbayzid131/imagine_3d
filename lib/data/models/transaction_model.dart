import 'package:cloud_firestore/cloud_firestore.dart';

class AccountTransaction {
  final String title;
  final double amount;
  final Timestamp date;
  final double nowBalance;

  AccountTransaction({
    required this.title,
    required this.amount,
    required this.date,
    required this.nowBalance,
  });

  factory AccountTransaction.fromMap(Map<String, dynamic> map) {
    return AccountTransaction(
      title: (map['title'] ?? '').toString(),

      amount: (map['amount'] is num) ? (map['amount'] as num).toDouble() : 0.0,

      date: map['date'] is Timestamp ? map['date'] : Timestamp.now(),

      nowBalance: (map['nowBalance'] is num)
          ? (map['nowBalance'] as num).toDouble()
          : 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'amount': amount,
      'date': date,
      'nowBalance': nowBalance,
    };
  }
}
