import 'package:crypto_info/common/ui/widgets/back_arrow_button.dart';
import 'package:crypto_info/common/ui/widgets/gradient_container.dart';
import 'package:crypto_info/currency_details/widget/currency_detail_header_information.dart';
import 'package:crypto_info/currency_list/model/currency_ui.dart';
import 'package:flutter/material.dart';

class CurrencyDetailPage extends StatelessWidget {
  const CurrencyDetailPage({
    required CurrencyUi currency,
    Key? key,
  })  : _currency = currency,
        super(key: key);

  final CurrencyUi _currency;

  Widget _buildCurrencyDetails(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const BackArrowButton(),
          CurrencyDetailHeaderInformation(currency: _currency),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const GradientContainer(),
          _buildCurrencyDetails(context),
        ],
      ),
    );
  }
}
