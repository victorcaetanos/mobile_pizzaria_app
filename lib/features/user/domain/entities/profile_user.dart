import 'package:mobile_pizzaria_app/features/auth/domain/entities/app_user.dart';

class ProfileUser {
  final AppUser user;
  final String role;
  final bool isActive;
  final String selectedCardId;
  final String selectedAddressId;
  final bool hasActiveCart;

  ProfileUser({
    required this.user,
    required this.role,
    required this.isActive,
    required this.selectedCardId,
    required this.selectedAddressId,
    required this.hasActiveCart,
  });

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'role': role,
      'is_active': isActive,
      'selected_card_id': selectedCardId,
      'selected_address_id': selectedAddressId,
      'has_active_cart': hasActiveCart,
    };
  }

  factory ProfileUser.fromJson(Map<String, dynamic> json) {
    return ProfileUser(
      user: json['user'],
      role: json['role'],
      isActive: json['is_active'],
      selectedCardId: json['selected_card_id'],
      selectedAddressId: json['selected_address_id'],
      hasActiveCart: json['has_active_cart'],
    );
  }
}
