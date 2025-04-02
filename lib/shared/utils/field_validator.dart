abstract class FieldValidator {
  static String? validateTextField(String? value, String filedName) {
    if (value != null && value.isEmpty) {
      return 'Please Enter $filedName';
    }
    return null;
  }
}