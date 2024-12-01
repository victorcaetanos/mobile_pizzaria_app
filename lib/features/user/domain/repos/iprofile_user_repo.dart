import 'package:mobile_pizzaria_app/features/auth/domain/entities/app_user.dart';
import 'package:mobile_pizzaria_app/features/user/domain/entities/profile_user.dart';

abstract class IProfileUserRepo {
  Future<ProfileUser?> getProfileUser();
  ProfileUser empty();
  Future<void> updateProfileUser(ProfileUser user);
  void addUser(AppUser appUser);
}
