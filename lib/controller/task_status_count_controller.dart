import '../data/service/network_caller.dart';
import '../models/network_response.dart';
import '../models/task_status_count_model.dart';
import '../models/task_status_model.dart';
import '../utils/url.dart';
import '../widgets/task_summary_card.dart';
import 'package:get/get.dart';
class TaskStatusCountController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  List<TaskStatusModel> _taskStatusCountList = [];
  List<TaskSummaryCard> _getTaskSummaryCardList() {
    List<TaskSummaryCard> taskSummaryCardList = [];
    for (TaskStatusModel t in _taskStatusCountList) {
      taskSummaryCardList.add(
        TaskSummaryCard(title: t.sId!, count: t.sum ?? 0),
      );
    }
    return taskSummaryCardList;
  }

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;
  List<TaskSummaryCard> get getTaskSummaryCardList => _getTaskSummaryCardList();

  Future<bool> taskStatusCountController() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.taskStatusCount);
    if (response.isSuccess) {
      final TaskStatusCountModel taskStatusCountModel =
      TaskStatusCountModel.fromJson(response.responseData);
      _taskStatusCountList = taskStatusCountModel.taskStatusCountList ?? [];
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();

    return isSuccess;
  }
}