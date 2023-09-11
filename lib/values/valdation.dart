class ValidationUtils {
  static String? validateName(String value) {
    if (value.isEmpty) {
      return 'Name is required';
    }
    if (!isValidName(value)) {
      return 'Invalid name format';
    }
    return null;
  }

  /*--------------------Password validation ----------------------*/
  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  /*--------------------Email validation ----------------------*/
  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (!emailRegex.hasMatch(value)) {
      return 'Invalid email format';
    }
    return null;
  }


  /*--------------------Name validation ----------------------*/
  static bool isValidName(String name) {
    // Use a regular expression to check if the name contains only letters and spaces
    final RegExp nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    return nameRegex.hasMatch(name);
  }
}