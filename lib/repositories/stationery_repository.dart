import "package:records/models/stationery/stationery.dart";
import "package:records/services/stationery_api_client.dart";

class StationeryRepository {
  final StationeryApiClient stationeryApiClient;

  StationeryRepository({StationeryApiClient? stationeryApiClient}): stationeryApiClient = stationeryApiClient ?? StationeryApiClient();

  Future<List<Stationery>> getAllStationery() {
    return stationeryApiClient.getAllStationery();
  }

  Future<Stationery> addStationery(name, quantity, image) {
    return stationeryApiClient.addStationery(name, quantity, image);
  }
}