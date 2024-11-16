import 'package:get/get.dart';

import '../data/service/network_caller.dart';
import '../models/network_response.dart';
import '../utils/url.dart';
class DeleteTaskController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> getDeleteTask(String taskId) async {
    bool isSuccessStatus = false;
    _inProgress = true;
    update();

    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.deleteTaskList(taskId));
    if (response.isSuccess) {
      isSuccessStatus = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();

    return isSuccessStatus;
  }
}