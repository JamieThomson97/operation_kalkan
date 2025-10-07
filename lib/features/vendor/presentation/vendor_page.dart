import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:operation_kalkan/features/homepage/presentation/models/card_item.dart';
import 'package:operation_kalkan/features/vendor/presentation/vendor_info_page.dart';

class VendorPage extends StatefulWidget {
  const VendorPage({required this.item, super.key});

  static const routeName = 'vendor';
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
  static const menuCategories = <_MenuCategory>[
    _MenuCategory(
      title: 'Starters',
      items: [
        _MenuItem(
          name: 'Garlic Prawns',
          description:
              'Sautéed prawns with garlic butter, chili, and toasted sourdough.',
          price: '£8.50',
          tag: 'Popular',
          imageUrl:
              'https://images.unsplash.com/photo-1504753793650-d4a2b783c15e?auto=format&fit=crop&w=800&q=80',
        ),
        _MenuItem(
          name: 'Truffle Arancini',
          description:
              'Crispy risotto balls filled with smoked mozzarella and truffle aioli.',
          price: '£7.20',
          imageUrl:
              'https://images.unsplash.com/photo-1525610553991-2bede1a236e2?auto=format&fit=crop&w=800&q=80',
        ),
        _MenuItem(
          name: 'Seasonal Soup',
          description:
              'Chef-selected vegetables simmered with herbs and finished with cream.',
          price: '£5.90',
        ),
      ],
    ),
    _MenuCategory(
      title: 'Mains',
      items: [
        _MenuItem(
          name: 'Seared Sea Bass',
          description:
              'Pan-seared sea bass with fennel salad, citrus beurre blanc, and charred lemon.',
          price: '£16.40',
          imageUrl:
              'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=800&q=80',
        ),
        _MenuItem(
          name: 'Charred Ribeye',
          description:
              '12oz ribeye grilled to order, served with chimichurri and rosemary potatoes.',
          price: '£21.00',
          tag: 'Chef\'s special',
          imageUrl:
              'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=800&q=80',
        ),
        _MenuItem(
          name: 'Wild Mushroom Risotto',
          description:
              'Creamy arborio rice with porcini, pecorino, and crispy sage.',
          price: '£14.30',
        ),
      ],
    ),
    _MenuCategory(
      title: 'Desserts',
      items: [
        _MenuItem(
          name: 'Lemon Tart',
          description:
              'Bright lemon curd in a buttery crust with vanilla bean cream.',
          price: '£6.50',
          imageUrl:
              'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?auto=format&fit=crop&w=800&q=80',
        ),
        _MenuItem(
          name: 'Chocolate Fondant',
          description:
              'Warm dark chocolate cake with molten center and salted caramel ice cream.',
          price: '£6.90',
        ),
        _MenuItem(
          name: 'Vanilla Bean Cheesecake',
          description:
              'Baked cheesecake layered with berry compote and almond crumble.',
          price: '£6.20',
          tag: 'New',
        ),
      ],
    ),
    _MenuCategory(
      title: 'Drinks',
      items: [
        _MenuItem(
          name: 'House Lemonade',
          description: 'Fresh lemons, agave, and mint over crushed ice.',
          price: '£3.80',
        ),
        _MenuItem(
          name: 'Berry Spritz',
          description:
              'Sparkling hibiscus, seasonal berries, and citrus bitters.',
          price: '£4.50',
        ),
        _MenuItem(
          name: 'Cold Brew Coffee',
          description: '24-hour steeped beans over clear ice with orange zest.',
          price: '£3.60',
        ),
      ],
    ),
  ];

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
      VendorPage.menuCategories.length,
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
    Scrollable.ensureVisible(
      targetContext,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final media = MediaQuery.of(context);
    final heroHeight = media.size.height * 0.35;
    final photoGroups = [
      for (var i = 0; i < VendorPage._photoGallery.length; i += 3)
        VendorPage._photoGallery.sublist(
          i,
          i + 3 > VendorPage._photoGallery.length
              ? VendorPage._photoGallery.length
              : i + 3,
        ),
    ];

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
                child: _buildHeroImage(widget.item.image),
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
                      _buildInfoRow(context),
                      const SizedBox(height: 16),
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: theme.dividerColor.withValues(alpha: 0.2),
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
                        height: 120,
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
                      const SizedBox(height: 24),
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: theme.dividerColor.withValues(alpha: 0.2),
                      ),
                      const SizedBox(height: 24),
                      _buildMenuContent(context),
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
            child: _buildCollapsedAppBar(context),
          ),
          Positioned(
            top: media.padding.top + (_showCollapsedBar ? kToolbarHeight : 16),
            left: 0,
            right: 0,
            child: _buildMenuTabs(context),
          ),
          Positioned(
            top: media.padding.top + 16,
            left: 16,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 180),
              opacity: _showCollapsedBar ? 0 : 1,
              child: IgnorePointer(
                ignoring: _showCollapsedBar,
                child: _buildFloatingBackButton(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCollapsedAppBar(BuildContext context) {
    final theme = Theme.of(context);
    final media = MediaQuery.of(context);
    final shadows = _showCollapsedBar
        ? [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ]
        : const <BoxShadow>[];

    return IgnorePointer(
      ignoring: !_showCollapsedBar,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: _showCollapsedBar ? 1 : 0,
        child: Container(
          padding: EdgeInsets.only(top: media.padding.top),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            boxShadow: shadows,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: SizedBox(
              height: kToolbarHeight,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Expanded(
                    child: Text(
                      widget.item.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite_border),
                    tooltip: 'Save',
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.share_outlined),
                    tooltip: 'Share',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuTabs(BuildContext context) {
    final theme = Theme.of(context);
    final shadows = _showMenuTabs
        ? [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ]
        : const <BoxShadow>[];

    return IgnorePointer(
      ignoring: !_showMenuTabs,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: _showMenuTabs ? 1 : 0,
        child: Container(
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            boxShadow: shadows,
          ),
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SizedBox(
            height: 44,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: VendorPage.menuCategories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final category = VendorPage.menuCategories[index];
                final selected = index == _activeCategoryIndex;

                return ChoiceChip(
                  label: Text(category.title),
                  selected: selected,
                  onSelected: (_) => _handleMenuTabTap(index),
                  selectedColor: Colors.transparent,
                  backgroundColor: Colors.white,
                  showCheckmark: false,
                  labelStyle: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    color: selected
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurface,
                  ),
                  side: BorderSide(
                    color: selected
                        ? theme.colorScheme.primary.withValues(alpha: 0.45)
                        : theme.dividerColor.withValues(alpha: 0.4),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuContent(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _cacheMenuOffset());
    final theme = Theme.of(context);

    return KeyedSubtree(
      key: _menuSectionKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Menu',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          for (var i = 0; i < VendorPage.menuCategories.length; i++) ...[
            _buildMenuSection(context, VendorPage.menuCategories[i], i),
            if (i != VendorPage.menuCategories.length - 1)
              const SizedBox(height: 24),
          ],
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildMenuSection(
    BuildContext context,
    _MenuCategory category,
    int index,
  ) {
    final theme = Theme.of(context);

    return KeyedSubtree(
      key: _categoryKeys[index],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category.title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          for (var i = 0; i < category.items.length; i++) ...[
            _MenuItemTile(
              item: category.items[i],
              showDivider: i != category.items.length - 1,
            ),
            if (i != category.items.length - 1) const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }

  Widget _buildHeroImage(String? imageUrl) {
    Widget buildBase() {
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

  Widget _buildFloatingBackButton(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
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

  Widget _buildInfoRow(BuildContext context) {
    final theme = Theme.of(context);
    final dividerColor = theme.dividerColor.withValues(alpha: 0.25);
    const cardFill = Color(0xFFF9F9F9);
    final labelStyle = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurface.withValues(alpha: 0.64),
      fontWeight: FontWeight.w500,
      fontSize: 12,
    );
    final valueStyle = theme.textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.w700,
    );
    final secondaryValueStyle = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
      fontWeight: FontWeight.w300,
      height: 1.2,
    );

    Widget buildCell({
      required Widget child,
      bool showDivider = true,
      VoidCallback? onTap,
    }) {
      final cell = Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            right: showDivider
                ? BorderSide(color: dividerColor, width: 0.8)
                : BorderSide.none,
          ),
        ),
        child: child,
      );

      return Expanded(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: cell,
        ),
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: cardFill,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                  Text('Info & Contact', style: labelStyle),
                ],
              ),
              onTap: () => _openVendorInfo(context),
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
      ),
    );
  }

  void _openVendorInfo(BuildContext context) {
    context.pushNamed(VendorInfoPage.routeName, extra: widget.item);
  }

  Widget _buildPhotoTile(
    BuildContext context, {
    required _PhotoResource photo,
    required String heroTag,
  }) {
    return Hero(
      tag: heroTag,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => _showPhotoLightbox(context, photo.url, heroTag),
          splashColor: Theme.of(context).colorScheme.primary.withValues(
            alpha: 0.1,
          ),
          highlightColor: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Image.network(
              photo.url,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
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

class _MenuItemTile extends StatelessWidget {
  const _MenuItemTile({
    required this.item,
    this.showDivider = false,
  });

  final _MenuItem item;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final secondaryColor = theme.colorScheme.onSurface.withValues(alpha: 0.68);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.description,
                    style: textTheme.bodySmall?.copyWith(
                      color: secondaryColor,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        item.price,
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (item.tag != null) ...[
                        const SizedBox(width: 8),
                        Text(
                          item.tag!,
                          style: textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            if (item.imageUrl != null) ...[
              const SizedBox(width: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item.imageUrl!,
                  width: 76,
                  height: 76,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ],
        ),
        if (showDivider) ...[
          const SizedBox(height: 12),
          Divider(
            height: 1,
            thickness: 1,
            color: theme.dividerColor.withValues(alpha: 0.15),
          ),
        ],
      ],
    );
  }
}

class _PhotoResource {
  const _PhotoResource(this.url);

  final String url;
}

class _MenuCategory {
  const _MenuCategory({
    required this.title,
    required this.items,
  });

  final String title;
  final List<_MenuItem> items;
}

class _MenuItem {
  const _MenuItem({
    required this.name,
    required this.description,
    required this.price,
    this.tag,
    this.imageUrl,
  });

  final String name;
  final String description;
  final String price;
  final String? tag;
  final String? imageUrl;
}
