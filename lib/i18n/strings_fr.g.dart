///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsFr implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsFr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.fr,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <fr>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsFr _root = this; // ignore: unused_field

	@override 
	TranslationsFr $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsFr(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsSettingsFr settings = _TranslationsSettingsFr._(_root);
	@override late final _TranslationsSectionsFr sections = _TranslationsSectionsFr._(_root);
	@override late final _TranslationsZeroInboxCardFr zero_inbox_card = _TranslationsZeroInboxCardFr._(_root);
	@override late final _TranslationsMailCardFr mail_card = _TranslationsMailCardFr._(_root);
	@override late final _TranslationsTrashedFr trashed = _TranslationsTrashedFr._(_root);
	@override late final _TranslationsMailComposerFr mail_composer = _TranslationsMailComposerFr._(_root);
	@override late final _TranslationsAccountFr account = _TranslationsAccountFr._(_root);
	@override late final _TranslationsUnderConstructionFr under_construction = _TranslationsUnderConstructionFr._(_root);
	@override late final _TranslationsMoreFr more = _TranslationsMoreFr._(_root);
	@override late final _TranslationsActionsFr actions = _TranslationsActionsFr._(_root);
	@override late final _TranslationsXxMailCardFr xx_mail_card = _TranslationsXxMailCardFr._(_root);
	@override late final _TranslationsEmailFoldersFr email_folders = _TranslationsEmailFoldersFr._(_root);
	@override late final _TranslationsMailActionsFr mail_actions = _TranslationsMailActionsFr._(_root);
	@override late final _TranslationsToastNotificationsFr toast_notifications = _TranslationsToastNotificationsFr._(_root);
}

// Path: settings
class _TranslationsSettingsFr implements TranslationsSettingsEn {
	_TranslationsSettingsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Paramètres';
	@override late final _TranslationsSettingsAppSettingsFr app_settings = _TranslationsSettingsAppSettingsFr._(_root);
	@override String get logout => 'Déconnexion';
}

// Path: sections
class _TranslationsSectionsFr implements TranslationsSectionsEn {
	_TranslationsSectionsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get mail => 'Mail';
}

// Path: zero_inbox_card
class _TranslationsZeroInboxCardFr implements TranslationsZeroInboxCardEn {
	_TranslationsZeroInboxCardFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Félicitations !';
	@override String get description => 'Vous n\'avez aucun message non lu.';
}

// Path: mail_card
class _TranslationsMailCardFr implements TranslationsMailCardEn {
	_TranslationsMailCardFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get no_content => 'Aucun contenu';
	@override late final _TranslationsMailCardDeleteDraftModalFr delete_draft_modal = _TranslationsMailCardDeleteDraftModalFr._(_root);
}

// Path: trashed
class _TranslationsTrashedFr implements TranslationsTrashedEn {
	_TranslationsTrashedFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get card_title => 'Supprimer tous les mails supprimés';
	@override String x_mails_trashed({required Object count}) => '${count} mails supprimés';
	@override String get description => 'Ce sont les mails que vous avez supprimés, ils seront supprimés après 30 jours.';
	@override late final _TranslationsTrashedDeleteAllTrashedMailsModalFr delete_all_trashed_mails_modal = _TranslationsTrashedDeleteAllTrashedMailsModalFr._(_root);
}

// Path: mail_composer
class _TranslationsMailComposerFr implements TranslationsMailComposerEn {
	_TranslationsMailComposerFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nouveau Mail';
	@override String get from => 'De';
	@override String get subject => 'Objet';
	@override String get to => 'À';
	@override late final _TranslationsMailComposerSaveDraftModalFr save_draft_modal = _TranslationsMailComposerSaveDraftModalFr._(_root);
	@override Map<String, String> get errors => {
		'error_sending_email': 'Une erreur s\'est produite lors de l\'envoi de l\'e-mail. Veuillez réessayer.',
	};
}

// Path: account
class _TranslationsAccountFr implements TranslationsAccountEn {
	_TranslationsAccountFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsAccountSectionsFr sections = _TranslationsAccountSectionsFr._(_root);
}

// Path: under_construction
class _TranslationsUnderConstructionFr implements TranslationsUnderConstructionEn {
	_TranslationsUnderConstructionFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'On travaille dessus !';
	@override String get description => 'Cette fonctionnalité est en cours de développement.\n\nRevenez bientôt pour découvrir les dernières mises à jour !';
}

// Path: more
class _TranslationsMoreFr implements TranslationsMoreEn {
	_TranslationsMoreFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Plus';
}

// Path: actions
class _TranslationsActionsFr implements TranslationsActionsEn {
	_TranslationsActionsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get save => 'Enregistrer';
	@override String get cancel => 'Annuler';
	@override String get delete => 'Supprimer';
}

// Path: xx_mail_card
class _TranslationsXxMailCardFr implements TranslationsXxMailCardEn {
	_TranslationsXxMailCardFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String description({required Object count}) => 'Vous avez ${count} mails dans ce dossier.';
}

// Path: email_folders
class _TranslationsEmailFoldersFr implements TranslationsEmailFoldersEn {
	_TranslationsEmailFoldersFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get inbox => 'Boîte de réception';
	@override String get drafts => 'Brouillons';
	@override String get archive => 'Archive';
	@override String get trashed => 'Corbeille';
	@override String get all => 'Tous';
}

// Path: mail_actions
class _TranslationsMailActionsFr implements TranslationsMailActionsEn {
	_TranslationsMailActionsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get mark_as_read => 'Marquer comme lu';
	@override String get mark_as_unread => 'Marquer comme non lu';
	@override String get archive => 'Archive';
	@override String get unarchive => 'Désarchiver';
	@override String get trash => 'Corbeille';
	@override String get untrash => 'Restaurer';
}

// Path: toast_notifications
class _TranslationsToastNotificationsFr implements TranslationsToastNotificationsEn {
	_TranslationsToastNotificationsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsToastNotificationsSelectedMailsFr selected_mails = _TranslationsToastNotificationsSelectedMailsFr._(_root);
}

// Path: settings.app_settings
class _TranslationsSettingsAppSettingsFr implements TranslationsSettingsAppSettingsEn {
	_TranslationsSettingsAppSettingsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Paramètres de l\'application';
	@override late final _TranslationsSettingsAppSettingsSelfHostedUrlFr selfHostedUrl = _TranslationsSettingsAppSettingsSelfHostedUrlFr._(_root);
}

// Path: mail_card.delete_draft_modal
class _TranslationsMailCardDeleteDraftModalFr implements TranslationsMailCardDeleteDraftModalEn {
	_TranslationsMailCardDeleteDraftModalFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Supprimer le brouillon';
	@override String get description => 'Êtes-vous sûr de vouloir supprimer ce brouillon ?';
	@override String get warning => 'Cette action ne peut pas être annulée.';
}

// Path: trashed.delete_all_trashed_mails_modal
class _TranslationsTrashedDeleteAllTrashedMailsModalFr implements TranslationsTrashedDeleteAllTrashedMailsModalEn {
	_TranslationsTrashedDeleteAllTrashedMailsModalFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Supprimer tous les mails supprimés';
	@override String get description => 'Êtes-vous sûr de vouloir supprimer tous les mails supprimés ?';
	@override String get warning => 'Cette action ne peut pas être annulée.';
}

// Path: mail_composer.save_draft_modal
class _TranslationsMailComposerSaveDraftModalFr implements TranslationsMailComposerSaveDraftModalEn {
	_TranslationsMailComposerSaveDraftModalFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Enregistrer le brouillon';
	@override String get description => 'Voulez-vous enregistrer le brouillon ?';
	@override String get confirm_text => 'Enregistrer';
	@override String get cancel_text => 'Annuler';
}

// Path: account.sections
class _TranslationsAccountSectionsFr implements TranslationsAccountSectionsEn {
	_TranslationsAccountSectionsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get account => 'Compte';
}

// Path: toast_notifications.selected_mails
class _TranslationsToastNotificationsSelectedMailsFr implements TranslationsToastNotificationsSelectedMailsEn {
	_TranslationsToastNotificationsSelectedMailsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String title({required Object count}) => '${count} mails sélectionnés';
	@override String get description => 'Cliquez ici pour effectuer une action.';
}

// Path: settings.app_settings.selfHostedUrl
class _TranslationsSettingsAppSettingsSelfHostedUrlFr implements TranslationsSettingsAppSettingsSelfHostedUrlEn {
	_TranslationsSettingsAppSettingsSelfHostedUrlFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'URL auto-hébergée';
	@override String get not_set => 'Non défini';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsFr {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'settings.title': return 'Paramètres';
			case 'settings.app_settings.title': return 'Paramètres de l\'application';
			case 'settings.app_settings.selfHostedUrl.title': return 'URL auto-hébergée';
			case 'settings.app_settings.selfHostedUrl.not_set': return 'Non défini';
			case 'settings.logout': return 'Déconnexion';
			case 'sections.mail': return 'Mail';
			case 'zero_inbox_card.title': return 'Félicitations !';
			case 'zero_inbox_card.description': return 'Vous n\'avez aucun message non lu.';
			case 'mail_card.no_content': return 'Aucun contenu';
			case 'mail_card.delete_draft_modal.title': return 'Supprimer le brouillon';
			case 'mail_card.delete_draft_modal.description': return 'Êtes-vous sûr de vouloir supprimer ce brouillon ?';
			case 'mail_card.delete_draft_modal.warning': return 'Cette action ne peut pas être annulée.';
			case 'trashed.card_title': return 'Supprimer tous les mails supprimés';
			case 'trashed.x_mails_trashed': return ({required Object count}) => '${count} mails supprimés';
			case 'trashed.description': return 'Ce sont les mails que vous avez supprimés, ils seront supprimés après 30 jours.';
			case 'trashed.delete_all_trashed_mails_modal.title': return 'Supprimer tous les mails supprimés';
			case 'trashed.delete_all_trashed_mails_modal.description': return 'Êtes-vous sûr de vouloir supprimer tous les mails supprimés ?';
			case 'trashed.delete_all_trashed_mails_modal.warning': return 'Cette action ne peut pas être annulée.';
			case 'mail_composer.title': return 'Nouveau Mail';
			case 'mail_composer.from': return 'De';
			case 'mail_composer.subject': return 'Objet';
			case 'mail_composer.to': return 'À';
			case 'mail_composer.save_draft_modal.title': return 'Enregistrer le brouillon';
			case 'mail_composer.save_draft_modal.description': return 'Voulez-vous enregistrer le brouillon ?';
			case 'mail_composer.save_draft_modal.confirm_text': return 'Enregistrer';
			case 'mail_composer.save_draft_modal.cancel_text': return 'Annuler';
			case 'mail_composer.errors.error_sending_email': return 'Une erreur s\'est produite lors de l\'envoi de l\'e-mail. Veuillez réessayer.';
			case 'account.sections.account': return 'Compte';
			case 'under_construction.title': return 'On travaille dessus !';
			case 'under_construction.description': return 'Cette fonctionnalité est en cours de développement.\n\nRevenez bientôt pour découvrir les dernières mises à jour !';
			case 'more.title': return 'Plus';
			case 'actions.save': return 'Enregistrer';
			case 'actions.cancel': return 'Annuler';
			case 'actions.delete': return 'Supprimer';
			case 'xx_mail_card.description': return ({required Object count}) => 'Vous avez ${count} mails dans ce dossier.';
			case 'email_folders.inbox': return 'Boîte de réception';
			case 'email_folders.drafts': return 'Brouillons';
			case 'email_folders.archive': return 'Archive';
			case 'email_folders.trashed': return 'Corbeille';
			case 'email_folders.all': return 'Tous';
			case 'mail_actions.mark_as_read': return 'Marquer comme lu';
			case 'mail_actions.mark_as_unread': return 'Marquer comme non lu';
			case 'mail_actions.archive': return 'Archive';
			case 'mail_actions.unarchive': return 'Désarchiver';
			case 'mail_actions.trash': return 'Corbeille';
			case 'mail_actions.untrash': return 'Restaurer';
			case 'toast_notifications.selected_mails.title': return ({required Object count}) => '${count} mails sélectionnés';
			case 'toast_notifications.selected_mails.description': return 'Cliquez ici pour effectuer une action.';
			default: return null;
		}
	}
}

