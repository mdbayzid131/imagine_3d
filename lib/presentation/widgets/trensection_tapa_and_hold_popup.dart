import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:imagine_3d/presentation/widgets/add_cancle_buttom.dart';
import 'package:imagine_3d/presentation/widgets/custom_text_field.dart';

import '../controllers/account_details_controller.dart';

class TrensectionTapaAndHoldPopup {
  static void showPopup({
    required BuildContext context,
    required String title,
    required double balance,
    required String date,
    required String groupId,
    required int index, // transaction index
    required String accountName,
  }) {
    final controller = Get.find<CardDetailsController>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 20.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Drag Handle
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              SizedBox(height: 16.h),

              Text(
                "Transaction Options",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),

              SizedBox(height: 16.h),

              _ActionTile(
                icon: Icons.edit_rounded,
                title: "Edit Transaction",
                color: Colors.blue,
                onTap: () {
                  Navigator.pop(context);
                  _showEditDialog(
                    context,
                    controller,
                    groupId,
                    index,
                    accountName,
                  );
                },
              ),

              _ActionTile(
                icon: Icons.delete_outline_rounded,
                title: "Delete Transaction",
                color: Colors.red,
                onTap: () {
                  Navigator.pop(context);
                  controller.deleteTransaction(groupId, index, accountName);
                },
              ),

              SizedBox(height: 10.h),
            ],
          ),
        );
      },
    );
  }

  static void _showEditDialog(
    BuildContext context,
    CardDetailsController controller,
    String groupId,
    int index,
    String accountName,
  ) {
    final tx = controller.transactions[index];
    final titleController = TextEditingController(text: tx.title);
    final amountController = TextEditingController(text: tx.amount.toString());
    DateTime selectedDate = tx.date.toDate();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: Colors.white, // ✅ white color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r), // ✅ smooth shape
          ),
          title: Text(
            "Edit Transaction",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
          ),
          content: StatefulBuilder(
            builder: (context, setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                controller: titleController,
                label: 'Title',
                hintText: '',
              ),
              SizedBox(height: 12.h),

              CustomTextField(
                controller: amountController,
                label: 'Amount',
                keyboardType: TextInputType.number,
                hintText: '',
              ),

              SizedBox(height: 16.h),

              /// Date Picker Field
              GestureDetector(
                onTap: () => _pickDate(context, selectedDate, (d) {
                  setState(() => selectedDate = d);
                }),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_month_rounded, size: 18.sp),
                      SizedBox(width: 8.w),
                      Text(
                        _formatDate(selectedDate),
                        style: TextStyle(fontSize: 13.sp),
                      ),
                      Spacer(),
                      Text(
                        "Change",
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        ),

        actionsPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          actions: [
            AddCancelButton(
              cancelText: 'Cancel',
              addText: 'Save',
              cancelOnTap: () => Navigator.pop(context),
              addOnTap: () {
                controller.updateTransaction(
                  groupId: groupId,
                  accountName: accountName,
                  index: index,
                  newTitle: titleController.text,
                  newAmount: double.parse(amountController.text),
                  newDate: selectedDate,
                );
              },
            ),
            SizedBox(height: 12.h),
          ],
        );
      },
    );
  }


  static Future<void> _pickDate(
      BuildContext context,
      DateTime currentDate,
      Function(DateTime) onPicked,
      ) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.deepPurple,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.deepPurple,
              ),
            ),
            dialogTheme: DialogThemeData(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
            )
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      onPicked(picked);
    }
  }


  static String _formatDate(DateTime date) {
    return "${date.day}-${date.month}-${date.year}";
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(fontSize: 14.sp)),
      onTap: onTap,
    );
  }
}
