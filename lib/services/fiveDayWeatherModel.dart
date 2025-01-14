class ForecastModel {
  final DateTime date;
  final double morningTemperature;
  final double eveningTemperature;

  ForecastModel({
    required this.date,
    required this.morningTemperature,
    required this.eveningTemperature,
  });

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    return ForecastModel(
      date: DateTime.parse(json['date']),
      morningTemperature: json['morningTemperature'],
      eveningTemperature: json['eveningTemperature'],
    );
  }
}