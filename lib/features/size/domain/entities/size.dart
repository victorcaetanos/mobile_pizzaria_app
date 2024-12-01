class MySize {
  final String id;
  final String name;
  final bool isActive;
  final int? slices;

  MySize({
    required this.id,
    required this.name,
    required this.isActive,
    this.slices,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MySize &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          isActive == other.isActive;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ isActive.hashCode;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'is_active': isActive,
    };
  }

  factory MySize.fromJson(Map<String, dynamic> json) {
    return MySize(
      id: json['id'] ?? '-1',
      name: json['name'] ?? '',
      isActive: json['is_active'] ?? false,
    );
  }
}
