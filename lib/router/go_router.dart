import 'package:apod/provider_model/app_state_manager.dart';
import 'package:apod/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'routes.dart';

final goRouter = GoRouter(
    initialLocation: Routes.splash.path,
    routes: [
      Routes.splash,
      Routes.main,
    ],
    refreshListenable: appStateManager,
    redirect: (GoRouterState state) {
      if (!appStateManager.isInitialized) {
        //if not initialized and not on the splash page,
        //go to splash page.
        if (state.subloc != Routes.splash.path) {
          //subloc mean the current location
          return Routes.splash.path;
        }
        //stay on the splash page while initializing;
        return null;
      }

      if (state.subloc == Routes.splash.path) {
        return Routes.main.path;
      }

      //No redirect
      return null;
    },
    errorPageBuilder: (BuildContext context, GoRouterState state) {
      //log error on the terminal during debugging use
      print('Error state: ${state.error}');
      return SplashPage.page(key: state.pageKey);
    });
