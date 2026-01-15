///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
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
	late final TranslationsEmailDomainValidationEn email_domain_validation = TranslationsEmailDomainValidationEn._(_root);
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

	/// en: 'Body'
	String get body => 'Body';

	/// en: 'Date'
	String get date => 'Date';

	/// en: 'Send'
	String get send => 'Send';

	Map<String, String> get fields => {
		'to': 'To',
		'subject': 'Subject',
		'body': 'Body',
	};
	late final TranslationsMailComposerSaveDraftModalEn save_draft_modal = TranslationsMailComposerSaveDraftModalEn._(_root);
	late final TranslationsMailComposerIncompleteEmailModalEn incomplete_email_modal = TranslationsMailComposerIncompleteEmailModalEn._(_root);
	Map<String, String> get errors => {
		'error_sending_email': 'An error occurred while sending the email. Please try again.',
		'no_recipient': 'Please specify at least one recipient.',
		'invalid_recipient': 'One or more recipients have an invalid email address.',
	};
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

	/// en: 'Spam'
	String get spam => 'Spam';

	/// en: 'Sent'
	String get sent => 'Sent';

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

// Path: email_domain_validation
class TranslationsEmailDomainValidationEn {
	TranslationsEmailDomainValidationEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Update Email Address'
	String get title => 'Update Email Address';

	/// en: 'Your current email address is not from an authorized domain. Please provide a new email address from one of the following authorized domains: ${domains}'
	String description({required Object domains}) => 'Your current email address is not from an authorized domain. Please provide a new email address from one of the following authorized domains: ${domains}';

	/// en: 'Current Email'
	String get current_email => 'Current Email';

	/// en: 'New Email Address'
	String get new_email_label => 'New Email Address';

	/// en: 'Enter your new email address'
	String get new_email_hint => 'Enter your new email address';

	/// en: 'Backup Email (Optional)'
	String get backup_email_label => 'Backup Email (Optional)';

	/// en: 'Enter a backup email address'
	String get backup_email_hint => 'Enter a backup email address';

	/// en: 'The backup email will be used for account recovery and important notifications.'
	String get info => 'The backup email will be used for account recovery and important notifications.';

	/// en: 'Update Email'
	String get submit => 'Update Email';

	/// en: 'Updating...'
	String get submitting => 'Updating...';

	Map<String, dynamic> get errors => {
		'empty_email': 'Please enter an email address.',
		'invalid_email_format': 'Please enter a valid email address.',
		'email_not_in_authorized_domain': ({required Object domains}) => 'The email address must be from one of these domains: ${domains}',
		'update_failed': 'Failed to update email address. Please try again.',
	};
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

// Path: mail_composer.incomplete_email_modal
class TranslationsMailComposerIncompleteEmailModalEn {
	TranslationsMailComposerIncompleteEmailModalEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Incomplete Email'
	String get title => 'Incomplete Email';

	/// en: 'The email you are trying to send is incomplete. Please check the following fields:'
	String get description => 'The email you are trying to send is incomplete.\nPlease check the following fields:';

	/// en: 'Do you want to go back and complete it?'
	String get want_to_go_back => 'Do you want to go back and complete it?';

	/// en: 'Go Back'
	String get cancel_text => 'Go Back';

	/// en: 'Send Anyway'
	String get confirm_text => 'Send Anyway';
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

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'settings.title' => 'Settings',
			'settings.app_settings.title' => 'App Settings',
			'settings.app_settings.selfHostedUrl.title' => 'Self-Hosted URL',
			'settings.app_settings.selfHostedUrl.not_set' => 'Not set',
			'settings.logout' => 'Logout',
			'sections.mail' => 'Mail',
			'account.sections.account' => 'Account',
			'mail_card.no_content' => 'No content',
			'mail_card.delete_draft_modal.title' => 'Delete draft',
			'mail_card.delete_draft_modal.description' => 'Are you sure you want to delete this draft?',
			'mail_card.delete_draft_modal.warning' => 'This action cannot be undone.',
			'zero_inbox_card.title' => 'Congratulations!',
			'zero_inbox_card.description' => 'You don\'t have any unread messages.',
			'trashed.card_title' => 'Delete all trashed mails',
			'trashed.x_mails_trashed' => ({required Object count}) => '${count} mails trashed',
			'trashed.description' => 'Those are the mails that have been trashed by you, they will be deleted after 30 days.',
			'trashed.delete_all_trashed_mails_modal.title' => 'Delete all trashed mails',
			'trashed.delete_all_trashed_mails_modal.description' => 'Are you sure you want to delete all trashed mails?',
			'trashed.delete_all_trashed_mails_modal.warning' => 'This action cannot be undone.',
			'mail_composer.title' => 'New Mail',
			'mail_composer.from' => 'From',
			'mail_composer.subject' => 'Subject',
			'mail_composer.to' => 'To',
			'mail_composer.body' => 'Body',
			'mail_composer.date' => 'Date',
			'mail_composer.send' => 'Send',
			'mail_composer.fields.to' => 'To',
			'mail_composer.fields.subject' => 'Subject',
			'mail_composer.fields.body' => 'Body',
			'mail_composer.save_draft_modal.title' => 'Save Draft',
			'mail_composer.save_draft_modal.description' => 'Do you want to save the draft?',
			'mail_composer.save_draft_modal.confirm_text' => 'Save',
			'mail_composer.save_draft_modal.cancel_text' => 'Discard',
			'mail_composer.incomplete_email_modal.title' => 'Incomplete Email',
			'mail_composer.incomplete_email_modal.description' => 'The email you are trying to send is incomplete.\nPlease check the following fields:',
			'mail_composer.incomplete_email_modal.want_to_go_back' => 'Do you want to go back and complete it?',
			'mail_composer.incomplete_email_modal.cancel_text' => 'Go Back',
			'mail_composer.incomplete_email_modal.confirm_text' => 'Send Anyway',
			'mail_composer.errors.error_sending_email' => 'An error occurred while sending the email. Please try again.',
			'mail_composer.errors.no_recipient' => 'Please specify at least one recipient.',
			'mail_composer.errors.invalid_recipient' => 'One or more recipients have an invalid email address.',
			'under_construction.title' => 'We\'re working on it!',
			'under_construction.description' => 'This feature is not yet available, but we\'re working hard to bring it to you soon.\n\nStay tuned!',
			'more.title' => 'More',
			'actions.delete' => 'Delete',
			'xx_mail_card.description' => ({required Object count}) => 'You have ${count} mails in this folder.',
			'email_folders.inbox' => 'Inbox',
			'email_folders.drafts' => 'Drafts',
			'email_folders.archive' => 'Archive',
			'email_folders.trashed' => 'Trashed',
			'email_folders.spam' => 'Spam',
			'email_folders.sent' => 'Sent',
			'email_folders.all' => 'All',
			'mail_actions.mark_as_read' => 'Mark as read',
			'mail_actions.mark_as_unread' => 'Mark as unread',
			'mail_actions.archive' => 'Archive',
			'mail_actions.unarchive' => 'Unarchive',
			'mail_actions.trash' => 'Trash',
			'mail_actions.untrash' => 'Untrash',
			'toast_notifications.selected_mails.title' => ({required Object count}) => '${count} mails selected',
			'toast_notifications.selected_mails.description' => 'Click here to perform action.',
			'email_domain_validation.title' => 'Update Email Address',
			'email_domain_validation.description' => ({required Object domains}) => 'Your current email address is not from an authorized domain. Please provide a new email address from one of the following authorized domains: ${domains}',
			'email_domain_validation.current_email' => 'Current Email',
			'email_domain_validation.new_email_label' => 'New Email Address',
			'email_domain_validation.new_email_hint' => 'Enter your new email address',
			'email_domain_validation.backup_email_label' => 'Backup Email (Optional)',
			'email_domain_validation.backup_email_hint' => 'Enter a backup email address',
			'email_domain_validation.info' => 'The backup email will be used for account recovery and important notifications.',
			'email_domain_validation.submit' => 'Update Email',
			'email_domain_validation.submitting' => 'Updating...',
			'email_domain_validation.errors.empty_email' => 'Please enter an email address.',
			'email_domain_validation.errors.invalid_email_format' => 'Please enter a valid email address.',
			'email_domain_validation.errors.email_not_in_authorized_domain' => ({required Object domains}) => 'The email address must be from one of these domains: ${domains}',
			'email_domain_validation.errors.update_failed' => 'Failed to update email address. Please try again.',
			_ => null,
		};
	}
}
