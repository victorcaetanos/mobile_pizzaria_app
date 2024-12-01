class MyState {
  final String id;
  final String name;
  final String abbreviation;
  final bool isActive;

  MyState({
    required this.id,
    required this.name,
    required this.abbreviation,
    required this.isActive,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyState &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          abbreviation == other.abbreviation &&
          isActive == other.isActive;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ abbreviation.hashCode ^ isActive.hashCode;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'abbreviation': abbreviation,
      'is_active': isActive,
    };
  }

  factory MyState.fromJson(Map<String, dynamic> json) {
    return MyState(
      id: json['id'] ?? '-1',
      name: json['name'] ?? '',
      abbreviation: json['abbreviation'] ?? '',
      isActive: json['is_active'] ?? true,
    );
  }
}
