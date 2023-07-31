// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jatya_patient_mobile/common_components/widgets/popup_widget.dart';
import 'package:jatya_patient_mobile/modules/Auth/screens/login_screen.dart';
import 'package:jatya_patient_mobile/modules/Auth/widgets/custom_text_button.dart';
import 'package:jatya_patient_mobile/modules/Auth/widgets/otp_form.dart';
import 'package:jatya_patient_mobile/modules/Auth/widgets/policy_buttons.dart';
import '../../../common_components/widgets/error_alert_dialog.dart';
import '../../../utils/constants/image_konstants.dart';
import '../bloc/forgot_password_bloc/forgot_password_bloc.dart';
import '../widgets/custom_elevated_button.dart';

class EnterOTPScreen extends StatefulWidget {
  final String otpSentAddress;
  final String screenTitle;
  final String promptTitle;
  final String buttonText;
  Function(BuildContext) resendOtp;
  Future<String> Function(BuildContext, String) onButtonPressed;
  EnterOTPScreen(
      {Key? key,
      required this.otpSentAddress,
      required this.screenTitle,
      required this.promptTitle,
      required this.buttonText,
      required this.onButtonPressed,
      required this.resendOtp})
      : super(key: key);

  @override
  State<EnterOTPScreen> createState() => _EnterOTPScreenState();
}

class _EnterOTPScreenState extends State<EnterOTPScreen> {
  String otp = "";
  @override
  Widget build(BuildContext context) {
    var devicesize = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
        builder: (context, state) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 50),
                    Image.asset(
                      ImagesConstants.jatyaLogoName,
                      height: devicesize.height * 0.14,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 28),
                    Text(
                      widget.screenTitle,
                      style: const TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: height * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            '${widget.promptTitle} ${widget.otpSentAddress}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        CustomTextButton(
                          onPressed: () {
                            widget.resendOtp(context);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('OTP resent'),
                            ));
                          },
                          text: 'Resend OTP',
                          fontSize: 14,
                          color: Colors.blue[900],
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'ENTER OTP',
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    OTPForm(
                      width: 48,
                      height: 44,
                      onChanged: (value) {
                        setState(() {
                          otp = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: height * 0.06,
                    ),
                    CustomElevatedButton(
                      onPressed: () async {
                        if (otp.length < 6) {
                          showPopup(
                              context: context,
                              child: const ErrorAlertDialog(
                                  error: "Enter a valid otp"));
                        } else {
                          String error =
                              await widget.onButtonPressed(context, otp);
                          log("message");
                          if (error != "") {
                            showPopup(
                                context: context,
                                child: ErrorAlertDialog(error: error));
                          }
                        }
                      },
                      horizontalWidth: width * 0.36,
                      verticalWidth: 12,
                      text: widget.buttonText,
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
                      text: 'Back to Login',
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                    ),
                  ],
                ),
                const PolicyButtons()
              ],
            ),
          ),
        ),
      );
    });
  }
}
