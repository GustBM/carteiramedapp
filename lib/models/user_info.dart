class UserInf {
  final String cpf;
  final String userId;
  final String name;
  final String birthDate;
  final String email;
  final String? imageUrl;
  final List<String> medications;
  final List<String> conditions;
  final List<String> vaccines;

  UserInf({
    required this.cpf,
    required this.userId,
    required this.name,
    required this.birthDate,
    required this.email,
    this.imageUrl,
    this.medications = const [],
    this.conditions = const [],
    this.vaccines = const [],
  });

  UserInf.fromJson(Map<String, Object?> json)
      : this(
          cpf: json['cpf'] as String,
          userId: json['userId'] as String,
          name: json['name']! as String,
          birthDate: json['birthDate'] as String,
          email: json['email'] as String,
          imageUrl: json['imageUrl'] as String,
          medications: (json['medications']! as List<dynamic>).cast<String>(),
          conditions: (json['conditions']! as List<dynamic>).cast<String>(),
          vaccines: (json['vaccines']! as List<dynamic>).cast<String>(),
        );

  Map<String, Object?> toJson() {
    return {
      'cpf': cpf,
      'userId': userId,
      'name': name,
      'birthDate': birthDate,
      'email': email,
      'imageUrl': imageUrl,
      'medications': medications,
      'conditions': conditions,
      'vaccines': vaccines,
    };
  }
}
