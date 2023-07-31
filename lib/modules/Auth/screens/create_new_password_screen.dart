import 'package:flutter/material.dart';
import 'package:clinic_app/common_components/widgets/error_alert_dialog.dart';
import 'package:clinic_app/common_components/widgets/password_textfield.dart';
import 'package:clinic_app/modules/Auth/model/forgot_password/verify_forgot_password_request.dart';
import 'package:clinic_app/modules/Auth/services/auth_repository.dart';
import 'package:clinic_app/modules/Auth/services/validators.dart';

import '../../../common_components/widgets/popup_widget.dart';
import 'login_screen.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_button.dart';
import '../widgets/icon_title_widget.dart';
import '../widgets/terms_and_copyright_widget.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  final String validationId;
  final String otp;
  const CreateNewPasswordScreen({super.key, required this.validationId, required this.otp});

  @override
  State<CreateNewPasswordScreen> createState() => _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController = TextEditingController();

  final formGlobalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formGlobalKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 50),
                ...buildIconAndTitle(
                  titleText: 'Create New Password',
                  height: height * 0.14,
                ),
                SizedBox(height: height * 0.03),
                PasswordTextField(
                  textEditingController: _newPasswordController,
                  labelText: 'NEW PASSWORD',
                  hintText: 'New Password',
                  validator: (password) => Validators.passwordValidator(password),
                  onchanged: (String) {},
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                PasswordTextField(
                  textEditingController: _confirmNewPasswordController,
                  labelText: 'CONFIRM NEW PASSWORD',
                  hintText: 'Confirm New Password',
                  validator: (password) => Validators.passwordValidator(password),
                  onchanged: (String) {},
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                CustomElevatedButton(
                  onPressed: () async {
                    if (formGlobalKey.currentState!.validate()) {
                      if (_newPasswordController.text == _confirmNewPasswordController.text) {
                        try {
                          final res = await AuthRepository().verifyForgotPassword(
                              verifyForgotPasswordRequest: VerifyForgotPasswordRequest(
                                  otp: widget.otp, validationId: widget.validationId, password: _confirmNewPasswordController.text));
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                              (Route<dynamic> route) => false);
                        } catch (e) {
                          showPopup(context: context, child: const ErrorAlertDialog(error: "Invalid Otp"));
                        }
                      } else {
                        showPopup(context: context, child: const ErrorAlertDialog(error: "Passwords do not match"));
                      }
                    }
                  },
                  horizontalWidth: width * 0.25,
                  verticalWidth: 12,
                  text: 'Update Password',
                ),
                CustomTextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  text: 'Back to Login',
                  color: Colors.orange,
                  decoration: TextDecoration.underline,
                  fontSize: 14,
                ),
                SizedBox(
                  height: height * 0.20,
                ),
                ...buildTermsAndCopyrightWidget(
                  termsOnPressed: () {},
                  privacyOnPressed: () {},
                  cookieOnPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
