class Validators {
  static String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter title';
    }

    return null;
  }

  static String? validateAmount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter amount';
    }

    final amount = double.tryParse(value);

    if (amount == null || amount <= 0) {
      return 'Enter valid amount';
    }

    return null;
  }

  static String? validateCategory(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select category';
    }

    return null;
  }
}