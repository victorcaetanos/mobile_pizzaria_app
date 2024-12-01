import 'package:mobile_pizzaria_app/features/address/domain/entities/address.dart';
import 'package:mobile_pizzaria_app/features/address/domain/entities/city.dart';

abstract class IAddressRepo {
  Address getAddress(String addressId);
  Address empty();
  List<Address> getAddressesByUserId(String userId);
  Address createAddress(
    final String cep,
    final String street,
    final String houseNumber,
    final String complement,
    final String neighborhood,
    final String userId,
    final MyCity city,
  );
  void updateAddress(Address address);
  void deleteAddress(String addressId);
}
