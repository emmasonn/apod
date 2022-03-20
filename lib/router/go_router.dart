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
    urlPathStrategy: UrlPathStrategy.path,
    refreshListenable: appStateManager,
    redirect: (GoRouterState state) {
      // if (!appStateManager.isInitialized) {
      //   //if not initialized and not on the splash page,
      //   //go to splash page.
      //   if (state.subloc != Routes.splash.path) {
      //     //subloc mean the current location
      //     return Routes.splash.path + '?next=${state.location}';
      //   }
      //   //stay on the splash page while initializing;
      //   return null;
      // }

      // if (state.subloc == Routes.splash.path) {
      //   if (state.queryParams.containsKey('next')) {
      //     return state.queryParams['next']!;
      //   }
      //   return Routes.main.path;
      // }

      // //No redirect
      // return null;

      return GoRouterRedirector.instance.redirect(state, appStateManager);
    },
    errorPageBuilder: (BuildContext context, GoRouterState state) {
      //log error on the terminal during debugging use
      print('Error state: ${state.error}');
      return SplashPage.page(key: state.pageKey);
    });

class GoRouterRedirector {
  const GoRouterRedirector(this._redirects);
  final List<Redirect> _redirects;

  static GoRouterRedirector get instance => GoRouterRedirector([
        UninitializedRedirect(),
        OnInitializationRedirect(),
        UpdateHomeTabRedirect(),
      ]);

  String? redirect(GoRouterState state, AppStateManager manager) {
    final current = Uri(path: state.subloc, queryParameters: state.queryParams);
    for (final redirect in _redirects) {
      if (redirect.predicate(state, manager)) {
        final uri = redirect.getNewURi(state, manager);
        if (uri != null) {
          final uriString = uri.toString();

          if (uriString == current.toString()) {
            print('$redirect attempted to redirect to itself at $uriString');
            return null;
          }

          //ignore: avoid_print
          print('$redirect redirecting from ${current.toString()}');
          return uriString;
        }
      }
    }

    return null;
  }
}

abstract class Redirect {
  //determines if redirect should take place
  bool predicate(GoRouterState state, AppStateManager manager);

  Uri? getNewURi(GoRouterState state, AppStateManager manager);
}

class UninitializedRedirect extends Redirect {
  @override
  bool predicate(GoRouterState state, AppStateManager manager) =>
      !manager.isInitialized;

  @override
  Uri? getNewURi(GoRouterState state, AppStateManager manager) {
    if (state.subloc == Routes.splash.path) return null;

    final queryParams = Map<String, String>.from(state.params);
    queryParams['next'] = state.subloc;
    return Uri(path: Routes.splash.path, queryParameters: queryParams);
  }
}

class OnInitializationRedirect extends Redirect {
  @override
  bool predicate(GoRouterState state, AppStateManager manager) =>
      manager.isInitialized && state.subloc == Routes.splash.path;

  @override
  Uri? getNewURi(GoRouterState state, AppStateManager manager) {
    final queryParams = Map<String, String>.from(state.params);
    String next = Routes.main.path;
    if (queryParams.containsKey('next')) {
      next = queryParams.remove('next')!;
      final uri = Uri(path: next, queryParameters: queryParams);

      //see if the upcoming location is the home page
      //if so, set that tab in our manager.
      if (uri.path == Routes.main.path &&
          uri.queryParameters.containsKey('tab')) {
        appStateManager.setTabSilently(int.parse(uri.queryParameters['tab']!));
      }
      next = uri.path;
    }
    return Uri(path: next, queryParameters: queryParams);
  }
}

class UpdateHomeTabRedirect extends Redirect {
  @override
  bool predicate(GoRouterState state, AppStateManager manager) =>
      state.subloc == Routes.main.path;

  @override
  Uri? getNewURi(GoRouterState state, AppStateManager manager) {
    if (manager.selectedTab.toString() != state.queryParams['tab']) {
      final queryParams = Map<String, String>.from(state.queryParams);
      queryParams['tab'] = appStateManager.selectedTab.toString();
      //ignore: do no leave print on code
      print('content of queryparam json: $queryParams');
      return Uri(
        path: state.subloc,
        queryParameters: queryParams,
      );
    }
    return null;
  }
}
