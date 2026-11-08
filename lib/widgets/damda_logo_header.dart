import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

class DamdaLogoHeader extends StatelessWidget {
  const DamdaLogoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;

    return ColoredBox(
      color: AppColors.header,
      child: SizedBox(
        height: 90 + topInset,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(top: topInset),
          child: Center(
            child: Semantics(
              label: '담다',
              image: true,
              child: Image.asset(
                'assets/images/damda_logo.png',
                width: 116,
                height: 48,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
