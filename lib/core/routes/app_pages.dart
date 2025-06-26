import 'package:get/get.dart';
import '../../views/dashboard/dashboard_screen.dart';
import '../../views/add_stock/add_stock_screen.dart';
import '../../views/details/stock_details_page.dart';
import '../../views/settings/settings_page.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> routes = [
    GetPage(name: AppRoutes.dashboard, page: () => const DashboardScreen()),
    GetPage(name: AppRoutes.search, page: () => const AddStockScreen()),
    GetPage(
      name: AppRoutes.details,
      page: () => StockDetailsPage(symbol: Get.parameters['symbol']!),
    ),
    GetPage(name: AppRoutes.settings, page: () => const SettingsPage()),
  ];
} 