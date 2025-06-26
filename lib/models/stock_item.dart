import 'package:equatable/equatable.dart';

class StockItem extends Equatable {
  final String symbol;
  final String name;
  final String description;
  final double price;
  final double changePercentage;

  const StockItem({required this.symbol, required this.name, required this.description, required this.price, this.changePercentage = 0.0});

  @override
  List<Object?> get props => [symbol, name, description, price, changePercentage];
} 