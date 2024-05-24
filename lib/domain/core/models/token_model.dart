
import '../entities/token.dart';

class TokenModel extends Token {

  const TokenModel({
    super.tokenType = TokenType.none,
    super.refreshToken,
    required super.token,
  });

  factory TokenModel.fromJson({required Map<String, dynamic> json, required TokenType tokenType}) {
    return TokenModel(
      token: json['access_token'],
      refreshToken: json['refresh_token'],
      tokenType:  tokenType,
    );
  }

  factory TokenModel.fromSecureStorage({required Map<String, dynamic> json}) {
    return TokenModel(
        token: json['token'],
        refreshToken: json['refresh_token'],
        tokenType: TokenTypeExtension.fromString(json['tokenType']),
    );
  }

  Map<String, dynamic> toSecureJson() {
    return {
      'token': token,
      'refresh_token': refreshToken,
      'tokenType': tokenType.stringRepresentation,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'refresh_token': refreshToken,
    };
  }
}
