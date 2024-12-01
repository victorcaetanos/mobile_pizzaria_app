import 'package:mobile_pizzaria_app/features/address/data/state_repo.dart';
import 'package:mobile_pizzaria_app/features/address/domain/entities/city.dart';
import 'package:mobile_pizzaria_app/features/address/domain/repos/icity_repo.dart';

class MyCityRepo implements IMyCityRepo {
  final List<MyCity> myCity = [];
  MyCityRepo() {
    if (myCity.isEmpty) {
      myCity.addAll([
        MyCity(
          isActive: true,
          id: '1',
          name: 'Rio Verde',
          state: MyStateRepo().getMyState('1'),
        ),
        MyCity(
          isActive: true,
          id: '2',
          name: 'Caçu',
          state: MyStateRepo().getMyState('1'),
        ),
        MyCity(
          isActive: true,
          id: '3',
          name: 'Belo Horizonte',
          state: MyStateRepo().getMyState('2'),
        ),
        MyCity(
          isActive: true,
          id: '4',
          name: 'São Paulo',
          state: MyStateRepo().getMyState('3'),
        ),
      ]);
    }
  }

  @override
  MyCity getMyCity(String cityId) {
    try {
      return myCity.firstWhere(
        (city) => city.id == cityId,
      );
    } catch (e) {
      throw Exception('Erro ao buscar cidade');
    }
  }

  @override
  List<MyCity> getMyCities([String? stateId]) {
    try {
      if (stateId == null) {
        return myCity;
      }
      return myCity
          .where(
            (city) => city.state.id == stateId,
          )
          .toList();
    } catch (e) {
      throw Exception('Erro ao buscar cidades');
    }
  }
}
