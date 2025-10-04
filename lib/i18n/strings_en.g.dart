///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final TranslationsSettingsEn settings = TranslationsSettingsEn._(_root);
	late final TranslationsSectionsEn sections = TranslationsSectionsEn._(_root);
	late final TranslationsAccountEn account = TranslationsAccountEn._(_root);
	late final TranslationsMailCardEn mail_card = TranslationsMailCardEn._(_root);
	late final TranslationsZeroInboxCardEn zero_inbox_card = TranslationsZeroInboxCardEn._(_root);
	late final TranslationsTrashedEn trashed = TranslationsTrashedEn._(_root);
	late final TranslationsMailComposerEn mail_composer = TranslationsMailComposerEn._(_root);
	late final TranslationsUnderConstructionEn under_construction = TranslationsUnderConstructionEn._(_root);
	late final TranslationsMoreEn more = TranslationsMoreEn._(_root);
	late final TranslationsActionsEn actions = TranslationsActionsEn._(_root);
	late final TranslationsXxMailCardEn xx_mail_card = TranslationsXxMailCardEn._(_root);
	late final TranslationsEmailFoldersEn email_folders = TranslationsEmailFoldersEn._(_root);
	late final TranslationsMailActionsEn mail_actions = TranslationsMailActionsEn._(_root);
	late final TranslationsToastNotificationsEn toast_notifications = TranslationsToastNotificationsEn._(_root);
}

// Path: settings
class TranslationsSettingsEn {
	TranslationsSettingsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Settings'
	String get title => 'Settings';

	late final TranslationsSettingsAppSettingsEn app_settings = TranslationsSettingsAppSettingsEn._(_root);

	/// en: 'Logout'
	String get logout => 'Logout';
}

// Path: sections
class TranslationsSectionsEn {
	TranslationsSectionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Mail'
	String get mail => 'Mail';
}

// Path: account
class TranslationsAccountEn {
	TranslationsAccountEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsAccountSectionsEn sections = TranslationsAccountSectionsEn._(_root);
}

// Path: mail_card
class TranslationsMailCardEn {
	TranslationsMailCardEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No content'
	String get no_content => 'No content';

	late final TranslationsMailCardDeleteDraftModalEn delete_draft_modal = TranslationsMailCardDeleteDraftModalEn._(_root);
}

// Path: zero_inbox_card
class TranslationsZeroInboxCardEn {
	TranslationsZeroInboxCardEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Congratulations!'
	String get title => 'Congratulations!';

	/// en: 'You don't have any unread messages.'
	String get description => 'You don\'t have any unread messages.';
}

// Path: trashed
class TranslationsTrashedEn {
	TranslationsTrashedEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Delete all trashed mails'
	String get card_title => 'Delete all trashed mails';

	/// en: '${count} mails trashed'
	String x_mails_trashed({required Object count}) => '${count} mails trashed';

	/// en: 'Those are the mails that have been trashed by you, they will be deleted after 30 days.'
	String get description => 'Those are the mails that have been trashed by you, they will be deleted after 30 days.';

	late final TranslationsTrashedDeleteAllTrashedMailsModalEn delete_all_trashed_mails_modal = TranslationsTrashedDeleteAllTrashedMailsModalEn._(_root);
}

// Path: mail_composer
class TranslationsMailComposerEn {
	TranslationsMailComposerEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'New Mail'
	String get title => 'New Mail';

	/// en: 'From'
	String get from => 'From';

	/// en: 'Subject'
	String get subject => 'Subject';

	/// en: 'To'
	String get to => 'To';

	late final TranslationsMailComposerSaveDraftModalEn save_draft_modal = TranslationsMailComposerSaveDraftModalEn._(_root);
}

// Path: under_construction
class TranslationsUnderConstructionEn {
	TranslationsUnderConstructionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'We're working on it!'
	String get title => 'We\'re working on it!';

	/// en: 'This feature is not yet available, but we're working hard to bring it to you soon. Stay tuned!'
	String get description => 'This feature is not yet available, but we\'re working hard to bring it to you soon.\n\nStay tuned!';
}

// Path: more
class TranslationsMoreEn {
	TranslationsMoreEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'More'
	String get title => 'More';
}

// Path: actions
class TranslationsActionsEn {
	TranslationsActionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Delete'
	String get delete => 'Delete';
}

// Path: xx_mail_card
class TranslationsXxMailCardEn {
	TranslationsXxMailCardEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'You have ${count} mails in this folder.'
	String description({required Object count}) => 'You have ${count} mails in this folder.';
}

// Path: email_folders
class TranslationsEmailFoldersEn {
	TranslationsEmailFoldersEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Inbox'
	String get inbox => 'Inbox';

	/// en: 'Drafts'
	String get drafts => 'Drafts';

	/// en: 'Archive'
	String get archive => 'Archive';

	/// en: 'Trashed'
	String get trashed => 'Trashed';

	/// en: 'All'
	String get all => 'All';
}

// Path: mail_actions
class TranslationsMailActionsEn {
	TranslationsMailActionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Mark as read'
	String get mark_as_read => 'Mark as read';

	/// en: 'Mark as unread'
	String get mark_as_unread => 'Mark as unread';

	/// en: 'Archive'
	String get archive => 'Archive';

	/// en: 'Unarchive'
	String get unarchive => 'Unarchive';

	/// en: 'Trash'
	String get trash => 'Trash';

	/// en: 'Untrash'
	String get untrash => 'Untrash';
}

// Path: toast_notifications
class TranslationsToastNotificationsEn {
	TranslationsToastNotificationsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsToastNotificationsSelectedMailsEn selected_mails = TranslationsToastNotificationsSelectedMailsEn._(_root);
}

// Path: settings.app_settings
class TranslationsSettingsAppSettingsEn {
	TranslationsSettingsAppSettingsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'App Settings'
	String get title => 'App Settings';

	late final TranslationsSettingsAppSettingsSelfHostedUrlEn selfHostedUrl = TranslationsSettingsAppSettingsSelfHostedUrlEn._(_root);
}

// Path: account.sections
class TranslationsAccountSectionsEn {
	TranslationsAccountSectionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Account'
	String get account => 'Account';
}

// Path: mail_card.delete_draft_modal
class TranslationsMailCardDeleteDraftModalEn {
	TranslationsMailCardDeleteDraftModalEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Delete draft'
	String get title => 'Delete draft';

	/// en: 'Are you sure you want to delete this draft?'
	String get description => 'Are you sure you want to delete this draft?';

	/// en: 'This action cannot be undone.'
	String get warning => 'This action cannot be undone.';
}

// Path: trashed.delete_all_trashed_mails_modal
class TranslationsTrashedDeleteAllTrashedMailsModalEn {
	TranslationsTrashedDeleteAllTrashedMailsModalEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Delete all trashed mails'
	String get title => 'Delete all trashed mails';

	/// en: 'Are you sure you want to delete all trashed mails?'
	String get description => 'Are you sure you want to delete all trashed mails?';

	/// en: 'This action cannot be undone.'
	String get warning => 'This action cannot be undone.';
}

// Path: mail_composer.save_draft_modal
class TranslationsMailComposerSaveDraftModalEn {
	TranslationsMailComposerSaveDraftModalEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Save Draft'
	String get title => 'Save Draft';

	/// en: 'Do you want to save the draft?'
	String get description => 'Do you want to save the draft?';

	/// en: 'Save'
	String get confirm_text => 'Save';

	/// en: 'Discard'
	String get cancel_text => 'Discard';
}

// Path: toast_notifications.selected_mails
class TranslationsToastNotificationsSelectedMailsEn {
	TranslationsToastNotificationsSelectedMailsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '${count} mails selected'
	String title({required Object count}) => '${count} mails selected';

	/// en: 'Click here to perform action.'
	String get description => 'Click here to perform action.';
}

// Path: settings.app_settings.selfHostedUrl
class TranslationsSettingsAppSettingsSelfHostedUrlEn {
	TranslationsSettingsAppSettingsSelfHostedUrlEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Self-Hosted URL'
	String get title => 'Self-Hosted URL';

	/// en: 'Not set'
	String get not_set => 'Not set';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'settings.title': return 'Settings';
			case 'settings.app_settings.title': return 'App Settings';
			case 'settings.app_settings.selfHostedUrl.title': return 'Self-Hosted URL';
			case 'settings.app_settings.selfHostedUrl.not_set': return 'Not set';
			case 'settings.logout': return 'Logout';
			case 'sections.mail': return 'Mail';
			case 'account.sections.account': return 'Account';
			case 'mail_card.no_content': return 'No content';
			case 'mail_card.delete_draft_modal.title': return 'Delete draft';
			case 'mail_card.delete_draft_modal.description': return 'Are you sure you want to delete this draft?';
			case 'mail_card.delete_draft_modal.warning': return 'This action cannot be undone.';
			case 'zero_inbox_card.title': return 'Congratulations!';
			case 'zero_inbox_card.description': return 'You don\'t have any unread messages.';
			case 'trashed.card_title': return 'Delete all trashed mails';
			case 'trashed.x_mails_trashed': return ({required Object count}) => '${count} mails trashed';
			case 'trashed.description': return 'Those are the mails that have been trashed by you, they will be deleted after 30 days.';
			case 'trashed.delete_all_trashed_mails_modal.title': return 'Delete all trashed mails';
			case 'trashed.delete_all_trashed_mails_modal.description': return 'Are you sure you want to delete all trashed mails?';
			case 'trashed.delete_all_trashed_mails_modal.warning': return 'This action cannot be undone.';
			case 'mail_composer.title': return 'New Mail';
			case 'mail_composer.from': return 'From';
			case 'mail_composer.subject': return 'Subject';
			case 'mail_composer.to': return 'To';
			case 'mail_composer.save_draft_modal.title': return 'Save Draft';
			case 'mail_composer.save_draft_modal.description': return 'Do you want to save the draft?';
			case 'mail_composer.save_draft_modal.confirm_text': return 'Save';
			case 'mail_composer.save_draft_modal.cancel_text': return 'Discard';
			case 'under_construction.title': return 'We\'re working on it!';
			case 'under_construction.description': return 'This feature is not yet available, but we\'re working hard to bring it to you soon.\n\nStay tuned!';
			case 'more.title': return 'More';
			case 'actions.delete': return 'Delete';
			case 'xx_mail_card.description': return ({required Object count}) => 'You have ${count} mails in this folder.';
			case 'email_folders.inbox': return 'Inbox';
			case 'email_folders.drafts': return 'Drafts';
			case 'email_folders.archive': return 'Archive';
			case 'email_folders.trashed': return 'Trashed';
			case 'email_folders.all': return 'All';
			case 'mail_actions.mark_as_read': return 'Mark as read';
			case 'mail_actions.mark_as_unread': return 'Mark as unread';
			case 'mail_actions.archive': return 'Archive';
			case 'mail_actions.unarchive': return 'Unarchive';
			case 'mail_actions.trash': return 'Trash';
			case 'mail_actions.untrash': return 'Untrash';
			case 'toast_notifications.selected_mails.title': return ({required Object count}) => '${count} mails selected';
			case 'toast_notifications.selected_mails.description': return 'Click here to perform action.';
			default: return null;
		}
	}
}

