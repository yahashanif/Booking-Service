import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/pelanggan_model.dart';

final EditPelangganStateProvider = StateProvider<Pelanggan?>((ref) => null);
final DeletePelanggaStateProvider = StateProvider<Pelanggan>((ref) => Pelanggan());