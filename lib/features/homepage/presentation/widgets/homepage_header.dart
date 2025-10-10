import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:operation_kalkan/shared/theme/context_theme_extensions.dart';

class HomepageHeader extends StatelessWidget {
  const HomepageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        return ClipRRect(
          child: SizedBox(
            width: constraints.maxWidth,
            height: 200,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: Image.network(
                    _heroImageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: const SizedBox(),
                  ),
                ),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          colorScheme.surface.withValues(alpha: 0.18),
                          colorScheme.surface.withValues(alpha: 0.45),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Welcome back',
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                        letterSpacing: -0.1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

const _heroImageUrl =
    'https://images.unsplash.com/photo-1507525428034-b723cf961d3e'
    '?auto=format&fit=crop&w=1600&q=80';
