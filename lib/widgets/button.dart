import 'package:flutter/material.dart';

import '../utils/colors.dart';

class Elevatebutton extends StatelessWidget {
  // const Elevatebutton({super.key});
  final String name;
  final Function onPressed;
  final List value;
  // final GlobalKey<FormState> formKey;
  const Elevatebutton({
    super.key,
    // required this.formKey,
    required this.name,
    required this.onPressed,
    required this.value,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 343,
      height: 59,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              letterSpacing: 1.0,
              fontWeight: FontWeight.w700),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        ),
        onPressed: () async {
          // if (formKey.currentState!.validate()) {}
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
      ),
    );
  }
}
