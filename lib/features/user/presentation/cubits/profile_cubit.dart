import 'package:bloc/bloc.dart';
import 'package:mobile_pizzaria_app/features/user/domain/entities/profile_user.dart';
import 'package:mobile_pizzaria_app/features/user/domain/repos/iprofile_user_repo.dart';
import 'package:mobile_pizzaria_app/features/user/presentation/cubits/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final IProfileUserRepo profileRepo;
  ProfileUser? _currentProfileUser;

  ProfileCubit({required this.profileRepo}) : super(ProfileInitial());


  void checkProfile() async {
    final ProfileUser? user = await profileRepo.getProfileUser(); 

    if (user != null) {
      _currentProfileUser = user;
      emit(ProfileLoaded(profileUser: user));
    } else {
      emit(ProfileError(message: 'Erro ao carregar perfil'));
    }
  }

  ProfileUser? get currentProfileUser => _currentProfileUser;
  
  Future<void> getUserProfile() async {
    emit(ProfileLoading());
    try {
      final ProfileUser? user = await profileRepo.getProfileUser();
      if (user != null) {
        _currentProfileUser = user;
        emit(ProfileLoaded(profileUser: user));
      } else {
        emit(ProfileError(message: 'Erro ao carregar perfil'));
      }
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  Future<void> updateProfile(ProfileUser user) async {
    emit(ProfileLoading());
    try {
      await profileRepo.updateProfileUser(user);
      emit(ProfileLoaded(profileUser: user));
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }
}
