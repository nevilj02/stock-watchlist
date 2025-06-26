import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../blocs/stock_list/stock_list_bloc.dart';
import '../../blocs/stock_list/stock_list_state.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_fonts.dart';
import '../../core/constants/app_icons.dart';
import '../../core/utils/theme_utils.dart';
import '../../core/widgets/button_icon.dart';
import '../../core/widgets/custom_app_bar.dart';

class StockDetailsPage extends StatefulWidget {
  final String symbol;

  const StockDetailsPage({required this.symbol, super.key});

  @override
  State<StockDetailsPage> createState() => _StockDetailsPageState();
}

class _StockDetailsPageState extends State<StockDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StockListBloc, StockListState>(
      listener: _blocListener,
      builder:
          (context, state) =>
              Scaffold(backgroundColor: AppColors.textBlack, body: _mainBody()),
    );
  }

  _blocListener(BuildContext context, StockListState state) {}

  _appBar() => CustomAppBar(
    leading: ButtonIcon(
      onTap: () => Get.back(),
      borderWith: 0.5,
      borderColor: AppColors.white.withOpacity(0.08),
      btnShape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: AppColors.black.withOpacity(0.06),
          offset: const Offset(0, 2),
          blurRadius: 3,
          spreadRadius: 0,
        ),
      ],
      child: SvgPicture.asset(
        AppIcons.svgGoBack,
        width: 24.h,
        height: 24.h,
        colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
      ),
    ),
    label: '',
    backgroundColor: AppColors.textBlack,
    verticalPadding: 27.h,
    horizontalPadding: 0,
  );

  _mainBody() => SingleChildScrollView(
    child: Padding(
      padding: REdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _appBar(),
          5.verticalSpace,
          _headerView(),
          32.verticalSpace,
          _priceView(),
          24.verticalSpace,
          _PerformanceView(),
          48.verticalSpace,
          _CalendarYearReturnsCard(),
          48.verticalSpace,
          _PerformanceEventsCard(),
          32.verticalSpace,
        ],
      ),
    ),
  );

  _headerView() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'HDFC Bank Large Cap Fund Direct Growth',
        style: ThemeUtils.textStyle(fontSize: 32.sp),
      ),
      8.verticalSpace,
      Text(
        'Tracks stocks showing sudden price moves with strong short-term momentum',
        style: ThemeUtils.textStyle(
          fontSize: 16.sp,
          color: AppColors.xThinGrey,
        ),
      ),
      16.verticalSpace,
      Row(
        children: [
          _Tag(
            icon: AppIcons.svgHighRisk,
            label: 'High Risk',
            color: AppColors.riskRed,
            bgColor: AppColors.bgBlack,
          ),
          12.horizontalSpace,
          _Tag(
            icon: AppIcons.svgSuitable,
            label: 'Suits current market',
            color: AppColors.btnBlue,
            bgColor: AppColors.bgBlack,
          ),
        ],
      ),
    ],
  );

  _priceView() => Row(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('₹72,651', style: ThemeUtils.textStyle(fontSize: 14.sp)),
          6.verticalSpace,
          Text(
            'Min. amount',
            style: ThemeUtils.textStyle(
              fontSize: 12.sp,
              color: AppColors.xThinGrey,
            ),
          ),
        ],
      ),
      32.horizontalSpace,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '84.62%',
            style: ThemeUtils.textStyle(
              fontSize: 14.sp,
              color: AppColors.textGreen,
            ),
          ),
          2.verticalSpace,
          Text(
            '2Y CAGR',
            style: ThemeUtils.textStyle(
              fontSize: 12.sp,
              color: AppColors.xThinGrey,
            ),
          ),
        ],
      ),
    ],
  );
}

class _Tag extends StatelessWidget {
  final String icon;
  final String label;
  final Color color;
  final Color bgColor;

  const _Tag({
    required this.icon,
    required this.label,
    required this.color,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(color: color, width: 0.5),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            width: 12.h,
            height: 12.h,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
          6.horizontalSpace,
          Text(
            label,
            style: ThemeUtils.textStyle(fontSize: 12.sp, color: color),
          ),
        ],
      ),
    );
  }
}

class _PerformanceView extends StatefulWidget {
  const _PerformanceView();

  @override
  State<_PerformanceView> createState() => _PerformanceViewState();
}

class _PerformanceViewState extends State<_PerformanceView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StockListBloc, StockListState>(
      listener: _blocListener,
      builder: (context, state) => _mainBody(),
    );
  }

  _blocListener(BuildContext context, StockListState state) {}

  final List<String> _performanceFilters = [
    '1W',
    '1M',
    '3M',
    '6M',
    '1Y',
    '5Y',
    'Max',
  ];

  int selectedIndex = 1;

  _mainBody() => Container(
    width: double.infinity,
    decoration: ThemeUtils.boxDecoration(
      color: AppColors.bgGrey,
      borderRadius: 16,
    ),
    padding: REdgeInsets.symmetric(horizontal: 10, vertical: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: REdgeInsets.only(left: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Live Performance vs.',
                style: ThemeUtils.textStyle(fontSize: 14.sp),
              ),
              Container(
                padding: REdgeInsets.symmetric(horizontal: 18, vertical: 12),
                decoration: ThemeUtils.boxDecoration(
                  color: AppColors.lightBlack,
                  borderRadius: 4.r,
                  border: Border.all(
                    color: AppColors.borderGrey.withOpacity(0.64),
                    width: 0.5,
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      'Equity Large Cap',
                      style: ThemeUtils.textStyle(color: AppColors.xThinGrey),
                    ),
                    8.horizontalSpace,
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.textWhite,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        24.verticalSpace,
        _filterView(),
        24.verticalSpace,
        Text('10.48%', style: ThemeUtils.textStyle(color: AppColors.btnBlue)),
        6.verticalSpace,
        Text(
          'This Stock',
          style: ThemeUtils.textStyle(
            fontSize: 12.sp,
            color: AppColors.xThinGrey,
          ),
        ),
        24.verticalSpace,
        Divider(height: 1.h, color: AppColors.bgDarkGrey),
        _ChartPlaceholder(),
      ],
    ),
  );

  _filterView() => SizedBox(
    height: 24.h,
    child: ListView.separated(
      itemBuilder:
          (context, index) => _TimeFilterButton(
            label: _performanceFilters[index],
            selected: index == selectedIndex,
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
      separatorBuilder: (context, index) => 10.horizontalSpace,
      itemCount: _performanceFilters.length,
      scrollDirection: Axis.horizontal,
    ),
  );
}

class _TimeFilterButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TimeFilterButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: REdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: ThemeUtils.boxDecoration(
          color:
              selected
                  ? AppColors.btnBlue.withOpacity(0.06)
                  : AppColors.darkBlack,
          borderRadius: 4.r,
          border: Border.all(
            color:
                selected
                    ? AppColors.btnBlue
                    : AppColors.borderGrey.withOpacity(0.64),
            width: 0.5,
          ),
        ),
        child: Text(
          label,
          style: ThemeUtils.textStyle(
            fontSize: 12.sp,
            color: selected ? AppColors.btnBlue : AppColors.xThinGrey,
          ),
        ),
      ),
    );
  }
}

class _CalendarYearReturnsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Calendar Year Returns',
          style: ThemeUtils.textStyle(
            fontSize: 16.sp,
            color: AppColors.textWhite,
          ),
        ),
        24.verticalSpace,
        _ChartPlaceholder(),
        22.verticalSpace,
        Row(
          children: [
            _LegendDot(color: AppColors.btnBlue),
            8.horizontalSpace,
            Text(
              'Short-Term Trend Catcher',
              style: ThemeUtils.textStyle(
                fontSize: 12.sp,
                color: AppColors.xThinGrey,
              ),
            ),
            32.horizontalSpace,
            _LegendDot(color: AppColors.borderGrey),
            8.horizontalSpace,
            Text(
              'Benchmark',
              style: ThemeUtils.textStyle(
                fontSize: 12.sp,
                color: AppColors.xThinGrey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PerformanceEventsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: ThemeUtils.boxDecoration(
        color: AppColors.bgGrey,
        borderRadius: 16,
      ),
      padding: REdgeInsets.symmetric(horizontal: 18, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Performance in Events',
            style: ThemeUtils.textStyle(
              fontSize: 16.sp,
              color: AppColors.white,
            ),
          ),
          32.verticalSpace,
          _ChartPlaceholder(),
          32.verticalSpace,
          Row(
            children: [
              _LegendDot(color: AppColors.btnBlue),
              8.horizontalSpace,
              Text(
                'Short-Term Trend Catcher',
                style: ThemeUtils.textStyle(
                  fontSize: 12.sp,
                  color: AppColors.thinGrey,
                ),
              ),
              18.horizontalSpace,
              _LegendDot(color: AppColors.borderGrey),
              8.horizontalSpace,
              Text(
                'Benchmark',
                style: ThemeUtils.textStyle(
                  fontSize: 12.sp,
                  color: AppColors.thinGrey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class _ChartPlaceholder extends StatelessWidget {
  const _ChartPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.8, // Controls dynamic height based on width
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: LineChart(_buildChartData()),
      ),
    );
  }

  LineChartData _buildChartData() {
    final List<double> data1 = [
      50000, 80000, 75000, 40000, 30000, 45000, 70000, 90000, 120000, 145000
    ];
    final List<double> data2 = [
      48000, 72000, 70000, 50000, 42000, 55000, 60000, 80000, 100000, 120000
    ];

    final maxY = [...data1, ...data2].reduce((a, b) => a > b ? a : b);

    return LineChartData(
      minY: 0,
      maxY: maxY * 1.1,
      backgroundColor: Colors.transparent,
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (_) => FlLine(
          color: Colors.white.withOpacity(0.05),
          strokeWidth: 1,
        ),
      ),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 48,
            interval: 25000,
            getTitlesWidget: (value, _) => Text(
              value == 0 ? '0' : '₹${(value ~/ 1000)}K',
              style: const TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, _) {
              const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sept', 'Oct'];
              if (value >= 0 && value < months.length) {
                return Text(
                  months[value.toInt()],
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      lineBarsData: [
        _buildLine(data1, Colors.cyanAccent),
        _buildLine(data2, Colors.white),
      ],
    );
  }

  LineChartBarData _buildLine(List<double> values, Color color) {
    return LineChartBarData(
      spots: values.asMap().entries
          .map((e) => FlSpot(e.key.toDouble(), e.value))
          .toList(),
      isCurved: true,
      color: color,
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
    );
  }
}


class _LegendDot extends StatelessWidget {
  final Color color;

  const _LegendDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
