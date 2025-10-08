import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:operation_kalkan/features/homepage/presentation/models/card_item.dart';
import 'package:operation_kalkan/features/vendor/data/vendor_static_content.dart';
import 'package:operation_kalkan/features/vendor/presentation/vendor_info_page.dart';
import 'package:operation_kalkan/features/vendor/presentation/widgets/vendor_collapsed_app_bar.dart';
import 'package:operation_kalkan/features/vendor/presentation/widgets/vendor_floating_back_button.dart';
import 'package:operation_kalkan/features/vendor/presentation/widgets/vendor_hero_image.dart';
import 'package:operation_kalkan/features/vendor/presentation/widgets/vendor_info_section.dart';
import 'package:operation_kalkan/features/vendor/presentation/widgets/vendor_menu_content.dart';
import 'package:operation_kalkan/features/vendor/presentation/widgets/vendor_menu_tabs.dart';
import 'package:operation_kalkan/features/vendor/presentation/widgets/vendor_photo_gallery.dart';

class VendorPage extends StatefulWidget {
  const VendorPage({required this.item, super.key});

  static const routeName = 'vendor';

  final CardItem item;

  @override
  State<VendorPage> createState() => _VendorPageState();
}

class _VendorPageState extends State<VendorPage> {
  static const _collapsedThreshold = 160.0;

  late final ScrollController _scrollController;
  bool _showCollapsedBar = false;
  bool _showMenuTabs = false;
  int _activeCategoryIndex = 0;
  double? _menuSectionOffset;

  final GlobalKey _menuSectionKey = GlobalKey();
  late final List<GlobalKey> _categoryKeys;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_handleScroll);
    _categoryKeys = List.generate(
      vendorMenuCategories.length,
      (_) => GlobalKey(),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => _cacheMenuOffset());
  }

  void _handleScroll() {
    final shouldShowCollapsed = _scrollController.offset >= _collapsedThreshold;

    var menuOffset = _menuSectionOffset;
    if (menuOffset == null) {
      _cacheMenuOffset();
      menuOffset = _menuSectionOffset;
    }

    final paddingTop = MediaQuery.of(context).padding.top;
    final collapsedHeight = shouldShowCollapsed ? kToolbarHeight : 0.0;
    final stickyThreshold = menuOffset != null
        ? menuOffset - (paddingTop + collapsedHeight + 56)
        : double.infinity;
    final shouldShowTabs =
        menuOffset != null && _scrollController.offset >= stickyThreshold;

    var newActiveIndex = _activeCategoryIndex;
    if (shouldShowTabs) {
      final anchor = paddingTop + collapsedHeight + 64;
      final candidate = _determineActiveCategory(anchor);
      if (candidate != null) {
        newActiveIndex = candidate;
      }
    }

    if (shouldShowCollapsed != _showCollapsedBar ||
        shouldShowTabs != _showMenuTabs ||
        newActiveIndex != _activeCategoryIndex) {
      setState(() {
        _showCollapsedBar = shouldShowCollapsed;
        _showMenuTabs = shouldShowTabs;
        _activeCategoryIndex = newActiveIndex;
      });
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_handleScroll)
      ..dispose();
    super.dispose();
  }

  void _cacheMenuOffset() {
    if (!mounted) {
      return;
    }
    final context = _menuSectionKey.currentContext;
    if (context == null) {
      return;
    }
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) {
      return;
    }
    final listOffset = renderBox.localToGlobal(Offset.zero).dy;
    final scrollOffset = _scrollController.hasClients
        ? _scrollController.offset
        : 0;
    _menuSectionOffset = listOffset + scrollOffset;
  }

  int? _determineActiveCategory(double anchorY) {
    int? activeIndex;
    for (var i = 0; i < _categoryKeys.length; i++) {
      final context = _categoryKeys[i].currentContext;
      if (context == null) {
        continue;
      }
      final renderBox = context.findRenderObject() as RenderBox?;
      if (renderBox == null) {
        continue;
      }
      final top = renderBox.localToGlobal(Offset.zero).dy;
      if (top <= anchorY) {
        activeIndex = i;
      } else if (activeIndex != null) {
        break;
      } else {
        return 0;
      }
    }

    return activeIndex ?? 0;
  }

  void _handleMenuTabTap(int index) {
    if (index < 0 || index >= _categoryKeys.length) {
      return;
    }
    final targetContext = _categoryKeys[index].currentContext;
    if (targetContext == null) {
      return;
    }
    unawaited(
      Scrollable.ensureVisible(
        targetContext,
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final media = MediaQuery.of(context);
    final heroHeight = media.size.height * 0.35;

    WidgetsBinding.instance.addPostFrameCallback((_) => _cacheMenuOffset());

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Stack(
        children: [
          ListView(
            controller: _scrollController,
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: heroHeight,
                width: double.infinity,
                child: VendorHeroImage(imageUrl: widget.item.image),
              ),
              Transform.translate(
                offset: const Offset(0, -24),
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 28,
                        offset: const Offset(0, -6),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              widget.item.title,
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
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
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text('Book'),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                height: 3,
                                width: 26,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.item.subtitle,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: theme.dividerColor.withValues(alpha: 0.2),
                      ),
                      const SizedBox(height: 16),
                      VendorInfoSection(
                        onInfoTap: () => _openVendorInfo(context),
                      ),
                      const SizedBox(height: 16),
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: theme.dividerColor.withValues(alpha: 0.2),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      VendorPhotoGallery(
                        photos: vendorPhotoGallery,
                        onPhotoTap: (photo, heroTag) => _showPhotoLightbox(
                          context,
                          photo.url,
                          heroTag,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: theme.dividerColor.withValues(alpha: 0.2),
                      ),
                      const SizedBox(height: 24),
                      VendorMenuContent(
                        categories: vendorMenuCategories,
                        menuSectionKey: _menuSectionKey,
                        categoryKeys: _categoryKeys,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: media.padding.bottom + 16),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: VendorCollapsedAppBar(
              visible: _showCollapsedBar,
              title: widget.item.title,
              onBack: () => Navigator.of(context).maybePop(),
            ),
          ),
          Positioned(
            top: media.padding.top + (_showCollapsedBar ? kToolbarHeight : 16),
            left: 0,
            right: 0,
            child: VendorMenuTabs(
              visible: _showMenuTabs,
              categories: vendorMenuCategories,
              activeIndex: _activeCategoryIndex,
              onCategorySelected: _handleMenuTabTap,
            ),
          ),
          Positioned(
            top: media.padding.top + 16,
            left: 16,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 180),
              opacity: _showCollapsedBar ? 0 : 1,
              child: IgnorePointer(
                ignoring: _showCollapsedBar,
                child: VendorFloatingBackButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openVendorInfo(BuildContext context) {
    unawaited(
      context.pushNamed(VendorInfoPage.routeName, extra: widget.item),
    );
  }

  void _showPhotoLightbox(
    BuildContext context,
    String imageUrl,
    String heroTag,
  ) {
    unawaited(
      showDialog<void>(
        context: context,
        barrierColor: Colors.black.withValues(alpha: 0.92),
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
      ),
    );
  }
}
