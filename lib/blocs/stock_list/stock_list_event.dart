import 'package:equatable/equatable.dart';
import '../../models/stock_item.dart';

abstract class StockListEvent extends Equatable {
  const StockListEvent();
  @override
  List<Object?> get props => [];
}

class LoadStocks extends StockListEvent {}
class DeleteStock extends StockListEvent {
  final StockItem item;
  const DeleteStock(this.item);
  @override
  List<Object?> get props => [item];
} 