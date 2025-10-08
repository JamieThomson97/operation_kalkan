import 'package:flutter/material.dart';

class VendorCollapsedAppBar extends StatelessWidget {
  const VendorCollapsedAppBar({
    required this.visible,
    required this.title,
    required this.onBack,
    this.onFavorite,
    this.onShare,
    super.key,
  });

  final bool visible;
  final String title;
  final VoidCallback onBack;
  final VoidCallback? onFavorite;
  final VoidCallback? onShare;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final media = MediaQuery.of(context);
    final shadows = visible
        ? [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ]
        : const <BoxShadow>[];

    return IgnorePointer(
      ignoring: !visible,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: visible ? 1 : 0,
        child: Container(
          padding: EdgeInsets.only(top: media.padding.top),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            boxShadow: shadows,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: SizedBox(
              height: kToolbarHeight,
              child: Row(
                children: [
                  IconButton(
                    onPressed: onBack,
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Expanded(
                    child: Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    onPressed: onFavorite ?? () {},
                    icon: const Icon(Icons.favorite_border),
                    tooltip: 'Save',
                  ),
                  IconButton(
                    onPressed: onShare ?? () {},
                    icon: const Icon(Icons.share_outlined),
                    tooltip: 'Share',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
