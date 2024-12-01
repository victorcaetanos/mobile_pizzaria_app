import 'package:bloc/bloc.dart';
import 'package:mobile_pizzaria_app/features/card/domain/entities/card.dart';
import 'package:mobile_pizzaria_app/features/card/domain/repos/icard_repo.dart';
import 'package:mobile_pizzaria_app/features/card/presentation/cubits/card_state.dart';


class CardCubit extends Cubit<CardState> {
  final ICardRepo cardRepo;

  CardCubit({required this.cardRepo}) : super(CardInitial());

  void getCard(String cardId) {
    emit(CardLoading());
    try {
      if (cardId.isEmpty || cardId == '-1') {
        final card = cardRepo.empty();
        emit(CardLoaded(cards: [card]));
        return;
      }
      final card = cardRepo.getCard(cardId);
      emit(CardLoaded(cards: [card]));
    } catch (e) {
      emit(CardError(message: e.toString()));
    }
  }

  void getCardsByUserId(String userId) {
    emit(CardLoading());
    try {
      final cards = cardRepo.getCardsByUserId(userId);
      emit(CardLoaded(cards: cards));
    } catch (e) {
      emit(CardError(message: e.toString()));
    }
  }

  void createCard(
    String cardName,
    String cardNumber,
    String cpf,
    String expireDate,
    String cvv,
    String userId,
  ) async {
    emit(CardLoading());
    try {
      cardRepo.createCard(
        cardName,
        cardNumber,
        cpf,
        expireDate,
        cvv,
        userId,
      );
      getCardsByUserId(userId);
    } catch (e) {
      emit(CardError(message: e.toString()));
    }
  }

  void updateCard(MyCard myCard) {
    emit(CardLoading());
    try {
      cardRepo.updateCard(myCard);
      getCardsByUserId(myCard.userId);
    } catch (e) {
      emit(CardError(message: e.toString()));
    }
  }

  void deleteCard(MyCard myCard) {
    try {
      cardRepo.deleteCard(myCard.id);
      getCardsByUserId(myCard.userId);
    } catch (e) {
      emit(CardError(message: e.toString()));
    }
  }
}
