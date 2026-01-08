import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../controllers/profile_controller.dart';

void showUpdateEmailDialog(BuildContext context, ProfileController controller) {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Change Email'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: emailCtrl,
            decoration: const InputDecoration(hintText: 'New email'),
          ),
          TextField(
            controller: passCtrl,
            decoration: const InputDecoration(hintText: 'Password'),
            obscureText: true,
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
        Obx(
          () => TextButton(
            onPressed: controller.isLoading.value
                ? null
                : () => controller.updateEmail(
                    newEmail: emailCtrl.text.trim(),
                    password: passCtrl.text.trim(),
                  ),
            child: controller.isLoading.value
                ? const CircularProgressIndicator()
                : const Text('Update'),
          ),
        ),
      ],
    ),
  );
}
