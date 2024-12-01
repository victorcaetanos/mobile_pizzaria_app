import 'package:mobile_pizzaria_app/features/card/domain/entities/card.dart';
import 'package:mobile_pizzaria_app/features/card/domain/repos/icard_repo.dart';

class CardRepo implements ICardRepo {
  final List<MyCard> cards = [];

  CardRepo() {
    if (cards.isEmpty) {
      cards.addAll([
        MyCard(
          id: '1',
          cardName: 'Card 1',
          cardNumber: '1234123412341234',
          cpf: '12345678900',
          expireDate: '12/2030',
          cvv: '123',
          isActive: true,
          userId: '1',
        ),
        MyCard(
          id: '2',
          cardName: 'Card 2',
          cardNumber: '1111222233334444123',
          cpf: '11122233344',
          expireDate: '09/2032',
          cvv: '321',
          isActive: true,
          userId: '1',
        ),
      ]);
    }
  }

  @override
  MyCard empty() {
    return MyCard(
      id: '-1',
      cardName: '',
      cardNumber: '',
      cpf: '',
      expireDate: '',
      cvv: '',
      isActive: true,
      userId: '',
    );
  }

  @override
  MyCard getCard(String cardId) {
    try {
      return cards.firstWhere((card) => card.id == cardId);
    } catch (e) {
      throw Exception('Erro ao buscar usuário');
    }
  }

  @override
  List<MyCard> getCardsByUserId(String userId) {
    try {
      return cards.where((card) => card.userId == userId).toList();
    } catch (e) {
      throw Exception('Erro ao buscar cartões');
    }
  }

  @override
  void createCard(
    String cardName,
    String cardNumber,
    String cpf,
    String expireDate,
    String cvv,
    String userId,
  ) {
    try {
      final card = MyCard(
        id: (cards.length + 1).toString(),
        cardName: cardName,
        cardNumber: cardNumber,
        cpf: cpf,
        expireDate: expireDate,
        cvv: cvv,
        isActive: true,
        userId: userId,
      );

      cards.add(card);
    } catch (e) {
      throw Exception('Erro ao criar cartão');
    }
  }

  @override
  void updateCard(MyCard card) {
    try {
      final index = cards.indexWhere((u) => u.id == card.id);

      if (index >= 0) {
        cards[index] = card;
      }
    } catch (e) {
      throw Exception('Erro ao atualizar cartão');
    }
  }

  @override
  void deleteCard(String cardId) {
    try {
      final index = cards.indexWhere((u) => u.id == cardId);

      if (index >= 0) {
        cards.removeAt(index);
      }
    } catch (e) {
      throw Exception('Erro ao deletar cartão');
    }
  }
}
