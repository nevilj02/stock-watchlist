import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/stock_list/stock_list_bloc.dart';
import '../../blocs/stock_list/stock_list_event.dart';

class BlocUtils {
  static get appBlocs => [
    BlocProvider<StockListBloc>(
      create: (_) => StockListBloc()..add(LoadStocks()),
    ),
  ];
}