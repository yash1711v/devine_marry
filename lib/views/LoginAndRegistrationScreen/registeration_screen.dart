import 'dart:developer';

import 'package:devine_marry/controller/AuthController/auth_controller.dart';
import 'package:devine_marry/widgets/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/images.dart';
import '../../utils/string_texts.dart';
import '../../widgets/common_button.dart';
import 'SubScreens/create_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<AuthController>().getCountries();
      Get.find<AuthController>().getReligion();
      Get.find<AuthController>().getUserAttributes();
    });
  }

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
              physics: NeverScrollableScrollPhysics(),
              controller: authController.pageController,
              children: [
                CreateScreen(),
              ],
            );
          },
        ),
        bottomNavigationBar: GetBuilder<AuthController>(builder: (controller) {
          return Padding(
              padding:
                  const EdgeInsets.only(bottom: 18.0, left: 16.0, right: 16.0),
              child: Row(
                children: [
                  Visibility(
                    visible: Get.find<AuthController>().currentPage != 0,
                    child: Expanded(
                        child: CommonButton(
                      onPressed: () {
                        if (controller.currentPage != 0) {
                          controller.previousPage();
                        }
                      },
                      isLightColor: true,
                      text: Text("",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      isShowIcon: false,
                    )),
                  ),
                  Visibility(
                      visible: Get.find<AuthController>().currentPage != 0,
                      child: SizedBox(width: 10)),
                  Expanded(
                      child: CommonButton(
                    onPressed: () {
                      if(controller.currentPage == 0){
                        debugPrint("Create Account");
                        controller.checkCreateAccountScreen();
                      }
                    },
                    isLightColor: false,
                    text: controller.isLoginLoading
                        ? Center(child: CircularProgressIndicator())
                        : Text(StringTexts.next,
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                    isShowIcon: false,
                  ))
                ],
              ));
        }),
      ),
    );
  }
}
