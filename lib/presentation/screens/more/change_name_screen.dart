import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:imagine_3d/presentation/widgets/custom_elevated_button.dart';
import 'package:imagine_3d/presentation/widgets/custom_text_field.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/profile_controller.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/emai_update_popup.dart';
import '../../widgets/name_update_popup.dart';

class ChangeNameScreen extends StatelessWidget {
  ChangeNameScreen({super.key});
  final _formKey = GlobalKey<FormState>();

  final AuthController authController = Get.find<AuthController>();
  final ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController(text: profileController.name.value);
    final TextEditingController emailController = TextEditingController(text: profileController.email.value);
    return Scaffold(
      appBar: CustomWidgets.customAppBar(title: 'User Information'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 40.h),
              CustomTextField(
                suffixIcon: IconButton(onPressed: (){
                  showUpdateNameDialog(context, profileController);
                }, icon: Icon(Icons.edit,size: 20.sp,)),
                readOnly: true,
                hintText: '',
                label: 'Name',
                controller: nameController,
                validator: authController.validName,
              ),
              SizedBox(height: 20.h),
              CustomTextField(
                suffixIcon: IconButton(onPressed: (){
                  showUpdateEmailDialog(context, profileController);
                }, icon: Icon(Icons.edit,size: 20.sp,)),
                readOnly: true,
                hintText: '',

                label: 'Email',
                controller: emailController,
                validator: authController.validEmail,
              ),
              SizedBox(height: 20.h),
              // CustomElevatedButton(
              //   label: 'Save Changes',
              //   onPressed: () {
              //     if (_formKey.currentState!.validate()) {
              //       Navigator.pop(context);
              //     }
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
