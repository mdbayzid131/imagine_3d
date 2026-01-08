import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../data/models/account_group_model.dart';
import '../../services/account_service.dart';
import '../screens/buttomNabBar_screen/bottom_nab_bar_screen.dart';
import '../widgets/custom_snackbar.dart';

class AccountController extends GetxController {
  final AccountService _service = AccountService();

  RxInt expandedIndex = (-1).obs;
  RxList<AccountGroup> accountGroups = <AccountGroup>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAccountGroups();
  }


  /// 🔥 TOTAL AMOUNT (ALL GROUPS)
  double get totalBalance {
    return accountGroups.fold(
      0.0,
          (groupSum, group) =>
      groupSum +
          group.accounts.fold(0.0, (accSum, acc) => accSum + acc.amount),
    );
  }

  /// 🔥 TOTAL ACCOUNTS COUNT
  int get totalAccounts {
    return accountGroups.fold(0, (sum, group) => sum + group.accounts.length);
  }

  List<Map<String, dynamic>> get allAccountsWithGroup {
    return accountGroups.expand((group) {
      return group.accounts.map(
            (acc) => {'group': group.title, 'account': acc},
      );
    }).toList();
  }


  // =============================
  /// 🔥 FETCH GROUPS
  // =============================
  void fetchAccountGroups() {
    isLoading.value = true;
    try {
      _service.getAccountGroups().listen(
            (data) {
          accountGroups.value = data;
          isLoading.value = false;
        },
        onError: (e) {
          isLoading.value = false;
          CustomSnackbar.showError('Error', 'Failed to fetch data');
        },
      );
    } catch (e) {
      isLoading.value = false;
      CustomSnackbar.showError('Error', 'Something went wrong');
    }
  }

  // =============================
  /// ➕ ADD ACCOUNT
  // =============================
  void addNewAccount({
    required int groupIndex,
    required String name,
    required String number,
    required double amount,
  }) async {
    isLoading.value = true;
    final group = accountGroups[groupIndex];

    try {
      await _service.addAccount(
        groupId: group.id,
        name: name,
        number: number,
        amount: amount,
      );

      Get.back();
      CustomSnackbar.showSuccess('Success', 'Account added successfully');
    } catch (e) {
      CustomSnackbar.showError('Error', 'Failed to add account');
    } finally {
      isLoading.value = false;
    }
  }

  void toggleExpand(int index) {
    expandedIndex.value = expandedIndex.value == index ? -1 : index;
  }

  // =============================
  /// ❌ DELETE ACCOUNT
  // =============================
  Future<void> deleteAccount({
    required String groupId,
    required int accountIndex,
  }) async {
    isLoading.value = true;

    try {
      final groupIndex =
      accountGroups.indexWhere((g) => g.id == groupId);

      if (groupIndex == -1) return;

      accountGroups[groupIndex].accounts.removeAt(accountIndex);
      accountGroups.refresh();

      await _updateGroupAccounts(
        groupId,
        accountGroups[groupIndex].accounts,
      );

      CustomSnackbar.showSuccess(
        'Success',
        'Account deleted successfully',
      );

      Get.to(BottomNavView());
    } catch (e) {
      CustomSnackbar.showError(
        'Error',
        'Failed to delete account',
      );
    } finally {
      isLoading.value = false;
    }
  }

  // =============================
  /// ✏️ UPDATE ACCOUNT NAME
  // =============================
  Future<void> updateAccountName({
    required String groupId,
    required int accountIndex,
    required String name,
  }) async {
    isLoading.value = true;

    try {
      final groupIndex =
      accountGroups.indexWhere((g) => g.id == groupId);

      if (groupIndex == -1) return;

      final account =
      accountGroups[groupIndex].accounts[accountIndex];

      account.name = name;
      accountGroups.refresh();

      await _updateGroupAccounts(
        groupId,
        accountGroups[groupIndex].accounts,
      );

      CustomSnackbar.showSuccess(
        'Success',
        'Account name updated',
      );
    } catch (e) {
      CustomSnackbar.showError(
        'Error',
        'Failed to update account name',
      );
    } finally {
      isLoading.value = false;
    }
  }

  // =============================
  /// ✏️ UPDATE BALANCE & NUMBER
  // =============================
  Future<void> updateAccountInfo({
    required String groupId,
    required int accountIndex,
    required double balance,
    required String number,
  }) async {
    isLoading.value = true;

    try {
      final groupIndex =
      accountGroups.indexWhere((g) => g.id == groupId);

      if (groupIndex == -1) return;

      final account =
      accountGroups[groupIndex].accounts[accountIndex];

      account.amount = balance;
      account.number = number;

      accountGroups.refresh();

      await _updateGroupAccounts(
        groupId,
        accountGroups[groupIndex].accounts,
      );

      CustomSnackbar.showSuccess(
        'Success',
        'Account updated successfully',
      );
    } catch (e) {
      CustomSnackbar.showError(
        'Error',
        'Failed to update account',
      );
    } finally {
      isLoading.value = false;
    }
  }

  // =============================
  /// 🔥 FIRESTORE UPDATE HELPER
  // =============================
  Future<void> _updateGroupAccounts(
      String groupId,
      List<AccountItem> accounts,
      ) {
    return FirebaseFirestore.instance
        .collection('account_groups')
        .doc(groupId)
        .update({
      'accounts': accounts.map((e) => e.toMap()).toList(),
    });
  }
}
