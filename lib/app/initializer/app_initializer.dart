import 'package:borsum/app/env/env.dart';
import 'package:borsum/locator.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AppInitializer {
  static Future<void> initialize() async {
    // Initialize Supabase
    await Supabase.initialize(
      url: Env.supabaseUrl,
      anonKey: Env.supabaseKey,
    );
    // Set the preferred orientation to portrait up
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // Initialize locator
    Locator.setupLocator(
      baseUrl: Env.baseUrl,
      supabase: Supabase.instance.client,
    );
  }
}
