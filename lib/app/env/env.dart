import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: 'env/.env', obfuscate: true)
abstract final class Env {
  @EnviedField(varName: 'BASE_URL')
  static final String baseUrl = _Env.baseUrl;
  @EnviedField(varName: 'TOKEN')
  static final String token = _Env.token;
  @EnviedField(varName: 'SUPABASE_URL')
  static final String supabaseUrl = _Env.supabaseUrl;
  @EnviedField(varName: 'SUPABASE_KEY')
  static final String supabaseKey = _Env.supabaseKey;
}
