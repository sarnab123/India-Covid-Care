import 'package:formz/formz.dart';

enum NameLanguageLocationValidationError { empty }

class NameLanguageLocation
    extends FormzInput<String, NameLanguageLocationValidationError> {
  const NameLanguageLocation.pure() : super.pure('');

  const NameLanguageLocation.dirty([String value = '']) : super.dirty(value);

  @override
  NameLanguageLocationValidationError? validator(String value) {
    return value.length >= 3 ? null : NameLanguageLocationValidationError.empty;
  }
}
