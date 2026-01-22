import 'package:ab_shared/pages/account/account.dart';
import 'package:ab_shared/blocs/auth/auth.bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:ab_shared/components/app/app_layout.dart';
import 'package:mail/components/modals/email_domain_validation_modal.dart';
import 'package:mail/pages/home/home.dart';
import 'package:mail/pages/mails/views/all_mail.dart';
import 'package:mail/pages/mails/views/archive.dart';
import 'package:mail/pages/mails/views/drafts.dart';
import 'package:mail/pages/mails/views/inbox.dart';
import 'package:mail/pages/mails/views/trashed.dart';
import 'package:mail/pages/organize/organize.dart';
import 'package:mail/pages/search/search.dart';
import 'package:mail/utils/nav_constants.dart';
import 'package:mail/utils/email_domain_validator.dart';

part 'app_router.g.dart';

final GlobalKey<NavigatorState> appLayoutNavigatorKey =
    GlobalKey<NavigatorState>();

@TypedShellRoute<AppRouter>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<HomeRoute>(path: '/', name: "home"),
    TypedGoRoute<InboxRoute>(path: '/inbox', name: "inbox"),
    TypedGoRoute<DraftRoute>(path: '/drafts', name: "drafts"),
    TypedGoRoute<ArchiveRoute>(path: '/archive', name: "archive"),
    TypedGoRoute<AllMailRoute>(path: '/all', name: "all"),
    TypedGoRoute<TrashedRoute>(path: '/trashed', name: "trashed"),
    TypedGoRoute<OrganizeRoute>(path: '/organize', name: "organize"),
    TypedGoRoute<SearchRoute>(path: '/search', name: "search"),
    TypedGoRoute<AccountRoute>(path: '/account', name: "account")
  ],
)
class AppRouter extends ShellRouteData {
  final getIt = GetIt.instance;
  AppRouter();

  static final GlobalKey<NavigatorState> $navigatorKey = appLayoutNavigatorKey;
  static bool _hasShownEmailValidationModal = false;

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, authState) {
        // Check if user is logged in and if their email is authorized
        if (authState.user != null && !_hasShownEmailValidationModal) {
          final userEmail = authState.user!.email;
          final authorizedDomains = authState.appConfig?.domains;

          if (userEmail != null &&
              !EmailDomainValidator.isEmailAuthorized(
                  userEmail, authorizedDomains)) {
            // Mark as shown before showing to prevent multiple renders
            _hasShownEmailValidationModal = true;

            // Show the email domain validation modal
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.mounted) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => EmailDomainValidationModal(
                    currentEmail: userEmail,
                    authorizedDomains: authorizedDomains ?? [],
                  ),
                ).then((_) {
                  // Reset flag when modal is closed so it can be shown again if needed
                  _hasShownEmailValidationModal = false;
                });
              }
            });
          }
        }
      },
      child: AppLayout(
        key: state.pageKey,
        items: $navConstants.primaryMenuItems(
          context,
        ),
        homeRouteLocation: '/',
        child: navigator,
      ),
    );
  }
}
