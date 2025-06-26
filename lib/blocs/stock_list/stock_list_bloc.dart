import 'package:flutter_bloc/flutter_bloc.dart';
import 'stock_list_event.dart';
import 'stock_list_state.dart';
import '../../models/stock_item.dart';

class StockListBloc extends Bloc<StockListEvent, StockListState> {
  StockListBloc() : super(StockListInitial()) {
    on<LoadStocks>((event, emit) async {
      emit(StockListLoading());
      // Simulate loading
      await Future.delayed(const Duration(seconds: 2));
      emit(StockListLoaded(stocks: [
        const StockItem(symbol: 'AAPL', name: 'Large Cap Fund Direct', description: 'Reliance Industries BSE Sensex Index Fund Direct Growth', price: 170.0, changePercentage: 0.54),
        const StockItem(symbol: 'GOOGL', name: 'Tata Consultancy Services Nifty200', description: 'Momentum 30 Index Fund', price: 2800.0, changePercentage: -0.80),
        const StockItem(symbol: 'HDFC', name: 'HDFC Bank BSE Sensex Index Fund', description: 'Direct Growth', price: 1500.0, changePercentage: 0.25),
        const StockItem(symbol: 'INFY', name: 'Infosys Nifty Next 50 Index Fund', description: 'Fund', price: 1600.0, changePercentage: -0.40),
        const StockItem(symbol: 'TCS', name: 'Tata Consultancy Services Nifty200', description: 'Momentum 30 Index Fund', price: 3400.0, changePercentage: 1.20),
        const StockItem(symbol: 'AAPL', name: 'Large Cap Fund Direct', description: 'Reliance Industries BSE Sensex Index Fund Direct Growth', price: 170.0, changePercentage: 0.54),
        const StockItem(symbol: 'GOOGL', name: 'Tata Consultancy Services Nifty200', description: 'Momentum 30 Index Fund', price: 2800.0, changePercentage: -0.80),
        const StockItem(symbol: 'HDFC', name: 'HDFC Bank BSE Sensex Index Fund', description: 'Direct Growth', price: 1500.0, changePercentage: 0.25),
        const StockItem(symbol: 'INFY', name: 'Infosys Nifty Next 50 Index Fund', description: 'Fund', price: 1600.0, changePercentage: -0.40),
        const StockItem(symbol: 'TCS', name: 'Tata Consultancy Services Nifty200', description: 'Momentum 30 Index Fund', price: 3400.0, changePercentage: 1.20),
      ]));

      // emit(StockListError("Could not load stocks"));
    });
    on<DeleteStock>((event, emit) async {
      if (state is StockListLoaded) {
        final current = (state as StockListLoaded).stocks;
        final updated = List<StockItem>.from(current)..remove(event.item);
        emit(StockListLoaded(stocks: updated));
      }
    });
  }
} 