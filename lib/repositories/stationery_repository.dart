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

  Future<Map> updateStationery(id, name, quantity, image) {
    return stationeryApiClient.updateStationery(id, name, quantity, image);
  }

  Future<Map> deleteStationery(id) {
    return stationeryApiClient.deleteStationery(id);
  }

  Future<Stationery> getStationeryRecords(id) {
    return stationeryApiClient.getStationeryRecords(id);
  }
}