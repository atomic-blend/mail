/// Utility class for validating email domains against authorized domains
class EmailDomainValidator {
  /// Checks if an email address is from an authorized domain
  static bool isEmailAuthorized(
      String? email, List<String>? authorizedDomains) {
    if (email == null || email.isEmpty) return false;
    if (authorizedDomains == null || authorizedDomains.isEmpty) {
      return true; // If no restrictions, allow all
    }

    try {
      final emailParts = email.split('@');
      if (emailParts.length != 2) return false;

      final domain = emailParts[1].toLowerCase();
      return authorizedDomains
          .any((authorizedDomain) => domain == authorizedDomain.toLowerCase());
    } catch (e) {
      return false;
    }
  }

  /// Extracts the domain from an email address
  static String? getDomainFromEmail(String? email) {
    if (email == null || email.isEmpty) return null;

    try {
      final emailParts = email.split('@');
      if (emailParts.length != 2) return null;
      return emailParts[1];
    } catch (e) {
      return null;
    }
  }
}
