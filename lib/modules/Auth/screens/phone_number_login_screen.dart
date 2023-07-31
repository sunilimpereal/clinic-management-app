// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jatya_patient_mobile/common_components/services/form_submission_status.dart';
import 'package:jatya_patient_mobile/modules/Auth/bloc/login_phone_bloc/login_phone_bloc.dart';
import 'package:jatya_patient_mobile/modules/Auth/model/login/mfa_phone_request.dart';
import 'package:jatya_patient_mobile/modules/Auth/screens/enter_otp_screen.dart';

import 'package:jatya_patient_mobile/modules/Auth/services/auth_repository.dart';
import 'package:jatya_patient_mobile/modules/Auth/services/validators.dart';
import 'package:jatya_patient_mobile/modules/Auth/widgets/custom_text_button.dart';
import 'package:jatya_patient_mobile/modules/Auth/widgets/icon_title_widget.dart';

import 'package:jatya_patient_mobile/modules/Auth/widgets/phone_number_textfield.dart';
import 'package:jatya_patient_mobile/modules/Auth/widgets/policy_buttons.dart';
import 'package:jatya_patient_mobile/modules/MyJatya/screens/MyJatya.dart';

import '../../../common_components/widgets/error_alert_dialog.dart';
import '../../../common_components/widgets/popup_widget.dart';
import '../bloc/login_phone_bloc/login_phone_state.dart';

import '../widgets/custom_elevated_button.dart';

class PhoneNumberLoginScreen extends StatefulWidget {
  const PhoneNumberLoginScreen({super.key});

  @override
  _PhoneNumberLoginScreenState createState() => _PhoneNumberLoginScreenState();
}

class _PhoneNumberLoginScreenState extends State<PhoneNumberLoginScreen> {
  final _phoneNumberController = TextEditingController(text: '');

  final formGlobalKey = GlobalKey<FormState>();

  void _onSendOtpButtonPressed() {
    // TODO: Implement OTP sending functionality
  }

  @override
  Widget build(BuildContext context) {
    var devicesize = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // Flag countryIcon = countryList.first;

    return BlocProvider(
      create: (context) => LoginPhoneBloc(context.read<AuthRepository>()),
      child: BlocListener<LoginPhoneBloc, LoginPhoneState>(
        listener: (context, state) {
          if (state.formStatus is FormSubmissionFailed) {
            showPopup(
              context: context,
              child: const ErrorAlertDialog(error: "Phone not registered"),
            );
          }
          if (state is LoginPhoneSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EnterOTPScreen(
                  otpSentAddress: _phoneNumberController.text,
                  promptTitle: 'OTP sent to',
                  screenTitle: 'Login using Mobile Number',
                  buttonText: 'Submit',
                  onButtonPressed: (context1, String enteredOtp) async {
                    try {
                      await AuthRepository().mfaPhone(
                          mfaPhoneRequest: MfaPhoneRequest(
                              otp: enteredOtp, validationId: state.validationId));
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyJatya(),
                        ),
                      );
                    } catch (e) {
                      showPopup(context: context, child: const ErrorAlertDialog(error: "Invalid otp"));
                    }
                    return "";
                  },
                  resendOtp: (BuildContext) {},
                ),
              ),
            );
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 50),
                      ...buildIconAndTitle(
                        titleText: 'Login using Mobile Number',
                        height: height * 0.2,
                        context: context,
                      ),
                      SizedBox(height: height * 0.03),
                      Container(
                        padding: const EdgeInsets.only(bottom: 4),
                        width: double.infinity,
                        child: Text(
                          'MOBILE #',
                          style: TextStyle(color: Colors.grey.shade400, fontWeight: FontWeight.bold),
                        ),
                      ),
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const PhoneNumberDropdownMenu(),
                            // Vertical Divider
                            Center(
                              child: Container(
                                height: 16,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    left: BorderSide(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.65,
                              child: BlocBuilder<LoginPhoneBloc, LoginPhoneState>(builder: (context, state) {
                                return Form(
                                  key: formGlobalKey,
                                  child: TextFormField(
                                    validator: (phone) => Validators.phoneValidator(phone),
                                    controller: _phoneNumberController,
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.fromLTRB(6, 4, 4, 4),
                                      hintText: 'Phone Number',
                                    ),
                                    onChanged: (value) => context.read<LoginPhoneBloc>().add(
                                          LoginPhoneNumberChanged(
                                            phoneNumber: value,
                                          ),
                                        ),
                                    keyboardType: TextInputType.number,
                                    // inputFormatters: <TextInputFormatter>[
                                    //   FilteringTextInputFormatter.digitsOnly
                                    // ], // Only numbers can be entered
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      BlocListener<LoginPhoneBloc, LoginPhoneState>(
                        listener: (context, state) {
                          // final formStatus = state.formStatus;
                          if (state is LoginPhoneFailure) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Center(
                                  child: ErrorAlertDialog(
                                    error: state.error.toString(),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                );
                              },
                            );
                          }
                          if (state is LoginPhoneSuccess) {
                            // navigateToOTPScreen(context);
                          }
                        },
                        child: BlocBuilder<LoginPhoneBloc, LoginPhoneState>(
                          builder: (context, state) {
                            if (state.formStatus is InitialFormStatus || state.formStatus is FormSubmissionFailed) {
                              return CustomElevatedButton(
                                onPressed: () {
                                  // print(formGlobalKey.currentState!.validate());
                                  if (formGlobalKey.currentState!.validate()) {
                                    context.read<LoginPhoneBloc>().add(const LoginPhoneSubmitted());
                                  }
                                },
                                horizontalWidth: width * 0.35,
                                verticalWidth: 12,
                                text: 'Send OTP',
                              );
                            }
                            return const CircularProgressIndicator();
                          },
                        ),
                      ),
                      // const Padding(
                      //   padding: EdgeInsets.all(10.0),
                      //   child: Text(
                      //     'or',
                      //     style: TextStyle(fontSize: 14),
                      //   ),
                      // ),
                      // const SocialLoginWidget(),
                      CustomTextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        text: 'Cancel',
                        fontSize: 14,
                      ),
                    ],
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

  // void navigateToOTPScreen(BuildContext context) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => EnterOTPScreen(
  //         otpSentAddress: _phoneNumberController.text,
  //         promptTitle: 'OTP sent to',
  //         screenTitle: 'Login using Mobile Number',
  //         buttonText: 'Submit',
  //         onButtonPressed: (context1, enteredOtps) {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(builder: (context) => BlocProvider(create: (context) => UploadProfilePicBloc(), child: const MyJatya())),
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }
}
