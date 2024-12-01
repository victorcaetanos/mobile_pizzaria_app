import 'package:mobile_pizzaria_app/features/address/domain/entities/state.dart';

abstract class IMyStateRepo {
  MyState getMyState(String stateId);
  List<MyState> getMyStates();
}
 