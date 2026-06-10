import 'package:super_career_ai/Features/profile/data/models/profile_model.dart';

sealed class ProfileState {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileLoaded extends ProfileState {
  final ProfileModel profile;
  final bool isSaving;

  const ProfileLoaded({required this.profile, this.isSaving = false});

  ProfileLoaded copyWith({ProfileModel? profile, bool? isSaving}) {
    return ProfileLoaded(
      profile: profile ?? this.profile,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}

class ProfileError extends ProfileState {
  final String message;
  const ProfileError(this.message);
}
