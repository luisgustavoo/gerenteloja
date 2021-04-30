import 'dart:async';

class LoginValidator {
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.contains("@")) {
      sink.add(email);
    } else {
      sink.addError("Informe um email válido!");
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, skin) {
    if (password.length >= 5) {
      skin.add(password);
    } else {
      skin.addError("Informe uma senha maior que 5 digitos!");
    }
  });
}
