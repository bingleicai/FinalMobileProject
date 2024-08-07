class Flight {
  final int id;
  final String departureCity;
  final String destinationCity;
  final String departureTime;
  final String arrivalTime;
  final int airplaneId;

  Flight({
    required this.id,
    required this.departureCity,
    required this.destinationCity,
    required this.departureTime,
    required this.arrivalTime,
    required this.airplaneId,
  });

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      id: json['id'],
      departureCity: json['departureCity'],
      destinationCity: json['destinationCity'],
      departureTime: json['departureTime'],
      arrivalTime: json['arrivalTime'],
      airplaneId: json['airplaneId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'departureCity': departureCity,
      'destinationCity': destinationCity,
      'departureTime': departureTime,
      'arrivalTime': arrivalTime,
      'airplaneId': airplaneId,
    };
  }
}