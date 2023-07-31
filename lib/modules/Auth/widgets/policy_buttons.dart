import 'package:flutter/material.dart';
import 'package:clinic_app/common_components/app_info_screen.dart';
import 'package:clinic_app/common_components/widgets/policy_dialog.dart';
import 'package:clinic_app/modules/Auth/widgets/terms_and_copyright_widget.dart';

class PolicyButtons extends StatelessWidget {
  const PolicyButtons({super.key});

  showPolicyDialog(String text, String title, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PolicyDialog(
          isAboutApp: false,
          titleText: title,
          text: text,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...buildTermsAndCopyrightWidget(
          termsOnPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AppInfoScreen(
                    title: 'Terms & Conditions',
                    filePath: "assets/app_info_doc/Jatya_T&C.pdf"),
              )),
          // showPolicyDialog(
          //     TermsConstants.termsAndConditions, 'Terms & Conditions', context),
          privacyOnPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AppInfoScreen(
                    title: 'Privacy Policy',
                    filePath: "assets/app_info_doc/Privacy-policy.pdf"),
              )),
          // showPolicyDialog(
          //     TermsConstants.privacyPolicy, 'Privacy Policy', context),
          cookieOnPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AppInfoScreen(
                    title: 'Cookie Policy',
                    filePath: "assets/app_info_doc/Cookie-Policy_Jatya.pdf"),
              )),
          // showPolicyDialog(
          //     TermsConstants.cookiePolicy, 'Cookie Policy', context),
        )
      ],
    );
  }
}
