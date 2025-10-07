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

  final CardItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          ClipRRect(
            child: AspectRatio(
              aspectRatio: 16 / 10,
              child: item.image != null
                  ? Image.network(item.image!, fit: BoxFit.cover)
                  : Container(
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.photo,
                        size: 80,
                        color: Colors.white70,
                      ),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(
                  item.title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.subtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w300,
                  ),
                ),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          color: theme.dividerColor.withValues(alpha: 0.2),
                        ),
                    ],
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
