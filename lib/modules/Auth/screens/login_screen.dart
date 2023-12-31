import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinic_app/common_components/services/form_submission_status.dart';
import 'package:clinic_app/common_components/widgets/password_textfield.dart';
import 'package:clinic_app/modules/Auth/bloc/login_bloc/login_bloc.dart';
import 'package:clinic_app/modules/Auth/screens/phone_number_login_screen.dart';
import 'package:clinic_app/modules/Auth/screens/register_screen.dart';
import 'package:clinic_app/modules/Auth/services/auth_repository.dart';
import 'package:clinic_app/modules/Auth/services/validators.dart';
import 'package:clinic_app/modules/Auth/widgets/custom_elevated_button.dart';
import 'package:clinic_app/modules/Auth/widgets/custom_text_button.dart';
import 'package:clinic_app/modules/Auth/widgets/icon_title_widget.dart';
import 'package:clinic_app/modules/Auth/widgets/input_text_field.dart';
import 'package:clinic_app/modules/Auth/widgets/policy_buttons.dart';
import 'package:clinic_app/modules/Auth/widgets/welcomepopup.dart';
import 'package:clinic_app/modules/MyJatya/screens/MyJatya.dart';
import 'package:clinic_app/utils/SharePref.dart';
import 'package:clinic_app/utils/constants/color_konstants.dart';

import '../../../common_components/widgets/error_alert_dialog.dart';
import '../../../common_components/widgets/popup_widget.dart';
import '../widgets/social_login_widget.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    sharedPrefs.setOnboarded();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleRememberMe(bool value) {
    setState(() {
      _rememberMe = value;
    });
  }

  final formGlobalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // var devicesize = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          log(state.formStatus.toString());
          if (state.formStatus is FormSubmissionFailed) {
            final FormSubmissionFailed formStatus =
                state.formStatus as FormSubmissionFailed;
            showPopup(
                context: context,
                child: ErrorAlertDialog(
                  error: formStatus.exception.toString(),
                ));
            context.read<LoginBloc>().add(const LoginREInitital());
            return;
          }
          if (state is LoginRoleFailed) {
            showPopup(
              context: context,
              child: const ErrorAlertDialog(
                error: "User not authoried",
              ),
            );
            context.read<LoginBloc>().add(const LoginREInitital());
            return;
          }
          if (state is LoginSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MyJatya(),
              ),
            );

            showPopup(
                context: context,
                child: Welcomepopup(
                  response: state.response,
                ));
          }
        },
        child: Form(
          key: formGlobalKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.025,
                  ),
                  ...buildIconAndTitle(
                    titleText: 'Login',
                    height: height * 0.12,
                  ),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return InputTextField(
                        textEditingController: _usernameController,
                        labelText: 'EMAIL ID',
                        hintText: 'Email',
                        validator: (email) =>
                            Validators.emailValidator(email),
                        onChanged: (value) => context.read<LoginBloc>().add(
                              LoginEmailChanged(email: value),
                            ),
                      );
                    },
                  ),
                  SizedBox(height: height * 0.03),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return PasswordTextField(
                        labelText: 'PASSWORD',
                        textEditingController: _passwordController,
                        hintText: 'Password',
                        validator: (password) => null,
                        // Validators.passwordValidator(password),
                        onchanged: (value) => context.read<LoginBloc>().add(
                              LoginPasswordChanged(password: value),
                            ),
                      );
                    },
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Checkbox(
                        materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                        visualDensity: const VisualDensity(
                            horizontal: -4, vertical: -4),
                        value: _rememberMe,
                        onChanged: (value) {
                          _toggleRememberMe(value!);
                        },
                      ),
                      const SizedBox(width: 8.0),
                      const Text(
                        'Remember me',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      CustomTextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ForgotPasswordScreen(),
                            ),
                          );
                        },
                        text: 'Forgot Password?',
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      // if (state.formStatus is SubmissionFailed) {
                      //   WidgetsBinding.instance.addPostFrameCallback((_) {
                      //     context.read<LoginBloc>().add(const LoginREInitital());
                      //   });
                      // }
                      return state.formStatus is FormSubmitting
                          ? const CircularProgressIndicator()
                          : CustomElevatedButton(
                              onPressed: () {
                                if (formGlobalKey.currentState!
                                    .validate()) {
                                  context
                                      .read<LoginBloc>()
                                      .add(const LoginSubmitted());
                                }
                              },
                              horizontalWidth: width * 0.4,
                              verticalWidth: 12,
                              text: 'Login',
                            );
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'or',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      // TODO: Implement login using mobile number
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const PhoneNumberLoginScreen(),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        width: 2.0,
                        color: ColorKonstants.primarySwatch.shade500,
                      ),
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.center,
                      backgroundColor: (Colors.transparent),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 16,
                        ),
                        const Icon(
                          Icons.dialpad,
                        ),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Login Using Mobile Number',
                            ),
                            SizedBox(
                              width: 16,
                            )
                          ],
                        ))
                        // SizedBox(
                        //   width: 16,
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  const SocialLoginWidget(),
                  // SizedBox(
                  //   height: height * 0.01,
                  // ),
                  CustomTextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                    text: 'Create your Jatya account?',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    color: Colors.black,
                  ),
                  SizedBox(height: height * 0.06),
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
