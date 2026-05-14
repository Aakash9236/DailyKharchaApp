import '../database/db_helper.dart';
import '../models/models.dart';

class ExpenseRepository {
  final DBHelper _dbHelper = DBHelper.instance;
  Future<int> addExpense(
      ExpenseModel expense,
      ) async {
    return await _dbHelper.insertExpense(expense);
  }

  Future<List<ExpenseModel>> getExpenses() async {
    return await _dbHelper.getExpenses();
  }

  // Update Expense
  Future<int> updateExpense(
      ExpenseModel expense,
      ) async {
    return await _dbHelper.updateExpense(expense);
  }

  // Delete Expense
  Future<int> deleteExpense(
      int id,
      ) async {
    return await _dbHelper.deleteExpense(id);
  }
}