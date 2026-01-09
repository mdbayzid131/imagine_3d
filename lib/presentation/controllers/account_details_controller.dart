import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/models/account_group_model.dart';
import '../../data/models/transaction_model.dart';
import 'homepgeController.dart';

class CardDetailsController extends GetxController {
  final homeController = Get.find<AccountController>();

  late String groupId;
  late int accountIndex;

  late Rx<AccountItem> account;
  RxList<AccountTransaction> transactions = <AccountTransaction>[].obs;

  @override
  void onInit() {
    final args = Get.arguments;
    groupId = args['groupId'];
    accountIndex = args['accountIndex'];

    final group = homeController.accountGroups.firstWhere(
      (g) => g.id == groupId,
    );

    account = group.accounts[accountIndex].obs;

    /// 🔥 already AccountTransaction list
    transactions.assignAll(account.value.transactions);

    super.onInit();
  }

  Future<void> addTransaction({
    required String title,
    required double amount,
    required DateTime date,
  }) async {
    final tx = AccountTransaction(
      title: title,
      amount: amount,
      date: Timestamp.fromDate(date),
      nowBalance: account.value.amount + amount,
    );

    /// 1️⃣ account model update
    account.update((acc) {
      acc!.transactions.insert(0, tx);
      acc.amount += amount;
    });

    /// 2️⃣ UI list update
    transactions.insert(0, tx);

    /// 3️⃣ Firestore sync
    await _syncFirestore();
  }

  Future<void> _syncFirestore() async {
    final group = homeController.accountGroups.firstWhere(
      (g) => g.id == groupId,
    );

    group.accounts[accountIndex] = account.value;
    homeController.accountGroups.refresh();

    await FirebaseFirestore.instance
        .collection('account_groups')
        .doc(groupId)
        .update({'accounts': group.accounts.map((e) => e.toMap()).toList()});
  }



  void deleteTransaction(String groupId, int index, String accountName) async {
    try {
      final tx = transactions[index];

      final docRef = FirebaseFirestore.instance.collection('account_groups').doc(groupId);
      final docSnapshot = await docRef.get();

      if (!docSnapshot.exists) return;

      // 1️⃣ Read accounts
      List accounts = List.from(docSnapshot.get('accounts'));

      // 2️⃣ Find the account
      for (var account in accounts) {
        if (account['name'] == accountName) {
          List transactionsList = List.from(account['transactions']);

          // Remove the transaction by matching title, date, amount
          transactionsList.removeWhere((t) =>
          t['title'] == tx.title &&
              t['amount'] == tx.amount &&
              t['date'] == tx.date &&
              t['nowBalance'] == tx.nowBalance);

          account['transactions'] = transactionsList;
        }
      }

      // 3️⃣ Update Firestore
      await docRef.update({'accounts': accounts});

      // 4️⃣ Local remove
      transactions.removeAt(index); // RxList → UI auto refresh
    } catch (e) {
      print("Delete failed: $e");
      Get.snackbar("Error", "Failed to delete transaction");
    }
  }



  void updateTransaction({
    required String groupId,
    required String accountName,
    required int index, // local transactions index
    required String newTitle,
    required double newAmount,
    required DateTime newDate,
  }) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('account_groups').doc(groupId);
      final doc = await docRef.get();
      if (!doc.exists) return;

      // 1️⃣ Read accounts safely
      List<Map<String, dynamic>> accounts = List<Map<String, dynamic>>.from(
          (doc.get('accounts') as List).map((e) => Map<String, dynamic>.from(e))
      );

      // 2️⃣ Find account
      for (int i = 0; i < accounts.length; i++) {
        var account = accounts[i];
        if (account['name'] == accountName) {

          // 3️⃣ Transactions list safely
          List<Map<String, dynamic>> txList = List<Map<String, dynamic>>.from(
              (account['transactions'] as List).map((e) => Map<String, dynamic>.from(e))
          );

          // 4️⃣ Old transaction amount
          double oldAmount = (txList[index]['amount'] ?? 0).toDouble();

          // 5️⃣ Update transaction
          txList[index] = {
            ...txList[index],
            'title': newTitle,
            'amount': newAmount,
            'date': newDate,
          };

          account['transactions'] = txList;

          // 6️⃣ Adjust main balance
          account['amount'] = (account['amount'] ?? 0) - oldAmount + newAmount;

          accounts[i] = account;
          break;
        }
      }

      // 7️⃣ Firestore update
      await docRef.update({'accounts': accounts});

      // 8️⃣ Local RxList update
      transactions[index] = transactions[index].copyWith(
        title: newTitle,
        amount: newAmount,
        date: Timestamp.fromDate(newDate),
      );

      // 9️⃣ Update local account
      account.update((acc) {
        acc!.transactions[index] = transactions[index];
        acc.amount = accounts.firstWhere((a) => a['name'] == accountName)['amount'];
      });

      Get.back();
      Get.snackbar("Success", "Transaction and account balance updated");
    } catch (e) {
      print("Update failed: $e");
      Get.snackbar("Error", "Failed to update transaction");
    }
  }







}
