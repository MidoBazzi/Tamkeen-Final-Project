import 'package:flutter/material.dart';
import 'package:service_provider/core/const/app_text_style.dart';

class PolicyItem extends StatelessWidget {
  final String title;
  final String description;

  const PolicyItem({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextStyle.lato4(title, Color(0xFF222B18), 16),
          const SizedBox(height: 16),
          AppTextStyle.lato4(description, Color(0xFF585E69), 14),
        ],
      ),
    );
  }
}
