import 'package:devine_marry/controller/AuthController/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/images.dart';
import '../../widgets/common_button.dart';
import 'SubScreens/create_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage(Images.bgPlain),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,

        body: GetBuilder<AuthController>(
          builder: (authController) {
            return PageView(
              controller: authController.pageController,
              children: [
                CreateScreen(),
              ],
            );
          },
        ),
        bottomNavigationBar: Padding(
            padding:
            const EdgeInsets.only(bottom: 18.0, left: 16.0, right: 16.0),
            child: Row(
              children: [
                Visibility(
                  visible: Get.find<AuthController>().pageController.page != 0,
                  child: Expanded(
                      child: CommonButton(
                        isLightColor: true,
                        text: '',
                        isShowIcon: false,
                      )),
                ),
                Visibility(
                    visible: Get.find<AuthController>().pageController.page != 0,
                    child: SizedBox(width: 10)),
                Expanded(
                    child: CommonButton(
                      isLightColor: false,
                      text: 'Next >',
                      isShowIcon: false,
                    ))
              ],
            )),
      ),
    );
  }
}
