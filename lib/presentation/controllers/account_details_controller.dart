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
}
