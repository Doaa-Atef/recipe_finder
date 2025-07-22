class Validators {
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter your name";
    }
    return null;
  }
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter email";
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
      return "Please enter a valid email";
    }
    return null;
  }
  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter password";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }
}
