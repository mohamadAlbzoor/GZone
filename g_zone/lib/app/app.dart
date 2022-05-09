import 'package:g_zone/ui/card/card_view.dart';
import 'package:g_zone/ui/home/home.dart';
import 'package:g_zone/ui/start_up/startup_view.dart';
import 'package:g_zone/ui/start_up/default_page.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked/stacked_annotations.dart';

import '../UI/login.dart';
import '../UI/signup.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: StartUpView),
    CupertinoRoute(page: SignupScreen),
    CupertinoRoute(page: LoginScreen),
    CupertinoRoute(page: HomeView),
    CupertinoRoute(page: CardView),
    CupertinoRoute(page: defaultPage)
  ],
  dependencies: [LazySingleton(classType: NavigationService)],
  logger: StackedLogger(),
)
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}
