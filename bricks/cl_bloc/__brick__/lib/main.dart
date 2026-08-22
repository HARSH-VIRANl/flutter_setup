import 'package:core/core_exports.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:{{{fullPath}}}/di/injector.dart';
import 'package:{{{fullPath}}}/routes/navigator_routes.dart';

void bootstrapApp(AppEnvironment env) async {
  WidgetsFlutterBinding.ensureInitialized();
  EnvConfig.init(env);

  // Catch uncaught Flutter & Platform errors (Global Error Boundary)
  FlutterError.onError = (details) {
    AppLogger.e('FlutterError: ${details.exception}', details.exception, details.stack);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    AppLogger.e('PlatformError: $error', error, stack);
    return true;
  };

  Bloc.observer = SimpleBlocDelegate();
  Injector.init();

  runApp(const MyApp());
}

void main() async {
  bootstrapApp(AppEnvironment.dev);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final messengerKey = GlobalKey<ScaffoldMessengerState>();
  late AppSettingsBloc baseBloc;

  @override
  void initState() {
    super.initState();

    final pref = Injector.instance.get<AppPreference>();
    final platformDark =
        WidgetsBinding.instance.platformDispatcher.platformBrightness ==
            Brightness.dark;

    baseBloc = AppSettingsBloc(
      AppSettingsState(
        isDarkMode: platformDark,
        isConnected: true,
        locale: 'en',
      ),
    );

    _restorePreferences(pref);

    Injector.instance.get<NetworkProvider>().onStateChange().listen(
      (isConnected) {
        if (mounted) {
          messengerKey.currentContext
              ?.read<AppSettingsBloc>()
              .add(ConnectivityChangeEvent(isConnected: isConnected));
        }
      },
    );
  }

  Future<void> _restorePreferences(AppPreference pref) async {
    final savedLocale =
        await pref.readString(PreferenceConstants.localeKey) ?? 'en';
    final savedDark =
        await pref.readBool(PreferenceConstants.isDarkModeKey);

    if (mounted) {
      baseBloc
        ..add(LocalizationChangeEvent(locale: savedLocale))
        ..add(ThemeChangeEvent(isDarkMode: savedDark));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppSettingsBloc>(create: (context) => baseBloc),
      ],
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        builder: (context, child) {
          return BlocBuilder<AppSettingsBloc, AppSettingsState>(
            buildWhen: (previous, current) =>
                previous.isDarkMode != current.isDarkMode ||
                previous.locale != current.locale ||
                previous.isConnected != current.isConnected,
            builder: (context, state) {
              return MaterialApp(
                navigatorKey: NavigationService.navigatorKey,
                scaffoldMessengerKey: messengerKey,
                title: EnvConfig.appTitle,
                theme: appLightTheme,
                darkTheme: appDarkTheme,
                themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
                locale: Locale(state.locale),
                supportedLocales: const [
                  Locale('en'),
                  Locale('hi'),
                ],
                localizationsDelegates: const [
                  AppLocalizationDelegate(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                debugShowCheckedModeBanner: !EnvConfig.isProd,
                onGenerateRoute: NavigatorRoutes.generateRoute,
                initialRoute: AppRoutes.root,
                builder: (context, child) {
                  return Stack(
                    children: [
                      child ?? const Offstage(),
                      SafeArea(
                        child: NoInternetWidget(
                          isConnected: state.isConnected,
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
