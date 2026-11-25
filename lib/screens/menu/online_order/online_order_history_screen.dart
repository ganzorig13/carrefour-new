import 'package:carrefour/library/library.dart';
import 'package:flutter/material.dart';

class OnlineOrderHistoryScreen extends StatelessWidget {
  const OnlineOrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(titleText: 'Онлайн захиалгын түүх'),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: IOEmptyWidget(
          icon: 'cart.svg',
          text: 'Онлайн захиалгын түүх байхгүй',
        ),
      ),
    );
  }
}
