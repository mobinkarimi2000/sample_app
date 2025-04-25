import 'package:sample_app/core/curd.dart';
import 'package:sample_app/core/data_state.dart';

import '../../../../../core/ql.dart';
import '../../../domain/entities/inout_entity.dart';
import '../gql/inout-gql.dart';

class InOutRemoteService implements CURD<InOut> {
  // final inoutesApiService _inoutesApiService;

  //const InOutRepository(this._inoutesApiService, );
  const InOutRemoteService();

  @override
  Future<DataState<InOut>> get(int id) async {
    return await qlT<InOut>().QueryItem('inout', gqlInout, {
      'id': id,
    }, InOut.fromJson);
  }

  @override
  Future<DataState<InOut>> add(InOut inout) async {
    return await qlT<InOut>().QueryItem(
      'inoutCreate',
      gqlInoutCreate,
      inout.toJson(),
      InOut.fromJson,
    );
  }

  @override
  Future<DataState<InOut>> update(InOut inout) async {
    return await qlT<InOut>().QueryItem(
      'inoutUpdate',
      gqlInoutUpdate,
      inout.toJson(),
      InOut.fromJson,
    );
  }

  @override
  Future<DataState<InOut>> delByID(int id) async {
    return await qlT<InOut>().QueryItem('inoutRemove', gqlInoutRemove, {
      'id': id,
    }, InOut.fromJson);
  }
}
