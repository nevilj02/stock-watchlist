import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:stock_watchlist_app/core/widgets/custom_fab.dart';
import '../../blocs/stock_list/stock_list_bloc.dart';
import '../../blocs/stock_list/stock_list_event.dart';
import '../../blocs/stock_list/stock_list_state.dart';
import '../../core/constants/app_fonts.dart';
import '../../core/constants/app_icons.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/dialog_utils.dart';
import '../../core/utils/theme_utils.dart';
import '../../core/widgets/button_icon.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../core/widgets/shimmer_view.dart';
import 'widgets/stock_item_tile.dart';
import '../../models/stock_item.dart';

// import 'package:fl_chart/fl_chart.dart'; // Removed as per user request
import '../../core/constants/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/routes/app_routes.dart';
import 'widgets/delete_from_watchlist_sheet.dart';

class StockListPage extends StatefulWidget {
  const StockListPage({super.key});

  @override
  State<StockListPage> createState() => _StockListPageState();
}

class _StockListPageState extends State<StockListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocConsumer<StockListBloc, StockListState>(
      listener: _blocListener,
      builder:
          (context, state) => Scaffold(
            backgroundColor: AppColors.textBlack,
            body: _mainBody(),
            floatingActionButton: CustomFab(
              onTap: () => Get.toNamed(AppRoutes.search),
            ),
          ),
    );
  }

  bool isLoadingStocks = false;

  String? errorMessage;

  List<StockItem> stocks = [];

  _blocListener(BuildContext context, StockListState state) {
    if (state is StockListLoading) {
      isLoadingStocks = true;
    } else if (state is StockListLoaded) {
      stocks = state.stocks;
      errorMessage = null;
      isLoadingStocks = false;
    } else if (state is StockListError) {
      errorMessage = state.message;
      isLoadingStocks = false;
    }
  }

  _mainBody() => Padding(
    padding: REdgeInsets.symmetric(horizontal: 8),
    child: Column(
      children: [
        _appBar(),
        Expanded(
          child:
              isLoadingStocks
                  ? _loadingStockView()
                  : errorMessage != null
                  ? _errorView()
                  : stocks.isEmpty
                  ? _noStocksView()
                  : _stocksListView(),
        ),
        30.verticalSpace,
      ],
    ),
  );

  _appBar() => CustomAppBar(
    verticalPadding: 27.h,
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
    label: AppStrings.watchlistTitle,
  );

  _loadingStockView() => ShimmerView(
    child: ListView.builder(
      itemCount: 5,
      itemBuilder:
          (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.bgDarkGrey,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
    ),
  );

  _errorView() => Center(
    child: Text(
      errorMessage ?? AppStrings.somethingWentWrong,
      style: ThemeUtils.textStyle(color: AppColors.red, fontSize: 16.sp),
    ),
  );

  _noStocksView() => Center(
    child: Text(
      AppStrings.noStocksInWatchlist,
      style: ThemeUtils.textStyle(color: AppColors.textWhite, fontSize: 16.sp),
    ),
  );

  _stocksListView() => Container(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    decoration: BoxDecoration(
      color: AppColors.bgGrey,
      borderRadius: BorderRadius.all(Radius.circular(16.r)),
    ),
    child: SingleChildScrollView(
      child: Column(
        children: [
          _filterView(),
          Divider(height: 1.h, color: AppColors.bgDarkGrey),
          SlidableAutoCloseBehavior(
            child: ListView.separated(
              itemCount: stocks.length,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              separatorBuilder:
                  (context, index) =>
                      Divider(height: 1.h, color: AppColors.bgDarkGrey),
              itemBuilder: (context, index) {
                final item = stocks[index];
                return StockItemTile(
                  item: item,
                  onDelete: () {
                    DialogUtils.showBlurredBottomSheet(
                      context: context,
                      child: DeleteFromWatchlistSheet(
                        stockName: item.name,
                        onDelete: () {
                          context.read<StockListBloc>().add(DeleteStock(item));
                          Navigator.of(context).pop();
                        },
                        onCancel: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
          30.verticalSpace,
        ],
      ),
    ),
  );

  _filterView() => Padding(
    padding: REdgeInsets.symmetric(horizontal: 16, vertical: 19),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: ThemeUtils.boxDecoration(
            border: Border.all(color: AppColors.lightGrey, width: 1),
          ),
          padding: REdgeInsets.symmetric(horizontal: 8, vertical: 5.5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.sort,
                style: ThemeUtils.textStyle(
                  fontFamily: AppFonts.inter,
                  color: AppColors.thinGrey,
                ),
              ),
              8.horizontalSpace,
              SvgPicture.asset(
                AppIcons.svgSort,
                width: 7.h,
                height: 7.h,
                colorFilter: const ColorFilter.mode(
                  AppColors.thinGrey,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: ThemeUtils.boxDecoration(
            border: Border.all(color: AppColors.lightGrey, width: 1),
          ),
          padding: REdgeInsets.symmetric(horizontal: 8, vertical: 5.5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                AppIcons.svgChanges,
                width: 7.h,
                height: 7.h,
                colorFilter: const ColorFilter.mode(
                  AppColors.thinGrey,
                  BlendMode.srcIn,
                ),
              ),
              8.horizontalSpace,
              Text(
                AppStrings.dayChangePercentage,
                style: ThemeUtils.textStyle(
                  fontFamily: AppFonts.inter,
                  color: AppColors.thinGrey,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  @override
  bool get wantKeepAlive => true;
}
