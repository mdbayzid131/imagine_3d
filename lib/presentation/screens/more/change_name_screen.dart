import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/profile_controller.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/emai_update_popup.dart';
import '../../widgets/name_update_popup.dart';

class ChangeNameScreen extends StatelessWidget {
  ChangeNameScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  final AuthController authController = Get.find<AuthController>();
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidgets.customAppBar(title: 'User Information'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// Name Field
                _InfoField(
                  label: 'Name',
                  value: profileController.name.value,
                  validator: authController.validName,
                  onEdit: () {
                    showUpdateNameDialog(context, profileController);
                  },
                ),

                SizedBox(height: 20.h),

                /// Email Field
                _InfoField(
                  label: 'Email',
                  value: profileController.email.value,
                  validator: authController.validEmail,
                  onEdit: () {
                    showUpdateEmailDialog(context, profileController);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// ================= Custom Info Field =================
class _InfoField extends StatelessWidget {
  final String label;
  final String value;
  final String? Function(String?)? validator;
  final VoidCallback onEdit;

  const _InfoField({
    required this.label,
    required this.value,
    required this.onEdit,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: value);

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: CustomTextField(
        controller: controller,
        readOnly: true,
        label: label,
        hintText: '',
        validator: validator,
        suffixIcon: IconButton(
          splashRadius: 20,
          onPressed: onEdit,
          icon: Icon(
            Icons.edit_rounded,
            size: 20.sp,
            color: Colors.blueGrey,
          ),
        ),
      ),
    );
  }
}
