import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: 'env/.env', obfuscate: false)
abstract final class Env {
  @EnviedField(varName: 'BASE_URL')
  static String baseUrl = _Env.baseUrl;
  @EnviedField(varName: 'TOKEN')
  static String token = _Env.token;
  @EnviedField(varName: 'SUPABASE_URL')
  static String supabaseUrl = _Env.supabaseUrl;
  @EnviedField(varName: 'SUPABASE_KEY')
  static String supabaseKey = _Env.supabaseKey;
}
