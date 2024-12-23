import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_getx/widgets/task_card.dart';

import '../controller/completedTaskListController.dart';
import '../widgets/snackBar_message.dart';
import '../widgets/task_card.dart';
import 'package:get/get.dart';
class CompletedTaskScreen extends StatefulWidget {
  static const String name = "/CompletedTaskScreen";

  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  final CompletedTaskListController _completedTaskListController =
  Get.find<CompletedTaskListController>();

  @override
  void initState() {
    _getCompleteTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CompletedTaskListController>(
        builder: (completedTaskListController) {
          return Visibility(
            visible: !completedTaskListController.inProgress,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: RefreshIndicator(
              onRefresh: () async {
                _getCompleteTaskList();
              },
              child: ListView.separated(
                itemCount: completedTaskListController.completedTaskList.length,
                itemBuilder: (context, index) {
                  return TaskCard(
                    taskModel: completedTaskListController.completedTaskList[index],
                    onRefreshList: _getCompleteTaskList,
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 8);
                },
              ),
            ),
          );
        });
  }

  Future<void> _getCompleteTaskList() async {
    final bool result =
    await _completedTaskListController.getCompletedTaskList();
    if (!result) {
      showSnackBar(
        context,
        _completedTaskListController.errorMessage!,
        true,
      );
    }
  }
}