import 'package:core/src/base/blocs/core_bloc_config/base_state_status.dart';
import 'package:equatable/equatable.dart';

abstract class BaseBlocState<T> extends Equatable {
  final BaseStateStatus status;

  const BaseBlocState({
    required this.status,
  });
}
