class UserInfo {
  final String id;
  final String cpf;
  final String name;
  final String birthDate;
  final String email;
  final String? imageUrl;
  final List<String> medications;
  final List<String> conditions;
  final List<String> vaccines;

  UserInfo({
    required this.id,
    required this.cpf,
    required this.name,
    required this.birthDate,
    required this.email,
    this.imageUrl,
    this.medications = const [],
    this.conditions = const [],
    this.vaccines = const [],
  });

  UserInfo.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as String,
          cpf: json['cpf'] as String,
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
      'id': id,
      'cpf': cpf,
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
