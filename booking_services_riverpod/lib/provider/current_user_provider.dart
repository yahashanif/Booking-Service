import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/user_model.dart';

final currentUserProvider = StateProvider<AuthModel?>((ref) => null);
