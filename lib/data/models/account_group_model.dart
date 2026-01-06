class AccountGroup {
  final String title;

  final List<AccountItem> accounts;

  AccountGroup({required this.title, required this.accounts});

  factory AccountGroup.fromMap(Map<String, dynamic> map) {
    return AccountGroup(
      title: map['title'] ?? '',

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
      amount: (map['amount'] ?? 0).toDouble(),
    );
  }
}
