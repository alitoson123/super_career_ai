import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_career_ai/Features/profile/data/profile_service.dart';
import 'package:super_career_ai/Features/profile/presentation/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileService _service;

  ProfileCubit({required ProfileService service})
    : _service = service,
      super(const ProfileInitial());

  Future<void> fetch() async {
    emit(const ProfileLoading());
    try {
      final profile = await _service.fetchMyProfile();
      emit(ProfileLoaded(profile: profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> save({
    required String fullName,
    required String professionalTitle,
    required String email,
  }) async {
    final current = state;
    if (current is! ProfileLoaded) return;
    emit(current.copyWith(isSaving: true));
    try {
      final updated = await _service.updateMyProfile(
        fullName: fullName,
        professionalTitle: professionalTitle,
        email: email,
      );
      emit(ProfileLoaded(profile: updated, isSaving: false));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
