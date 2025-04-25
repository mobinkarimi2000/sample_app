// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sample_app/core/data_state.dart';

class ql {
  //static late HttpLink httpLink;// =      HttpLink(baseUrlGql /*'http://127.0.0.1:8101/graphql'*/);

  // static AuthLink authLink = AuthLink(
  //   getToken: () async => "Bearer ${Auth.token.accessToken}",
  // );

  //static late Link link;

  static late GraphQLClient gqlClient;

  static init() {
    final httpLink = HttpLink(baseUrlGql);

    final authLink = AuthLink(
      getToken: () async => "Bearer ${Auth.token.accessToken}",
    );

    var link = authLink.concat(httpLink);

    final websocketLink = WebSocketLink(
      baseUrlGqlws /*'ws://127.0.0.1:8101/graphql'*/,
      subProtocol: GraphQLProtocol.graphqlTransportWs,
      config: SocketClientConfig(
        initialPayload: () {
          var headers = <String, String>{};
          headers.putIfAbsent(
            HttpHeaders.authorizationHeader,
            () => "Bearer ${Auth.token.accessToken}",
          );
          return headers;
        },
      ),
    );

    // link = authLink.concat(httpLink);
    link = Link.split((request) => request.isSubscription, websocketLink, link);

    gqlClient = GraphQLClient(
      link: link,
      cache: GraphQLCache(store: InMemoryStore()),
      queryRequestTimeout: const Duration(seconds: 30),
      defaultPolicies: DefaultPolicies(
        query: Policies(
          cacheReread: CacheRereadPolicy.ignoreAll,
          fetch: FetchPolicy.noCache,
        ),
      ),
    );

    return ValueNotifier(gqlClient);
  }

  static Future<QueryResult> Query(
    String operationName,
    String query,
    Map<String, dynamic> variables,
  ) async {
    QueryOptions options = QueryOptions(
      document: gql(query),
      variables: variables,
      operationName: operationName,
    );

    final result = await gqlClient.query(options);

    return result;
  }

  static Future<QueryResult> Mutation(
    String query,
    Map<String, dynamic> variables,
  ) async {
    MutationOptions options = MutationOptions(
      document: gql(query),
      variables: variables,
      update: (cache, result) {
        // var queryRequest = Operation(
        //   document: gql('GqlQuery.todoQuery'),
        // ).asRequest();
        // final data = gqlClient.readQuery(queryRequest);
        // cache.writeQuery(queryRequest, data: {
        //   "__typename": "Query",
        //   "todos": [
        //     ...data?['todos'],
        //     result?.data?['createTodo'],
        //   ],
        // });
      },
    );

    final result = await gqlClient.mutate(options);

    //Print(result);

    return result;
  }

  static Future<DataState<dynamic>> QueryItems(
    String itemname,
    String query,
    Map<String, dynamic> variables,
    Function(Map<String, dynamic> json) fromJson,
  ) async {
    try {
      final QueryResult res = await ql.Query(itemname, query, variables);

      if (res.hasException) {
        {
          print(res);
        }
        return DataQqlException(res.exception!);
      }
      if (res.isLoading) {}

      List? list = res.data?[itemname];

      var value =
          list
              ?.map<dynamic>((dynamic i) => fromJson(i as Map<String, dynamic>))
              .toList();

      return DataSuccess(value);
    } catch (e) {
      return DataError(e.toString());
    }
  }

  static Future<DataState<dynamic>> QueryItem(
    String itemname,
    String query,
    Map<String, dynamic> variables,
    Function(Map<String, dynamic> json) fromJson,
  ) async {
    try {
      final QueryResult res = await ql.Query(itemname, query, variables);

      if (res.hasException) {
        {
          print(res);
        }
        return DataQqlException(res.exception!);
      }
      if (res.isLoading) {}

      Object? item = res.data?[itemname];
      var value = fromJson(item as Map<String, dynamic>);

      return DataSuccess(value);
    } catch (e) {
      return DataError(e.toString());
    }
  }

  static Future<DataState<dynamic>> MutationItem(
    String itemname,
    String query,
    Map<String, dynamic> variables,
    Function(Map<String, dynamic> json) fromJson,
  ) async {
    try {
      final QueryResult res = await ql.Mutation(query, variables);

      if (res.hasException) {
        {
          print(res);
        }
        return DataQqlException(res.exception!);
      }
      if (res.isLoading) {}

      Object? item = res.data?[itemname];
      var value = fromJson(item as Map<String, dynamic>);

      return DataSuccess(value);
    } catch (e) {
      return DataError(e.toString());
    }
  }
}

class qlT<T> {
  Future<DataState<T>> QueryItem(
    String itemname,
    String query,
    Map<String, dynamic> variables,
    Function(Map<String, dynamic> json) fromJson,
  ) async {
    try {
      final QueryResult res = await ql.Query(itemname, query, variables);

      if (res.hasException) {
        {
          print(res);
        }
        return DataQqlException(res.exception!);
      }
      if (res.isLoading) {}

      Object? item = res.data?[itemname];
      var value = fromJson(item as Map<String, dynamic>);

      return DataSuccess(value);
    } catch (e) {
      return DataError(e.toString());
    }
  }

  Future<DataState<List<T>>> QueryItems(
    String itemname,
    String query,
    Map<String, dynamic> variables,
    Function(Map<String, dynamic> json) fromJson,
  ) async {
    try {
      final QueryResult res = await ql.Query(itemname, query, variables);

      if (res.hasException) {
        {
          print(res);
        }
        return DataQqlException(res.exception!);
      }
      if (res.isLoading) {}

      List? list = res.data?[itemname];

      var value =
          list?.map<T>((i) => fromJson(i as Map<String, dynamic>)).toList();

      //value!.cast<T>();
      return DataSuccess(value!);
    } catch (e) {
      return DataError(e.toString());
    }
  }

  Future<DataState<T>> MutationItem(
    String itemname,
    String query,
    Map<String, dynamic> variables,
    Function(Map<String, dynamic> json) fromJson,
  ) async {
    try {
      final QueryResult res = await ql.Mutation(query, variables);

      if (res.hasException) {
        {
          print(res);
        }
        return DataQqlException(res.exception!);
      }
      if (res.isLoading) {}

      Object? item = res.data?[itemname];
      var value = fromJson(item as Map<String, dynamic>);

      return DataSuccess(value);
    } catch (e) {
      return DataError(e.toString());
    }
  }
}
