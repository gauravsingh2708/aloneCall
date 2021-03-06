import 'package:alonecall/app/modules/call/binding/audio_call_binding.dart';
import 'package:alonecall/app/modules/call/binding/video_call_binding.dart';
import 'package:alonecall/app/modules/call/view/audio_call_view.dart';
import 'package:alonecall/app/modules/call/view/video_call_view.dart';
import 'package:alonecall/app/modules/edit_profile/binding/profile_edit_binding.dart';
import 'package:alonecall/app/modules/edit_profile/view/profile_edit_view.dart';
import 'package:alonecall/app/modules/home/binding/home_binding.dart';
import 'package:alonecall/app/modules/home/view/home_view.dart';
import 'package:alonecall/app/modules/home/view/page/fliter_view.dart';
import 'package:alonecall/app/modules/home/view/page/profile_page.dart';
import 'package:alonecall/app/modules/login/view/login_view.dart';
import 'package:alonecall/app/modules/login/binding/login_binding.dart';
import 'package:alonecall/app/modules/login/view/page/otp_view.dart';
import 'package:alonecall/app/modules/login/view/page/phone_input_view.dart';
import 'package:alonecall/app/modules/payment/binding/payment_binding.dart';
import 'package:alonecall/app/modules/payment/view/payment_view.dart';
import 'package:alonecall/app/modules/profile/binding/profile_create_binding.dart';
import 'package:alonecall/app/modules/profile/view/profile_create_view.dart';
import 'package:alonecall/app/modules/profile/view/terms_and_conditions_view.dart';
import 'package:alonecall/app/modules/random/binding/random_call_binding.dart';
import 'package:alonecall/app/modules/random/view/random_call_view.dart';
import 'package:alonecall/app/modules/search_users/binding/search_binding.dart';
import 'package:alonecall/app/modules/search_users/view/search_users_view.dart';
import 'package:alonecall/app/modules/settings/binding/setting_binding.dart';
import 'package:alonecall/app/modules/settings/view/blocked_list_view.dart';
import 'package:alonecall/app/modules/settings/view/settings_view.dart';
import 'package:alonecall/app/modules/userDetails/binding/user_details_binding.dart';
import 'package:alonecall/app/modules/userDetails/view/user_details_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

/// Contains the list of pages or routes taken across the whole application.
/// This will prevent us in using context for navigation. And also providing
/// the blocs required in the next named routes.
///
/// [pages] : will contain all the pages in the application as a route
///                 and will be used in the material app.
abstract class AppPages{
  static const initial = _Paths.login;
  static var transitionDuration = const Duration(
    milliseconds: 300,
  );

  static final pages = <GetPage>[
    GetPage(
      name: _Paths.home,
      transitionDuration: transitionDuration,
      page: () => HomeView(),
      binding: HomeBinding(),
      transition: Transition.downToUp,
    ),

    GetPage(
      name: _Paths.login,
      transitionDuration: transitionDuration,
      page: () => LoginView(),
      binding: LoginBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Paths.otp,
      transitionDuration: transitionDuration,
      page: () => OtpView(),
      binding: LoginBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Paths.phoneNumber,
      transitionDuration: transitionDuration,
      page: () => PhoneNumberView(),
      binding: LoginBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Paths.profile,
      transitionDuration: transitionDuration,
      page: () => ProfileCreateView(),
      binding: ProfileCreateBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Paths.detailsPage,
      transitionDuration: transitionDuration,
      page: () => UserDetailsView(),
      binding: UserDetailsBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Paths.videoCall,
      transitionDuration: transitionDuration,
      page: () => VideoCallView(),
      binding: VideoCallBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Paths.audioCall,
      transitionDuration: transitionDuration,
      page: () => AudioCallView(),
      binding: AudioCallBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Paths.payment,
      transitionDuration: transitionDuration,
      page: () => PaymentView(),
      binding: PaymentBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Paths.random,
      transitionDuration: transitionDuration,
      page: () => RandomCallView(),
      binding: RandomCallBinding(),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: _Paths.editProfile,
      transitionDuration: transitionDuration,
      page: () => ProfileEditView(),
      binding: ProfileEditBinding(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: _Paths.settings,
      transitionDuration: transitionDuration,
      page: () => SettingsView(),
      binding: SettingBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.searchPage,
      transitionDuration: transitionDuration,
      page: () => SearchUsers(),
      binding: SearchBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Paths.blockedList,
      transitionDuration: transitionDuration,
      page: () => BlockedList(),
      binding: SettingBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.filter,
      transitionDuration: transitionDuration,
      page: () => FilterView(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Paths.termsAndConditions,
      transitionDuration: transitionDuration,
      page: () => TermsAndConditionsView(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Paths.myProfileScreen,
      transitionDuration: transitionDuration,
      page: () => ProfileView(),
    ),
  ];

}