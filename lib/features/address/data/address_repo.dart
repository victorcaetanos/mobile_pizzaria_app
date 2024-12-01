import 'package:mobile_pizzaria_app/features/address/data/city_repo.dart';
import 'package:mobile_pizzaria_app/features/address/domain/entities/address.dart';
import 'package:mobile_pizzaria_app/features/address/domain/entities/city.dart';
import 'package:mobile_pizzaria_app/features/address/domain/entities/state.dart';
import 'package:mobile_pizzaria_app/features/address/domain/repos/iaddress_repo.dart';

class AddressRepo implements IAddressRepo {
  final List<Address> addresses = [];

  AddressRepo() {
    if (addresses.isEmpty) {
      MyCityRepo cityRepo = MyCityRepo();
      addresses.addAll([
        Address(
          isActive: true,
          id: '1',
          userId: '1',
          cep: '75900000',
          street: 'Rua 10',
          houseNumber: '911',
          complement: 'Casa',
          neighborhood: 'Bairro UniRV',
          city: cityRepo.getMyCity('1'),
        ),
        Address(
          isActive: true,
          id: '2',
          userId: '1',
          cep: '75813000',
          street: 'Rua Medeiros',
          houseNumber: '1911',
          complement: 'Kitnet 7',
          neighborhood: 'Centro',
          city: cityRepo.getMyCity('2'),
        ),
        Address(
          isActive: true,
          id: '3',
          userId: '1',
          cep: '76700213',
          street: 'Av. JK',
          houseNumber: '1',
          complement: 'Apto 101',
          neighborhood: 'Parque das Américas',
          city: cityRepo.getMyCity('3'),
        ),
      ]);
    }
  }

  @override
  Address empty() {
    return Address(
      id: '',
      cep: '',
      street: '',
      houseNumber: '',
      complement: '',
      neighborhood: '',
      isActive: true,
      userId: '',
      city: MyCity(
        id: '',
        name: '',
        isActive: true,
        state: MyState(
          id: '',
          name: '',
          abbreviation: '',
          isActive: true,
        ),
      ),
    );
  }

  @override
  Address getAddress(String addressId) { 
    try {
      return addresses.firstWhere(
        (address) => address.id == addressId,
      );
    } catch (e) {
      throw Exception('Erro ao buscar endereço');
    }
  }

  @override
  List<Address> getAddressesByUserId(String userId) {
    try {
      return addresses.where((address) => address.userId == userId).toList();
    } catch (e) {
      throw Exception('Erro ao buscar endereços');
    }
  }

  @override
  Address createAddress(
    String cep,
    String street,
    String houseNumber,
    String complement,
    String neighborhood,
    String userId,
    MyCity city,
  ) {
    try {
      final address = Address(
        id: (addresses.length + 1).toString(),
        cep: cep,
        street: street,
        houseNumber: houseNumber,
        complement: complement,
        neighborhood: neighborhood,
        isActive: true,
        userId: userId,
        city: city,
      );

      addresses.add(address);
      return address;
    } catch (e) {
      throw Exception('Erro ao atualizar endereço');
    }
  }

  @override
  void updateAddress(Address address) {
    try {
      final index = addresses.indexWhere((u) => u.id == address.id);

      if (index >= 0) {
        addresses[index] = address;
      }
    } catch (e) {
      throw Exception('Erro ao atualizar endereço');
    }
  }

  @override
  void deleteAddress(String addressId) {
    try {
      final index = addresses.indexWhere((u) => u.id == addressId);

      if (index >= 0) {
        addresses.removeAt(index);
      }
    } catch (e) {
      throw Exception('Erro ao deletar cartão');
    }
  }
}
