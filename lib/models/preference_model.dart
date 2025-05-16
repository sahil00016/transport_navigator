class PreferenceModel {
  final String userId;
  final double speedVsCost;

  PreferenceModel({
    required this.userId,
    required this.speedVsCost,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'speedVsCost': speedVsCost,
    };
  }

  factory PreferenceModel.fromMap(Map<String, dynamic> map) {
    return PreferenceModel(
      userId: map['userId'],
      speedVsCost: map['speedVsCost'],
    );
  }
}