import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:clinic_app/common_components/widgets/common_drawer.dart';
import 'package:clinic_app/common_components/widgets/link_text.dart';
import 'package:clinic_app/modules/Faq/widgets/faq_dialog_box.dart';
import 'package:clinic_app/modules/Faq/widgets/faq_qestion_widget.dart';
import 'package:clinic_app/utils/constants/faq_konstants.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CommonDrawer(),
      appBar: AppBar(
        title: const Text("FAQ"),
        actions: [
          LinkText(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: const FAQDialog(),
                  );
                },
              );
            },
            text: "Need help?",
            textColor: Colors.white,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: faqData.length,
        itemBuilder: (context, index) {
          Map<String, String> faq = faqData[index];
          return FAQQuestion(
            answer: faq['answer']!,
            question: faq['question']!,
          );
        },
      ),
    );
  }
}
