import 'package:mobile_pizzaria_app/features/auth/domain/entities/app_user.dart';

abstract class IAuthRepo {
  Future<AppUser?> register(
    String email,
    String password,
    String firstName,
    String lastName,
    String phoneNumber,
  );
  Future<AppUser?> signIn(
    String email,
    String password,
  );
  AppUser empty();
  Future<void> logOut();
  Future<AppUser?> getCurrentUser();
  AppUser getUser(String email);
}
