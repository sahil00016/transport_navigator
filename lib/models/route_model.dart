class RouteModel {
  final String id;
  final String description;
  final double eta;
  final double cost;
  final DateTime timestamp;

  RouteModel({
    required this.id,
    required this.description,
    required this.eta,
    required this.cost,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'eta': eta,
      'cost': cost,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory RouteModel.fromMap(Map<String, dynamic> map) {
    return RouteModel(
      id: map['id'],
      description: map['description'],
      eta: map['eta'],
      cost: map['cost'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}