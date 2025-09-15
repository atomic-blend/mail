# Changelog
All notable changes to this project will be documented in this file. See [conventional commits](https://www.conventionalcommits.org/) for commit guidelines.

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

