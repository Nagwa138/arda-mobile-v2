part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {}

final class ProfileError extends ProfileState {
  final String error;
  ProfileError(this.error);
}

final class AllInputCheck extends ProfileState {}
final class CheckGenderSuccessful extends ProfileState {}

final class ProfileEditLoading extends ProfileState {}

final class ProfileEditLoaded extends ProfileState {}

final class ProfileEditError extends ProfileState {
  final String error;
  ProfileEditError(this.error);
}
final class CompanyLoading extends ProfileState {}

final class CompanyLoaded extends ProfileState {}

final class CompanyError extends ProfileState {
  final String error;
  CompanyError(this.error);
}

final class CompanyEditLoading extends ProfileState {}

final class CompanyEditLoaded extends ProfileState {}

final class CompanyEditError extends ProfileState {
  final String error;
  CompanyEditError(this.error);
}
