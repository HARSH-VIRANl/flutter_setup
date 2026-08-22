enum BaseStateStatus {
  initial,
  loading,
  success,
  empty,
  failure,
  noInternet;

  bool get isInitial => this == BaseStateStatus.initial;
  bool get isLoading => this == BaseStateStatus.loading;
  bool get isSuccess => this == BaseStateStatus.success;
  bool get isEmpty => this == BaseStateStatus.empty;
  bool get isFailure => this == BaseStateStatus.failure;
  bool get isNoInternet => this == BaseStateStatus.noInternet;
}
