// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter_password_generate_app/model/function_build.dart';
import 'package:flutter_password_generate_app/provider/model_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/colors_app.dart';


class ButtonGenerator extends ConsumerWidget {
  const ButtonGenerator({super.key});

  static var failureSnackBar = SnackBar(
    duration: const Duration(seconds: 3),
    elevation: 0,
    // behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: 'Warning',
      message: 'Select at least one option and retry again !',
      contentType: ContentType.warning,
    ),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: MaterialButton(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        height: 60,
        color: ColorsApp.secondaryColor,
        onPressed: () {
          if (ref.watch(passwordProvider).optionsList.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(failureSnackBar);
          } else {
            ref.read(passwordProvider).generatePassword();
          }
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'GENERATE',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(width: 4),
            Icon(Icons.arrow_forward_rounded)
          ],
        ),
      ),
    );
  }
}

class PasswordStrength extends ConsumerWidget {
  const PasswordStrength({
    super.key,
  });

  Widget getNotation(double indice) {
    if (indice <= 25 && indice > 0) {
      return const Text('WEAK',
          style:
              TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w700));
    } else if (indice > 25 && indice <= 50) {
      return const Text('MEDIUM',
          style: TextStyle(
              color: Colors.orangeAccent, fontWeight: FontWeight.w700));
    }
    if (indice > 50 && indice <= 75) {
      return const Text('STRONG',
          style: TextStyle(
              color: Color.fromARGB(255, 210, 255, 64),
              fontWeight: FontWeight.w700));
    } else if (indice > 75) {
      return const Text('VERY STRONG',
          style: TextStyle(
              color: Colors.greenAccent, fontWeight: FontWeight.w700));
    } else {
      return const Text('');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double indice = ref.watch(passwordProvider).indice;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        width: double.infinity,
        height: 60,
        color: const Color.fromRGBO(19, 18, 25, 1),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'STRENGTH',
                style: TextStyle(color: Color.fromRGBO(139, 136, 155, 1)),
              ),
              Row(
                children: [
                  getNotation(indice),
                  const SizedBox(width: 16),
                  // buildWidgetBasedOnValue(strength)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CheckBoxSelect extends ConsumerWidget {
  const CheckBoxSelect(
      {super.key, required this.checkOptionButton, required this.index});
  final CheckOptionButton checkOptionButton;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Checkbox(
          value: checkOptionButton.isChecked,
          onChanged: (bool? value) {
            ref.read(passwordProvider).setCheckedState(value!, index);
          },
          fillColor: MaterialStateProperty.all<Color>(ColorsApp.secondaryColor),
          checkColor: const Color.fromRGBO(19, 18, 25, 1),
          activeColor: ColorsApp.secondaryColor,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Text(checkOptionButton.text,
                style: const TextStyle(color: Colors.white, fontSize: 17)),
          ),
        )
      ],
    );
  }
}

class SliderLength extends ConsumerWidget {
  const SliderLength({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double passwordlength = ref.watch(passwordProvider).passwordlength;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Character Length',
                  style: TextStyle(color: Colors.white, fontSize: 17)),
              Text(passwordlength.toInt().toString(),
                  style: const TextStyle(
                      color: ColorsApp.secondaryColor, fontSize: 20))
            ],
          ),
        ),
        Slider(
          value: passwordlength,
          min: 5,
          max: 20,
          activeColor: ColorsApp.secondaryColor,
          inactiveColor: const Color.fromRGBO(19, 18, 25, 1),
          onChanged: (double value) {
            ref.read(passwordProvider).setPasswordLength(value);
          },
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}

class PasswordContainer extends ConsumerWidget {
  PasswordContainer({super.key});

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    passwordController.text = ref.watch(passwordProvider).text;
    return Container(
        decoration: const BoxDecoration(
            color: ColorsApp.primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        width: double.infinity,
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  enabled: false,
                  controller: passwordController,
                  cursorColor: ColorsApp.secondaryColor,
                  style: const TextStyle(fontSize: 19, color: Colors.white),
                  decoration: const InputDecoration(
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      hintText: 'PASSWORD',
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 145, 145, 145)),
                      border: InputBorder.none),
                ),
              ),
              IconButton(
                  splashRadius: 2,
                  onPressed: () {
                    FlutterClipboard.copy(
                        passwordController.value.text.toString());

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                        animation: AlwaysStoppedAnimation(
                            BorderSide.strokeAlignInside),
                        content: Text('Copied'),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.copy,
                    color: ColorsApp.secondaryColor,
                  ))
            ],
          ),
        ));
  }
}
