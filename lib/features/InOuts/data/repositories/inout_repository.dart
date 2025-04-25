import 'package:sample_app/core/curd.dart';
import 'package:sample_app/core/data_state.dart';

import '../../domain/entities/inout_entity.dart';
import '../datasource/remote/inout_remoteService.dart';

class InOutRepository implements CURD<InOut> {
  final InOutRemoteService _inOutRemoteService;

  InOutRepository(this._inOutRemoteService);
  final bool cachable = false;

  @override
  Future<DataState<InOut>> get(int id) async {
    final item = await _inOutRemoteService.get(id);

    return item;
  }

  // Future<List<InOut>> gets(ListRequestParams reqparams) async {
  //   if (isDeviceConnected.value && AppSettings.workMode != WorkMode.Offline) {
  //     final item = await _inOutRemoteService.fetchItems(reqparams);
  //     if (cachable && Sync.allowLocaling && item.isSuccess()) _inOutLocalService.save(item);
  //     return item;
  //   } else {
  //     return (await _inOutLocalService.gets(reqparams)).data!;
  //   }
  // }

  @override
  Future<DataState<InOut>> add(InOut inOut) async {
    final item = await _inOutRemoteService.add(inOut);

    return item;
  }

  @override
  Future<DataState<InOut>> update(InOut inOut) async {
    final item = await _inOutRemoteService.update(inOut);

    return item;
  }

  @override
  Future<DataState<InOut>> delByID(int id) async {
    final item = await _inOutRemoteService.delByID(id);

    return item;
  }

  // @override
  // Future<DataState<InOut>> del(InOut inOut) async {
  //   if (isDeviceConnected.value && AppSettings.workMode != WorkMode.Offline) {
  //     final item = await _inOutRemoteService.delete(inOut);
  //     if (cachable && Sync.allowLocaling && item.isSuccess()) _inOutLocalService.delSafe(inOut);
  //     return item;
  //   } else {
  //     return AppSettings.workMode == WorkMode.Offline
  //         ? _inOutLocalService.del(inOut)
  //         : _inOutLocalService.delSafe(inOut);
  //   }
  // }
}
