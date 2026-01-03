import 'package:PassPort/services/add%20service/add_service_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'add_images_state.dart';

class AddImagesCubit extends Cubit<AddImagesState> {
  AddImagesCubit() : super(AddImagesInitial());
  List<XFile> serviceImages = [];
  int serviceImageCoverImageNumber = 0;

  addServiceImages(BuildContext context) async {
    final ImagePicker imagePicker = ImagePicker();
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage(
      imageQuality: 70,
      maxWidth: 1920,
    );
    if (selectedImages!.isNotEmpty) {
      serviceImages.addAll(selectedImages);
      BlocProvider.of<AddServiceCubit>(context)
          .addServiceImages(selectedImages);
    }

    print(serviceImages);
    emit(AddServiceImagesChanged());
  }

  addServiceImagesFromCamera(
    BuildContext context,
  ) async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? selectedImages = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 70,
      maxWidth: 1920,
    );
    if (selectedImages != null) {
      serviceImages.add(selectedImages);
      BlocProvider.of<AddServiceCubit>(context)
          .addServiceImages([selectedImages]);
    }
    print(serviceImages);
    emit(AddServiceImagesChanged());
  }

  removeServiceImage(BuildContext context, int index) {
    serviceImages.removeAt(index);
    BlocProvider.of<AddServiceCubit>(context).removeServiceImage(index);
    emit(AddServiceImagesChanged());
  }

  changeServiceImageCoverImageNumber(BuildContext context, int index) {
    BlocProvider.of<AddServiceCubit>(context)
        .changeServiceImageCoverImageNumber(index);

    emit(AddServiceImagesChanged());
  }
}
