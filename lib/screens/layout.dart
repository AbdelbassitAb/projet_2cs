import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet_2cs/config/config.dart';
import 'package:projet_2cs/screens/all_missions.dart';
import 'package:projet_2cs/screens/login.dart';
import 'package:projet_2cs/services/cloud_service.dart';
import 'package:projet_2cs/widgets/all_widgets.dart';
import 'package:projet_2cs/widgets/default_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

import 'missions.dart';



class Layout extends StatefulWidget {
  static const route = "/layout";
  const Layout({Key? key}) : super(key: key);

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _currentIndex = 0;
  bool isLoading = true;
  getUserData() async {
    try {
      await Provider.of<Auth>(context, listen: false).getUserData();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('test');
      print(e);
      errorSnackBar(context, "Connecting...");
    }
    setState(() {
      isLoading = false;
    });
  }

  final List<Widget> tabs = [
    const Missions(),
    const AllMission()

  ];


  @override
  void initState() {
    super.initState();
    getUserData();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      _currentIndex == 2 ? Colors.white : const Color(0xFFE7F7ED),
      body: isLoading ? Center(child: const CircularProgressIndicator()) : IndexedStack(
        children: tabs,
        index: _currentIndex,
      ),
      bottomNavigationBar: SalomonBottomBar(
        selectedColorOpacity: 1,
        selectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          SalomonBottomBarItem(
            activeIcon: const Icon(
              Icons.home,
              color: secondaryColor,
            ),
            icon: const Icon(Icons.home),
            title:  const Text(
            "Mission en cours",
              style:  TextStyle(color: secondaryColor),
            ),
          ),
          SalomonBottomBarItem(
            activeIcon: const Icon(
              Icons.list,
              color: secondaryColor,
            ),
            icon: const Icon(Icons.list),
            title: const  Text(
              "Tous les missions",
              style:  TextStyle(color: secondaryColor),
            ),
          ),

        ],
      ),
    );
  }
}
