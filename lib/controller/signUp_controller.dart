import '../data/service/network_caller.dart';
import '../models/network_response.dart';
import '../utils/url.dart';
import 'package:get/get.dart';
class SignupController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get signUpInProgress => _inProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> getSignUpController(
      String email,
      String firstname,
      String lastName,
      String mobile,
      String password,
      ) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstname,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
      "photo": ""
    };

    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.registration, body: requestBody);
    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();

    return isSuccess;
  }
}