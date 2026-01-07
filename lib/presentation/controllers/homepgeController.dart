import 'package:get/get.dart';
import '../../data/models/account_group_model.dart';
import '../../services/account_service.dart';
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

  void fetchAccountGroups() {
    _service.getAccountGroups().listen((data) {
      accountGroups.value = data;
      isLoading.value = false;
    },onError: (e){
      CustomSnackbar.showError('Error', 'Failed to fetch data');
    });
  }

  void addNewAccount({
    required int groupIndex,
    required String name,
    required String number,
    required double amount,
  }) async {
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
    }
  }

  void toggleExpand(int index) {
    expandedIndex.value = expandedIndex.value == index ? -1 : index;
  }
}
