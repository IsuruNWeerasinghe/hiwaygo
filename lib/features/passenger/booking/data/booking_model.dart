class BookingModel {
  final String id;
  final String bookingDate;
  final int noOfSeats;
  final String pickupLocation;
  final String? busRouteId;
  final String? busId;
  final String? busNo;

  BookingModel({
    required this.id,
    required this.bookingDate,
    required this.noOfSeats,
    required this.pickupLocation,
    this.busRouteId,
    this.busId,
    this.busNo,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    print("--- Debugging BookingModel Parsing ---");
    print("Full JSON Object: $json");
    print("Value for 'id': ${json['id']}");
    print("Value for 'StartTime': ${json['startTime']}");
    print("Value for 'Seats': ${json['seats']}");
    print("Value for 'PickupLocation': ${json['pickupLocation']}");
    print("Value for 'Route': ${json['route']}");
    print("Value for 'BookingId': ${json['bookingId']}");

    return BookingModel(
      id: json['id']?.toString() ?? '',
      bookingDate: json['startTime']?.toString() ?? '',
      noOfSeats: json['seats'] is int ? json['seats'] : int.tryParse(json['seats']?.toString() ?? '0') ?? 0,
      pickupLocation: json['pickupLocation']?.toString() ?? 'Unknown Location',
      busRouteId: json['route']?.toString(),
      busId: json['bookingId']?.toString(),
      busNo: json['bus']?.toString(),
    );
  }
}