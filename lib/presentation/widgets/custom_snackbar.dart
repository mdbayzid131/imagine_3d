import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static void showError(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.pink.shade100,
      colorText: Colors.black,
      borderRadius: 12,
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(16),
      icon: const Icon(Icons.error, color: Colors.redAccent),
      duration: const Duration(seconds: 3),
    );
  }

  static void showSuccess(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade100,
      colorText: Colors.black,
      borderRadius: 12,
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(16),
      icon: const Icon(Icons.check_circle, color: Colors.green),
      duration: const Duration(seconds: 3),
    );
  }
}
