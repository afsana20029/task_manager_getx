import 'controller/add_new_task_controller.dart';
import 'controller/canceledTaskListController.dart';
import 'controller/completedTaskListController.dart';
import 'controller/deleteTaskController.dart';
import 'controller/forgotPassEmailVerify_controller.dart';
import 'controller/forgotPassOTP_controller.dart';
import 'controller/inprogress_taskList_controller.dart';
import 'controller/new_taskList_controller.dart';
import 'controller/resetPass_controller.dart';
import 'controller/signIn_controller.dart';
import 'controller/signUp_controller.dart';
import 'controller/taskStatus_controller.dart';
import 'controller/task_status_count_controller.dart';
import 'package:get/get.dart';
class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(SignInController());
    Get.put(NewTaskListController());
    Get.put(CompletedTaskListController());
    Get.put(CanceledTaskListController());
    Get.put(InProgressTaskListController());
    Get.put(SignupController());
    Get.put(AddNewTaskController());
    Get.put(ForgotPassEmailVerifyController());
    Get.put(ForgotPassOTPVerityController());
    Get.put(ResetPasswordController());
    Get.put(DeleteTaskController());
    Get.put(UpdateTaskStatusController());
    Get.put(TaskStatusCountController());
  }
}

