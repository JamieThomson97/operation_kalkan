import 'package:flutter/material.dart';
import 'package:operation_kalkan/shared/theme/context_theme_extensions.dart';

class HomepageBulletText extends StatelessWidget {
  const HomepageBulletText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('• '),
        Expanded(
          child: Text(
            text,
            style: textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
