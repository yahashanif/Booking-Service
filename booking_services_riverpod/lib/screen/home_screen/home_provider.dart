import 'package:booking_services_riverpod/provider/dio_provider.dart';
import 'package:booking_services_riverpod/repository/booking_repository.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class CountBooking extends StateNotifier<int> {
  final Ref ref;
  CountBooking({required this.ref}) : super(0);

  final _initialcount = 0;
  void count({
    required String tgl,
  }) async {
    final resp = await BookingRepository(dio: ref.read(dioProvider))
        .listBooking(tgl: tgl);
    state = resp.length;
    
  }
}

final countProvider =
    StateNotifierProvider<CountBooking, int>((ref) => CountBooking(ref: ref));


