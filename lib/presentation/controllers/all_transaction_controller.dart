import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/models/unified_transaction_model.dart';
import 'homepgeController.dart';

class AllTransactionController extends GetxController {
  final homeController = Get.find<AccountController>();

  RxList<GlobalTransaction> allTransactions = <GlobalTransaction>[].obs;

  @override
  void onInit() {
    super.onInit();
    _buildTransactionList();
  }

  void _buildTransactionList() {
    final List<GlobalTransaction> temp = [];

    for (final group in homeController.accountGroups) {
      for (int i = 0; i < group.accounts.length; i++) {
        final acc = group.accounts[i];

        if (acc.transactions == null) continue;

        for (final tx in acc.transactions!) {
          temp.add(
            GlobalTransaction(
              groupId: group.id,
              groupTitle: group.title,
              accountIndex: i,
              accountName: acc.name,
              accountNumber: acc.number,
              title: tx.title,
              amount: (tx.amount as num).toDouble(),
              date: (tx.date).toDate(),
            ),
          );
        }
      }
    }

    /// 🔥 Date অনুযায়ী sort (latest first)
    temp.sort((a, b) => b.date.compareTo(a.date));

    allTransactions.value = temp;
  }
}

Map<String, List<GlobalTransaction>> groupByDate(
    List<GlobalTransaction> list,
    ) {
  final Map<String, List<GlobalTransaction>> map = {};

  for (final tx in list) {
    final key =
        "${tx.date.day}-${tx.date.month}-${tx.date.year}";

    map.putIfAbsent(key, () => []);
    map[key]!.add(tx);
  }

  return map;
}
