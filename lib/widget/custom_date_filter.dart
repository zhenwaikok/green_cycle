import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/font_manager.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/widget/touchable_capacity.dart';

class CustomDateRangeFilter extends StatefulWidget {
  const CustomDateRangeFilter({
    super.key,
    this.selectedRange,
    this.onDateRangeChanged,
  });

  final DateTimeRange? selectedRange;
  final void Function(DateTimeRange range)? onDateRangeChanged;

  @override
  State<CustomDateRangeFilter> createState() => _CustomDateRangeFilterState();
}

class _CustomDateRangeFilterState extends State<CustomDateRangeFilter> {
  @override
  Widget build(BuildContext context) {
    return getDateFilter();
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _CustomDateRangeFilterState {
  void pickDateRange() async {
    final result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: ColorManager.primary,
              onPrimary: Colors.white,
              onSurface: ColorManager.blackColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: ColorManager.primary,
              ),
            ),
          ),
          child: child ?? SizedBox(),
        );
      },
    );

    if (result != null && widget.onDateRangeChanged != null) {
      widget.onDateRangeChanged!(result);
    }
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _CustomDateRangeFilterState {
  Widget getDateFilter() {
    return TouchableOpacity(
      onPressed: pickDateRange,
      child: IntrinsicWidth(
        child: Container(
          decoration: BoxDecoration(
            color: ColorManager.lightGreyColor2,
            borderRadius: BorderRadius.circular(_Styles.borderRadius),
          ),
          child: Padding(
            padding: _Styles.dateFilterPadding,
            child: getDateText(),
          ),
        ),
      ),
    );
  }

  Widget getDateText() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          widget.selectedRange == null
              ? 'Date'
              : '${WidgetUtil.dateFormatter(widget.selectedRange?.start ?? DateTime.now())} - ${WidgetUtil.dateFormatter(widget.selectedRange?.end ?? DateTime.now())}',

          style: _Styles.dateTextStyle,
        ),
        SizedBox(width: 10),
        Icon(
          Icons.arrow_drop_down,
          color: ColorManager.blackColor,
          size: _Styles.iconSize,
        ),
      ],
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const borderRadius = 10.0;
  static const iconSize = 25.0;

  static const dateFilterPadding = EdgeInsets.symmetric(
    horizontal: 15,
    vertical: 10,
  );

  static const dateTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );
}
