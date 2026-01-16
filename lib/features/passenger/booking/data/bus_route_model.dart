class BusRouteModel {
  final String id;
  final String routeNo;
  final String city1;
  final String city2;

  BusRouteModel({
    required this.id,
    required this.routeNo,
    required this.city1,
    required this.city2,
  });

  factory BusRouteModel.fromJson(Map<String, dynamic> json) {
    return BusRouteModel(
      id: json['id'] ?? '',
      routeNo: json['routeNo'] ?? '',
      city1: json['city1'] ?? '',
      city2: json['city2'] ?? '',
    );
  }

  // Helper to display the route in the dropdown
  String get displayText => "$routeNo: $city1 - $city2";
}