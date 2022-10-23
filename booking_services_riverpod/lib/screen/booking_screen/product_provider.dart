import 'package:booking_services_riverpod/repository/booking_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/booking_model.dart';
import '../../provider/dio_provider.dart';
import '../../repository/base_repository.dart';

abstract class ProductListState extends Equatable {
  final DateTime date;

  const ProductListState(this.date);
  @override
  List<Object?> get props => [date];
}

class ProductListStateInit extends ProductListState {
  ProductListStateInit() : super(DateTime.now());
}

class ProductListStateLoading extends ProductListState {
  ProductListStateLoading() : super(DateTime.now());
}

class ProductListStateError extends ProductListState {
  final String message;
  ProductListStateError({
    required this.message,
  }) : super(DateTime.now());
}

class ProductListStateDone extends ProductListState {
  final List<Product> model;
  ProductListStateDone({
    required this.model,
  }) : super(DateTime.now());
}

//notifier
class ProductListNotifier extends StateNotifier<ProductListState> {
  final Ref ref;
  ProductListNotifier({
    required this.ref,
  }) : super(ProductListStateInit());
  void list() async {
    try {
      final resp =
          await BookingRepository(dio: ref.read(dioProvider)).listProduct();
      state = ProductListStateLoading();
      state = ProductListStateDone(model: resp);
      
    } catch (e) {
      if (e is BaseRepositoryException) {
        state = ProductListStateError(message: e.message);
      } else {
        state = ProductListStateError(message: e.toString());
      }
    }
  }

 
}

final ProductListProvider =
    StateNotifierProvider<ProductListNotifier, ProductListState>(
  (ref) => ProductListNotifier(ref: ref),
);
