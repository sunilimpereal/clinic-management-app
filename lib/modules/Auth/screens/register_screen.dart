import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinic_app/common_components/services/app_exceptions.dart';
import 'package:clinic_app/common_components/services/form_submission_status.dart';
import 'package:clinic_app/common_components/widgets/password_textfield.dart';
import 'package:clinic_app/common_components/widgets/success_alert_dialog.dart';
import 'package:clinic_app/modules/Auth/screens/login_screen.dart';
import 'package:clinic_app/modules/Auth/services/auth_repository.dart';
import 'package:clinic_app/modules/Auth/widgets/custom_elevated_button.dart';
import 'package:clinic_app/modules/Auth/widgets/custom_text_button.dart';
import 'package:clinic_app/modules/Auth/widgets/input_text_field.dart';
import 'package:clinic_app/modules/Auth/widgets/policy_buttons.dart';

import '../../../common_components/widgets/error_alert_dialog.dart';
import '../../../common_components/widgets/popup_widget.dart';
import '../bloc/register_bloc/register_bloc.dart';
import '../model/register/verify_register_request_model.dart';
import '../model/register/verify_register_response_model.dart';
import '../services/validators.dart';
import '../widgets/icon_title_widget.dart';
import 'enter_otp_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  static String validationId = '';
  static void updateValidationId(String newValidationId) {
    validationId = newValidationId;
  }

  // @override
  // void dispose() {
  //   _emailController.dispose();
  //   _passwordController.dispose();
  //   _firstNameController.dispose();
  //   _lastNameController.dispose();
  //   _confirmPasswordController.dispose();
  //   super.dispose();
  // }

  bool pushedToOtp = false;
  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var devicesize = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.formStatus is FormSubmissionFailed) {
          final FormSubmissionFailed formStatus =
              state.formStatus as FormSubmissionFailed;
          showPopup(
              context: context,
              child: ErrorAlertDialog(
                error: formStatus.exception.toString(),
              ));
          context.read<RegisterBloc>().add(const RegisterReInitial());
          return;
        }
        if (state is RegisterSuccess) {
          updateValidationId(state.validationId);
        }
        if (state is RegisterSuccess && !pushedToOtp) {
          pushedToOtp = true;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EnterOTPScreen(
                otpSentAddress: state.email,
                promptTitle:
                    'Verification code sent to ${_emailController.text}',
                screenTitle: 'Verify your phone',
                buttonText: 'Verify',
                onButtonPressed: (context1, String enteredOtp) async {
                  log("otp$enteredOtp");
                  String success = "";
                  try {
                    context
                        .read<AuthRepository>()
                        .registerVerify(
                            verifyRegisterRequest: VerifyRegisterRequest(
                          otp: enteredOtp,
                          validationId: validationId,
                        ))
                        .then((VerifyRegisterResponse value) {
                      success = "true";
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                      Future.delayed(const Duration(milliseconds: 100))
                          .then((value) {
                        showPopup(
                            context: context,
                            child: const SuccessAlertDialog(
                                message: "Registration Successful"));
                      });
                    }).catchError((e) {
                      String errorString = "Something went wrong";
                      if (e is BadRequestException) {
                        errorString = "Invalid OTP";
                      }
                      showPopup(
                          context: context,
                          child: ErrorAlertDialog(error: errorString));
                    });
                  } catch (e) {
                    showPopup(
                        context: context,
                        child: ErrorAlertDialog(error: e.toString()));
                  }
                  return success;
                },
                resendOtp: (BuildContext context1) {
                  context.read<RegisterBloc>().add(RegisterSubmitted(
                        email: _emailController.text,
                        password: _passwordController.text,
                        name:
                            '${_firstNameController.text} ${_lastNameController.text}',
                      ));
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
                    titleText: 'Register',
                    height: height * 0.12,
                  ),
                  BlocBuilder<RegisterBloc, RegisterState>(
                    builder: (context, state) {
                      return InputTextField(
                        labelText: 'FIRST NAME',
                        hintText: 'First Name',
                        textEditingController: _firstNameController,
                        validator: (name) => Validators.nameValidator(name),
                        onChanged: (value) => context
                            .read<RegisterBloc>()
                            .add(RegisterFirstNameChanged(firstName: value)),
                      );
                    },
                  ),
                  SizedBox(height: height * 0.03),
                  BlocBuilder<RegisterBloc, RegisterState>(
                    builder: (context, state) {
                      return InputTextField(
                        labelText: 'LAST NAME',
                        hintText: 'Last Name',
                        textEditingController: _lastNameController,
                        validator: (name) => Validators.nameValidator(name),
                        onChanged: (value) => context.read<RegisterBloc>().add(
                              RegisterLastNameChanged(lastName: value),
                            ),
                      );
                    },
                  ),
                  SizedBox(height: height * 0.03),
                  BlocBuilder<RegisterBloc, RegisterState>(
                    builder: (context, state) {
                      return InputTextField(
                          labelText: 'EMAIL ID',
                          hintText: 'Email ID',
                          textEditingController: _emailController,
                          validator: (email) =>
                              Validators.emailValidator(email),
                          onChanged: (email) => context
                              .read<RegisterBloc>()
                              .add(RegisterEmailChanged(email: email)));
                    },
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  BlocBuilder<RegisterBloc, RegisterState>(
                    builder: (context, state) {
                      return PasswordTextField(
                        labelText: 'PASSWORD',
                        textEditingController: _passwordController,
                        hintText: 'Password',
                        validator: (password) =>
                            Validators.passwordValidator(password),
                        onchanged: (value) => context
                            .read<RegisterBloc>()
                            .add(RegisterPasswordChanged(password: value)),
                      );
                    },
                  ),
                  SizedBox(height: height * 0.03),
                  BlocBuilder<RegisterBloc, RegisterState>(
                    builder: (context, state) {
                      return PasswordTextField(
                        labelText: 'CONFIRM PASSWORD',
                        textEditingController: _confirmPasswordController,
                        hintText: 'Confirm Password',
                        validator: (password) =>
                            Validators.passwordValidator(password),
                        onchanged: (value) => context.read<RegisterBloc>().add(
                            RegisterConfPasswordChanged(confpassword: value)),
                      );
                    },
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  BlocBuilder<RegisterBloc, RegisterState>(
                    builder: (context, state) {
                      return state.formStatus is FormSubmitting
                          ? const CircularProgressIndicator()
                          : CustomElevatedButton(
                              onPressed: () {
                                if (formGlobalKey.currentState!.validate()) {
                                  if (_passwordController.text ==
                                      _confirmPasswordController.text) {
                                    pushedToOtp = false;
                                    context
                                        .read<RegisterBloc>()
                                        .add(RegisterSubmitted(
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                          name:
                                              '${_firstNameController.text} ${_lastNameController.text}',
                                        ));
                                  } else {
                                    showPopup(
                                        context: context,
                                        child: const ErrorAlertDialog(
                                            error:
                                                "Password and Confirm password do not match"));
                                  }
                                }
                              },
                              horizontalWidth: width * 0.3,
                              verticalWidth: 12,
                              text: 'Create Account',
                            );
                    },
                  ),
                  CustomTextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    text: 'Already have an account? Sign in',
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                  const PolicyButtons()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
