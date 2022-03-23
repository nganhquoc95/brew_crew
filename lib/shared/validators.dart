String? emailValidator(value) {
  if (value == null) {
    return null;
  }

  RegExp exp = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$");

  if (value.isEmpty) {
    return "E-Mail can't be blank!";
  } else if (!exp.hasMatch(value.toString())) {
    return "E-Mail is incorrect!";
  }

  return null;
}

String? passwordValidator(value) {
  if (value == null) {
    return null;
  }

  if (value.length < 6) {
    return "Password must be at least 6 characters";
  }

  return null;
}
