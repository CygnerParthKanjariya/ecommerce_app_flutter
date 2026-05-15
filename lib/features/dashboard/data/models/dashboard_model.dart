import '../../domain/entities/dashboard.dart';

class DashboardModel extends Dashboard {
    const DashboardModel() : super();

    factory DashboardModel.fromJson(Map<String, dynamic> json) {
      return DashboardModel();
    }

    Map<String, dynamic> toJson() {
      return {};
    }
}