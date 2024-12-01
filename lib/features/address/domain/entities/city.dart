import 'package:mobile_pizzaria_app/features/address/domain/entities/state.dart';

class MyCity {
  final String id;
  final String name;
  final bool isActive;
  final MyState state;

  MyCity({
    required this.id,
    required this.name,
    required this.isActive,
    required this.state,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyCity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          isActive == other.isActive &&
          state == other.state;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ isActive.hashCode ^ state.hashCode;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'is_active': isActive,
      'state': state,
    };
  }

  factory MyCity.fromJson(Map<String, dynamic> json) {
    return MyCity(
      id: json['id'],
      name: json['name'],
      isActive: json['is_active'],
      state: json['state'],
    );
  }
}
