import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:operation_kalkan/features/homepage/presentation/homepage.dart';
import 'package:operation_kalkan/features/homepage/presentation/models/card_item.dart';
import 'package:operation_kalkan/features/vendor/presentation/vendor_info_page.dart';
import 'package:operation_kalkan/features/vendor/presentation/vendor_page.dart';

final goRouterProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const Homepage(),
      ),
      GoRoute(
        path: '/vendor',
        name: VendorPage.routeName,
        builder: (context, state) {
          final extra = state.extra;
          if (extra is! CardItem) {
            return const _MissingVendorView();
          }

          return VendorPage(item: extra);
        },
      ),
      GoRoute(
        path: '/vendor/info',
        name: VendorInfoPage.routeName,
        builder: (context, state) {
          final extra = state.extra;
          if (extra is! CardItem) {
            return const _MissingVendorView();
          }

          return VendorInfoPage(item: extra);
        },
      ),
    ],
  ),
);

class _MissingVendorView extends StatelessWidget {
  const _MissingVendorView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Vendor details not available.'),
      ),
    );
  }
}
