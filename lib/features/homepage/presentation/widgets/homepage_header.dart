import 'package:flutter/material.dart';
import 'package:operation_kalkan/shared/theme/context_theme_extensions.dart';

class HomepageHeader extends StatelessWidget {
  const HomepageHeader({
    super.key,
    this.userName = 'Jamie',
    this.onProfilePressed,
    this.profileImageProvider = const NetworkImage(_exampleProfileImageUrl),
  });

  final String userName;
  final VoidCallback? onProfilePressed;
  final ImageProvider<Object>? profileImageProvider;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    final topPadding = MediaQuery.of(context).padding.top;

    return Container(
      width: double.infinity,
      color: const Color(0xFFF8F6F1),
      padding: EdgeInsets.fromLTRB(
        24,
        topPadding + 16,
        24,
        16,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Welcome back, $userName',
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
                letterSpacing: -0.2,
              ),
            ),
          ),
          _ProfileButton(
            colorScheme: colorScheme,
            profileImageProvider: profileImageProvider,
            onPressed: onProfilePressed,
          ),
        ],
      ),
    );
  }
}

const _exampleProfileImageUrl =
    'https://images.unsplash.com/photo-1517841905240-472988babdf9'
    '?auto=format&fit=facearea&facepad=2&w=256&h=256&q=80';

class _ProfileButton extends StatelessWidget {
  const _ProfileButton({
    required this.colorScheme,
    required this.profileImageProvider,
    required this.onPressed,
  });

  final ColorScheme colorScheme;
  final ImageProvider<Object>? profileImageProvider;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: CircleAvatar(
          radius: 24,
          backgroundColor: colorScheme.primaryContainer,
          foregroundImage: profileImageProvider,
          child: profileImageProvider == null
              ? Icon(
                  Icons.person_outline,
                  color: colorScheme.primary,
                )
              : null,
        ),
      ),
    );
  }
}
