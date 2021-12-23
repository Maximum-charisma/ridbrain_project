import 'package:flutter/material.dart';
import 'package:ridbrain_project/screens/accept_orders_screen.dart';
import 'package:ridbrain_project/screens/account_screen.dart';
import 'package:ridbrain_project/screens/new_orders_screen.dart';
import 'package:ridbrain_project/services/tab_item.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

final List<TabItem> _tabBar = [
  TabItem(title: 'Новые заявки', icon: const Icon(Icons.mail_outline)),
  TabItem(title: 'Принятые заявки', icon: const Icon(Icons.check_box_outlined)),
  TabItem(title: 'Профиль', icon: const Icon(Icons.account_circle_outlined)),
];

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabBar.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.3,
        backgroundColor: Colors.white,
        title: Text(
          _tabBar[_tabController.index].title,
          style: const TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.black,
        onTap: (index) {
          setState(() {
            _tabController.index = index;
            _currentTabIndex = index;
          });
        },
        currentIndex: _currentTabIndex,
        items: [
          for (final item in _tabBar)
            BottomNavigationBarItem(icon: item.icon, label: item.title)
        ],
      ),
      backgroundColor: Colors.white,
      body: TabBarView(controller: _tabController, children: const [
        NewOrdersScreen(),
        AcceptOrdersScreen(),
        AccountScreen(),
      ]),
    );
  }
}
