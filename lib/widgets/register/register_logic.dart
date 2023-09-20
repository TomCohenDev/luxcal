Future<void> signUp() async {}

bool isFormValidated(formKey) {
  final isValid = formKey.currentState!.validate();
  if (!isValid) return false;
  return true;
}
