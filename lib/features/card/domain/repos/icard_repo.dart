import 'package:mobile_pizzaria_app/features/card/domain/entities/card.dart';

abstract class ICardRepo {
  MyCard getCard(String cardId);
  MyCard empty();
  List<MyCard> getCardsByUserId(String userId);
  void createCard(
    String cardName,
    String cardNumber,
    String cpf,
    String expireDate,
    String cvv,
    String userId,
  );
  void updateCard(MyCard card);
  void deleteCard(String cardId);
}
