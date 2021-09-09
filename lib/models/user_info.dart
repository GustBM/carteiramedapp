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
}
