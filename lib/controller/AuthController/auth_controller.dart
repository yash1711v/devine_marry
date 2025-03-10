import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:devine_marry/data/api/api.dart';
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
import '../../models/component_models/country.dart';
import '../../models/component_models/religion.dart';
import '../../models/component_models/user_atributes.dart';
import '../../models/user/user.dart';
import '../../utils/app_constants.dart';
import '../../widgets/common_loading.dart';
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

  bool get isLoginLoading => _isLoginLoading;
  final loginFormKey = GlobalKey<FormState>();
  final FocusNode phoneFocus = FocusNode();

  PageController pageController = PageController();
  int currentPage = 0;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController fathersNameController = TextEditingController();
  TextEditingController fathersProfessionController = TextEditingController();
  TextEditingController motherNameController = TextEditingController();
  TextEditingController motherProfessionController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  //CreateScreenOne
  int? siblings = 0;
  String? numberOfSiblings;
  String? lookingFor;
  String? maritalStatus;
  String? religion;
  String? caste;
  String? country;
  String? state;
  String? dob = "";
  String? gender;
  String? profilePhoto = "";

  CountryResponse countryResponse = CountryResponse(countries: []);
  ReligionResponse religionResponse = ReligionResponse(religions: []);
  DataModel dataModel = DataModel(maritalStatuses: [], genders: []);
  CasteResponse casteResponse = CasteResponse(castes: []);
  StateResponse stateResponse = StateResponse(states: []);
  List<LookingFor> lookingForList = [
    LookingFor(id: 1, title: 'Bridegroom'),
    LookingFor(id: 2, title: 'Bride')
  ];

  void updateLookingFor(String value) {
    lookingFor = value;
    update();
  }

  void updateMaritalStatusFor(String value) {
    maritalStatus = value;
    update();
  }

  void updateReligion(String value) {
    religion = value;
    update();
  }

  void updateCaste(String? value) {
    caste = value;
    update();
  }

  void updateCountry(String value) {
    country = value;
    update();
  }

  void updateState(String? value) {
    state = value;
    update();
  }

  void updateDob(String value) {
    dob = value;
    dobController.text =
        value.replaceAll("0", "").replaceAll(":", "").replaceAll(".", "");
    update();
  }

  void updateGender(String value) {
    gender = value;
    update();
  }

  void updateProfilePhoto(String value) {
    profilePhoto = value;
    update();
  }

  void nextPage() {
    pageController.nextPage(
        duration: Duration(
          milliseconds: 300,
        ),
        curve: Curves.easeIn);
    currentPage = pageController.page!.toInt();
    update();
  }

  void previousPage() {
    pageController.previousPage(
        duration: Duration(
          milliseconds: 300,
        ),
        curve: Curves.easeOut);
    currentPage = pageController.page!.toInt();
    update();
  }

  void changePhoneNumber(String value) {
    phoneController.text = value;
    update();
  }

  //
  // Future<bool> isLoggedIn() async {
  //   bool value = await  authRepo.isLoggedIn();
  //   if(value){
  //     try {
  //       Response response = await authRepo.getUserData();
  //       debugPrint(response.body.toString());
  //       UserModel user = UserModel.fromJson(response.body['user']);
  //       debugPrint("User: ${user.toJson()}");
  //     } catch (e) {
  //       debugPrint("Error: $e");
  //     }
  //   } else {
  //
  //   }
  //
  //   return false;
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
    _isLoginLoading = true;
    update();
    try {
      Response response =
          await authRepo.sendOtpRepo(phoneController.text.trim());

      // var responseData = response.body;
      if (response.body['status']) {
        var responseData = response.body;

        if (responseData["message"]
            .toString()
            .contains("OTP sent successfully.")) {
          String otp = responseData['otp'].toString();
          _isLoginLoading = false;
          update();
          closeSnackBar();
          showCustomSnackBar(
              responseData['message'] + responseData['otp'].toString(),
              isError: false,
              isSuccess: true);
          debugPrint("OTP: ${responseData['otp']}");
          Get.toNamed(
              RouteHelper.getOtpVerificationRoute(phoneController.text.trim()));
        } else {
          _isLoginLoading = false;
          update();
          closeSnackBar();
          showCustomSnackBar(responseData['message'], isError: true);
        }
      } else {
        print('Failed to send OTP');
      }
    } catch (e) {
      print("Error sending OTP: $e");
      closeSnackBar();
      showCustomSnackBar("Something went wrong. Please try again. $e",
          isError: true);
    } finally {
      _isLoginLoading = false;
      update();
    }
  }

  Future<void> getCountries() async {
    _isLoginLoading = true;
    // showLoading();
    update();
    try {
      _isLoginLoading = true;
      update();
      Response response = await authRepo.getCountries();

      // var responseData = response.body;
      if (response.body['status']) {
        var responseData = response.body;
        CountryResponse countries = CountryResponse.fromJson(responseData);
        countryResponse = countries;
        _isLoginLoading = false;
        update();
      } else {
        print('Failed to fetch the countries');
      }
    } catch (e) {
      closeSnackBar();
      showCustomSnackBar("Something went wrong. Please try again. $e",
          isError: true);
    } finally {
      _isLoginLoading = false;
      update();
    }
  }

  Future<void> getReligion() async {
    _isLoginLoading = true;
    update();
    try {
      _isLoginLoading = true;
      update();
      Response response = await authRepo.getreligions();

      // var responseData = response.body;
      if (response.body['status']) {
        var responseData = response.body;
        ReligionResponse religion =
            ReligionResponse.fromJson(responseData['data']);
        religionResponse = religion;
        _isLoginLoading = false;
        update();
      } else {
        print('Failed to fetch the countries');
        showCustomSnackBar("Something went wrong. Please try again.",
            isError: true);
      }
    } catch (e) {
      closeSnackBar();
      showCustomSnackBar("Something went wrong. Please try again. $e",
          isError: true);
    } finally {
      _isLoginLoading = false;
      update();
    }
  }

  Future<void> getUserAttributes() async {
    _isLoginLoading = true;
    update();
    try {
      _isLoginLoading = true;
      update();
      Response response = await authRepo.getUserAttributes();

      // var responseData = response.body;
      if (response.body['status']) {
        var responseData = response.body;
        DataModel userAttribute = DataModel.fromJson(responseData['data']);
        dataModel = userAttribute;
        _isLoginLoading = false;
        update();
      } else {
        print('Failed to fetch the countries');
        showCustomSnackBar("Something went wrong. Please try again.",
            isError: true);
      }
    } catch (e) {
      closeSnackBar();
      showCustomSnackBar("Something went wrong. Please try again. $e",
          isError: true);
    } finally {
      _isLoginLoading = false;
      update();
    }
  }

  Future<void> getCastes(String id) async {
    showLoading();
    updateCaste(null);
    casteResponse = CasteResponse(castes: []);
    _isLoginLoading = true;
    update();
    try {
      _isLoginLoading = true;
      update();
      Response response = await authRepo.getCastes(id);
      if (response.body == null) {}
      if (response.body['status'] && response.body != null) {
        var responseData = response.body;
        CasteResponse castes = CasteResponse.fromJson(responseData['data']);
        casteResponse = castes;
        _isLoginLoading = false;
        update();
      } else {
        print('Failed to fetch the castes');
        showCustomSnackBar("Something went wrong. Please try again.",
            isError: true);
        hideLoading();
      }
    } catch (e) {
      closeSnackBar();
      hideLoading();
      showCustomSnackBar("Something went wrong. Please try again. $e",
          isError: true);
    } finally {
      hideLoading();
      _isLoginLoading = false;
      update();
    }
  }

  Future<void> getStates(String id) async {
    showLoading();
    updateState(null);
    stateResponse = StateResponse(states: []);
    _isLoginLoading = true;
    update();
    try {
      _isLoginLoading = true;
      update();
      Response response = await authRepo.getstates(id);

      if (response.body['status'] && response.body != null) {
        var responseData = response.body;
        StateResponse states = StateResponse.fromJson(responseData['data']);
        stateResponse = states;
        _isLoginLoading = false;
        update();
      } else {
        print('Failed to fetch the castes');
        showCustomSnackBar("Something went wrong. Please try again.",
            isError: true);
        hideLoading();
      }
    } catch (e) {
      closeSnackBar();
      hideLoading();
      showCustomSnackBar("Something went wrong. Please try again. $e",
          isError: true);
    } finally {
      hideLoading();
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
    ApiClient apiClient = ApiClient(
        appBaseUrl: AppConstants.baseUrl, sharedPreferences: sharedPreferences);
    if (phoneController.text.isEmpty || otp == null) {
      showCustomSnackBar('Phone number and OTP cannot be null', isError: true);
      return;
    }

    _isLoginLoading = true;
    update();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? deviceToken = "";
    // await prefs.getString('FCM');
    //debugPrint('Device token: $deviceToken');
    try {
      Response response = await authRepo.verifyOtp(
          phoneController.text.trim(), otp, deviceToken);
      // Create a multipart request
      await prefs.setString(AppConstants.token, response.body['token']);
      apiClient.updateHeader(response.body['token']);
      if (response.body['status']) {
        closeSnackBar();
        log("Body==> ${response.body['user']}");
        UserModel user = UserModel.fromJson(response.body['user']);
        if (user.profileComplete == 0 || user.profileComplete == null) {
          Get.toNamed(RouteHelper.register);
          showCustomSnackBar(response.body['message'],
              isError: false, isSuccess: true);
        } else {
          Get.toNamed(RouteHelper.dashboard);
        }
      } else {
        showCustomSnackBar(response.body['message'], isError: true);
      }
    } catch (e) {
      closeSnackBar();
      showCustomSnackBar("Something went wrong. Please try again $e .",
          isError: true);
    } finally {
      _isLoginLoading = false;
      update();
    }
  }

  void updateSiblings(int i) {
    siblings = i;
    numberOfSiblings = siblings.toString();
    update();
  }

  Future<bool> registerUser() async {
    showLoading();
    final String url = AppConstants.baseUrl+AppConstants.register; // Replace with your API URL

    // Image file (Replace with actual file picker logic)
    File imageFile = File(profilePhoto ?? ""); // Replace with actual image path

    // Create a request
    var request = http.MultipartRequest("POST", Uri.parse(url));
    String token = await sharedPreferences.getString(AppConstants.token) ?? "";

    request.headers.addAll({
      "Authorization": "Bearer $token", // Replace with actual token
      "Content-Type": "multipart/form-data",
      "Accept": "application/json",
    });

    // Add fields
    request.fields.addAll({
      "step": "register",
      "looking_for": lookingForList
          .firstWhere((element) => element.title == lookingFor)
          .id
          .toString(),
      "firstname": firstNameController.text,
      "lastname": lastNameController.text,
      "religions": religionResponse.religions
          .firstWhere((element) => element.name == religion)
          .id
          .toString(),
      "caste": casteResponse.castes
          .firstWhere((element) => (element.name ?? "") == caste)
          .id
          .toString(),
      "country": countryResponse.countries
          .firstWhere((element) => (element.name ?? "") == country)
          .id
          .toString(),
      "state": "California",
      "birthDate": dobController.text,
      "gender": dataModel.genders
          .firstWhere((element) => (element.gender ?? "") == gender)
          .id
          .toString(),
      "father_name": fathersNameController.text,
      "father_profession": fathersProfessionController.text,
      "mother_name": motherNameController.text,
      "mother_profession": motherProfessionController.text,
      "number_of_siblings": (numberOfSiblings ?? "").toString(),
    });

    // Add image file
    request.files.add(
      await http.MultipartFile.fromPath("image", imageFile.path),
    );

    try {
      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        hideLoading();
        print("Success: $responseData");
        nextPage();
        return true;
      } else {
        hideLoading();
        print("Error: ${response.statusCode} - $responseData");
        return false;
      }
    } catch (e) {
      hideLoading();
      print("Request failed: $e");
      return false;
    } finally {
      return false;
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

  void checkCreateAccountScreen() {
    if ((lookingFor ?? "").isNotEmpty &&
        (maritalStatus ?? "").isNotEmpty &&
        (country ?? "").isNotEmpty &&
        (caste ?? "").isNotEmpty &&
        (religion ?? "").isNotEmpty &&
        (state ?? "").isNotEmpty &&
        (firstNameController.text ?? "").isNotEmpty &&
        (lastNameController.text ?? "").isNotEmpty &&
        (fathersProfessionController.text ?? "").isNotEmpty &&
        (fathersNameController.text ?? "").isNotEmpty &&
        (motherNameController.text ?? "").isNotEmpty &&
        (motherProfessionController.text ?? "").isNotEmpty &&
        ((numberOfSiblings ?? "").isNotEmpty &&
            (numberOfSiblings ?? "") != "0") &&
        (dobController.text).isNotEmpty &&
        (gender ?? "").isNotEmpty &&
        (profilePhoto ?? "").isNotEmpty) {
      registerUser();
      // controller.nextPage();
    } else {
      if (numberOfSiblings == "0") {
        showCustomSnackBar("Number of siblings should be greater than 0",
            isError: true);
      } else if (dobController.text.isEmpty) {
        showCustomSnackBar("Please select date of birth", isError: true);
      } else if ((profilePhoto ?? "").isEmpty) {
        showCustomSnackBar("Please select profile photo", isError: true);
      } else if ((gender ?? "").isEmpty) {
        showCustomSnackBar("Please select gender", isError: true);
      } else if ((maritalStatus ?? "").isEmpty) {
        showCustomSnackBar("Please select marital status", isError: true);
      } else if ((country ?? "").isEmpty) {
        showCustomSnackBar("Please select a country", isError: true);
      } else if ((state ?? "").isEmpty) {
        showCustomSnackBar("Please select a state", isError: true);
      } else if ((caste ?? "").isEmpty) {
        showCustomSnackBar("Please select a caste", isError: true);
      } else if ((religion ?? "").isEmpty) {
        showCustomSnackBar("Please select a religion", isError: true);
      } else if (firstNameController.text.isEmpty) {
        showCustomSnackBar("Please enter your first name", isError: true);
      } else if (lastNameController.text.isEmpty) {
        showCustomSnackBar("Please enter your last name", isError: true);
      } else if (fathersNameController.text.isEmpty) {
        showCustomSnackBar("Please enter your father's name", isError: true);
      } else if (fathersProfessionController.text.isEmpty) {
        showCustomSnackBar("Please enter your father's profession",
            isError: true);
      } else if (motherNameController.text.isEmpty) {
        showCustomSnackBar("Please enter your mother's name", isError: true);
      } else if (motherProfessionController.text.isEmpty) {
        showCustomSnackBar("Please enter your mother's profession",
            isError: true);
      }
    }
  }
}
