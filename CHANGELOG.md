# Changelog
All notable changes to this project will be documented in this file. See [conventional commits](https://www.conventionalcommits.org/) for commit guidelines.

- - -
## 0.2.1 - 2025-09-19
#### Bug Fixes
- add sudo to the install dependency commands - (93ae5b9) - Brandon Guigo
#### Miscellaneous Chores
- **(release)** 0.2.0 [skip ci] - (36d58e5) - GitHub Actions

- - -

## 0.2.0 - 2025-09-19
#### Bug Fixes
- add a new step in the cicd that will build the linux app and store it as an artifact - (0e38747) - Brandon Guigo
- translate organize - (1ede3d8) - Brandon Guigo
- translate mail details - (69b2964) - Brandon Guigo
- translate mail composer - (cf3ff19) - Brandon Guigo
- translate filtered view - (eb478eb) - Brandon Guigo
- translate trashed view - (e3e0208) - Brandon Guigo
- linter - (ea3d7b8) - Brandon Guigo
- draft didn't use sync service - (d2b4cd7) - Brandon Guigo
- update to latest shared - (1c07c6a) - Brandon Guigo
- linter - (364ddc9) - Brandon Guigo
- draft popup bugs - (d0ea212) - Brandon Guigo
- ui so the text editor is always to the max of the available space - (2c66ab8) - Brandon Guigo
- sizes of the editor - (48966e8) - Brandon Guigo
- overflow on mail card - (2fa9e05) - Brandon Guigo
- draft bug with new editor + fix broken modal for draft save - (a12ae73) - Brandon Guigo
- move editor and toolbar to shared package - (cf14372) - Brandon Guigo
- wasm error - (785d0af) - Brandon Guigo
- add the ability to choose editor when using MailComposer widget - (68fd01a) - Brandon Guigo
- linter - (f1ee60f) - Brandon Guigo
- bug with card swiper - (94a25be) - Brandon Guigo
- linter - (1bca72b) - Brandon Guigo
#### Features
- translate mail card - (20c02c5) - Brandon Guigo
- make draft screen have search too - (0ed1bc5) - Brandon Guigo
- add search to filtered view - (9ffc4d1) - Brandon Guigo
- add basic search for the search page - (0652ec0) - Brandon Guigo
- support json to search without a model - (e0f1e6b) - Brandon Guigo
- add search service - (dfe3c65) - Brandon Guigo
- update to new version of shared - (31df0af) - Brandon Guigo
- add load config when the app starts - (46bef63) - Brandon Guigo
- customized navbar for mobile editor - (33ad8ab) - Brandon Guigo
- update the parchment document to html convert + load draft document - (6504e56) - Brandon Guigo
- add fleather controller - (26bbb53) - Brandon Guigo
- update min version + fix the last bugs in organize page for now - (9b99f19) - Brandon Guigo
- ui for organize screen - (ccefb63) - Brandon Guigo
- add the loop and end ui for the tinder like ui - (7013794) - Brandon Guigo
- add buttons for actions - (133e438) - Brandon Guigo
- add a tinder like swappable effect for the mail app - (e5f1380) - Brandon Guigo
- add the empty inbox ui in organize - (5a32051) - Brandon Guigo
- add organize page - (bf36afd) - Brandon Guigo
- add call to empty trash endpoint with modal to confirm before - (3765ec8) - Brandon Guigo
- add header to filtered mail view + container for trashed elements - (d8333e9) - Brandon Guigo
#### Miscellaneous Chores
- **(release)** 0.1.0 [skip ci] - (3bb22be) - GitHub Actions

- - -

## 0.1.0 - 2025-09-15
#### Bug Fixes
- bad depends on in pipeline - (06ec48e) - Brandon Guigo
- remove the from in the copy in the Dockerfile - (203a40c) - Brandon Guigo
- remove bad dependency - (db93694) - Brandon Guigo
- correctly create the files for config from secrets - (85b73b4) - Brandon Guigo
- make the cicd build flutter web app before docker images - (b0f7e73) - Brandon Guigo
- refactor mail state to add a transform method that prevents missing fields from state changes - (728a4ee) - Brandon Guigo
- change icon for unarchive button - (2fc22f4) - Brandon Guigo
- enhance the ui of the to / from mail controller ui - (3f8c6eb) - Brandon Guigo
- linter + remove todos - (5a0ef0d) - Brandon Guigo
- update ab_shared and check local dependency before pub get - (cd21707) - Brandon Guigo
- change the draft screen icon - (e746f4b) - Brandon Guigo
- padding for mail filtered view - (bece15b) - Brandon Guigo
- merge the 2 loads methods for drafts and mails into the load mails method - (4fcc20b) - Brandon Guigo
- state overwrite other data in mail bloc - (6b39866) - Brandon Guigo
- linter - (78cf9ce) - Brandon Guigo
- complete the logic of the draft, needs backend code now - (5dd9693) - Brandon Guigo
- convert to modal bottom sheet - (1aed606) - Brandon Guigo
- start of the ui - (26d45d1) - Brandon Guigo
- linter - (1c82d1a) - Brandon Guigo
- ui for read / unread - (f31c18f) - Brandon Guigo
- mail detail read ui - (c5c8586) - Brandon Guigo
- refresh indicator when there's mails - (435cc4e) - Brandon Guigo
- pubspec for shared - (f1e9c9d) - Brandon Guigo
- make the card display unread - (e240463) - Brandon Guigo
- mail service for decryption - (802ff40) - Brandon Guigo
- update to the new ab navbar - (680544a) - Brandon Guigo
- use new version of shared - (d6c7840) - Brandon Guigo
- update the app to use the new navbar - (96ac14c) - Brandon Guigo
- adapt to new navbar - (28da8bf) - Brandon Guigo
#### Features
- add slidable trash / untrash - (6addc3d) - Brandon Guigo
- add trashed view + trash/untrash in mail details - (2fd3df8) - Brandon Guigo
- add trashed at field to mail model - (d1c5c26) - Brandon Guigo
- add trashed and untrashed into mail bloc - (e47a703) - Brandon Guigo
- add slidable action on mail card - (00d969e) - Brandon Guigo
- add archived mails view - (a5d39e7) - Brandon Guigo
- be able to archive an email - (009aa32) - Brandon Guigo
- add archived and unarchived to mail bloc + fix read messages not displayed in inbox - (3e31974) - Brandon Guigo
- make a pill shape display for mail recipients - (c086d00) - Brandon Guigo
- add the delete draft slidable - (27d01cc) - Brandon Guigo
- update the draft work - (f68e5ce) - Brandon Guigo
- convert draft model to send mail entity so there's fields and id for the draft available - (6f7f257) - Brandon Guigo
- open draft from draft list - (443691c) - Brandon Guigo
- make get draft page - (9d502c4) - Brandon Guigo
- setup drawer for inbox - (b6587b1) - Brandon Guigo
- add the draft methods to the bloc - (f4d4004) - Brandon Guigo
- pop the send modal when sending is done - (785693d) - Brandon Guigo
- send email via API call from the app - (9ba1d48) - Brandon Guigo
- create mail from raw mail - (5ad745c) - Brandon Guigo
- add all the necessary fields - (fdf8c2c) - Brandon Guigo
- support basic mobile toolbar v2 - (9c99dc2) - Brandon Guigo
- basic version of appflowy editor - (83ba3d4) - Brandon Guigo
- add the mail composer widget - (4fc360a) - Brandon Guigo
- mark as unread work - (1accca0) - Brandon Guigo
- mark as read work when openning an email - (0e318e7) - Brandon Guigo
- add sync actions bloc methods - (6ed9ede) - Brandon Guigo
- display the content of an email - (40ee9d0) - Brandon Guigo
- add the mail detail screen - (807c614) - Brandon Guigo
- display the email in the list - (9b4195d) - Brandon Guigo
- add mail bloc - (2e1ba07) - Brandon Guigo
- add mail_service and get mail - (e766f54) - Brandon Guigo
- add mail screen and no mails container - (95758db) - Brandon Guigo
- configure navbar - (fbca256) - Brandon Guigo
- add mail entity - (70aa011) - Brandon Guigo
#### Miscellaneous Chores
- **(release)** 0.0.2 [skip ci] - (8822317) - GitHub Actions
- update main pipeline to use one runner per docker image - (04459f8) - Brandon Guigo
- update the pipelines to do docker build + self-hosted runners - (3e148a5) - Brandon Guigo
- update main.yaml to build a docker image - (387ff7d) - Brandon Guigo
- add the dockerfile - (4fb1809) - Brandon Guigo
- update the ab_shared package version - (5f79422) - Brandon Guigo

- - -

## 0.0.2 - 2025-08-14
#### Bug Fixes
- trigger rebuild - (1bef0c2) - Brandon Guigo

- - -

## 0.0.2 - 2025-08-14
#### Bug Fixes
- changelog + workflows - (2020df8) - Brandon Guigo

- - -

