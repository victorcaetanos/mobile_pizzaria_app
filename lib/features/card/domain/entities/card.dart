class MyCard {
  final String id;
  final String cardName;
  final String cardNumber;
  final String cpf;
  final String expireDate;
  final String cvv;
  final bool isActive;
  final String userId;

  MyCard({
    required this.id,
    required this.cardName,
    required this.cardNumber,
    required this.cpf,
    required this.expireDate,
    required this.cvv,
    required this.isActive,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'card_name': cardName,
      'card_number': cardNumber,
      'cpf_cnpj': cpf,
      'expire_date': expireDate,
      'cvv': cvv,
      'is_active': isActive,
      'user_id': userId,
    };
  }

  factory MyCard.fromJson(Map<String, dynamic> json) {
    return MyCard(
      id: json['id'] ?? '-1',
      cardName: json['card_name'] ?? '',
      cardNumber: json['card_number'] ?? '',
      cpf: json['cpf_cnpj'] ?? '',
      expireDate: json['expire_date'] ?? '',
      cvv: json['cvv'] ?? '',
      isActive: json['is_active'] ?? false,
      userId: json['user_id'] ?? '',
    );
  }
}
