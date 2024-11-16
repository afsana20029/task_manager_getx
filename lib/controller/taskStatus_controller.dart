import '../data/service/network_caller.dart';
import '../models/network_response.dart';
import '../utils/url.dart';
import 'package:get/get.dart';
class UpdateTaskStatusController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> getUpdateTaskStatusController(
      String taskId, String taskStatus) async {
    bool isSuccess = false;

    _inProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.updateTaskStatus(taskId, taskStatus));
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