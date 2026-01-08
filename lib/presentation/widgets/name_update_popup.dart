import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../controllers/profile_controller.dart';

void showUpdateNameDialog(BuildContext context, ProfileController controller) {
  final nameCtrl = TextEditingController(text: controller.name.value);

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Update Name'),
      content: TextField(
        controller: nameCtrl,
        decoration: const InputDecoration(hintText: 'Enter name'),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('Cancel'),
        ),
        Obx(
              () => TextButton(
            onPressed: controller.isLoading.value
                ? null
                : () => controller.updateName(nameCtrl.text.trim()),
            child: controller.isLoading.value
                ? const CircularProgressIndicator()
                : const Text('Save'),
          ),
        ),
      ],
    ),
  );
}
