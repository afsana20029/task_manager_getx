import '../data/service/network_caller.dart';
import '../models/network_response.dart';
import 'package:get/get.dart';

import '../screens/signIn_screen.dart';
import '../utils/url.dart';
class ResetPasswordController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> getPasswordResetController(
      String email, String otp, String password) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "email": email,
      "OTP": otp,
      "password": password,
    };
    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.resetPassword,
      body: requestBody,
    );

    if (response.isSuccess) {
      Get.offAllNamed(SignInScreen.name);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();

    return isSuccess;
  }
}