import 'package:equatable/equatable.dart';

class Token extends Equatable {
  final String token;
  final String? refreshToken;
  final TokenType tokenType;

  const Token({required this.token, required this.refreshToken, this.tokenType = TokenType.none});

  factory Token.ofNoneType() {
    return const Token(
      token: '',
      refreshToken: '',
      tokenType: TokenType.none,
    );
  }

  @override
  List<Object?> get props => [
        token,
        refreshToken,
      ];
}

enum TokenType {
  /// user token type should be the one you get after authoriztaion with user credentials
  user,

  /// if you don't have any please consider getting api first
  none
}

extension TokenTypeExtension on TokenType {
  String get stringRepresentation {
    switch (this) {
      case TokenType.user:
        return 'user';
      case TokenType.none:
        return 'none';
    }
  }

  static TokenType fromString(String? stringTokenType) {
    switch (stringTokenType ?? "") {
      case 'user':
        return TokenType.user;
      default:
        return TokenType.none;
    }
  }
}
