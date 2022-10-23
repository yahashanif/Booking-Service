import 'package:booking_services_riverpod/model/pelanggan_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/dio_provider.dart';
import '../../repository/base_repository.dart';
import '../../repository/pelanggan_repository.dart';

abstract class PelangganListState extends Equatable {
  final DateTime date;

  const PelangganListState(this.date);
  @override
  List<Object?> get props => [date];
}

class PelangganListStateInit extends PelangganListState {
  PelangganListStateInit() : super(DateTime.now());
}

class PelangganListStateLoading extends PelangganListState {
  PelangganListStateLoading() : super(DateTime.now());
}

class PelangganListStateError extends PelangganListState {
  final String message;
  PelangganListStateError({
    required this.message,
  }) : super(DateTime.now());
}

class PelangganListStateDone extends PelangganListState {
  final List<Pelanggan> model;
  PelangganListStateDone({
    required this.model,
  }) : super(DateTime.now());
}

//notifier
class PelangganListNotifier extends StateNotifier<PelangganListState> {
  final Ref ref;
  PelangganListNotifier({
    required this.ref,
  }) : super(PelangganListStateInit());
  void list() async {
    try {
      final resp =
          await PelangganRepository(dio: ref.read(dioProvider)).listPelanggan();
      state = PelangganListStateLoading();
      state = PelangganListStateDone(model: resp);
      
    } catch (e) {
      if (e is BaseRepositoryException) {
        state = PelangganListStateError(message: e.message);
      } else {
        state = PelangganListStateError(message: e.toString());
      }
    }
  }

  void delete(String id) async{
     await PelangganRepository(dio: ref.read(dioProvider)).DeletePelanggan(id);
     list();
  }

 
}

final PelangganListProvider =
    StateNotifierProvider<PelangganListNotifier, PelangganListState>(
  (ref) => PelangganListNotifier(ref: ref),
);
