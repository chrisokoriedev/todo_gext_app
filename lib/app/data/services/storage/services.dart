import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_gext_app/app/core/utlls/keys.dart';

class StorageService extends GetxService {
  late GetStorage _box;
  Future<StorageService> init() async {
    _box = GetStorage();
    await _box.write(taskKey, []);
    return this;
  }

  read<T>(String key) {
    return _box.read<T>(key);
  }

  void write<T>(String key, dynamic value) async {
    await _box.write(key, value);
  }
}
