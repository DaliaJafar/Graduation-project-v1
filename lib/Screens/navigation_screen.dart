import 'package:firebase_login_app/Screens/home_screen.dart';
import 'package:firebase_login_app/Screens/login_screen.dart';
import 'package:firebase_login_app/Screens/map_screen.dart';
import 'package:firebase_login_app/Screens/profile.dart';
import 'package:firebase_login_app/Screens/search_by_map.dart';
import 'package:firebase_login_app/Screens/search_screen.dart';
import 'package:firebase_login_app/Screens/signup_screen.dart';
import 'package:firebase_login_app/Screens/student_edit_profile.dart';
import 'package:firebase_login_app/Screens/student_profile.dart';
import 'package:firebase_login_app/Screens/upcomingSessions_screen%20copy.dart';
import 'package:firebase_login_app/Screens/usertype_screen.dart';
import 'package:flutter/material.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    with TickerProviderStateMixin<NavigationScreen> {
  static const List<Destination> allDestinations = <Destination>[
    Destination(0, 'Home', Icons.home, Colors.purple, HomeScreen()),
    Destination(1, 'Calendar', Icons.calendar_month_outlined, Colors.purple,
        UpcomingSessionsScreenCopy()),
    Destination(
        2, 'Map', Icons.map_outlined, Colors.purple, SearchByMapScreen()),
    Destination(3, 'Search', Icons.search, Colors.purple, SearchScreen()),
    Destination(
        4, 'Profile', Icons.person, Colors.purple, StudentEditProfileUI()),
  ];

  late final List<GlobalKey<NavigatorState>> navigatorKeys;
  late final List<GlobalKey> destinationKeys;
  late final List<AnimationController> destinationFaders;
  late final List<Widget> destinationViews;
  int selectedIndex = 0;

  AnimationController buildFaderController() {
    final AnimationController controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.dismissed) {
        setState(() {}); // Rebuild unselected destinations offstage.
      }
    });
    return controller;
  }

  @override
  void initState() {
    super.initState();
    navigatorKeys = List<GlobalKey<NavigatorState>>.generate(
        allDestinations.length, (int index) => GlobalKey()).toList();
    destinationFaders = List<AnimationController>.generate(
        allDestinations.length, (int index) => buildFaderController()).toList();
    destinationFaders[selectedIndex].value = 1.0;
    destinationViews = allDestinations.map((Destination destination) {
      return FadeTransition(
        opacity: destinationFaders[destination.index]
            .drive(CurveTween(curve: Curves.fastOutSlowIn)),
        child: destination.screen,
      );
    }).toList();
  }

  @override
  void dispose() {
    for (final AnimationController controller in destinationFaders) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final NavigatorState navigator =
            navigatorKeys[selectedIndex].currentState!;
        if (!navigator.canPop()) {
          return true;
        }
        navigator.pop();
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          top: false,
          child: Stack(
            fit: StackFit.expand,
            children: allDestinations.map((Destination destination) {
              final int index = destination.index;
              final Widget view = destinationViews[index];
              if (index == selectedIndex) {
                destinationFaders[index].forward();
                return Offstage(offstage: false, child: view);
              } else {
                destinationFaders[index].reverse();
                if (destinationFaders[index].isAnimating) {
                  return IgnorePointer(child: view);
                }
                return Offstage(child: view);
              }
            }).toList(),
          ),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: (int index) {
            setState(() {
              selectedIndex = index;
            });
          },
          destinations: allDestinations.map((Destination destination) {
            return NavigationDestination(
              icon: Icon(destination.icon, color: destination.color),
              label: destination.title,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class Destination {
  const Destination(this.index, this.title, this.icon, this.color, this.screen);
  final int index;
  final String title;
  final IconData icon;
  final MaterialColor color;
  final Widget screen;
}
