import 'package:flutter/material.dart';
import 'package:operation_kalkan/shared/theme/context_theme_extensions.dart';

class PlanLocalTipsCard extends StatelessWidget {
  const PlanLocalTipsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primary.withValues(alpha: 0.95),
            colorScheme.primaryContainer.withValues(alpha: 0.9),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Local intel',
              style: textTheme.labelLarge?.copyWith(
                color: colorScheme.onPrimary,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Catch the harbor golden hour from the Lighthouse promenade—barista Onur keeps cold brew ready for you.',
              style: textTheme.titleMedium?.copyWith(
                color: colorScheme.onPrimary,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 18),
            TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: colorScheme.onPrimary,
                backgroundColor: colorScheme.onPrimary.withValues(alpha: 0.08),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {},
              icon: const Icon(Icons.map_outlined),
              label: const Text('Open in map'),
            ),
          ],
        ),
      ),
    );
  }
}
