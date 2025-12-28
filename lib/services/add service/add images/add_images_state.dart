part of 'add_images_cubit.dart';

@immutable
sealed class AddImagesState {}

final class AddImagesInitial extends AddImagesState {}

final class AddServiceImagesChanged extends AddImagesState {}
