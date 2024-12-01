import 'package:mobile_pizzaria_app/features/address/domain/entities/city.dart';

abstract class IMyCityRepo {
  MyCity getMyCity(String cityId);
  List<MyCity> getMyCities([String? stateId]);
}
