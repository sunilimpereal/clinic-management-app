class Validators {
  static String? emailValidator(String? email) {
    if (email == '') {
      return "email is required";
    }
    if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(email ?? '')) {
      return "Enter valid Email";
    }
    return null;
  }

  static String? forgotPasswordEmailValidator(String? email, String? phoneNumber) {
    if (email == "" && phoneNumber == "") {
      return "Please enter any one field";
    }
    if (email == '' && phoneNumber!.isNotEmpty) {
      return null;
    }
    if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(email ?? '')) {
      return "Enter valid Email";
    }
    return null;
  }

  static String? forgotPasswordPhoneValidator(String? phoneNumber, String? email) {
    if (email == "" && phoneNumber == "") {
      // return "Please enter any one field";
      return null;
    }
    if (email!.isNotEmpty && phoneNumber == "") {
      return null;
    }
    if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(phoneNumber ?? '')) {
      return "Enter valid phone number";
    }
    return null;
  }

  static String? phoneValidator(String? number) {
    if (number == '') {
      return "Phone number is required";
    }
    if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(number ?? '')) {
      return "Enter valid phone number";
    }
    return null;
  }

  static String? passwordValidator(String? password) {
    if (password == '') {
      return "password is required";
    }
    if (password!.length < 8) {
      return "Password should be atleast 8 characters";
    }
    if (password.length > 16) {
      return "Password should be atmost 16 characters";
    }
    if (!password.contains(RegExp(r'\d')) || !password.contains(RegExp(r'[!@#$%^&*]'))) {
      return "Password must contain numbers and special characters";
    }
    return null;
  }

  static String? nameValidator(String? name) {
    if (name == '') {
      return "name is required";
    }

    return null;
  }

  static String? faqValidator(String? question) {
    question = question ?? '';
    return question.isEmpty ? "Please enter the question" : null;
  }

  static String? weightValidator(String? weight) {
    // if (weight == '') {
    //   return "weight is required";
    // }
    if (int.parse(weight == '' ? "0" : weight ?? "0") > 200) {
      return "Invalid weight value";
    }

    return null;
  }

  static String? heightValidator(String? height) {
    // if (height == '') {
    //   return "height is required";
    // }
    if (int.parse(height == '' ? "0" : height ?? "0") > 250) {
      return "Invalid height value";
    }

    return null;
  }
}
