import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/models.dart';
import '../../../data/repositories/expense_repositories.dart';

class HomeController extends GetxController {
  final ExpenseRepository _repository =
  ExpenseRepository();

  RxBool isLoading = false.obs;

  RxList<ExpenseModel> expenses = <ExpenseModel>[].obs;
  RxList<ExpenseModel> filteredExpenses = <ExpenseModel>[].obs;

  TextEditingController searchController =
  TextEditingController();

  RxString selectedCategory = 'All'.obs;

  double get totalExpense {
    return filteredExpenses.fold(
      0.0,
          (sum, item) => sum + item.amount,
    );
  }

  @override
  void onInit() {
    super.onInit();
    fetchExpenses();
  }

  // Future<void> fetchExpenses() async {
  //   try {
  //     isLoading.value = true;
  //
  //     final data =
  //     await _repository.getExpenses();
  //
  //     expenses.assignAll(data);
  //
  //     applyFilters();
  //   } catch (e) {
  //     Get.snackbar(
  //       'Error',
  //       'Failed to fetch expenses',
  //     );
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
  Future<void> fetchExpenses() async {
    try {
      isLoading.value = true;

      final data =
      await _repository.getExpenses();

      expenses.assignAll(data);

      applyFilters();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch expenses',
      );
    } finally {
      isLoading.value = false;
    }
  }
  
  Future<void> deleteExpense(int id) async {
    await _repository.deleteExpense(id);
    fetchExpenses();
    Get.snackbar(
      'Deleted',
      'Expense deleted successfully',
    );
  }

  void applyFilters() {
    List<ExpenseModel> temp =
    expenses.toList();

    if (selectedCategory.value != 'All') {
      temp = temp.where((expense) {
        return expense.category ==
            selectedCategory.value;
      }).toList();
    }

    if (searchController.text.isNotEmpty) {
      temp = temp.where((expense) {
        return expense.title
            .toLowerCase()
            .contains(
          searchController.text
              .toLowerCase(),
        );
      }).toList();
    }

    filteredExpenses.assignAll(temp);
  }

  void changeCategory(String category) {
    selectedCategory.value = category;

    applyFilters();
  }
}