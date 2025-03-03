import 'package:devine_marry/controller/AuthController/auth_controller.dart';
import 'package:devine_marry/helper/route_helper.dart';
import 'package:devine_marry/helper/validations.dart';
import 'package:devine_marry/utils/string_texts.dart';
import 'package:devine_marry/widgets/common_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../../widgets/custom_snack_bar.dart';
import '../../widgets/login_text_fields.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: Get.find<AuthController>().loginFormKey,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage(Images.bg),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(children: [
            SizedBox(height: 228),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  StringTexts.login,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF212121),
                    fontSize: 32,
                    // fontFamily: 'DM Sans',
                    fontWeight: DmSansBold.fontWeight,
                    // height: 1.40,
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    StringTexts.enterYourPhoneNumber,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Color(0xFF212121),
                      fontSize: DmSansRegular.copyWith(fontSize: 16).fontSize,
                      // fontFamily: 'DM Sans',
                      fontWeight: DmSansBold.fontWeight,
                      // height: 1.40,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 18),
            GetBuilder<AuthController>(
              builder: (loginController) {
                return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: LoginTextField(
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                       ValidatorAndInputFormatters.numericInputFormatter(),
                      ],
                      controller: loginController.phoneController,
                      hintText:   StringTexts.phoneNumber,
                      onChanged: (number) {
                        loginController.changePhoneNumber(number);
                        debugPrint("Phone Number: $number");
                      },
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          '+91',
                          style: TextStyle(
                            color: Color(0xFF212121),
                            fontSize:
                                DmSansRegular.copyWith(fontSize: 16).fontSize,
                            // fontFamily: 'DM Sans',
                            fontWeight: DmSansBold.fontWeight,
                            // height: 1.40,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password cannot be empty";
                        } else if (ValidatorAndInputFormatters
                            .isValidPhoneNumber(value)) {
                          return "Enter Valid Phone Number";
                        }
                        return null;
                      },
                      focusNode: loginController.phoneFocus,
                    ));
              },
            ),
            SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CommonButton(isLightColor: true, text: "Next >", onPressed: () {

                showCustomSnackBar("You have Logged In Successfully", isError: false);
                 Get.toNamed(RouteHelper.otpVerification, arguments: Get.find<AuthController>().phoneController.text);
                 // if(Get.find().loginFormKey.currentState!.validate()){
                 //   Get.find<AuthController>().sendOtpApi();}
              }, isShowIcon: false,),
            ),
          ]),
        ),
      ),
    );
  }
}
