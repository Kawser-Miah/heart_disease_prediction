import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heart_disease_prediction/data/repository_iml/authentication_repository_iml.dart';
import 'package:heart_disease_prediction/models/user_profile.dart';

import '../utils/storage_service.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final StorageService storageService;
  final AuthenticationRepositoryIml authenticationRepositoryIml;

  ProfileBloc({
    required this.storageService,
    required this.authenticationRepositoryIml,
  }) : super(const ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfile>(_onUpdateProfile);
  }

  Future<void> _onLoadProfile(
    LoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(const ProfileLoading());
      UserModel result = UserModel(
        uid: '',
        name: '',
        email: '',
        photoUrl: '',
        phoneNumber: '',
      );
      try {
        result = await authenticationRepositoryIml.getUserProfile();
        print(result);
      } catch (e) {
        print("error: $e");
      }
      final profile = UserProfile(
        name: result.name ?? '',
        email: result.email ?? '',
        dateOfBirth: result.createdAt!,
        avatarUrl: result.photoUrl ?? '',
        phone: result.phoneNumber ?? '',
        emergencyContact: result.phoneNumber ?? '',
      );
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError('Failed to load profile: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateProfile(
    UpdateProfile event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      await storageService.saveUserProfile(event.profile);
      emit(ProfileLoaded(event.profile));
    } catch (e) {
      emit(ProfileError('Failed to update profile: ${e.toString()}'));
    }
  }
}
