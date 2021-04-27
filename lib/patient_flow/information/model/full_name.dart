import 'package:formz/formz.dart';

enum FullNameValidationError { empty }

class FullName extends FormzInput<String, FullNameValidationError> {
  const FullName.pure() : super.pure('');

  const FullName.dirty([String value = '']) : super.dirty(value);

  @override
  FullNameValidationError? validator(String value) {
    return value.length > 5 ? null : FullNameValidationError.empty;
  }
}
