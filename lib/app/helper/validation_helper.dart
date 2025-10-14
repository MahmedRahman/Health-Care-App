class ValidationHelper {
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    if (value.trim().length < 2) {
      return 'Name is too short';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Invalid email format';
    }

    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }

    final phoneRegex = RegExp(r'^\+?[0-9]{7,15}$');
    if (!phoneRegex.hasMatch(value.trim())) {
      return 'Invalid phone number';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? validateNameOnlyEnglishAndArabic(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    final nameRegex = RegExp(r'^[a-zA-Z؀-ۿ]+$');
    if (!nameRegex.hasMatch(value.trim())) {
      return 'Name must contain only English or Arabic characters';
    }
    return null;
  }

  // static String? validatePassword(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Confirm password is required';
  //   }
  //   if (value != value) {
  //     return 'Passwords do not match';
  //   }
  //   return null;
  // }

  static String? validateNotEmpty(String? value, [String fieldName = 'Field']) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? validateNumber(String? value, [String fieldName = 'Value']) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    final number = double.tryParse(value);
    if (number == null) {
      return '$fieldName must be a number';
    }

    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    } else if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }
}
