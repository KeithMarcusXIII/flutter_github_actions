import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'sample_feature/sample_item_details_view.dart';
import 'sample_feature/sample_item_list_view.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          restorationScopeId: 'app',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                final definitions = Platform.environment.entries.toList();

                return Scaffold(
                  body: ListView.builder(
                    itemCount: definitions.length,
                    itemBuilder: (BuildContext context, int index) {
                      final entry = definitions[index];
                      final key = entry.key;
                      final value = entry.value;

                      return ListTile(
                        title: Text(key),
                        subtitle: Text(value),
                      );
                    },
                  ),
                );

                // switch (routeSettings.name) {
                //   case SettingsView.routeName:
                //     return SettingsView(controller: settingsController);
                //   case SampleItemDetailsView.routeName:
                //     return const SampleItemDetailsView();
                //   case SampleItemListView.routeName:
                //   default:
                //     return const SampleItemListView();
                // }
              },
            );
          },
        );
      },
    );
  }
}
