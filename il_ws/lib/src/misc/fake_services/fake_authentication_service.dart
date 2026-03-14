import 'package:il_core/il_entities.dart';
import 'package:il_core/il_exceptions.dart';
import 'package:il_ws/il_ws.dart';

class FakeAuthenticationService implements IAuthenticationService {
  Map<String, User> get _users => {
        'bruno': User(
          id: 1,
          username: 'bruno',
          firstName: 'Bruno',
          lastName: 'Brunić',
          email: 'bbrunic@gmail.com',
          contact: '99 100 2000',
          role: UserRole(id: 1, name: 'Admin'),
        ),
        'maja': User(
          id: 2,
          username: 'maja',
          firstName: 'Maja',
          lastName: 'Majić',
          email: 'mmajic@gmail.com',
          contact: '99 100 2000',
          role: UserRole(id: 1, name: 'Admin'),
        ),
      };

  @override
  Future<RegisteredUser> login(String username, String password) async {
    User? user = _users[username];
    if (user == null || username != password) {
      throw WebServiceException("Invalid username or password.");
    }

    return RegisteredUser(
      user: user,
      accessToken: JwtToken(value: 'access-token:$username'),
      refreshToken: JwtToken(value: 'refresh-token:$username'),
    );
  }

  @override
  Future<RegisteredUser> renewSession(JwtToken refreshToken) async {
    var username = refreshToken.value.split(':').last.trim();
    return login(username, username);
  }

  @override
  Future<MqttCredentials> getMqttCredentials() {
    throw UnimplementedError();
  }
}
