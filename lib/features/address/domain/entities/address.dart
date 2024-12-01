import 'package:mobile_pizzaria_app/features/address/domain/entities/city.dart';

class Address {
  final String id;
  final String cep;
  final String street;
  final String houseNumber;
  final String complement;
  final String neighborhood;
  final bool isActive;
  final String userId;
  final MyCity city;

  Address({
    required this.id,
    required this.cep,
    required this.street,
    required this.houseNumber,
    required this.complement,
    required this.neighborhood,
    required this.isActive,
    required this.userId,
    required this.city,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cep': cep,
      'street': street,
      'house_number': houseNumber,
      'complement': complement,
      'neighborhood': neighborhood,
      'is_active': isActive,
      'user_id': userId,
      'city': city,
    };
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      cep: json['cep'],
      street: json['street'],
      houseNumber: json['house_number'],
      complement: json['complement'],
      neighborhood: json['neighborhood'],
      isActive: json['is_active'],
      userId: json['user_id'],
      city: json['city'],
    );
  }
}
