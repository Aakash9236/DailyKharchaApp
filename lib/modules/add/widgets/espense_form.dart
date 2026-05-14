import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/date_formatter.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../controllers/add_controller.dart';

class ExpenseForm extends GetView<AddExpenseController> {
  const ExpenseForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          // Title
          CustomTextField(
            hintText: 'Enter title',
            controller:
            controller.titleController,
            validator:
            Validators.validateTitle,
          ),

          const SizedBox(height: 16),

          // Amount
          CustomTextField(
            hintText: 'Enter amount',
            controller:
            controller.amountController,
            keyboardType:
            TextInputType.number,
            validator:
            Validators.validateAmount,
          ),

          const SizedBox(height: 16),

          Obx(
                () => DropdownButtonFormField(
              value: controller
                  .selectedCategory
                  .value
                  .isEmpty
                  ? null
                  : controller
                  .selectedCategory
                  .value,
              items: controller.categories
                  .map(
                    (category) =>
                    DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    ),
              )
                  .toList(),
              onChanged: (value) {
                controller.selectedCategory
                    .value = value!;
              },
              decoration:
              const InputDecoration(
                hintText:
                'Select category',
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Date Picker
          Obx(
                () => CustomTextField(
              hintText:
              controller.selectedDate
                  .value ==
                  null
                  ? 'Select date'
                  : DateFormatter
                  .formatDate(
                controller
                    .selectedDate
                    .value!,
              ),
              controller:
              TextEditingController(),
              readOnly: true,
              onTap: () {
                controller.pickDate(
                  context,
                );
              },
              suffixIcon: const Icon(
                Icons.calendar_month,
              ),
            ),
          ),

          const SizedBox(height: 30),

          // Save Button
          Obx(
                () => CustomButton(
              text: controller.expense ==
                  null
                  ? 'Save Expense'
                  : 'Update Expense',
              isLoading:
              controller.isLoading.value,
              onPressed: () {
                controller.saveExpense();
              },
            ),
          ),
        ],
      ),
    );
  }
}