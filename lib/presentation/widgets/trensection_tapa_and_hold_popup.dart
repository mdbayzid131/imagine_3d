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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Transaction Options",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12.h),
              ListTile(
                leading: Icon(Icons.edit),
                title: Text("Edit Transaction"),
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
              ListTile(
                leading: Icon(Icons.delete),
                title: Text("Delete Transaction"),
                onTap: () {
                  Navigator.pop(context);
                  controller.deleteTransaction(groupId, index, accountName);
                },
              ),
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
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white, // ✅ white color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r), // ✅ smooth shape
        ),
        title: Text(
          "Edit Transaction",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              controller: titleController,
              hintText: '',
              label: 'Title',
            ),
            SizedBox(height: 12.h),
            CustomTextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              hintText: '',
              label: "Amount",
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Text(
                  "Date: ${_formatDate(selectedDate)}",
                  style: TextStyle(fontSize: 13.sp),
                ),
                Spacer(),
                TextButton(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) selectedDate = picked;
                  },
                  child: Text("Change"),
                ),
              ],
            ),
          ],
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
      ),
    );
  }

  static String _formatDate(DateTime date) {
    return "${date.day}-${date.month}-${date.year}";
  }
}
