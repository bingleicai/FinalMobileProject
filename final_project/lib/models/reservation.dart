class Reservation {
  final int id;
  final int customerId;
  final int flightId;
  final String reservationName;

  Reservation({
    required this.id,
    required this.customerId,
    required this.flightId,
    required this.reservationName,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'],
      customerId: json['customerId'],
      flightId: json['flightId'],
      reservationName: json['reservationName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerId': customerId,
      'flightId': flightId,
      'reservationName': reservationName,
    };
  }
}
