import 'package:flutter/material.dart';

class AppBarStyle extends StatelessWidget {
  const AppBarStyle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Icon(
            Icons.menu,
            size: 30.0,
            color: Colors.grey,
          ),
          Icon(
            Icons.shopping_cart,
            size: 30.0,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
