import 'package:carrefour/library/library.dart';
import 'package:flutter/material.dart';

class EbarimgCardWidget extends StatelessWidget {
  const EbarimgCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 164,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          begin: Alignment(-1, -1),
          end: Alignment(1, 1),
          stops: [
            0,
            0.3,
            0.6,
            0.8,
            1,
          ],
          colors: [
            Color(0xff05AD9B),
            Color(0xff88C441),
            Color(0xff05AD9B),
            Color(0xff00ABEB),
            Color(0xff124D85),
          ],
        ),
      ),
      child: Container(
        width: 120,
        height: 120,
        alignment: const Alignment(0, -0.3),
        decoration: const BoxDecoration(
          color: IOColors.backgroundPrimary,
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          'assets/icons/ebarimt.png',
          fit: BoxFit.contain,
          width: 80,
          height: 80,
        ),
      ),
    );
  }
}
