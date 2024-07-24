class AppRegex {
  AppRegex._();

  static RegExp phoneNumber = RegExp(r'^(?:[+0][1-9])?[0-9]{10,12}$');
  static RegExp emailRegex = RegExp(
      r"^[\w!#$%&'*+/=?`{|}~^-]+(?:\.[\w!#$%&'*+/=?`{|}~^-]+)*@(?:[a-zA-Z0-9-]+\.)+[a-zA-Z]{2,6}$");
  static RegExp password = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[~!@#$%^&*()_+\[\],./:;<>?{}\\|^`"\s])[a-zA-Z\d~!@#$%^&*()_+\[\],./:;<>?{}\\|^`"\s]{8,24}$');
}
