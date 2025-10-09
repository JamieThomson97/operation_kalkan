import 'package:flutter/material.dart';
import 'package:operation_kalkan/features/vendor/data/vendor_static_content.dart';
import 'package:operation_kalkan/shared/widgets/safe_network_image.dart';

typedef VendorPhotoTapCallback =
    void Function(
      VendorPhotoResource photo,
      String heroTag,
    );

class VendorPhotoGallery extends StatelessWidget {
  const VendorPhotoGallery({
    required this.photos,
    required this.onPhotoTap,
    super.key,
  });

  final List<VendorPhotoResource> photos;
  final VendorPhotoTapCallback onPhotoTap;

  @override
  Widget build(BuildContext context) {
    final photoGroups = [
      for (var i = 0; i < photos.length; i += 3)
        photos.sublist(
          i,
          i + 3 > photos.length ? photos.length : i + 3,
        ),
    ];

    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(right: 8),
        itemCount: photoGroups.length,
        separatorBuilder: (context, _) => const SizedBox(width: 8),
        itemBuilder: (context, groupIndex) {
          final group = photoGroups[groupIndex];
          if (group.isEmpty) {
            return const SizedBox.shrink();
          }

          return SizedBox(
            width: 320,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: VendorPhotoTile(
                    photo: group.first,
                    heroTag: 'photo-${groupIndex * 3}',
                    onTap: onPhotoTap,
                  ),
                ),
                if (group.length > 1) ...[
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: VendorPhotoTile(
                            photo: group[1],
                            heroTag: 'photo-${groupIndex * 3 + 1}',
                            onTap: onPhotoTap,
                          ),
                        ),
                        if (group.length > 2) ...[
                          const SizedBox(height: 8),
                          Expanded(
                            child: VendorPhotoTile(
                              photo: group[2],
                              heroTag: 'photo-${groupIndex * 3 + 2}',
                              onTap: onPhotoTap,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class VendorPhotoTile extends StatelessWidget {
  const VendorPhotoTile({
    required this.photo,
    required this.heroTag,
    required this.onTap,
    super.key,
  });

  final VendorPhotoResource photo;
  final String heroTag;
  final VendorPhotoTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Hero(
      tag: heroTag,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => onTap(photo, heroTag),
          splashColor: theme.colorScheme.primary.withValues(alpha: 0.1),
          highlightColor: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
            ),
            child: SafeNetworkImage(
              imageUrl: photo.url,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
      ),
    );
  }
}
