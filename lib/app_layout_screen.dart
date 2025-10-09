import 'package:ab_shared/blocs/auth/auth.bloc.dart';
import 'package:ab_shared/pages/auth/sso_module.dart';
import 'package:ab_shared/services/encryption.service.dart';
import 'package:ab_shared/utils/api_client.dart';
import 'package:ab_shared/utils/env/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template/pages/page1/page1.dart';

class AppLayoutScreen extends StatelessWidget {
  final EncryptionService? encryptionService;
  final ApiClient? globalApiClient;
  final SharedPreferences? prefs;
  final EnvModel? env;
  const AppLayoutScreen({
    super.key,
    this.encryptionService,
    this.globalApiClient,
    this.env,
    this.prefs,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, authState) {
      if (authState is! LoggedIn) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          SsoModuleRoute(SsoModuleParams(
            onAuthSuccess: () {
              Page1Route().go(context);
            },
            env: env,
            encryptionService: encryptionService,
            globalApiClient: globalApiClient,
            prefs: prefs,
          )).go(context);
        });
      }
      return Placeholder();
    });
  }

}
