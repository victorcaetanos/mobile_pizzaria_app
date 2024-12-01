import 'package:mobile_pizzaria_app/features/auth/domain/entities/app_user.dart';
import 'package:mobile_pizzaria_app/features/auth/domain/repos/iauth_repo.dart'; 
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo implements IAuthRepo {
  final List<AppUser> _users = [];
  AppUser? _currentUser;

  AuthRepo() {
    if (_users.isEmpty) {
      _users.add(
        AppUser(
          id: '1',
          email: 'victor@email.com',
          password: '12341234',
          firstName: 'Victor',
          lastName: 'Caetano Souto',
          phoneNumber: '64999751234',
        ),
      );
    }
  }

  @override
  Future<AppUser?> register(
    String email,
    String password,
    String firstName,
    String lastName,
    String phoneNumber,
  ) async {
    if (_users.any((user) => user.email == email)) {
      throw Exception('Email já cadastrado');
    }

    final newUser = AppUser(
      id: (_users.length + 1).toString(),
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
    );

    _users.add(newUser);
    _currentUser = newUser;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', newUser.email);
    return newUser;
  }

  @override
  Future<AppUser?> signIn(String email, String password) async {
    final user = _users.firstWhere(
      (user) => user.email == email && user.password == password,
      orElse: () => throw Exception('Email ou senha inválidos'),
    );
    _currentUser = user;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', user.email);

    return user;
  }

  @override
  Future<void> logOut() async {
    _currentUser = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    if (_currentUser == null) {
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString('email'); 
      if (email != null && email.isNotEmpty) {
        try {
          _currentUser = _users.firstWhere(
            (user) => user.email == email,
          );
        } catch (e) {
          _currentUser = null;
        }
      }
    }
    return _currentUser;
  }

  @override
  AppUser empty()  {
    return AppUser(
      id: '-1',
      email: '',
      password: '',
      firstName: '',
      lastName: '',
      phoneNumber: '',
    );
  }

  @override
  AppUser getUser(String email) {
    return _users.firstWhere(
      (user) => user.email == email,
    );
  }
}
