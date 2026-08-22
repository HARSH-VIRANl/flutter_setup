import 'package:core/core_exports.dart';

abstract class DemoRepository {
  Future<ResponseHandler> fetchDemoData();
}

class DemoRepositoryImpl extends DemoRepository {
  final BaseApiProvider dio;

  DemoRepositoryImpl({required this.dio});

  @override
  Future<ResponseHandler> fetchDemoData() async {
    final response = await dio.getMethod(APIConstant.agencyDashboard);
    return ResponseHandler.fromJson(response.data);
  }
}
