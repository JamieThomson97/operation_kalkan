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
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w400,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                style: theme.textTheme.bodyMedium?.copyWith(
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
