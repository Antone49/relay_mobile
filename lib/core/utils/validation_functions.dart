
class Validator {
  static RegExp regexName = RegExp(r"^[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.'-]{0,30}$");
  static RegExp regexEmail = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  static RegExp regexPassword = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$');
  static RegExp regexPhoneNumber = RegExp(r'^[\d+]{0,13}$');
  static RegExp regexPostCode = RegExp(r'^[\d+]{0,5}$');

  static bool isValidName(String inputString) {
    return isValid(inputString, regexName);
  }

  static bool isValidPhone(String inputString) {
    return isValid(inputString, regexPhoneNumber);
  }

  static bool isValidEmail(String inputString) {
    return isValid(inputString, regexEmail);
  }

  // Minimum eight characters, at least one uppercase letter, one lowercase letter and one number
  static bool isValidPassword(String inputString) {
    return isValid(inputString, regexPassword);
  }

  static bool isValid(String inputString, RegExp regex) {
    bool isValid = false;

    if (inputString.isNotEmpty) {
      isValid = regex.hasMatch(inputString);
    }

    return isValid;
  }
}
