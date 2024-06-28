// ignore_for_file: public_member_api_docs, sort_constructors_first

class FunctionBuild {
  FunctionBuild({required this.execute, required this.option});
  // int id;
  Function execute;
  options option;
}

enum options {
  includeLowercase,
  includeUppercase,
  includeSpace,
  includeSpecialCharacter,
  includeNumericValue,
}

class CheckOptionButton {
  String text;
  options option;
  bool isChecked = false ;
  CheckOptionButton({
    required this.option,
    required this.text,
  });
}
