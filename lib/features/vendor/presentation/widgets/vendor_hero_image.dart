import 'package:flutter/material.dart';

class VendorHeroImage extends StatelessWidget {
  const VendorHeroImage({
    super.key,
    this.imageUrl,
  });

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    Widget buildBase() {
      if (imageUrl != null) {
        return Image.network(
          imageUrl!,
          fit: BoxFit.cover,
        );
      }

      return Container(
        color: Colors.grey[300],
        child: const Center(
          child: Icon(
            Icons.photo,
            size: 80,
            color: Colors.white70,
          ),
        ),
      );
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(child: buildBase()),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.35),
                  Colors.black.withValues(alpha: 0.12),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
