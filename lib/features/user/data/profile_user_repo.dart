import 'package:mobile_pizzaria_app/features/auth/data/auth_repo.dart';
import 'package:mobile_pizzaria_app/features/auth/domain/entities/app_user.dart';
import 'package:mobile_pizzaria_app/features/user/domain/entities/profile_user.dart';
import 'package:mobile_pizzaria_app/features/user/domain/repos/iprofile_user_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileUserRepo implements IProfileUserRepo {
  static final ProfileUserRepo _instance = ProfileUserRepo._internal();

  factory ProfileUserRepo() {
    _instance.initialize();
    return _instance;
  }

  ProfileUserRepo._internal();

  final List<ProfileUser> _users = [];
  ProfileUser? _currentProfileUser;

  void initialize() {
    if (_users.isEmpty) {
      _users.add(
        ProfileUser(
          user: AppUser(
            id: '1',
            email: 'victor@email.com',
            password: '12341234',
            firstName: 'Victor',
            lastName: 'Caetano Souto',
            phoneNumber: '64999751234',
          ),
          role: 'user',
          isActive: true,
          selectedCardId: '1',
          selectedAddressId: '1',
          hasActiveCart: false,
        ),
      );
    }
  }

  @override
  void addUser(AppUser appUser) {
    _users.add(
      ProfileUser(
        user: appUser,
        role: 'user',
        isActive: true,
        selectedCardId: '-1',
        selectedAddressId: '-1',
        hasActiveCart: false,
      ),
    );
  }

  @override
  Future<ProfileUser?> getProfileUser() async {
    if (_currentProfileUser == null) {
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString('email'); 
      if (email != null && email.isNotEmpty) {
        try {
          _currentProfileUser = _users.firstWhere(
            (user) => user.user.email == email,
          ); 
        } catch (e) {
          _currentProfileUser = null; 
        }
      }
    } 
    return _currentProfileUser;
  }

  @override
  ProfileUser empty() {
    return ProfileUser(
      user: AuthRepo().empty(),
      role: '',
      isActive: true,
      selectedCardId: '-1',
      selectedAddressId: '-1',
      hasActiveCart: false,
    );
  }

  @override
  Future<void> updateProfileUser(ProfileUser user) async {
    try {
      final index = _users.indexWhere((u) => u.user.id == user.user.id);

      if (index >= 0) {
        _users[index] = user;
        _currentProfileUser = user;
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', user.user.email);
    } catch (e) {
      throw Exception('Erro ao atualizar usuário');
    }
  }
}
