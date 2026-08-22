enum AppEnvironment { dev, staging, prod }

class EnvConfig {
  EnvConfig._();

  static late AppEnvironment environment;
  static late String apiBaseUrl;
  static late String appTitle;

  static void init(AppEnvironment env) {
    environment = env;
    switch (env) {
      case AppEnvironment.dev:
        apiBaseUrl = 'https://dev-api.example.com';
        appTitle = 'App (Dev)';
        break;
      case AppEnvironment.staging:
        apiBaseUrl = 'https://staging-api.example.com';
        appTitle = 'App (Staging)';
        break;
      case AppEnvironment.prod:
        apiBaseUrl = 'https://api.example.com';
        appTitle = 'App';
        break;
    }
  }

  static bool get isDev => environment == AppEnvironment.dev;
  static bool get isStaging => environment == AppEnvironment.staging;
  static bool get isProd => environment == AppEnvironment.prod;
}
