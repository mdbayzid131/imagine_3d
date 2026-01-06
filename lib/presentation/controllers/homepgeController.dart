import 'package:get/get.dart';
import '../../data/models/account_group_model.dart';
import '../../services/account_service.dart';

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
    });
  }

  void toggleExpand(int index) {
    expandedIndex.value = expandedIndex.value == index ? -1 : index;
  }
}
