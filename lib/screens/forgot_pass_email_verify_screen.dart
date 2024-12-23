import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_getx/screens/signIn_screen.dart';
import 'package:task_manager_getx/widgets/screen_background.dart';
import 'package:get/get.dart';
import '../controller/forgotPassEmailVerify_controller.dart';
import '../widgets/circularProgressIndicator.dart';
import '../widgets/snackBar_message.dart';
import 'forgot_pass_otp_screen.dart';

class ForgotPasswdEmailScreen extends StatefulWidget {
  static const String name = '/ForgotPassEmailVerifyScreen';

  const ForgotPasswdEmailScreen({
    super.key,
  });

  @override
  State<ForgotPasswdEmailScreen> createState() =>
      _ForgotPasswdEmailScreenState();
}

class _ForgotPasswdEmailScreenState extends State<ForgotPasswdEmailScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailVerifyTEController =
  TextEditingController();

  final ForgotPassEmailVerifyController _forgotPassEmailVerifyController =
  Get.find<ForgotPassEmailVerifyController>();



  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 82),
                Text(
                  'Your Email Address',
                  style: textTheme.displaySmall
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Text(
                  'A 6 digit verification OTP will be sent to your email address',
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 24),
                _buildVerifyEmailForm(),
                const SizedBox(height: 24),
                Center(
                  child: _buildHaveAccountSection(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVerifyEmailForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailVerifyTEController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'Email'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Enter a valid email !';
              }
              if (!value!.contains('@')) {
                return '@ must be contain in email !';
              }
            },
          ),
          const SizedBox(height: 24),
          GetBuilder<ForgotPassEmailVerifyController>(
              builder: (forgotPassOtpController) {
                return Visibility(
                  visible: !forgotPassOtpController.inProgress,
                  replacement: const Center(
                    child: CenterCircularProgressIndicator(),
                  ),
                  child: ElevatedButton(
                    onPressed: _onTapNextButton,
                    child: const Icon(Icons.arrow_circle_right_outlined),
                  ),
                );
              }
          ),
        ],
      ),
    );
  }

  Widget _buildHaveAccountSection() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            letterSpacing: 0.5),
        text: "Have an account? ",
        children: [
          TextSpan(
              text: 'Sign in',
              style: const TextStyle(color: Colors.green),
              recognizer: TapGestureRecognizer()..onTap = _onTapSignUp),
        ],
      ),
    );
  }

  Future<void> _sendOTPToEmail() async {
    final bool result = await _forgotPassEmailVerifyController
        .getForgotPassEmailVerifyController(
        _emailVerifyTEController.text);
    if (result) {
      Get.toNamed(ForgotPasswdOTPScreen.name,
          arguments: _emailVerifyTEController.text);
      showSnackBar(context, 'message');
    } else {
      showSnackBar(context, _forgotPassEmailVerifyController.errorMessage!);
    }
  }

  void _onTapNextButton() {
    _sendOTPToEmail();
  }

  void _onTapSignUp() {
    Get.toNamed(SignInScreen.name);
  }
}