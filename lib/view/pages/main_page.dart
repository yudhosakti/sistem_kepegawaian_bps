import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:simpeg/provider/bottom_nav_provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(241, 238, 252, 1),
      appBar: null,
      body: Consumer<BottomNavProvider>(builder: (context, provider, child) {
        return provider.page[provider.pageIndex];
      }),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child:
              Consumer<BottomNavProvider>(builder: (context, provider, child) {
            return GNav(
              tabMargin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.03),
              style: GnavStyle.google,
              gap: 12,
              activeColor: Colors.white,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Color.fromRGBO(121, 102, 255, 1),
              selectedIndex: provider.pageIndex,
              onTabChange: (value) {
                provider.changeWidget(value);
              },
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.chat,
                  text: 'AI Chat',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
