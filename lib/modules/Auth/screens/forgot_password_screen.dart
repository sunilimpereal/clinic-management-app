import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jatya_patient_mobile/common_components/services/form_submission_status.dart';
import 'package:jatya_patient_mobile/modules/Auth/screens/create_new_password_screen.dart';
import 'package:jatya_patient_mobile/modules/Auth/screens/enter_otp_screen.dart';
import 'package:jatya_patient_mobile/modules/Auth/widgets/custom_elevated_button.dart';
import 'package:jatya_patient_mobile/modules/Auth/widgets/custom_text_button.dart';
import 'package:jatya_patient_mobile/modules/Auth/widgets/icon_title_widget.dart';
import 'package:jatya_patient_mobile/modules/Auth/widgets/input_text_field.dart';
import 'package:jatya_patient_mobile/modules/Auth/widgets/phone_number_textfield.dart';
import 'package:jatya_patient_mobile/modules/Auth/widgets/policy_buttons.dart';

import '../../../common_components/widgets/popup_widget.dart';
import '../bloc/forgot_password_bloc/forgot_password_bloc.dart';
import '../../../common_components/widgets/error_alert_dialog.dart';
import '../services/validators.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _phoneNumberTextController =
      TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();
  bool pushedToOtp = false;

  String? _validateFields(bool isPhone) {
    if (_phoneNumberTextController.text.isNotEmpty &&
        _emailTextController.text.isNotEmpty) {
      return 'Please fill either Phone or Email';
    }
    if (_phoneNumberTextController.text.isNotEmpty) {
      if (!isPhone) return null;
      return Validators.phoneValidator(_phoneNumberTextController.text);
    }
    if (_emailTextController.text.isNotEmpty) {
      if (isPhone) return null;
      return Validators.emailValidator(_emailTextController.text);
    }
    return 'Please fill either Phone or Email';
  }

  static String validationId = '';
  static void updateValidationId(String newValidationId) {
    validationId = newValidationId;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          log(state.toString());
          if (state.formStatus is FormSubmissionFailed) {
            final FormSubmissionFailed formStatus =
                state.formStatus as FormSubmissionFailed;
            showPopup(
                context: context,
                child: ErrorAlertDialog(
                  error: formStatus.exception.toString(),
                ));
            context
                .read<ForgotPasswordBloc>()
                .add(const ForgotPasswordReinital());
            return;
          }
          if (state is ForgotPasswordSuccess) {
            updateValidationId(state.validationId);
          }
          if (state is ForgotPasswordSuccess && !pushedToOtp) {
            log("Email=${_emailTextController.text}");
            log("Mobile=${_phoneNumberTextController.text}");
            pushedToOtp = true;

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EnterOTPScreen(
                  resendOtp: (context1) {
                    // Navigator.pop(context1);
                    context
                        .read<ForgotPasswordBloc>()
                        .add(ForgotPasswordSubmitted(
                          email: _emailTextController.text,
                          phone: _phoneNumberTextController.text,
                        ));
                  },
                  otpSentAddress: _phoneNumberTextController.text.isEmpty
                      ? _emailTextController.text
                      : _phoneNumberTextController.text,
                  promptTitle: 'Verification code sent to',
                  screenTitle: 'Reset your password',
                  buttonText: 'Verify',
                  onButtonPressed: (context1, String enteredOtp) async {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateNewPasswordScreen(
                          otp: enteredOtp,
                          validationId: validationId,
                        ),
                      ),
                    );
                    return "";
                  },
                ),
              ),
            );
          }
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formGlobalKey,
                child: Column(
                  children: [
                    ...buildIconAndTitle(
                      titleText: 'Reset your Password',
                      height: height * 0.2,
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    // BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                    //   builder: (context, state) {
                    //     return InputTextField(
                    //       labelText: 'Name',
                    //       hintText: 'Name',
                    //       validator: (name) => Validators.nameValidator(name),
                    //       onChanged: (value) => context.read<ForgotPasswordBloc>().add(NameChanged(name: value)),
                    //     );
                    //   },
                    // ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                      builder: (context, state) {
                        return InputTextField(
                          labelText: 'EMAIL ID',
                          textEditingController: _emailTextController,
                          hintText: 'Email ID',
                          validator: (email) => _validateFields(false),
                          onChanged: (value) => context
                              .read<ForgotPasswordBloc>()
                              .add(EmailChanged(email: value)),
                        );
                      },
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    const Text('or'),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        const PhoneNumberDropdownMenu(),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: SizedBox(
                            width: width * 0.65,
                            child: TextFormField(
                                controller: _phoneNumberTextController,
                                decoration: const InputDecoration(
                                  hintText: 'Phone Number',
                                ),
                                keyboardType: TextInputType.number,
                                validator: (phone) => _validateFields(true)
                                // inputFormatters: <TextInputFormatter>[
                                //   FilteringTextInputFormatter.digitsOnly
                                // ], // Only numbers can be entered
                                ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                      builder: (context, state) {
                        return state.formStatus is FormSubmitting
                            ? const CircularProgressIndicator()
                            : CustomElevatedButton(
                                onPressed: () {
                                  if (formGlobalKey.currentState!.validate()) {
                                    pushedToOtp = false;
                                    context
                                        .read<ForgotPasswordBloc>()
                                        .add(ForgotPasswordSubmitted(
                                          email: _emailTextController.text,
                                          phone:
                                              _phoneNumberTextController.text,
                                        ));
                                  }
                                },
                                horizontalWidth: width * 0.25,
                                verticalWidth: 12,
                                text: 'Send Verification Code',
                              );
                      },
                    ),
                    CustomTextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      text: 'Back to Login',
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                    ),
                    SizedBox(
                      height: height * 0.25,
                    ),
                    const PolicyButtons(),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
