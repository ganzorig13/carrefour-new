import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BranchListWidget extends StatelessWidget {
  final List<BranchModel> branches;
  const BranchListWidget({super.key, required this.branches});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: IOColors.backgroundSecondary,
      child: ListView.separated(
        padding: EdgeInsets.only(
          top: 76,
          left: 24,
          right: 24,
          bottom: 24 + Get.mediaQuery.padding.bottom,
        ),
        itemBuilder: (context, index) {
          return BranchListItemWidget(
            branch: branches[index],
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16);
        },
        itemCount: branches.length,
      ),
    );
  }
}
