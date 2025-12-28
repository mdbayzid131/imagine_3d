

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import '../presentation/controllers/auth_controller.dart';


class HomeBinding extends Bindings {
  @override
  void dependencies() {

     // Get.lazyPut<AuthController>(() => AuthController());
    // Get.put(ApiClient());
    // Get.put(UserProfileManageRepo(apiClient: Get.find<ApiClient>()));
    // Get.put(AuthRepo(apiClient: Get.find<ApiClient>()));
    //
    // Get.put(AuthController(Get.find<AuthRepo>()));
    //
    //  Get.put(HomePageController(Get.find<UserProfileManageRepo>()), permanent: true);
    //
    // Get.put(NetworkController(), permanent: true);
     Get.put(AuthController() );

  }
}
