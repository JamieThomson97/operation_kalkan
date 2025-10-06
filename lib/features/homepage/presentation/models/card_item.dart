class CardItem {
  const CardItem({
    required this.title,
    required this.subtitle,
    this.image,
  });

  final String title;
  final String subtitle;
  final String? image;
}
