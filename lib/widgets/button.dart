import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../utils/colors.dart';

class Elevatebutton extends StatelessWidget {
  // const Elevatebutton({super.key});
  final String name;
  final Function onPressed;
  final GlobalKey<FormState> formKey;
  const Elevatebutton({
    super.key,
    required this.formKey,
    required this.name,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 17,
            letterSpacing: 1.0,
            fontWeight: FontWeight.w700),
      ),
      onPressed: () async {
        if (formKey.currentState!.validate()) {}
      },
      child:

          // (_result)
          //     ? LoadingAnimationWidget.discreteCircle(
          //         color: Colors.white,
          //         size: 25,
          //         secondRingColor: Colors.white,
          //       )
          //     :

          Text(name.toString()),
    );
  }
}
