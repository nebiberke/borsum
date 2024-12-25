enum EndpointEnums {
  mt5Based(
    path: '/models/nebiberke/haber-ozet-mt5-based',
  ),
  mbartLarge50(
    path: '/models/nebiberke/haber-ozet-mbart-large-50',
  );

  const EndpointEnums({required this.path});
  final String path;
}
