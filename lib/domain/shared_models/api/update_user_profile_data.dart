class UpdateUserProfileData {
  UpdateUserProfileData({
    this.phoneNumber,
    this.email,
  });

  final String? phoneNumber;
  final String? email;

  Map<String, dynamic> toJson() {
    return {
      if (phoneNumber != null) 
        "phoneNumber": phoneNumber,
      if (email != null) 
        "email": email,
    };
  }
}
