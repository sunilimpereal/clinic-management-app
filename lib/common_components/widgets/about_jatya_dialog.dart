// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:clinic_app/common_components/app_info_screen.dart';

import 'package:clinic_app/modules/Auth/widgets/custom_text_button.dart';
import 'package:clinic_app/utils/constants/terms_konstants.dart';
import 'package:clinic_app/utils/helper/helper.dart';

import '../../utils/constants/image_konstants.dart';

class AboutJatyaDialog extends StatelessWidget {
  final String text;
  final String titleText;
  final bool isAboutApp;
  const AboutJatyaDialog({
    Key? key,
    required this.text,
    required this.titleText,
    required this.isAboutApp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.67,
        child: Stack(
          children: [
            AlertDialog(
              title: Padding(
                padding: const EdgeInsets.only(top: 14.0),
                child: Text(titleText),
              ),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(text),
                    const SizedBox(height: 8.0),
                    if (isAboutApp)
                      CustomTextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AppInfoScreen(
                                    title: 'Terms & Conditions',
                                    filePath:
                                        "assets/app_info_doc/Jatya_T&C.pdf"),
                              ));
                        },
                        text: 'Terms & Conditions',
                        fontSize: 14,
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    if (isAboutApp)
                      CustomTextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AppInfoScreen(
                                    title: 'Privacy Policy',
                                    filePath:
                                        "assets/app_info_doc/Privacy-policy.pdf"),
                              ));
                        },
                        text: 'Privacy Policy',
                        fontSize: 14,
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    if (isAboutApp)
                      CustomTextButton(
                        onPressed: () {
                          WidgetHelper.showToast("Coming soon");
                        },
                        text: 'Cookie Policy',
                        fontSize: 14,
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    if (isAboutApp)
                      CustomTextButton(
                        onPressed: () {
                           Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AppInfoScreen(
                                    title: 'Disclaimer',
                                    filePath:
                                        "assets/app_info_doc/Privacy-policy.pdf"),
                              ));
                        },
                        text: 'Disclaimer',
                        fontSize: 14,
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    const SizedBox(height: 8.0),
                    if (isAboutApp)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Icon(
                            Icons.copyright,
                            size: 16,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            'Copyright 2023-2024 Jatya Inc.',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              actions: [
                Center(
                  child: CustomTextButton(
                    onPressed: () => Navigator.pop(context),
                    text: 'Close',
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            Positioned(
                left: MediaQuery.of(context).size.width * 0.43,
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    ImagesConstants.jatyalogoCircular,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
