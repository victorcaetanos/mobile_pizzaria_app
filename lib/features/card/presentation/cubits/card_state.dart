import 'package:mobile_pizzaria_app/features/card/domain/entities/card.dart';

abstract class CardState {}

class CardInitial extends CardState {}

class CardLoading extends CardState {}

class CardLoaded extends CardState {
  final List<MyCard> cards;

  CardLoaded({required this.cards});
}

class CardError extends CardState {
  final String message;

  CardError({required this.message});
}
