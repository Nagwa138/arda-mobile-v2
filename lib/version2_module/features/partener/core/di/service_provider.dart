import 'package:http/http.dart' as http;
import '../../data/datasources/service_submission_remote_datasource.dart';
import '../../data/repositories/service_submission_repository_impl.dart';
import '../../presentation/cubit/service_submission_cubit.dart';

class ServiceProvider {
  static ServiceSubmissionCubit createServiceSubmissionCubit() {
    final httpClient = http.Client();
    final remoteDataSource =
        ServiceSubmissionRemoteDataSourceImpl(client: httpClient);
    final repository =
        ServiceSubmissionRepositoryImpl(remoteDataSource: remoteDataSource);
    return ServiceSubmissionCubit(repository: repository);
  }
}
