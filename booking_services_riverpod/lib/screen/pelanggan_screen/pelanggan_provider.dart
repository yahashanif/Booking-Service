import 'package:booking_services_riverpod/model/pelanggan_model.dart';
import 'package:booking_services_riverpod/provider/dio_provider.dart';
import 'package:booking_services_riverpod/repository/pelanggan_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../repository/base_repository.dart';

final PelangganProvider =
    StateNotifierProvider<PelangganNotifier, PelangganState>(
        (ref) => PelangganNotifier(ref: ref));

class PelangganNotifier extends StateNotifier<PelangganState> {
  final Ref ref;

  PelangganNotifier({required this.ref})
      : super(PelangganStateInit());

  void Input({
    required Pelanggan p,
  }) async {
    try {
      final resp = await PelangganRepository(dio: ref.read(dioProvider))
          .inputPelanggan(p);

      state = PelangganStateDone(resp);
    } catch (e) {
      if (e is BaseRepositoryException) {
        state = PelangganStateError(e.message);
      } else {
        state = PelangganStateError(e.toString());
      }
    }
  }

  void Edit({
    required Pelanggan p,
  }) async {
    try {
      final resp = await PelangganRepository(dio: ref.read(dioProvider))
          .EditPelanggan(p);

      state = PelangganStateDone(resp);
    } catch (e) {
      if (e is BaseRepositoryException) {
        state = PelangganStateError(e.message);
      } else {
        state = PelangganStateError(e.toString());
      }
    }
  }
}

abstract class PelangganState extends Equatable {
  final DateTime date;
  const PelangganState(this.date);
  @override
  List<Object?> get props => [date];
}

class PelangganStateInit extends PelangganState {
  PelangganStateInit() : super(DateTime.now());
}

class PelangganStateLoading extends PelangganState {
  PelangganStateLoading() : super(DateTime.now());
}

class PelangganStateError extends PelangganState {
  final String message;
  PelangganStateError(this.message) : super(DateTime.now());
}

class PelangganStateDone extends PelangganState {
  final bool kondisi;
  PelangganStateDone(this.kondisi) : super(DateTime.now());
}
