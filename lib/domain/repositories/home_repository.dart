import '../../data/models/home/home_model.dart';

abstract class HomeRepository {
  const HomeRepository();

  Future<List<HomeModel>> getHomeData();
}
