import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/string_texts.dart';
import '../../../utils/styles.dart';
import '../../../widgets/custom_drop_down_field.dart';
import '../../../widgets/custom_text_field.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          SizedBox(height: 91),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  StringTexts.createAccount,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF86413F),
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    height: 1.40,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    StringTexts.fillDetailsToStartYourJourney,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF212121),
                      fontSize: DmSansRegular.copyWith(fontSize: 12).fontSize,
                      // fontFamily: 'DM Sans',
                      fontWeight: DmSansBold.fontWeight,
                      height: 1.40,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 21),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              width: Get.size.width,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    SizedBox(height: 21),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'PROFILE DETAILS',
                          style: TextStyle(
                            color: Color(0xFF86413F),
                            fontSize:
                                DmSansRegular.copyWith(fontSize: 14).fontSize,
                            // fontFamily: 'DM Sans',
                            fontWeight: DmSansBold.fontWeight,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 17),
                    CustomDropdownField(
                      hintText: 'Looking For',
                      options: [
                        "Male",
                        "Female",
                        "Others",
                      ],
                      onChanged: (String? value) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select an option';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 25),
                    CustomTextField(
                      hintText: 'First Name',
                      onChanged: (value) {},
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 25),
                    CustomTextField(
                      hintText: 'Last Name',
                      onChanged: (value) {},
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
