import '../model/function_build.dart';
import 'dart:math';

// CONSTANTS
final lowerCaseAlphabetList =
    List.generate(26, (index) => String.fromCharCode(index + 65));

final specialCharacterList = [
  '!',
  '@',
  '#',
  '\$',
  '%',
  '^',
  '&',
  '*',
  '(',
  ')',
  '-',
  '_',
  '+',
  '=',
  '[',
  ']',
  '{',
  '}',
  ';',
  ':',
  ',',
  '.',
  '<',
  '>',
  '/',
  '?',
  '|'
];


// FUNCTIONS
int generateRandomValue(int limit) {
  return Random().nextInt(limit);
}


String generateRandomLowerCaseCharacter() {
  final limit = lowerCaseAlphabetList.length;
  return lowerCaseAlphabetList[generateRandomValue(limit)].toLowerCase();
}


String generateRandomUpperCaseCharacter() {
  return generateRandomLowerCaseCharacter().toUpperCase();
}


String generateRandomSpecialCharacter() {
  final limit = specialCharacterList.length;
  return specialCharacterList[generateRandomValue(limit)];
}


String generateRandomNumericValue() {
  const int limit = 10;
  return generateRandomValue(limit).toString();
}


String generateSpace() {
  return ' ';
}


bool isSelectedOption(List<options> options, options op) {
  return options.contains(op);
}


double getPasswordIndice(List<options> optionsList, passwordlength) {
  double indice = (passwordlength * 20) / 20;
  for (var i = 0; i < optionsList.length; i++) {
    options op = optionsList[i];
    indice += op == options.includeLowercase ? 5 : 0;
    indice += op == options.includeUppercase ? 10 : 0;
    indice += op == options.includeNumericValue ? 25 : 0;
    indice += op == options.includeSpecialCharacter ? 35 : 0;
    indice += op == options.includeSpace ? 5 : 0;
  }
  return indice;
}


List<FunctionBuild> functionList = [
  FunctionBuild(
      execute: generateRandomLowerCaseCharacter,
      option: options.includeLowercase),
  FunctionBuild(
      execute: generateRandomUpperCaseCharacter,
      option: options.includeUppercase),
  FunctionBuild(
      execute: generateRandomSpecialCharacter,
      option: options.includeSpecialCharacter),
  FunctionBuild(
      execute: generateRandomNumericValue, option: options.includeNumericValue),
  FunctionBuild(execute: generateSpace, option: options.includeSpace),
];


String generateRandomPassword(List<options> options, int passwordlength) {
  String password = '';

  final List<FunctionBuild> functionsBuilder = functionList.where((function) {
    return isSelectedOption(options, function.option);
  }).toList();

  for (var i = 0; i < passwordlength; i++) {
    // int randomIndex = generateRandomValue(functionsBuilder.length);
    int index = i % (functionsBuilder.length);
    password += functionsBuilder[index].execute();
  }

  return password;
}
