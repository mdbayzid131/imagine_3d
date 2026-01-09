import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import 'add_cancle_buttom.dart';
import 'custom_text_field.dart';

class AddTrensectionPopup {
  static Future<void> showPopup(
    BuildContext context, {
    required Function(String title, double amount, DateTime date) onSubmit,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => DialogBody(onSubmit: onSubmit),
    );
  }
}

class DialogBody extends StatefulWidget {
  final Function(String, double, DateTime) onSubmit;

  const DialogBody({super.key, required this.onSubmit});

  @override
  State<DialogBody> createState() => _DialogBodyState();
}

class _DialogBodyState extends State<DialogBody> {
  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController amountCtrl = TextEditingController();
  final TextEditingController dateCtrl = TextEditingController();

  DateTime selectedDate = DateTime.now();

  final _showTitleError = false.obs;
  final _showAmountError = false.obs;

  @override
  void dispose() {
    titleCtrl.dispose();
    amountCtrl.dispose();
    dateCtrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    dateCtrl.text = _formatDate(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title
            Text(
              "Transaction Add",
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.h),

            /// Title
            Obx(
              () => CustomTextField(
                label: 'Title',
                hintText: "Type...",
                controller: titleCtrl,
                errorText: _showTitleError.value ? 'Title is required' : null,
              ),
            ),
            SizedBox(height: 12.h),

            /// Amount
            Obx(
              () => CustomTextField(
                label: 'Amount',
                hintText: "Type...",
                keyboardType: TextInputType.number,
                controller: amountCtrl,
                errorText: _showAmountError.value ? 'Amount is required' : null,
              ),
            ),
            SizedBox(height: 12.h),

            /// Date picker
            /// Date picker
            GestureDetector(
              onTap: _pickDate,
              child: AbsorbPointer(
                child: CustomTextField(
                  label: 'Date',
                  controller: dateCtrl,
                  hintText: 'Select date',
                  suffixIcon: Icon(Icons.calendar_month_rounded, size: 20.sp),
                ),
              ),
            ),

            SizedBox(height: 20.h),

            /// Buttons
            AddCancelButton(
              cancelText: 'Cancel',
              addText: 'Add Transaction',
              cancelOnTap: () => Navigator.pop(context),
              addOnTap: _submit,
            ),
          ],
        ),
      ),
    );
  }

  void _submit() {
    final title = titleCtrl.text.trim();
    final amountText = amountCtrl.text.trim();
    bool hasError = false;

    if (title.isEmpty) {
      _showTitleError.value = true;
      hasError = true;
    } else {
      _showTitleError.value = false;
    }

    if (amountText.isEmpty) {
      _showAmountError.value = true;
      hasError = true;
    } else {
      _showAmountError.value = false;
    }

    if (hasError) return; // Don't submit if error exists

    widget.onSubmit(title, double.parse(amountText), selectedDate);

    Navigator.pop(context);
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.deepPurple, // header + selected date
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: Colors.deepPurple),
            ),
            dialogTheme: DialogThemeData(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        dateCtrl.text = _formatDate(picked);
      });
    }
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }
}
