import 'package:dashboard/dashboard.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeBloc', () {
    late HomeBloc homeBloc;

    setUp(() {
      homeBloc = HomeBloc();
    });

    tearDown(() {
      homeBloc.close();
    });

    test('initial state is HomeInitial', () {
      expect(homeBloc.state, isA<HomeInitial>());
    });

    test('emits [HomeLoading, HomeLoaded] when HomeStarted is added', () async {
      final expectedStates = [
        isA<HomeLoading>(),
        isA<HomeLoaded>(),
      ];

      expectLater(homeBloc.stream, emitsInOrder(expectedStates));

      homeBloc.add(const HomeStarted());
    });
  });
}
