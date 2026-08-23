import 'package:core/core_exports.dart';
import '../../data/model/demo_model.dart';
import '../../data/repositories/demo_repository_impl.dart';

class DemoUsecase
    extends UseCase<List<DemoUserModel>, NoParamModelForUseCase> {
  final DemoRepository demoRepository;

  DemoUsecase({required this.demoRepository});

  @override
  Future<Either<Failure, List<DemoUserModel>>> call(
    NoParamModelForUseCase params,
  ) async {
    try {
      final response = await demoRepository.fetchDemoData();
      return response.isSuccess
          ? right(
              tryParseList<DemoUserModel>(
                response.result as List<dynamic>,
                (map) => DemoUserModel.fromJson(map),
              ),
            )
          : left(getFailureFromAPI(response.message ?? ''));
    } catch (e) {
      return left(getFailureFromException(e));
    }
  }
}

