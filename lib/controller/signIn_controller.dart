import '../data/service/network_caller.dart';
import '../models/login_model.dart';
import '../models/network_response.dart';
import '../utils/url.dart';
import 'authcontroller.dart';
import 'package:get/get.dart';
class SignInController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> signIn(String email, String pass) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {'email': email, "password": pass,};

    final NetworkResponse response =
    await NetworkCaller.postRequest(url: Urls.login, body: requestBody);
    if (response.isSuccess) {
      LoginModel loginModel = LoginModel.fromJson(response.responseData);
      await AuthController.saveAccessToken(loginModel.token!);
      await AuthController.saveUserData(loginModel.data!);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();

    return isSuccess;
  }
}