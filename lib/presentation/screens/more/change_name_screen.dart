import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:imagine_3d/presentation/widgets/custom_elevated_button.dart';
import 'package:imagine_3d/presentation/widgets/custom_text_field.dart';

import '../../controllers/auth_controller.dart';
import '../../widgets/custom_appbar.dart';

class ChangeNameScreen extends StatelessWidget {
   ChangeNameScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidgets.customAppBar(title: 'User Information',),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20.h),
              CustomTextField(hintText: 'Enter your name', label: 'Name',controller: _nameController,validator: authController.validName),
              SizedBox(height: 20.h),
              CustomTextField(hintText: 'Enter your email', label: 'Email',controller: _emailController,validator: authController.validEmail),
              SizedBox(height: 20.h),
              CustomElevatedButton(label: 'Save Changes', onPressed: (){
                if (_formKey.currentState!.validate()) {
                  Navigator.pop(context);
                }
              })


            ],
          ),
        ),
      ),
    );
  }
}
