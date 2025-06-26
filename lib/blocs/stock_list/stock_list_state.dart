import 'package:equatable/equatable.dart';
import '../../models/stock_item.dart';

abstract class StockListState extends Equatable {
  const StockListState();
  @override
  List<Object?> get props => [];
}

class StockListInitial extends StockListState {}
class StockListLoading extends StockListState {}
class StockListLoaded extends StockListState {
  final List<StockItem> stocks;
  const StockListLoaded({required this.stocks});
  @override
  List<Object?> get props => [stocks];
}
class StockListError extends StockListState {
  final String message;
  const StockListError(this.message);
  @override
  List<Object?> get props => [message];
} 