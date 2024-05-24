class PhoneNumberFormatter {
  static String format(String phoneNumber) {
    return phoneNumber.replaceAll('-', '');
  }
}
