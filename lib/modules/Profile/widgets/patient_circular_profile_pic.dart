import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinic_app/modules/Profile/bloc/upload_profile_pic_bloc/upload_profile_pic_bloc.dart';
import 'package:clinic_app/modules/Profile/widgets/image_selector_tile_widget.dart';
import 'package:clinic_app/utils/SharePref.dart';
import 'package:clinic_app/utils/helper/helper.dart';

import '../../../utils/constants/color_konstants.dart';
import '../../../utils/constants/image_konstants.dart';
import '../../../utils/enums.dart';

class PatientCircularProfilePic extends StatelessWidget {
  final String profilePhotoUrl;
  const PatientCircularProfilePic({Key? key, required this.profilePhotoUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final uploadProfilePicBloc = BlocProvider.of<UploadProfilePicBloc>(context);

    return BlocBuilder<UploadProfilePicBloc, UploadProfilePicState>(
        builder: (context, state) {
      return BlocListener<UploadProfilePicBloc, UploadProfilePicState>(
        listener: (context, state) {
          if (state is UploadProfilePicLoadingState) {
            showDialog(
              context: context,
              builder: (context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          } else {
            Navigator.pop(context);
            // BlocProvider.of<PatientBloc>(context).add(FetchPatientData());
          }
        },
        child: InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (dialogContext) {
                    return Dialog(
                      child: Container(
                        width: size.width * 0.8,
                        height: size.width * 0.8,
                        color: ColorKonstants.blueccolor,
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Center(
                                  child: sharedPrefs.getProfilePic.isEmpty
                                      ? CircleAvatar(
                                          radius: 30,
                                          //backgroundColor: Colors.grey,
                                          backgroundImage: const AssetImage(
                                              ImagesConstants.profileimage),
                                          backgroundColor: Colors.transparent,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 4.0,
                                              ),
                                            ),
                                          ),
                                          // child: Padding(
                                          //   padding: EdgeInsets.all(8.0),
                                          //   child: Icon(
                                          //     Icons.camera_enhance,
                                          //     color: Colors.white,
                                          //     size: 35,
                                          //   ),
                                          // ),
                                        )
                                      : Image.network(
                                          sharedPrefs.getProfilePic)),
                            ),
                            Positioned(
                                right: 0,
                                top: 0,
                                child: InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (bottomSheetContext) {
                                            return SizedBox(
                                              height: size.height * .3,
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 50,
                                                    width: size.width,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    color: ColorKonstants
                                                        .primaryColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20),
                                                    child: const Text(
                                                      "Change profile picture",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                  Wrap(
                                                    children: [
                                                      ImageSelectorTileWidget(
                                                        type: ImageSelectorType
                                                            .gallery,
                                                        uploadProfilePicBloc:
                                                            uploadProfilePicBloc,
                                                      ),
                                                      ImageSelectorTileWidget(
                                                        type: ImageSelectorType
                                                            .camera,
                                                        uploadProfilePicBloc:
                                                            uploadProfilePicBloc,
                                                      ),
                                                      ListTile(
                                                        onTap: () async {
                                                          // uploadProfilePicBloc.add(
                                                          //     onSelectProfileImageEvent(
                                                          //         profileImage:
                                                          //             null));
                                                          WidgetHelper.showToast(
                                                              'Coming Soon!');
                                                          Navigator.of(context)
                                                              .pop();
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        leading: Icon(
                                                          Icons.delete,
                                                          color: ColorKonstants
                                                              .errorColor,
                                                        ),
                                                        title: const Text(
                                                            'Delete profile picture'),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ))),
                          ],
                        ),
                      ),
                    );
                  });
            },
            child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 27,
                backgroundImage: sharedPrefs.getProfilePic != null
                    ? NetworkImage(sharedPrefs.getProfilePic)
                    : const NetworkImage(
                        ImagesConstants.networkImageProfilePicPlacholder))),
      );
    });
  }
}
