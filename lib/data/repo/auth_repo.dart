import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_constants.dart';
import '../api/api.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<bool> saveUserToken(String token,) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.token, token);
  }

  Future<bool> isLoggedIn() async {
    final String? isTokenAvailable = await sharedPreferences.getString(AppConstants.token);
    //debugPrint("isTokenAvailable: $isTokenAvailable");
    return isTokenAvailable != null && isTokenAvailable.isNotEmpty;
  }



  String getUserToken() {
    return sharedPreferences.getString(AppConstants.token) ?? "";
  }

  Future<bool> clearSharedData() async {
    await sharedPreferences.remove(AppConstants.token);
    return true;
  }

  Future<Response> sendOtpRepo(String? phoneNo,) async {
    return await apiClient.postData(AppConstants.sendOtpUrl, {"mobile":"+91${phoneNo}"});
  }

  Future<Response> verifyOtp(String? phoneNo,String? otp,String? fcmToken) async {
    return await apiClient.postData(AppConstants.verifyOtpUrl, {"mobile": "+91$phoneNo", "otp" : otp,"fcmToken": fcmToken});
  }

  Future<Response> getUserData() async {
    return await apiClient.getData(AppConstants.myProfileUrl,method: 'GET');
  }

  Future<Response> getPrivacyPolicy(String data) async {
    return await apiClient.getData(AppConstants.privacyUrl+"${data}",method: 'GET');
  }






}