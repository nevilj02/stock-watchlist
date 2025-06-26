import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stock_watchlist_app/core/utils/dialog_utils.dart';
import 'package:stock_watchlist_app/core/utils/theme_utils.dart';
import '../../blocs/stock_list/stock_list_bloc.dart';
import '../../blocs/stock_list/stock_list_state.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_fonts.dart';
import '../../core/constants/app_icons.dart';
import '../../core/constants/app_strings.dart';
import '../../core/widgets/button_icon.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../models/stock_item.dart';
import 'widgets/add_to_watchlist_sheet.dart';

class AddStockScreen extends StatefulWidget {
  const AddStockScreen({super.key});

  @override
  State<AddStockScreen> createState() => _AddStockScreenState();
}

class _AddStockScreenState extends State<AddStockScreen> {
  final TextEditingController _controller = TextEditingController();
  List<StockItem> _results = [];
  bool _showSheet = false;
  StockItem? _selectedItem;

  // Dummy data for demonstration
  final List<StockItem> _allStocks = [
    StockItem(
      symbol: 'TCS',
      name: 'Tata Consultancy',
      description: 'IT Services',
      price: 3450,
      changePercentage: 1.2,
    ),
    StockItem(
      symbol: 'INFY',
      name: 'Infosys',
      description: 'IT Services',
      price: 1500,
      changePercentage: -0.8,
    ),
    StockItem(
      symbol: 'RELI',
      name: 'Reliance',
      description: 'Conglomerate',
      price: 2500,
      changePercentage: 0.5,
    ),
    StockItem(
      symbol: 'TCS',
      name: 'Tata Consultancy',
      description: 'IT Services',
      price: 3450,
      changePercentage: 1.2,
    ),
    StockItem(
      symbol: 'INFY',
      name: 'Infosys',
      description: 'IT Services',
      price: 1500,
      changePercentage: -0.8,
    ),
    StockItem(
      symbol: 'RELI',
      name: 'Reliance',
      description: 'Conglomerate',
      price: 2500,
      changePercentage: 0.5,
    ),
  ];

  void _onSearch(String query) {
    setState(() {
      _results =
          _allStocks
              .where(
                (item) =>
                    item.name.toLowerCase().contains(query.toLowerCase()) ||
                    item.symbol.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    });
  }

  void _showAddSheet(StockItem item) {
    setState(() {
      _selectedItem = item;
      _showSheet = true;
    });
    DialogUtils.showBlurredBottomSheet(
      context: context,
      child: AddToWatchlistSheet(
        stockName: item.name,
        onAdd: () {
          // Add to watchlist logic here
          Navigator.of(context).pop();
        },
        onCancel: () {
          Navigator.of(context).pop();
        },
      ),
    ).then((_) {
      setState(() {
        _showSheet = false;
        _selectedItem = null;
      });
    });
  }

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

  _mainBody() => Padding(
    padding: REdgeInsets.symmetric(horizontal: 8),
    child: Column(
      children: [
        _appBar(),
        _searchBox(),
        22.verticalSpace,
        Expanded(
          child:
              _results.isEmpty
                  ? _noResultView()
                  : _resultsView(),
        ),
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
    label: AppStrings.addStock,
  );

  _searchBox() => Container(
    margin: REdgeInsets.symmetric(horizontal: 16),
    padding: REdgeInsets.only(left: 16, right: 16, top: 12, bottom: 15),
    decoration: ThemeUtils.boxDecoration(
      color: AppColors.trans,
      borderRadius: 8.r,
      border: Border.all(color: AppColors.mintGrey, width: 1),
    ),
    child: TextField(
      controller: _controller,
      onChanged: _onSearch,
      style: ThemeUtils.textStyle(
        fontFamily: AppFonts.inter,
        color: AppColors.textWhite,
      ),
      decoration: InputDecoration(
        hintText: AppStrings.searchStockTitle,
        hintStyle: ThemeUtils.textStyle(
          fontFamily: AppFonts.inter,
          color: AppColors.textGrey,
        ),
        border: InputBorder.none,
        isCollapsed: true,
        contentPadding: EdgeInsets.zero,
      ),
    ),
  );

  _noResultView() => Center(
    child: Text(
      'No results',
      style: ThemeUtils.textStyle(fontSize: 16.sp),
    ),
  );

  _resultsView() => ListView.separated(
    itemCount: _results.length,
    separatorBuilder:
        (context, index) =>
        Divider(height: 1.h, color: AppColors.bgGrey),
    itemBuilder: (context, index) {
      final item = _results[index];
      return GestureDetector(
        onTap: () => _showAddSheet(item),
        child: Container(
          width: double.infinity,
          padding: REdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
          child: Text(
            item.name,
            style: ThemeUtils.textStyle(
              fontFamily: AppFonts.inter,
            ),
          ),
        ),
      );
    },
  );
}
