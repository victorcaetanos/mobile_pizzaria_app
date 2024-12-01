import 'package:mobile_pizzaria_app/features/address/domain/entities/state.dart';
import 'package:mobile_pizzaria_app/features/address/domain/repos/istate_repo.dart';

class MyStateRepo implements IMyStateRepo {
  final List<MyState> myState = [];

  MyStateRepo() {
    if (myState.isEmpty) {
      myState.addAll([
        MyState(
          isActive: true,
          id: '1',
          name: 'Goiás',
          abbreviation: 'GO',
        ),
        MyState(
          isActive: true,
          id: '2',
          name: 'Minas Gerais',
          abbreviation: 'MG',
        ),
        MyState(
          isActive: true,
          id: '3',
          name: 'São Paulo',
          abbreviation: 'SP',
        ),
      ]);
    }
  }

  @override
  MyState getMyState(String stateId) {
    try {
      return myState.firstWhere(
        (myState) => myState.id == stateId,
      );
    } catch (e) {
      throw Exception('Erro ao buscar estado');
    }
  }

  @override
  List<MyState> getMyStates() {
    try {
      return myState;
    } catch (e) {
      throw Exception('Erro ao buscar estados');
    }
  }
}
