class MyCategory {
  final String id;
  final String name;
  final bool isActive;

  MyCategory({
    required this.id,
    required this.name,
    required this.isActive,
  });
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyCategory &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          isActive == other.isActive  ;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ isActive.hashCode;


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'is_active': isActive,
    };
  }

  factory MyCategory.fromJson(Map<String, dynamic> json) {
    return MyCategory(
      id: json['id'] ?? '-1',
      name: json['name'] ?? '',
      isActive: json['is_active'] ?? false,
    );
  }
}
