import 'package:auth/auth.dart';
import 'package:core/core_exports.dart';
import 'package:flutter_test/flutter_test.dart';

class MockAppPreference implements AppPreference {
  @override
  Future<bool> readBool(String key) async => false;
  @override
  Future<int?> readInt(String key) async => null;
  @override
  Future<String?> readString(String key) async => null;
  @override
  Future<void> writeBool(String key, bool value) async {}
  @override
  Future<void> writeInt(String key, int value) async {}
  @override
  Future<void> writeString(String key, String value) async {}
  @override
  void init() {}
}

void main() {
  group('LoginBloc', () {
    late LoginBloc loginBloc;
    late MockAppPreference mockPreference;

    setUp(() {
      mockPreference = MockAppPreference();
      loginBloc = LoginBloc(preference: mockPreference);
    });

    tearDown(() {
      loginBloc.close();
    });

    test('initial state is default LoginState', () {
      expect(loginBloc.state.email, '');
      expect(loginBloc.state.password, '');
      expect(loginBloc.state.status, BaseStateStatus.initial);
    });

    test('updates email on LoginEmailChanged', () {
      loginBloc.add(const LoginEmailChanged('test@example.com'));
      expectLater(
        loginBloc.stream,
        emits(predicate<LoginState>((s) => s.email == 'test@example.com')),
      );
    });
  });
}
