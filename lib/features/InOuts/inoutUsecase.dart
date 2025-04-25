import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_app/core/data_state.dart';

import 'data/datasource/remote/inout_remoteService.dart';
import 'data/repositories/inout_repository.dart';
import 'domain/entities/inout_entity.dart';

//////////////////////////////////////
final InOutRemoteServiceProvider = Provider<InOutRemoteService>((ref) {
  //final _dio = Dio();
  return const InOutRemoteService();
});

////////////////////////////////////

final inoutsRepositoryProvider = Provider<InOutRepository>((ref) {
  final remoteService = ref.read(InOutRemoteServiceProvider);

  return InOutRepository(remoteService);
});

///////////////////////////////////////

final getInOutProvider = FutureProvider.autoDispose
    .family<DataState<InOut>, int>((ref, id) async {
      final dataStore = ref.read(inoutsRepositoryProvider);
      DataState<InOut> res = await dataStore.get(id);
      await Future.delayed(Duration.zero).then((_) {
        if (res.isSuccess()) {
          ref.read(inoutProvider.notifier).setState(res.data!);
        }
      });
      res.action = ActionType.GET;
      ref.read(inoutDataStateProvider.notifier).setState(res);
      return res;
    });

///////////////////////////////////////

final newInOutProvider = FutureProvider.autoDispose
    .family<DataState<InOut>, bool>((ref, type) async {
      DataState<InOut> res = DataSuccess(InOut.NewInOut(type));
      await Future.delayed(Duration.zero).then((_) {
        if (res.isSuccess()) {
          ref.read(inoutProvider.notifier).setState(res.data!);
        }
      });
      res.action = ActionType.NEW;
      ref.read(inoutDataStateProvider.notifier).setState(res);
      return res;
    });

///////////////////////////////////////

final addInOutProvider = FutureProvider.autoDispose
    .family<DataState<InOut>, InOut>((ref, inout) async {
      final dataStore = ref.read(inoutsRepositoryProvider);
      DataState<InOut> res = await dataStore.add(inout);
      res.action = ActionType.ADD;
      if (res.isSuccess()) ref.read(inoutProvider.notifier).setState(res.data!);
      ref.read(inoutDataStateProvider.notifier).setState(res);
      return res;
    });

///////////////////////////////////////

final deleteInOutProvider = FutureProvider.autoDispose
    .family<DataState<void>, int>((ref, inoutID) async {
      final dataStore = ref.read(inoutsRepositoryProvider);
      DataState<InOut> res = await dataStore.delByID(inoutID);
      res.action = ActionType.DEL;
      ref.read(inoutDataStateProvider.notifier).setState(res);
      return res;
    });

///////////////////////////////////////

final updateInOutProvider = FutureProvider.autoDispose
    .family<DataState<InOut>, InOut>((ref, inout) async {
      final dataStore = ref.read(inoutsRepositoryProvider);
      DataState<InOut> res = await dataStore.update(inout);
      res.action = ActionType.UPDATE;
      if (res.isSuccess()) ref.read(inoutProvider.notifier).setState(res.data!);
      ref.read(inoutDataStateProvider.notifier).setState(res);
      return res;
    });

///////////////////////////////////////

class InOutStateNotifier extends StateNotifier<InOut> {
  InOutStateNotifier(this.ref) : super(InOut.NewInOut(false));

  final Ref ref;

  void rest() {
    state = InOut.NewInOut(false);
  }

  void recalc() {
    state = state.copyWith();
  }

  void setState(InOut inout) {
    state = inout;
  }
}

///////////////////////////////////////

final inoutProvider = StateNotifierProvider<InOutStateNotifier, InOut>((ref) {
  return InOutStateNotifier(ref);
});

///////////////////////////////////////

class InOutDataStateNotifier extends StateNotifier<DataState<InOut>> {
  InOutDataStateNotifier(this.ref) : super(DataSuccess(InOut.NewInOut(false)));

  final Ref ref;

  void setState(DataState<InOut> newsate) {
    state = newsate;
  }
}

final inoutDataStateProvider =
    StateNotifierProvider<InOutDataStateNotifier, DataState<InOut>>((ref) {
      return InOutDataStateNotifier(ref);
    });

///////////////////////////////////////
