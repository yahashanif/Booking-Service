import 'package:booking_services_riverpod/model/pelanggan_model.dart';
import 'package:booking_services_riverpod/repository/booking_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/booking_model.dart';
import '../../model/request_model.dart';
import '../../provider/dio_provider.dart';
import '../../repository/base_repository.dart';
import '../../repository/pelanggan_repository.dart';

abstract class BookingProviderState extends Equatable {
  final DateTime date;

  const BookingProviderState(this.date);
  @override
  List<Object?> get props => [date];
}

class BookingProviderStateInit extends BookingProviderState {
  BookingProviderStateInit() : super(DateTime.now());
}

class BookingProviderStateLoading extends BookingProviderState {
  BookingProviderStateLoading() : super(DateTime.now());
}

class BookingProviderStateError extends BookingProviderState {
  final String message;
  BookingProviderStateError({
    required this.message,
  }) : super(DateTime.now());
}

class BookingProviderStateDone extends BookingProviderState {
  final List<Booking> model;
  BookingProviderStateDone({
    required this.model,
  }) : super(DateTime.now());
}

//notifier
class BookingProviderNotifier extends StateNotifier<BookingProviderState> {
  final Ref ref;
  BookingProviderNotifier({
    required this.ref,
  }) : super(BookingProviderStateInit());
  void list(String tgl) async {
    try {
      final resp =
          await BookingRepository(dio: ref.read(dioProvider)).listBooking(tgl: tgl);
      state = BookingProviderStateLoading();
      state = BookingProviderStateDone(model: resp);
      
    } catch (e) {
      if (e is BaseRepositoryException) {
        state = BookingProviderStateError(message: e.message);
      } else {
        state = BookingProviderStateError(message: e.toString());
      }
    }
  }
   void Input({
    required BookingRequest b,
  }) async {
    try {
      final resp = await BookingRepository(dio: ref.read(dioProvider))
          .inputBooking(b);

      state = BookingProviderStateDone(model: []);
    } catch (e) {
      if (e is BaseRepositoryException) {
        state = BookingProviderStateError( message: e.message);
      } else {
        state = BookingProviderStateError( message: e.toString());
      }
    }
  }
   void edit({
    required BookingRequest b,
    required String id,
    required String tgl
  }) async {
    try {
      final resp = await BookingRepository(dio: ref.read(dioProvider))
          .editBooking(b,id);
        list(tgl);

      state = BookingProviderStateDone(model: []);
    } catch (e) {
      if (e is BaseRepositoryException) {
        state = BookingProviderStateError( message: e.message);
      } else {
        state = BookingProviderStateError( message: e.toString());
      }
    }
  }

  void delete(String id,String tgl) async{
     await BookingRepository(dio: ref.read(dioProvider)).DeleteBooking(id);
     list(tgl);
  }

 
}

final BookingProvider =
    StateNotifierProvider<BookingProviderNotifier, BookingProviderState>(
  (ref) => BookingProviderNotifier(ref: ref),
);
// final inputBookingProvider =
//     StateNotifierProvider<BookingProviderNotifier, BookingProviderState>(
//         (ref) => BookingProviderNotifier(ref: ref));
// final editBookingProvider =
//     StateNotifierProvider<BookingProviderNotifier, BookingProviderState>(
//         (ref) => BookingProviderNotifier(ref: ref));