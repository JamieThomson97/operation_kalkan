import 'package:flutter/material.dart';
import 'package:operation_kalkan/features/homepage/presentation/models/card_item.dart';

class VendorPage extends StatelessWidget {
  const VendorPage({required this.item, super.key});

  static const routeName = 'vendor';
  static const _weeklyHours = <MapEntry<String, String>>[
    MapEntry('Monday', '8 AM - 6 PM'),
    MapEntry('Tuesday', '8 AM - 6 PM'),
    MapEntry('Wednesday', '8 AM - 6 PM'),
    MapEntry('Thursday', '8 AM - 6 PM'),
    MapEntry('Friday', '8 AM - 6 PM'),
    MapEntry('Saturday', '8 AM - 6 PM'),
    MapEntry('Sunday', '8 AM - 6 PM'),
  ];
  static const _contactDetails = <MapEntry<String, String>>[
    MapEntry('Phone', '(555) 123-4567'),
    MapEntry('Address', '123 Market Street, Springfield'),
    MapEntry('Website', 'www.thecozycorner.com'),
    MapEntry('Email', 'hello@thecozycorner.com'),
  ];
  static const _photoGallery = <_PhotoResource>[
    _PhotoResource(
      'https://images.unsplash.com/photo-1504753793650-d4a2b783c15e?auto=format&fit=crop&w=1200&q=80',
    ),
    _PhotoResource(
      'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=1200&q=80',
    ),
    _PhotoResource(
      'https://images.unsplash.com/photo-1466978913421-dad2ebd01d17?auto=format&fit=crop&w=1200&q=80',
    ),
    _PhotoResource(
      'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=1200&q=80',
    ),
    _PhotoResource(
      'https://images.unsplash.com/photo-1525610553991-2bede1a236e2?auto=format&fit=crop&w=1200&q=80',
    ),
    _PhotoResource(
      'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?auto=format&fit=crop&w=1200&q=80',
    ),
  ];

  final CardItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final media = MediaQuery.of(context);
    final heroHeight = media.size.height * 0.35;
    final photoGroups = [
      for (var i = 0; i < _photoGallery.length; i += 3)
        _photoGallery.sublist(
          i,
          i + 3 > _photoGallery.length ? _photoGallery.length : i + 3,
        ),
    ];

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: heroHeight,
                width: double.infinity,
                child: _buildHeroImage(item.image),
              ),
              Transform.translate(
                offset: const Offset(0, -24),
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: .05),
                        blurRadius: 18,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.title,
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 12),
                          FilledButton(
                            onPressed: () {},
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.black87,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: const Text('Book'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.subtitle,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildInfoRow(theme),
                      const SizedBox(height: 24),
                      Text(
                        'Hours',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        children: [
                          for (var i = 0; i < _weeklyHours.length; i++) ...[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 6,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _weeklyHours[i].key,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Text(
                                    _weeklyHours[i].value,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (i != _weeklyHours.length - 1)
                              Divider(
                                height: 1,
                                thickness: 1,
                                color: theme.dividerColor.withOpacity(0.2),
                              ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Contact',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        children: [
                          for (var i = 0; i < _contactDetails.length; i++) ...[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 6,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _contactDetails[i].key,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Text(
                                      _contactDetails[i].value,
                                      textAlign: TextAlign.right,
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w400,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (i != _contactDetails.length - 1)
                              Divider(
                                height: 1,
                                thickness: 1,
                                color: theme.dividerColor.withOpacity(0.2),
                              ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Photos',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('View All'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 240,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(right: 8),
                          itemCount: photoGroups.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 8),
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
                                    child: _buildPhotoTile(
                                      context,
                                      photo: group.first,
                                      heroTag: 'photo-${groupIndex * 3}',
                                    ),
                                  ),
                                  if (group.length > 1) ...[
                                    const SizedBox(width: 8),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: _buildPhotoTile(
                                              context,
                                              photo: group[1],
                                              heroTag:
                                                  'photo-${groupIndex * 3 + 1}',
                                            ),
                                          ),
                                          if (group.length > 2) ...[
                                            const SizedBox(height: 8),
                                            Expanded(
                                              child: _buildPhotoTile(
                                                context,
                                                photo: group[2],
                                                heroTag:
                                                    'photo-${groupIndex * 3 + 2}',
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
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
              SizedBox(height: media.padding.bottom + 16),
            ],
          ),
          Positioned(
            top: media.padding.top + 16,
            left: 16,
            child: _buildFloatingBackButton(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroImage(String? imageUrl) {
    if (imageUrl != null) {
      return Image.network(
        imageUrl,
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

  Widget _buildFloatingBackButton(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IconButton(
        onPressed: () => Navigator.of(context).maybePop(),
        icon: const Icon(Icons.arrow_back),
        color: Colors.black87,
      ),
    );
  }

  Widget _buildInfoRow(ThemeData theme) {
    final dividerColor = theme.dividerColor.withOpacity(0.2);
    final labelStyle = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurface.withOpacity(0.7),
      fontWeight: FontWeight.w400,
      fontSize: 12,
    );
    final valueStyle = theme.textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.w600,
    );
    final secondaryValueStyle = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurface.withOpacity(0.65),
      fontWeight: FontWeight.w400,
      height: 1.2,
    );

    Widget buildCell({
      required Widget child,
      bool showDivider = true,
    }) {
      return Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              right: showDivider
                  ? BorderSide(color: dividerColor, width: 0.8)
                  : BorderSide.none,
            ),
          ),
          child: child,
        ),
      );
    }

    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.zero,
      ),
      child: Row(
        children: [
          buildCell(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Rating', style: labelStyle),
                const SizedBox(height: 6),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, color: Colors.amber[600], size: 18),
                    const SizedBox(width: 6),
                    Text('4.8', style: valueStyle),
                  ],
                ),
                const SizedBox(height: 4),
                Text('500+ reviews', style: secondaryValueStyle),
              ],
            ),
          ),
          buildCell(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  size: 18,
                  color: labelStyle?.color,
                ),
                const SizedBox(height: 6),
                Text('Info and Contact', style: labelStyle),
              ],
            ),
          ),
          buildCell(
            showDivider: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Distance', style: labelStyle),
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.directions_walk,
                      size: 18,
                      color: labelStyle?.color,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        '0.5 mi',
                        style: valueStyle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoTile(
    BuildContext context, {
    required _PhotoResource photo,
    required String heroTag,
  }) {
    return GestureDetector(
      onTap: () => _showPhotoLightbox(context, photo.url, heroTag),
      child: Hero(
        tag: heroTag,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Image.network(
            photo.url,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    );
  }

  void _showPhotoLightbox(
    BuildContext context,
    String imageUrl,
    String heroTag,
  ) {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.92),
      builder: (dialogContext) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.of(dialogContext).pop(),
          child: SafeArea(
            child: Stack(
              children: [
                Center(
                  child: Hero(
                    tag: heroTag,
                    child: InteractiveViewer(
                      minScale: 0.8,
                      maxScale: 4,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.black54,
                    ),
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
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

class _PhotoResource {
  const _PhotoResource(this.url);

  final String url;
}
