import 'package:bloc/bloc.dart';
import 'package:mobile_pizzaria_app/features/auth/domain/entities/app_user.dart';
import 'package:mobile_pizzaria_app/features/auth/domain/repos/iauth_repo.dart';
import 'package:mobile_pizzaria_app/features/auth/presentation/cubits/auth_state.dart';
import 'package:mobile_pizzaria_app/features/user/data/profile_user_repo.dart';

class AuthCubit extends Cubit<AuthState> {
  final IAuthRepo authRepo;
  AppUser? _currentUser;

  AuthCubit({required this.authRepo}) : super(AuthInitial());

  void checkAuth() async {
    final AppUser? user = await authRepo.getCurrentUser();

    if (user != null) {
      _currentUser = user;
      emit(Authenticated(user));
    } else {
      emit(Unauthenticated());
    }
  }

  AppUser? get currentUser => _currentUser;

  Future<void> login(String email, String password) async {
    emit(AuthLoading());

    try {
      final AppUser? user = await authRepo
          .signIn(email, password)
          .timeout(const Duration(seconds: 10));

      if (user == null) {
        emit(Unauthenticated());
        return;
      }

      _currentUser = user;
      emit(Authenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  Future<void> register(
    String email,
    String password,
    String firstName,
    String lastName,
    String phoneNumber,
  ) async {
    emit(AuthLoading());
    try {
      final AppUser? user = await authRepo.register(
        email,
        password,
        firstName,
        lastName,
        phoneNumber,
      );

      if (user == null) {
        emit(Unauthenticated());
        return;
      }

      ProfileUserRepo().addUser(user);

      _currentUser = user;
      emit(Authenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  Future<void> logout() async {
    await authRepo.logOut();
    _currentUser = null;
    emit(Unauthenticated());
  }
}
