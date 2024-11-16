import '../data/service/network_caller.dart';
import '../models/network_response.dart';
import '../models/task_list_model.dart';
import '../models/task_model.dart';
import '../utils/url.dart';
import 'package:get/get.dart';
class CanceledTaskListController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  List<TaskModel> _canceledTaskList = [];

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;
  List<TaskModel> get canceledTaskList => _canceledTaskList;

  Future<bool> getCanceledTaskList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.canceledTaskList);
    if (response.isSuccess) {
      final TaskListModel canceledTaskListModel =
      TaskListModel.fromJson(response.responseData);
      _canceledTaskList = canceledTaskListModel.taskList ?? [];
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}