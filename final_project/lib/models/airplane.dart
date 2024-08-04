class Airplane {
  int? id;
  String type;
  int numberOfPassengers;
  double maxSpeed;
  double range;

  Airplane({
    this.id,
    required this.type,
    required this.numberOfPassengers,
    required this.maxSpeed,
    required this.range,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'numberOfPassengers': numberOfPassengers,
      'maxSpeed': maxSpeed,
      'range': range,
    };
  }

  static Airplane fromMap(Map<String, dynamic> map) {
    return Airplane(
      id: map['id'],
      type: map['type'],
      numberOfPassengers: map['numberOfPassengers'],
      maxSpeed: map['maxSpeed'],
      range: map['range'],
    );
  }
}
