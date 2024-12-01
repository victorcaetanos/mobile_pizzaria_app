import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_pizzaria_app/features/auth/domain/entities/app_user.dart';
import 'package:mobile_pizzaria_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:mobile_pizzaria_app/features/card/domain/entities/card.dart';
import 'package:mobile_pizzaria_app/features/card/presentation/components/card_dismisable.dart';
import 'package:mobile_pizzaria_app/features/card/presentation/components/card_display.dart';
import 'package:mobile_pizzaria_app/features/card/presentation/components/create_card_button.dart';
import 'package:mobile_pizzaria_app/features/card/presentation/cubits/card_cubit.dart';
import 'package:mobile_pizzaria_app/features/card/presentation/cubits/card_state.dart';
import 'package:mobile_pizzaria_app/features/card/presentation/pages/edit_card_page.dart';
import 'package:mobile_pizzaria_app/features/card/presentation/pages/create_card_page.dart';
import 'package:mobile_pizzaria_app/features/home/presentation/pages/home_page.dart';
import 'package:mobile_pizzaria_app/features/loading/pages/loading_page.dart';

class CardListPage extends StatefulWidget {
  const CardListPage({super.key});

  @override
  State<CardListPage> createState() => _CardListPageState();
}

class _CardListPageState extends State<CardListPage> {
  late final CardCubit cardCubit = context.read<CardCubit>();

  AppUser? currentUser;

  @override
  void initState() {
    super.initState();
    getAllCards();
  }

  void getAllCards() {
    final AuthCubit authCubit = context.read<AuthCubit>();
    currentUser = authCubit.currentUser;
    cardCubit.getCardsByUserId(currentUser!.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
        title: const Text(
          'Formas de Pagamento',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<CardCubit, CardState>(
        builder: (context, state) {
          if (state is CardLoading) {
            return const LoadingPage();
          } else if (state is CardLoaded) {
            if (state.cards.isEmpty) {
              return _buildNoCardBody(context);
            }
            return _buildFilledCardBody(context, state);
          }
          return const Scaffold(
            body: Center(
              child: Text('Erro ao carregar cartões'),
            ),
          );
        },
      ),
    );
  }

  SafeArea _buildFilledCardBody(BuildContext context, CardLoaded state) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24.0),
              Text(
                'Meus Cartões',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onPrimaryFixedVariant,
                ),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                flex: 1,
                child: ListView.separated(
                  itemCount: state.cards.length + 1,
                  itemBuilder: (context, index) {
                    if (index != state.cards.length) {
                      final card = state.cards[index];
                      return _buildMyCardDismissable(
                        card,
                        state,
                        index,
                        context,
                      );
                    } else {
                      return buildCreateButton();
                    }
                  },
                  separatorBuilder: (context, index) {
                    if (index == state.cards.length - 1) {
                      return const SizedBox(height: 20.0);
                    }
                    return const SizedBox(height: 12.0);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Dismissible _buildMyCardDismissable(
      MyCard card, CardLoaded state, int index, BuildContext context) {
    return Dismissible(
      background: const CardDismisable(),
      key: ValueKey<int>(int.tryParse(card.id)!),
      onDismissed: (DismissDirection direction) {
        cardCubit.deleteCard(state.cards[index]);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cartão deletado com sucesso'),
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditCardPage(
                card: card,
                index: index,
              ),
            ),
          );
        },
        child: CardDisplay(
          card: card,
        ),
      ),
    );
  }

  SafeArea _buildNoCardBody(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24.0),
              Text(
                'Meus Cartões',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onPrimaryFixedVariant,
                ),
              ),
              const SizedBox(height: 16.0),
              buildCreateButton(),
            ],
          ),
        ),
      ),
    );
  }

  buildCreateButton() {
    return SizedBox(
      height: 200.0,
      child: CreateCardButton(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateCardPage(),
            ),
          );
        },
        text: 'Adicionar',
      ),
    );
  }
}
