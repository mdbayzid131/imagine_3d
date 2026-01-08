class GlobalTransaction {
  final String groupId;
  final String groupTitle;
  final int accountIndex;
  final String accountName;
  final String accountNumber;
  final String title;
  final double amount;
  final DateTime date;

  GlobalTransaction({
    required this.groupId,
    required this.groupTitle,
    required this.accountIndex,
    required this.accountName,
    required this.accountNumber,
    required this.title,
    required this.amount,
    required this.date,
  });
}
