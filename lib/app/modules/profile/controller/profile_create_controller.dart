import 'package:alonecall/app/data/enum.dart';
import 'package:alonecall/app/data/model/profile_model.dart';
import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/data/service/common_service.dart';
import 'package:alonecall/app/routes/routes_management.dart';
import 'package:alonecall/app/utils/utility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:alonecall/app/theme/theme.dart';

class ProfileCreateController extends GetxController {
  final CommonService _controller = Get.find();

  /// The current status of the page.
  PageStatus pageStatus = PageStatus.idle;

  ProfileModel model;
  bool isCheckPrivacy = false;

  List<String> profileImageUrl = <String>['', '', ''];

  @override
  void onInit() async {
    model = ProfileModel();
    model.dob = 'Your Birthday';
    await Utility.getCurrentLatLng().then((value) {
      Utility.printDLog('${value.latitude} ${value.longitude}');
      model
        ..lat = value.latitude
        ..long = value.longitude;
    });
    await Utility.getCurrentLocation().then((value) {
      Utility.printDLog(value.addressLine1);
      model
        ..city = value.city
        ..country = value.country;
      Utility.printDLog('${value.city}, ${value.country}');
      update();
    });
    super.onInit();
  }

  TextEditingController nameController = TextEditingController();

  final CommonService _commonService = Get.find();

  List<String> genderList = <String>[
    'Male',
    'Female',
  ];
  List<String> countryList = <String>['India', 'Nepal', 'Bhutan', 'Pakistan'];
  List<String> languageList = <String>[
    'English',
    'Hindi',
    'Marathi',
    'Telugu',
    'Tamil',
  ];

  void updatePrivacy(bool value) {
    isCheckPrivacy = value;
    update();
  }

  void updateDob(String date) {
    model.dob = date;
    update();
  }

  void showGenderBottomSheet() {
    Get.bottomSheet<void>(
        Container(
          height: 150,
          width: Dimens.screenWidth,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                children: List.generate(
                    genderList.length,
                    (index) => InkWell(
                          onTap: () {
                            model.gender = genderList[index];
                            update();
                            Utility.closeBottomSheet();
                          },
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: Colors.grey.withOpacity(0.4)),
                                borderRadius: BorderRadius.circular(30),
                                color: model.gender == genderList[index]
                                    ? ColorsValue.primaryColor
                                    : Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: const Offset(0, 1),
                                  )
                                ]),
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8),
                                child: Text(
                                  genderList[index],
                                  style: Styles.boldBlack16,
                                )),
                          ),
                        ))),
          ),
        ),
        backgroundColor: Colors.white);
  }

  void showLanguageBottomSheet() {
    Get.bottomSheet<void>(
        Container(
          height: 200,
          width: Dimens.screenWidth,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: SingleChildScrollView(
              child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: List.generate(
                      languageList.length,
                      (index) => InkWell(
                            onTap: () {
                              model.lang = languageList[index];
                              update();
                              Utility.closeBottomSheet();
                            },
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1,
                                      color: Colors.grey.withOpacity(0.4)),
                                  borderRadius: BorderRadius.circular(30),
                                  color: model.lang == languageList[index]
                                      ? ColorsValue.primaryColor
                                      : Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: const Offset(0, 1),
                                    )
                                  ]),
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8),
                                  child: Text(
                                    languageList[index],
                                    style: Styles.blackBold16,
                                  )),
                            ),
                          ))),
            ),
          ),
        ),
        backgroundColor: Colors.white);
  }

  void showCountryBottomSheet() {
    Get.bottomSheet<void>(
        Container(
          height: 200,
          width: Dimens.screenWidth,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: SingleChildScrollView(
              child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: List.generate(
                      countryList.length,
                      (index) => InkWell(
                            onTap: () {
                              model.country = countryList[index];
                              update();
                              Utility.closeBottomSheet();
                            },
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1,
                                      color: Colors.grey.withOpacity(0.4)),
                                  borderRadius: BorderRadius.circular(30),
                                  color: model.country == countryList[index]
                                      ? ColorsValue.primaryColor
                                      : Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: const Offset(0, 1),
                                    )
                                  ]),
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8),
                                  child: Text(
                                    countryList[index],
                                    style: Styles.grey16,
                                  )),
                            ),
                          ))),
            ),
          ),
        ),
        backgroundColor: Colors.white);
  }

  /// Shows a bottom sheet with gallery and camera option
  /// for the user to choose from where the image must be picked.
  void getImage(int index) {
    print('get image function called');
    Get.bottomSheet<void>(
      ListView(
        shrinkWrap: true,
        primary: false,
        children: [
          ListTile(
            leading: const Icon(
              Icons.image,
            ),
            title: Text(
              'gallery',
              style: Styles.black18,
            ),
            onTap: () {
              getImageUrlFromGallery(index);
              Utility.closeBottomSheet();
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.camera,
            ),
            title: Text(
              'camera',
              style: Styles.black18,
            ),
            onTap: () {
              getImageUrlFromCamera(index);
              Utility.closeBottomSheet();
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }

  /// Update the image url which is selected by the user.
  void updateImageUrl(String imageUrl, int index) {
    if (imageUrl.isNotEmpty) {
      print(imageUrl);
      profileImageUrl[index - 1] = imageUrl;
      update();
    }
  }

  /// Get image from gallery.
  void getImageUrlFromGallery(int index) async {
    updateImageUrl(await _commonService.getImageFromGallery(index), index);
  }

  /// Get image from camera.
  void getImageUrlFromCamera(int index) async {
    print('get image from camera called');
    updateImageUrl(await _commonService.getImageFromCamera(index), index);
  }

  /// Upload User data Firebase
  void validateAndSubmit() {
    if (profileImageUrl[0].isNotEmpty ||
        profileImageUrl[1].isNotEmpty ||
        profileImageUrl[2].isNotEmpty) {
      if (nameController.text.isNotEmpty &&
          model.gender != null &&
          model.country != null &&
          model.lang != null &&
          model.dob != null) {
        if (isCheckPrivacy) {
          model
            ..name = nameController.text
            ..coin = 0
            ..online = true
            ..time = Timestamp.now()
            ..audioCoin = 0
            ..profileImageUrl = profileImageUrl
            ..uid = Repository().currentUser();
          updatePageStatus(PageStatus.loading);
          Repository()
              .createProfile(model)
              .whenComplete(RoutesManagement.goToHome);
        } else {
          Utility.showError('Please check Terms And Conditons');
        }
      } else {
        Utility.showError('Enter All field');
      }
    } else {
      Utility.showError('please upload at least one image');
    }
  }

  /// Update the page status
  /// [pageStatus] : the new page status.
  void updatePageStatus(PageStatus pageStatus) {
    this.pageStatus = pageStatus;
    update();
  }
}
