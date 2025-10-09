import 'package:flutter/material.dart';

/// Displays a network image but falls back to a neutral placeholder if the
/// request fails for any reason.
class SafeNetworkImage extends StatelessWidget {
  const SafeNetworkImage({
    super.key,
    this.imageUrl,
    this.fit,
    this.width,
    this.height,
    this.alignment = Alignment.center,
    this.placeholder,
  });

  final String? imageUrl;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final AlignmentGeometry alignment;
  final Widget? placeholder;

  @override
  Widget build(BuildContext context) {
    Widget buildPlaceholder() {
      return placeholder ??
          Container(
            width: width,
            height: height,
            color: Colors.grey[300],
            alignment: Alignment.center,
            child: const Icon(
              Icons.image_not_supported_outlined,
              color: Colors.white70,
              size: 32,
            ),
          );
    }

    if (imageUrl == null || imageUrl!.isEmpty) {
      return buildPlaceholder();
    }

    try {
      return Image.network(
        imageUrl!,
        fit: fit,
        width: width,
        height: height,
        alignment: alignment,
        errorBuilder: (context, error, stackTrace) => buildPlaceholder(),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return buildPlaceholder();
        },
      );
    } catch (_) {
      return buildPlaceholder();
    }
  }
}

/// Convenience helper for folks who prefer a function interface.
Widget safeNetworkImage({
  String? imageUrl,
  BoxFit? fit,
  double? width,
  double? height,
  AlignmentGeometry alignment = Alignment.center,
  Widget? placeholder,
}) {
  return SafeNetworkImage(
    imageUrl: imageUrl,
    fit: fit,
    width: width,
    height: height,
    alignment: alignment,
    placeholder: placeholder,
  );
}
