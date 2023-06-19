class HistoryItem {
  HistoryItem(
      {required this.id,
      required this.dateTime,
      required this.totalDistance,
      required this.totalElectricity,
      required this.totalFood,
      required this.distanceCategory,
      required this.electricityCategory,
      required this.overallTotal});

  final String id;
  final String dateTime;
  final double totalDistance;
  final String distanceCategory;
  final double totalFood;
  final double totalElectricity;
  final String electricityCategory;
  final double overallTotal;
}
