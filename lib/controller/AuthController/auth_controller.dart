import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repo/auth_repo.dart';
import '../../helper/date_converter.dart';
import '../../helper/route_helper.dart';
import '../../widgets/custom_snack_bar.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  final SharedPreferences sharedPreferences;

  AuthController({
    required this.authRepo,
    required this.sharedPreferences,
  });

  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  bool _isLoginLoading = false;
  final loginFormKey = GlobalKey<FormState>();
  final FocusNode phoneFocus = FocusNode();

  PageController pageController = PageController();


  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController fathersNameController = TextEditingController();
  TextEditingController fathersProfessionController = TextEditingController();
  TextEditingController motherNameController = TextEditingController();
  TextEditingController motherProfessionController = TextEditingController();
  String numberOfSiblings = "";
  String lookingFor = "";
  String religion = "";
  String caste = "";
  String country = "";
  String state = "";
  String dob = "";
  String gender = "";


  void nextPage() {
    pageController.nextPage(duration: Duration(
      milliseconds: 300,
    ), curve: Curves.easeIn);
    update();
  }
  void previousPage() {
    pageController.previousPage(duration: Duration(
      milliseconds: 300,
    ), curve: Curves.easeOut);
    update();
  }

  void changePhoneNumber(String value) {
    phoneController.text = value;
    update();
  }





  //
  // Future<bool> isLoggedIn() async {
  //   bool value = await  authRepo.isLoggedIn();
  //   return value;
  // }
  // DateTime? selectedDate;
  // String? formattedDate;
  // String? privacyPolicy;
  //
  // void updateDate(DateTime newDate) {
  //   selectedDate = newDate;
  //   formattedDate = SimpleDateConverter.formatDateToCustomFormat(selectedDate!);
  //   update();
  // }
  //
  // var selectedGender = 'Male'; // Observable for selected gender
  // final List<String> genderOptions = ['Male', 'Female',]; // List of options
  //
  // void updateGender(String gender) {
  //   selectedGender = gender; // Update selected gender
  //   update(); // Call update to refresh listeners (not using Obx)
  // }
  //
  // var selectedDiabetes = 'No';
  // final List<String> diabetesOptions = ['No','Yes']; // List of options
  //
  // void updateDiabetes(String val) {
  //   selectedDiabetes = val;
  //   update();
  // }
  //
  // var selectedGlasses = 'No';
  // final List<String> glassesOptions = ['No','Yes'];
  // void updateGlasses(String val) {
  //   selectedGlasses = val;
  //   update();
  // }
  //
  // var selectedBp= 'No';
  // final List<String> bpOptions = ['No','Yes'];
  //
  // void updateHealth(String val) {
  //   selectedBp = val;
  //   update();
  // }
  //
  //
  // bool _isLoading = false;
  // bool get isLoading => _isLoading;
  //
  // DateTime? lastBackPressTime;
  // Future<bool> handleOnWillPop() async {
  //   final now = DateTime.now();
  //
  //   if (lastBackPressTime == null || now.difference(lastBackPressTime!) > const Duration(seconds: 2)) {
  //     updateLastBackPressTime(now);
  //     ScaffoldMessenger.of(Get.context!).showSnackBar(
  //       const SnackBar(
  //         content: Text('Press back again to exit'),
  //         duration: Duration(seconds: 2),
  //       ),
  //     );
  //     SystemNavigator.pop();
  //     return Future.value(false);
  //   }
  //   return Future.value(true);
  // }
  //
  // Future<void> getPrivacyPolicy(String value) async {
  //
  //   _isLoginLoading = true;
  //   update();
  //   Response response = await authRepo.getPrivacyPolicy(value);
  //
  //   final Map<String, dynamic> data = response.body['data'] as Map<String, dynamic>;
  //   log(data.toString(),name: "Privacy Policy");
  //
  //   privacyPolicy = data['content'].toString();
  //   if(value == "1") {
  //     Get.to(() => PrivacyPolicy(
  //       privacyPolicy: privacyPolicy ?? "",
  //       title: "Privacy Policy",
  //     ));
  //   } else {
  //     Get.to(() => PrivacyPolicy(
  //       privacyPolicy: privacyPolicy ?? "",
  //       title: "Terms & Condition",
  //     ));
  //   }
  //   _isLoginLoading = false;
  //   update();
  // }
  //
  //
  //
  // void updateLastBackPressTime(DateTime time) {
  //   lastBackPressTime = time;
  //   update();
  // }
  //
  // ///################ Apis ########################
  //
  //
  // bool _isLoginLoading = false;
  // bool get isLoginLoading => _isLoginLoading;
  //
  // bool _isShowingBottomBar = true;
  // bool get isShowingBottomBar => _isShowingBottomBar;
  //
  //
  // void updateBottomBarVisibility(bool isVisible) {
  //   _isShowingBottomBar = isVisible;
  //   //debugPrint('Bottom bar visibility: $isVisible');
  //   update();
  // }
  Future<void> sendOtpApi() async {
    try {
      _isLoginLoading = true;
      update();

      Response response =
          await authRepo.sendOtpRepo(phoneController.text.trim());

      if (response.statusCode == 200) {
        var responseData = response.body;
        if (responseData["message"]
            .contains("OTP sent to your mobile number")) {
          String otp = responseData['otp'].toString();
          _isLoginLoading = false;
          update();
          // showCustomSnackBar(responseData['message'], isError: false);
          debugPrint("OTP: ${responseData['message']}");
          Get.toNamed(
              RouteHelper.getOtpVerificationRoute(phoneController.text.trim()));
        } else {
          _isLoginLoading = false;
          update();
          showCustomSnackBar(responseData['message'], isError: true);
        }
      } else {
        print('Failed to send OTP');
      }
    } catch (e) {
      print("Error sending OTP: $e");
      showCustomSnackBar("Something went wrong. Please try again.",
          isError: true);
    } finally {
      _isLoginLoading = false;
      update();
    }
  }

  //
  // Future<void> saveSubscriptionStatus(bool isActive) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('isSubscriptionActive', isActive);
  // }
  //
  //
  // Future<bool> getSubscriptionStatus() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getBool('isSubscriptionActive') ?? false;
  // }
  //
  Future<void> verifyOtpApi(String? otp) async {
    if (phoneController.text.isEmpty || otp == null) {
      showCustomSnackBar('Phone number and OTP cannot be null', isError: true);
      return;
    }

    _isLoginLoading = true;
    update();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? deviceToken = await prefs.getString('FCM');
    //debugPrint('Device token: $deviceToken');
    try {
      Response response = await authRepo.verifyOtp(
          phoneController.text.trim(), otp, deviceToken);
      // Create a multipart request

      if (response.statusCode == 200) {
      } else {
        showCustomSnackBar(response.body['message'], isError: true);
      }
    } catch (e) {
      print("Error verifying OTP: $e");
      showCustomSnackBar("Something went wrong. Please try again.",
          isError: true);
    } finally {
      _isLoginLoading = false;
      update();
    }
  }
//
//
// bool _userDataLoading = false;
// bool get userDataLoading => _userDataLoading;
//
//
// UserData? _userData;
// PatientData? _patientData;
//
// UserData? get userData => _userData;
// PatientData? get patientData => _patientData;
//
// Future<ApiResponse?> userDataApi() async {
//   // LoadingDialog.showLoading(message: "Please wait...");
//   _userDataLoading = true;
//   _userData = null;
//   _patientData = null;
//   update();
//   Response response = await authRepo.getUserData();
//   if (response.statusCode == 200) {
//     Map<String, dynamic> responseData = response.body;
//     ApiResponse apiResponse = ApiResponse.fromJson(responseData);
//     _userData = apiResponse.userData;
//     _patientData = apiResponse.patientData;
//     bool isSubscriptionActive = (responseData['subscriptionArray']['status'] ??false) as bool;
//     debugPrint("Subscription status: ${responseData['subscriptionArray']['status']}");
//     await saveSubscriptionStatus(isSubscriptionActive);
//   } else {
//
//   }
//   _userDataLoading = false;
//   // LoadingDialog.hideLoading();
//   update();
//   return ApiResponse(userData: _userData, patientData: _patientData); // Return the combined response
// }
}
