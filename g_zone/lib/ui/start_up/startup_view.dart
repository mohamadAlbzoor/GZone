import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:g_zone/app/app.locator.dart';
import 'package:g_zone/app/app.logger.dart';
import 'package:g_zone/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartUpView extends StatelessWidget {
  const StartUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpViewModel>.reactive(
      onModelReady: (model) =>
          SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
        model.runStartupLogic();
      }),
      builder: (context, model, child) => const Scaffold(
        body: Center(
          child: Text('Startup View'),
        ),
      ),
      viewModelBuilder: () => StartUpViewModel(),
    );
  }
}

class StartUpViewModel extends BaseViewModel {
  final log = getLogger('StartUpViewModel');
  final _navigationService = locator<NavigationService>();

  Future<void> runStartupLogic() async {
    log.i("running startup logic ...");

    // this should nav only if the user is authenticated ...
    _navigationService.replaceWith(Routes.login);
  }
}
