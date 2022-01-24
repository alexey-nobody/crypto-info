import 'package:crypto_info/common/ui/widgets/gradient_container.dart';
import 'package:crypto_info/currency_list/bloc/currency_list_bloc.dart';
import 'package:crypto_info/currency_list/bloc/currency_list_event.dart';
import 'package:crypto_info/currency_list/bloc/currency_list_state.dart';
import 'package:crypto_info/currency_list/model/currency_list_sorting_type.dart';
import 'package:crypto_info/currency_list/widget/currency_list.dart';
import 'package:crypto_info/currency_list/widget/currency_list_loader.dart';
import 'package:crypto_info/currency_list/widget/currency_list_row_titles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurrencyListPage extends StatelessWidget {
  const CurrencyListPage({Key? key}) : super(key: key);

  void onChangeSorting(
    BuildContext context,
    CurrencyListSortingType sortingType,
  ) {
    context.read<CurrencyListBloc>().add(CurrencyListSorted(sortingType));
  }

  Widget _buildCurrencyList(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<CurrencyListBloc, CurrencyListState>(
        builder: (context, state) {
          return Column(
            children: [
              CurrencyListRowTitles(
                sortingType: state.sortingType,
                onChangeSorting: (sortingType) => onChangeSorting(
                  context,
                  sortingType,
                ),
              ),
              Divider(
                height: 1.sp,
                thickness: 0.5.sp,
                indent: 20.sp,
                endIndent: 20.sp,
              ),
              if (state.status == CurrencyListStateStatus.loading)
                const Expanded(child: CurrencyListLoader()),
              if (state.status == CurrencyListStateStatus.loaded)
                Expanded(
                  child: CurrencyList(currencies: state.currencies),
                ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const GradientContainer(),
          _buildCurrencyList(context),
        ],
      ),
    );
  }
}
