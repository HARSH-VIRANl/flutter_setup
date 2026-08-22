import 'package:core/core_exports.dart';
import '../../data/model/demo_model.dart';
import '../../data/repositories/demo_repository_impl.dart';

class DemoUsecase extends UseCase<DemoModel, NoParamModelForUseCase> {
  final DemoRepository demoRepository;

  DemoUsecase({required this.demoRepository});

  @override
  Future<Either<Failure, DemoModel>> call(
    NoParamModelForUseCase params,
  ) async {
    try {
      final response = await demoRepository.fetchDemoData();
      if (response.isSuccess) {
        return right(
          DemoModel.fromJson(
            response.result as Map<String, dynamic>,
          ),
        );
      } else {
        return left(getFailureFromAPI(response.message ?? ''));
      }
    } catch (e) {
      return left(getFailureFromException(e));
    }
  }
}
