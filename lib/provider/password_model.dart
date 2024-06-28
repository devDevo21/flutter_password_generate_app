import 'package:flutter/material.dart';
import 'package:flutter_password_generate_app/model/function_build.dart';
import 'package:flutter_password_generate_app/utils/generate_options.dart';

class PasswordModel extends ChangeNotifier {
  double indice = 0;
  String text = '';
  double passwordlength = 10;
  List<options> optionsList = [];

  List<CheckOptionButton> checkOptionButton = [
    CheckOptionButton(
      text: 'Include Uppercase Letters',
      option: options.includeUppercase,
    ),
    CheckOptionButton(
      text: 'Include Lowercase Letters',
      option: options.includeLowercase,
    ),
    CheckOptionButton(
      text: 'Include Numbers',
      option: options.includeNumericValue,
    ),
    CheckOptionButton(
      text: 'Include Symbols',
      option: options.includeSpecialCharacter,
    ),
    CheckOptionButton(
      text: 'Include Space',
      option: options.includeSpace,
    )
  ];

  setPasswordLength(double value) {
    passwordlength = value;
    notifyListeners();
  }

  setCheckedState(bool val, int index) {
    checkOptionButton[index].isChecked = val;
    resetAndAddOptions();
    notifyListeners();
  }

  void resetAndAddOptions() {
    optionsList.clear();
    for (var i = 0; i < checkOptionButton.length; i++) {
      if (checkOptionButton[i].isChecked) {
        optionsList.add(checkOptionButton[i].option);
      }
    }
  }

  generatePassword() {
    // resetAndAddOptions();
    indice = getPasswordIndice(optionsList, passwordlength);
    text = generateRandomPassword(optionsList, passwordlength.toInt());
    notifyListeners();
  }
}
