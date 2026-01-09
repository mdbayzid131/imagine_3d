import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../widgets/custom_snackbar.dart';

class ProfileController extends GetxController {
  final RxString name = ''.obs;
  final RxString email = ''.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUser();
  }

  void loadUser() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      name.value = user.displayName ?? 'No Name';
      email.value = user.email ?? '';
    }
  }

  /// 🔥 UPDATE NAME
  Future<void> updateName(String newName) async {
    try {
      isLoading.value = true;
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      await user.updateDisplayName(newName);
      await user.reload();

      name.value = FirebaseAuth.instance.currentUser!.displayName ?? newName;
      Get.back();
      Get.snackbar('Success', 'Name updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update name');
    } finally {
      isLoading.value = false;
    }
  }

  /// 🔥 UPDATE EMAIL
  Future<void> updateEmail({
    required String newEmail,
    required String password,
  }) async {
    try {
      isLoading.value = true;

      final user = FirebaseAuth.instance.currentUser;
      if (user == null || user.email == null) {
        throw 'User not logged in';
      }

      /// 🔐 Re-authentication
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: password,
      );

      await user.reauthenticateWithCredential(credential);

      /// ✅ Firebase v4+
      await user.verifyBeforeUpdateEmail(newEmail);

      /// ✅ Snackbar first
      CustomSnackbar.showSuccess(
        'Verify Email',
        'Verification email sent to $newEmail',
      );

      /// ✅ Delay then back
      await Future.delayed(const Duration(seconds: 2));
      Get.back();

    } on FirebaseAuthException catch (e) {
      CustomSnackbar.showError('Error', _firebaseError(e.code));
    } catch (e) {
      CustomSnackbar.showError('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }


  String _firebaseError(String code) {
    switch (code) {
      case 'invalid-email':
        return 'Invalid email address';
      case 'email-already-in-use':
        return 'This email is already in use';
      case 'requires-recent-login':
        return 'Please login again and try';
      case 'wrong-password':
        return 'Incorrect password';
      case 'user-mismatch':
        return 'User mismatch';
      case 'user-not-found':
        return 'User not found';
      case 'operation-not-allowed':
        return 'Operation not allowed';
      case 'too-many-requests':
        return 'Too many attempts. Try later';
      default:
        return 'Something went wrong ($code)';
    }
  }
}
