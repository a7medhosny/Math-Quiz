import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FillAnswerField extends StatelessWidget {
  final TextEditingController controller;

  const FillAnswerField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 16.sp),
      decoration: InputDecoration(
        hintText: 'Enter your answer',
        hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
        contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.deepPurple, width: 2.w),
        ),
      ),
    );
  }
}
