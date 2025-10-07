import 'package:flutter/material.dart';
import 'package:operation_kalkan/features/homepage/presentation/models/card_item.dart';

class VendorInfoPage extends StatelessWidget {
  const VendorInfoPage({required this.item, super.key});

  static const routeName = 'vendor-info';

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
        title: Text('${item.title} Info'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          _SectionCard(
            title: 'Hours',
            child: Column(
              children: [
                for (var i = 0; i < _weeklyHours.length; i++) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
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
                            fontWeight: FontWeight.w500,
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
          ),
          const SizedBox(height: 16),
          _SectionCard(
            title: 'Contact',
            child: Column(
              children: [
                for (var i = 0; i < _contactDetails.length; i++) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            _contactDetails[i].key,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 3,
                          child: Text(
                            _contactDetails[i].value,
                            textAlign: TextAlign.right,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
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
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
