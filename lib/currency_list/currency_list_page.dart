import 'package:crypto_info/common/ui/app_text_styles.dart';
import 'package:crypto_info/common/ui/gradient_container.dart';
import 'package:flutter/material.dart';

class CurrencyListPage extends StatelessWidget {
  const CurrencyListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const GradientContainer(),
          Align(
            child: Text('Test', style: AppTextStyles.lightTextStyle),
          ),
        ],
      ),
    );
  }
}
