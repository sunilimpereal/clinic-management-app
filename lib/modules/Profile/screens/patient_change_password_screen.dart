import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common_components/widgets/error_alert_dialog.dart';
import '../../../common_components/widgets/password_textfield.dart';
import '../../../common_components/widgets/popup_widget.dart';
import '../../../utils/constants/color_konstants.dart';
import '../../../utils/helper/helper.dart';
import '../../Auth/services/validators.dart';
import '../bloc/patient_change_password_bloc/patient_change_password_bloc.dart';
import '../models/patient_change_password_request_model.dart';

class PatientChangePasswordScreen extends StatefulWidget {
  final String userId;
  const PatientChangePasswordScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);
  @override
  State<PatientChangePasswordScreen> createState() =>
      _PatientChangePasswordScreenState();
}

class _PatientChangePasswordScreenState
    extends State<PatientChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorKonstants.primaryColor,
        title: Text(
          "Change Password",
          style: TextStyle(color: ColorKonstants.primarySwatch.shade50),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          BlocListener<PatientChangePassBloc, PatientChangePassState>(
            listener: (context, state) {
              if (state is PatientChangePassLoadingState) {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    });
                return;
              } else if (state is PatientChangePassSuccessState) {
                Navigator.pop(context);
                Navigator.pop(context);
                // Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //         builder: ((context) =>
                //             const PatientProfilePage(apiCall: false))));
                WidgetHelper.showToast("Password Succesfully Updated!");
                return;
              } else if (state is PatientChangePassErrorState) {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) => Center(
                    child: ErrorAlertDialog(error: state.err),
                  ),
                );
                return;
              }
            },
            child: IconButton(
              onPressed: () {
                submitButton();
              },
              icon: const Icon(Icons.done),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(32, 32, 32, 65),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PasswordTextField(
                      validator: (password) =>
                          Validators.passwordValidator(password),
                      labelText: 'CURRENT PASSWORD',
                      textEditingController: _oldPasswordController,
                      hintText: 'Enter Current Password',
                      onchanged: (value) {}),
                  const SizedBox(
                    height: 20,
                  ),
                  PasswordTextField(
                      validator: (password) =>
                          Validators.passwordValidator(password),
                      labelText: 'NEW PASSWORD',
                      textEditingController: _newPasswordController,
                      hintText: 'Enter New Password',
                      onchanged: (value) {}),
                  const SizedBox(
                    height: 20,
                  ),
                  PasswordTextField(
                      validator: (password) =>
                          Validators.passwordValidator(password),
                      labelText: 'CONFIRM PASSWORD',
                      textEditingController: _confirmPasswordController,
                      hintText: 'Re enter New Password',
                      onchanged: (value) {}),
                ],
              )),
        ),
      ),
    );
  }

  void submitButton() {
    if (_formKey.currentState!.validate()) {
      if (_newPasswordController.text == _confirmPasswordController.text) {
        BlocProvider.of<PatientChangePassBloc>(context).add(
            PatientChangePassEvent(
                userId: widget.userId,
                PatientChangePassRequest: PatientChangePassRequestModel(
                    oldPassword: _oldPasswordController.text,
                    password: _newPasswordController.text)));
      } else {
        showPopup(
          context: context,
          child: const ErrorAlertDialog(
              error: "New password doesn't match with confirm password!"),
        );
      }
    }
  }
}
