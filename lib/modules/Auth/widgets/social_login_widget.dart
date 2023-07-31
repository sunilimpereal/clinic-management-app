import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:clinic_app/modules/Auth/model/login/user_object.dart';
import 'package:clinic_app/modules/Auth/services/social_signin_repository.dart';
import 'package:clinic_app/modules/Auth/widgets/social_media_login_button.dart';
import 'package:clinic_app/modules/MyJatya/screens/MyJatya.dart';

import '../../../common_components/widgets/error_alert_dialog.dart';
import '../../../common_components/widgets/popup_widget.dart';
import '../../../utils/constants/image_konstants.dart';

class SocialLoginWidget extends StatefulWidget {
  const SocialLoginWidget({super.key});

  @override
  State<SocialLoginWidget> createState() => _SocialLoginWidgetState();
}

class _SocialLoginWidgetState extends State<SocialLoginWidget> {
  bool logoutUser = false;
  @override
  Widget build(BuildContext context) {
    UserObject user =
        UserObject(firstName: '', lastName: '', email: '', profileImageUrl: '');
    return Row(
      mainAxisAlignment: Platform.isIOS
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.center,
      children: [
        // SocialMediaLoginButton(
        //   iconImage: ImagesConstants.facebook,
        //   onPressed: () async {
        //     SocialMediaSignInRepository repoObj = SocialMediaSignInRepository();
        //     final resp = await repoObj.facebookSignIn();
        //     if (resp.runtimeType == AuthCredential) {
        //       log('$resp');
        //     } else if (resp != null) {
        //       if (context.mounted) {
        //         showPopup(
        //           context: context,
        //           child: ErrorAlertDialog(error: resp.toString()),
        //         );
        //       }
        //     }
        //     // TODO: Send token from resp to Backend
        //   },
        // ),
        SocialMediaLoginButton(
          iconImage: ImagesConstants.google,
          onPressed: () async {
            SocialMediaSignInRepository repoObj = SocialMediaSignInRepository();
            final resp = await repoObj.googleSignIn();
            print('${resp.runtimeType}olleh');
            if (resp.runtimeType == GoogleSignInAccount) {
              log('$resp');
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyJatya(),
                ),
              );
            } else if (resp != null) {
              if (context.mounted) {
                showPopup(
                  context: context,
                  child: ErrorAlertDialog(error: resp.toString()),
                );
              }
            }

            // AuthRepository().socialMediaLogin(url: ApiConstants.googleLogin);
            // TODO: Send token from resp to Backend
          },
        ),
        Platform.isIOS
            ? SocialMediaLoginButton(
                iconImage: ImagesConstants.apple,
                onPressed: () async {
                  SocialMediaSignInRepository repoObj =
                      SocialMediaSignInRepository();
                  final resp = await repoObj.appleSignIn();
                  if (resp.runtimeType == AuthCredential) {
                    log('$resp');
                  } else if (resp != null) {
                    if (context.mounted) {
                      showPopup(
                        context: context,
                        child: ErrorAlertDialog(error: resp.toString()),
                      );
                    }
                  }
                  // TODO: Send token from resp to Backend
                },
              )
            : Container(),
        // SocialMediaLoginButton(
        //   iconImage: ImagesConstants.linkedin,
        //   onPressed: () async {
        //     UserObject? user =
        //         await SocialMediaSignInRepository().linkedinSignIn(context);
        //     if (user != null) print('${user.lastName}hello');
        //     setState(() {
        //       logoutUser = false;
        //     });

        //     // Navigator.of(context).pop();
        //     // Navigator.pushReplacement(
        //     //   context,
        //     //   MaterialPageRoute(
        //     //     builder: (context) => const MyJatya(),
        //     //   ),
        //     // );
        //   },
        // ),
        SocialMediaLoginButton(
          iconImage: ImagesConstants.twitter,
          onPressed: () async {
            SocialMediaSignInRepository repoObj = SocialMediaSignInRepository();
            final resp = await repoObj.twitterSignIn();
            if (resp.runtimeType == AuthCredential) {
              log('$resp');
            } else if (resp != null) {
              if (context.mounted) {
                showPopup(
                  context: context,
                  child: ErrorAlertDialog(error: resp.toString()),
                );
              }
            }

            // TODO: Send token from resp to Backend
          },
        ),
      ],
    );
  }
}
