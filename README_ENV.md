# Environment files and usage

This project uses per-environment `.env` files to store runtime configuration.

Files created:
- `.env.development` - development values
- `.env.staging` - staging values
- `.env.production` - production values

Quick setup:
1. Add dependency in `pubspec.yaml`:

   dependencies:
     flutter_dotenv: ^6.0.0

2. Load env early in `main()` before `runApp()`:

   import 'package:flutter/material.dart';
   import 'core/env.dart';

   void main() async {
     WidgetsFlutterBinding.ensureInitialized();
     await Env.load(); // loads .env.development by default
     runApp(MyApp());
   }

3. To load a different file, pass the filename: `await Env.load(envFile: '.env.production');`

Notes:
- Keep secrets out of git (add `.env.*` to `.gitignore` or use CI secret managers).
- For Flutter flavors consider using build variants or `--dart-define` for compile-time values.
