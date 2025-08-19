import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/route/app_route.dart';
import 'core/route/route_name.dart';
import 'core/services/app_setting_provider.dart';
import 'core/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();






  final appSettingProvider = AppSettingProvider();
  // await appSettingProvider.loadSettings();
  runApp(MyApp(appSettingProvider: appSettingProvider));

}

class MyApp extends StatelessWidget {
  final AppSettingProvider appSettingProvider;

  const MyApp( {super.key, required this.appSettingProvider});

  @override
  Widget build(BuildContext context) {
    return
      
      ChangeNotifierProvider.value(
        value:appSettingProvider,

        child: Consumer<AppSettingProvider>(
          builder: (context, provider, child) {

            return MaterialApp(

              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              initialRoute: RouteNames.splash,
              onGenerateRoute: AppRouter.generateRoute,
              themeMode: provider.themeMode,
              theme: TAppTheme.lightAppTheme,
              darkTheme: TAppTheme.darkAppTheme,

            );

          }
        ),
      );
  }
}
