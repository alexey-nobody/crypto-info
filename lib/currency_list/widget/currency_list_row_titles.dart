import 'package:crypto_info/common/ui/app_colors.dart';
import 'package:crypto_info/common/ui/app_text_styles.dart';
import 'package:crypto_info/currency_list/model/currency_list_sorting_type.dart';
import 'package:flutter/material.dart';

class CurrencyListRowTitles extends StatelessWidget {
  const CurrencyListRowTitles({
    required CurrencyListSortingType sortingType,
    required ValueChanged<CurrencyListSortingType> onChangeSorting,
    Key? key,
  })  : _sortingType = sortingType,
        _onChangeSorting = onChangeSorting,
        super(key: key);

  final CurrencyListSortingType _sortingType;
  final ValueChanged<CurrencyListSortingType> _onChangeSorting;

  void _onChangeVolumeSorting() {
    if (_sortingType == CurrencyListSortingType.none) {
      return _onChangeSorting(CurrencyListSortingType.volumeAsc);
    }
    if (_sortingType == CurrencyListSortingType.volumeAsc) {
      return _onChangeSorting(CurrencyListSortingType.volumeDesc);
    }
    if (_sortingType == CurrencyListSortingType.volumeDesc) {
      return _onChangeSorting(CurrencyListSortingType.none);
    }
    return _onChangeSorting(CurrencyListSortingType.volumeAsc);
  }

  void _onChangePriceSorting() {
    if (_sortingType == CurrencyListSortingType.none) {
      return _onChangeSorting(CurrencyListSortingType.priceAsc);
    }
    if (_sortingType == CurrencyListSortingType.priceAsc) {
      return _onChangeSorting(CurrencyListSortingType.priceDesc);
    }
    if (_sortingType == CurrencyListSortingType.priceDesc) {
      return _onChangeSorting(CurrencyListSortingType.none);
    }
    return _onChangeSorting(CurrencyListSortingType.priceAsc);
  }

  Widget _arrowDownIcon() {
    return const Icon(
      Icons.keyboard_arrow_down,
      size: 18,
      color: AppColors.textPrimary,
    );
  }

  Widget _arrowUpIcon() {
    return const Icon(
      Icons.keyboard_arrow_up,
      size: 18,
      color: AppColors.textPrimary,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Pair',
                style: AppTextStyles.bold.copyWith(fontSize: 18),
              ),
            ),
            Expanded(
              child: InkWell(
                customBorder: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(22)),
                ),
                onTap: _onChangeVolumeSorting,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Volume',
                        style: AppTextStyles.bold.copyWith(fontSize: 18),
                      ),
                      if (_sortingType == CurrencyListSortingType.volumeAsc)
                        _arrowDownIcon(),
                      if (_sortingType == CurrencyListSortingType.volumeDesc)
                        _arrowUpIcon(),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                customBorder: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(22)),
                ),
                onTap: _onChangePriceSorting,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (_sortingType == CurrencyListSortingType.priceAsc)
                        _arrowDownIcon(),
                      if (_sortingType == CurrencyListSortingType.priceDesc)
                        _arrowUpIcon(),
                      Text(
                        'Price',
                        style: AppTextStyles.bold.copyWith(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}