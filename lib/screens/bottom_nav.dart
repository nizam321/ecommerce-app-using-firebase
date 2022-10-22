import 'package:ecommerce/bottom_nav_pages/cart.dart';
import 'package:ecommerce/bottom_nav_pages/favoret.dart';
import 'package:ecommerce/bottom_nav_pages/home.dart';
import 'package:ecommerce/bottom_nav_pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class BottomNavComtroller extends StatefulWidget {
  const BottomNavComtroller({super.key});

  @override
  State<BottomNavComtroller> createState() => _BottomNavComtrollerState();
}

class _BottomNavComtrollerState extends State<BottomNavComtroller> {
  final Pages = [HomePage(), Favorate(), Cart(), Profile()];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
            print(currentIndex);
          });
        },
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorate",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      body: Pages[currentIndex],
    );
  }
}
