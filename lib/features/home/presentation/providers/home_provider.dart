import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:livemcq3/features/home/domain/usecases/get_dashboard_data.dart';
import 'package:livemcq3/core/providers/app_providers.dart';
part 'home_provider.g.dart';

final getDashboardDataProvider = Provider<GetDashboardData>((ref) {
  return GetDashboardData(ref.read(homeRepositoryProvider));
});

@riverpod
Future<Map<String, dynamic>> home(HomeRef ref) {
  return ref.read(getDashboardDataProvider)();
}
