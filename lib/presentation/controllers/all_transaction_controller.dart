import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/models/account_group_model.dart';
import '../../data/models/unified_transaction_model.dart';



class TransactionController extends GetxController {
  final RxList<AllTransactionModel> transactions =
      <AllTransactionModel>[].obs;

  void loadTransactions(List<AccountGroup> groups) {

    print("Groups: ${groups.length}");

    final data = getAllTransactions(groups);
    print("Transactions: ${data.length}");
    transactions.assignAll(getAllTransactions(groups));
  }


  List<AllTransactionModel> getAllTransactions(List<AccountGroup> groups) {
    final List<AllTransactionModel> allTransactions = [];

    for (final group in groups) {
      for (final account in group.accounts) {
        for (final tx in account.transactions) {
          allTransactions.add(
            AllTransactionModel(
              title: tx.title,
              amount: tx.amount,
              date: tx.date.toDate(),
              nowBalance: tx.nowBalance,
              accountName: account.name,
              groupTitle: group.title,
            ),
          );
        }
      }
    }

    /// 🔥 Date অনুযায়ী sort (Latest first)
    allTransactions.sort((a, b) => b.date.compareTo(a.date));

    return allTransactions;
  }
}