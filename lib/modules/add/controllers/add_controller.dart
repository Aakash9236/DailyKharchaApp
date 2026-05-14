import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/models.dart';
import '../../../data/repositories/expense_repositories.dart';

class AddExpenseController extends GetxController {
  final ExpenseRepository _repository =
  ExpenseRepository();

  // Form Key
  final formKey = GlobalKey<FormState>();

  // Controllers
  final titleController =
  TextEditingController();

  final amountController =
  TextEditingController();

  // Selected Category
  RxString selectedCategory = ''.obs;

  // Selected Date
  Rx<DateTime?> selectedDate =
  Rx<DateTime?>(null);

  // Loading State
  RxBool isLoading = false.obs;

  // Edit Expense
  ExpenseModel? expense;

  final List<String> categories = [
    'Food',
    'Travel',
    'Shopping',
    'Bills',
    'Health',
    'Entertainment',
    'Other',
  ];

  @override
  void onInit() {
    super.onInit();

    // Receive Edit Data
    if (Get.arguments != null) {
      expense = Get.arguments;

      loadExpenseData();
    }
  }

  // Load Existing Expense
  void loadExpenseData() {
    titleController.text = expense!.title;

    amountController.text =
        expense!.amount.toString();

    selectedCategory.value =
        expense!.category;

    selectedDate.value =
        DateTime.parse(expense!.date);
  }

  // Pick Date
  Future<void> pickDate(
      BuildContext context,
      ) async {
    final pickedDate =
    await showDatePicker(
      context: context,
      initialDate:
      selectedDate.value ??
          DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      selectedDate.value = pickedDate;
    }
  }

  // Save Expense
  Future<void> saveExpense() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (selectedCategory.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Please select category',
      );

      return;
    }

    if (selectedDate.value == null) {
      Get.snackbar(
        'Error',
        'Please select date',
      );

      return;
    }

    try {
      isLoading.value = true;

      final expenseData = ExpenseModel(
        id: expense?.id,
        title: titleController.text.trim(),
        amount: double.parse(
          amountController.text.trim(),
        ),
        category: selectedCategory.value,
        date:
        selectedDate.value.toString(),
      );

      if (expense == null) {
        // Add Expense
        await _repository.addExpense(
          expenseData,
        );
      } else {
        // Update Expense
        await _repository.updateExpense(
          expenseData,
        );
      }

      Get.back(result: true);

      Get.snackbar(
        'Success',
        expense == null ? 'Expense added successfully' : 'Expense updated successfully',
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong',
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    amountController.dispose();

    super.onClose();
  }
}