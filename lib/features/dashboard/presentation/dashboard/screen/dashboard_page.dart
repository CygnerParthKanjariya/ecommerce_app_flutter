import 'package:ecommerce_app/core/navigation/goto.dart';
import 'package:ecommerce_app/core/navigation/routes.dart';
import 'package:ecommerce_app/core/storage/session/sesssion.dart';
import 'package:flutter/material.dart';
import '../widgets/cart_page.dart';
import '../widgets/home_page.dart';
import '../widgets/profile_page.dart';
import '../widgets/wishlist_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final PageController _pageController = PageController();

  int currentIndex = 0;

  final List<Widget> pages = const [HomePage(), WishlistPage(), CartPage(), ProfilePage()];

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> logout() async {
    await SessionManager.setLoggedIn(false);

    if (!mounted) return;

    context.pushAndRemoveUntil(Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(getTitle(), style: const TextStyle(fontWeight: FontWeight.bold)),
        actions: [IconButton(onPressed: logout, icon: const Icon(Icons.logout))],
      ),

      // PAGE VIEW
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        children: pages,
      ),

      // BOTTOM NAVIGATION
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: changePage,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        elevation: 10,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_rounded), label: "Wishlist"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_rounded), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: "Profile"),
        ],
      ),
    );
  }

  String getTitle() {
    switch (currentIndex) {
      case 0:
        return "Home";
      case 1:
        return "Wishlist";
      case 2:
        return "Cart";
      case 3:
        return "Profile";
      default:
        return "Dashboard";
    }
  }
}
