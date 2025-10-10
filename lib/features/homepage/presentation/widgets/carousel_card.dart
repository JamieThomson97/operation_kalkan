import 'package:flutter/material.dart';
import 'package:operation_kalkan/features/homepage/presentation/models/card_item.dart';
import 'package:operation_kalkan/shared/theme/context_theme_extensions.dart';
import 'package:operation_kalkan/shared/widgets/safe_network_image.dart';

class CarouselCard extends StatelessWidget {
  const CarouselCard({
    required this.item,
    this.onTap,
    super.key,
  });

  final CardItem item;
  final ValueChanged<CardItem>? onTap;

  @override
  Widget build(BuildContext context) {
    const imageRadius = Radius.circular(8);
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;
    final subtleTextColor = colorScheme.onSurface.withValues(alpha: 0.65);

    return SizedBox(
      width: 200,
      child: Material(
        color: colorScheme.surface,
        child: InkWell(
          onTap: onTap == null ? null : () => onTap!(item),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(imageRadius),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: SafeNetworkImage(
                    imageUrl: item.image,
                    fit: BoxFit.cover,
                    placeholder: ColoredBox(
                      color: colorScheme.surfaceContainerHighest,
                      child: Icon(
                        Icons.photo,
                        size: 64,
                        color: colorScheme.onSurface.withValues(alpha: 0.4),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 9, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.subtitle,
                      style: textTheme.bodySmall?.copyWith(
                        color: subtleTextColor,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
