import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.primary,
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          child: const Text('See all'),
        ),
      ],
    );
  }
}
