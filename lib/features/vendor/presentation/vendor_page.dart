import 'package:flutter/material.dart';
import 'package:operation_kalkan/features/homepage/presentation/models/card_item.dart';

class VendorPage extends StatelessWidget {
  const VendorPage({required this.item, super.key});

  static const routeName = 'vendor';

  final CardItem item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: 16 / 9,
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
          const SizedBox(height: 16),
          Text(
            item.subtitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          const Text(
            'More details coming soon...',
          ),
        ],
      ),
    );
  }
}
