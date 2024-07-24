import 'package:myapp/config/env.dart';

enum Flavor {
  dev,
  stg,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Flutter Bloc Base (dev)';
      case Flavor.stg:
        return 'Flutter Bloc Base (stg)';
      case Flavor.prod:
        return 'Flutter Bloc Base';
      default:
        return 'title';
    }
  }

  static String get configFileName {
    switch (appFlavor) {
      case Flavor.dev:
        return EnvFileNames.dev;
      case Flavor.stg:
        return EnvFileNames.stg;
      case Flavor.prod:
        return EnvFileNames.prod;
      default:
        return EnvFileNames.dev;
    }
  }

  static String get env {
    switch (appFlavor) {
      case Flavor.dev:
        return 'dev';
      case Flavor.stg:
        return 'staging';
      case Flavor.prod:
        return 'production';
      default:
        return 'dev';
    }
  }
}
