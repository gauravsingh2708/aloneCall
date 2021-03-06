import 'package:alonecall/app/data/service/call_service.dart';
import 'package:alonecall/app/modules/home/controller/home_controller.dart';
import 'package:alonecall/app/modules/home/view/local_widget/bottom_navigation.dart';
import 'package:alonecall/app/modules/home/view/page/history.dart';
import 'package:alonecall/app/modules/home/view/page/home_page.dart';
import 'package:alonecall/app/modules/home/view/page/location_page.dart';
import 'package:alonecall/app/modules/home/view/page/notification_page.dart';
import 'package:alonecall/app/modules/home/view/page/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetBuilder<HomeController>(
      builder: (_controller) => SafeArea(
            child: Scaffold(
              floatingActionButton: GetBuilder<CallService>(
                  builder: (_controller) => _controller.callingModel.callerUid == null
                      ? const SizedBox()
                      : FloatingActionButton(
                          onPressed: () {
                            _controller.showCallDialog();
                          },
                          child: const Icon(
                            Icons.call,
                            color: Colors.black,
                          ),
                        )),
              backgroundColor: Colors.white,
              bottomNavigationBar: BottomNavigation(),
              body: IndexedStack(
                index: _controller.currentTab,
                children: [
                  HomePage(),
                  NearYouMapView(),
                  HistoryPage(),
                  NotificationPage(),
                  ProfileView()
                ],
              ),
            ),
          ));
}
