import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_sizes.dart';
import '../controllers/add_controller.dart';
import '../widgets/espense_form.dart';

class AddExpenseView
    extends GetView<AddExpenseController> {
  const AddExpenseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.expense == null
              ? 'Add Expense'
              : 'Edit Expense',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(
          AppSizes.paddingMD,
        ),
        child: const ExpenseForm(),
      ),
    );
  }
}