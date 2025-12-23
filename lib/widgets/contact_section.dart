import 'dart:convert';
import 'dart:js' as js;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants/colors.dart';
import '../constants/size.dart';
import '../constants/sns_links.dart';
import '../widgets/custom_text_field.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  static const String serviceId = 'service_wef85gu';
  static const String templateId = 'template_1knmf7j';
  static const String publicKey = 'S5gD-JGD02q904ZVW';

  // Future<void> sendEmail() async {
  //   final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  //   try {
  //     final response = await http.post(
  //       url,
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'origin': 'http://localhost',
  //       },
  //       body: jsonEncode({
  //         'service_id': serviceId,
  //         'template_id': templateId,
  //         'user_id': publicKey,
  //         'template_params': {
  //           'name': nameController.text,
  //           'email': emailController.text,
  //           'message': messageController.text,
  //         },
  //       }),
  //     );
  //     if (response.statusCode == 200) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Message sent successfully ✅')),
  //       );
  //       nameController.clear();
  //       emailController.clear();
  //       messageController.clear();
  //     } else {
  //       throw Exception('Failed to send email');
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(const SnackBar(content: Text('Something went wrong ❌')));
  //     print('Error sending email: $e');
  //   }
  // }
  Future<void> sendEmail() async {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': publicKey,
          'template_params': {
            'name': nameController.text,
            'email': emailController.text,
            'message': messageController.text,
          },
        }),
      );

      print('STATUS: ${response.statusCode}');
      print('BODY: ${response.body}');

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Message sent successfully ✅')),
        );

        nameController.clear();
        emailController.clear();
        messageController.clear();
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      print('EmailJS Error: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Email failed ❌')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 20, 25, 60),
      color: CustomColor.bgLight1,
      child: Column(
        children: [
          const Text(
            "Get in touch",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: CustomColor.whitePrimary,
            ),
          ),

          const SizedBox(height: 50),

          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth >= kMinDesktopWidth) {
                  return Row(
                    children: [
                      Flexible(
                        child: CustomTextField(
                          hintText: "Your name",
                          controller: nameController,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Flexible(
                        child: CustomTextField(
                          hintText: "Your email",
                          controller: emailController,
                        ),
                      ),
                    ],
                  );
                }

                return Column(
                  children: [
                    CustomTextField(
                      hintText: "Your name",
                      controller: nameController,
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      hintText: "Your email",
                      controller: emailController,
                    ),
                  ],
                );
              },
            ),
          ),

          const SizedBox(height: 15),

          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: CustomTextField(
              hintText: "Your message",
              maxLines: 16,
              controller: messageController,
            ),
          ),

          const SizedBox(height: 20),

          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: sendEmail,
                child: const Text(
                  "Send Message",
                  style: TextStyle(color: CustomColor.whitePrimary),
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 300),
            child: Divider(),
          ),
          const SizedBox(height: 15),

          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              _socialIcon("assets/github.png", SnsLinks.github),
              _socialIcon("assets/linkedin.png", SnsLinks.linkedIn),
              _socialIcon("assets/facebook.png", SnsLinks.facebook),
              _socialIcon("assets/instagram.png", SnsLinks.instagram),
              _socialIcon("assets/telegram.png", SnsLinks.telegram),
              _socialIcon("assets/leetCode.png", SnsLinks.leetCode),
            ],
          ),
        ],
      ),
    );
  }

  Widget _socialIcon(String asset, String url) {
    return InkWell(
      onTap: () => js.context.callMethod('open', [url]),
      child: Image.asset(asset, width: 28),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }
}
