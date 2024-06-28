import 'package:flutter/material.dart';
import 'package:flutter_password_generate_app/model/function_build.dart';
import 'package:flutter_password_generate_app/provider/model_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '.././widgets/password_widget.dart';
import '../theme/colors_app.dart';


class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<CheckOptionButton> checkOptionButton =
        ref.watch(passwordProvider).checkOptionButton;
    double displayHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(19, 18, 25, 1),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(left: 20.0, right: 20, top: displayHeight * 0.06),
          child: Column(
            children: [
              const Text('Password Generator',
                  style: TextStyle(
                      color: Color.fromRGBO(134, 131, 150, 1), fontSize: 25)),
              const SizedBox(height: 20),
              PasswordContainer(),
              const SizedBox(height: 10),
              Container(
                decoration: const BoxDecoration(
                    color: ColorsApp.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(7))),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    children: [
                      const SliderLength(),
                      ...List.generate(checkOptionButton.length, (index) {
                        CheckOptionButton c = checkOptionButton[index];
                        return CheckBoxSelect(
                          checkOptionButton: c,
                          index: index,
                        );
                      }),
                      // checkOptionButton.map((e) => CheckBoxSelect(checkOptionButton: e)).toList(),
                      const SizedBox(height: 20),
                      const PasswordStrength(),
                      const SizedBox(height: 25),
                      const ButtonGenerator(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
