class AllTransactionModel {
  final String title;
  final double amount;
  final DateTime date;
  final double nowBalance;
  final String accountName;
  final String groupTitle;

  AllTransactionModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.nowBalance,
    required this.accountName,
    required this.groupTitle,
  });
}
