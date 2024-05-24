class UpdateProfileRequestParameters {
  final String phoneNumber;
  final String? email;
  final bool isTermsAccepted;

  UpdateProfileRequestParameters({
    required this.phoneNumber,
    this.email,
    required this.isTermsAccepted,
  });
}
