import 'package:flutter_password_generate_app/provider/password_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final passwordProvider = ChangeNotifierProvider((ref) => PasswordModel());