import 'dart:convert'; // Import this for jsonEncode and jsonDecode

class Customer {
  final int? id;
  final String firstName;
  final String lastName;
  final String address;
  final String birthday;

  Customer({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.birthday,
  });

  // Convert a Customer object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'address': address,
      'birthday': birthday,
    };
  }

  // Extract a Customer object from a Map object
  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      address: map['address'],
      birthday: map['birthday'],
    );
  }

  // Convert a Customer object into a JSON string
  String toJson() {
    final Map<String, dynamic> data = toMap();
    return jsonEncode(data); // Use jsonEncode to convert the map to a JSON string
  }

  // Extract a Customer object from a JSON string
  factory Customer.fromJson(String jsonString) {
    final Map<String, dynamic> data = jsonDecode(jsonString); // Use jsonDecode to convert JSON string to map
    return Customer.fromMap(data);
  }
}
