import 'package:bloc/bloc.dart';
import 'package:mobile_pizzaria_app/features/address/domain/entities/address.dart';
import 'package:mobile_pizzaria_app/features/address/domain/entities/city.dart';
import 'package:mobile_pizzaria_app/features/address/domain/repos/iaddress_repo.dart';
import 'package:mobile_pizzaria_app/features/address/presentation/cubits/address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  final IAddressRepo addressRepo;

  AddressCubit({required this.addressRepo}) : super(AddressInitial());

  void getAddress(String addressId)  {
    emit(AddressLoading());
    try {
      if (addressId.isEmpty || addressId == '-1') {
        final address = addressRepo.empty();
        emit(AddressLoaded(addresses: [address]));
        return;
      }
      final address = addressRepo.getAddress(addressId);
      emit(AddressLoaded(addresses: [address]));
    } catch (e) {
      emit(AddressError(message: e.toString()));
    }
  }

  void getAddressesByUserId(String userId) {
    emit(AddressLoading());
    try {
      final addresses = addressRepo.getAddressesByUserId(userId);
      emit(AddressLoaded(addresses: addresses));
    } catch (e) {
      emit(AddressError(message: e.toString()));
    }
  }

  void createAddress(
    String cep,
    String street,
    String houseNumber,
    String complement,
    String neighborhood,
    String userId,
    MyCity city,
  ) {
    emit(AddressLoading());
    try {
      addressRepo.createAddress(
        cep,
        street,
        houseNumber,
        complement,
        neighborhood,
        userId,
        city,
      );
      getAddressesByUserId(userId);
    } catch (e) {
      emit(AddressError(message: e.toString()));
    }
  }

  void updateAddress(Address address) {
    emit(AddressLoading());
    try {
      addressRepo.updateAddress(address);
      getAddressesByUserId(address.userId);
    } catch (e) {
      emit(AddressError(message: e.toString()));
    }
  }

  void deleteAddress(Address address) {
    try {
      addressRepo.deleteAddress(address.id);
      getAddressesByUserId(address.userId);
    } catch (e) {
      emit(AddressError(message: e.toString()));
    }
  }
}
