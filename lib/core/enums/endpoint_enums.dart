enum EndpointEnums {
  bert2bertShared(
    path: '/models/nebiberke/haber-ozet-bert2bert-shared',
  ),
  mt5MultilingualXlsum(
    path: '/models/nebiberke/haber-ozet-mt5-multilingual-xlsum',
  );

  const EndpointEnums({required this.path});
  final String path;
}
