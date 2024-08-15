import 'dart:async';

import 'package:built_value/serializer.dart';
import 'package:chopper/chopper.dart';
import 'package:movie_flutter/common/log.dart';

/// src https://resocoder.com/2019/07/14/chopper-retrofit-for-flutter-3-converters-built-value-integration/
class BuiltValueConverter extends JsonConverter {
  const BuiltValueConverter(this.serializers);

  final Serializers serializers;

  @override
  Request convertRequest(Request request) {
    // We need to access this property that comes from chopper
    // ignore: avoid_dynamic_calls
    final type = request.body.runtimeType;

    if (request.body is Map) {
      return super.convertRequest(request);
    }

    final serializer = serializers.serializerForType(type);

    if (serializer == null) {
      throw Exception(
              'No serializer for request exists for type $type for ${request.body}',
              );
    }

    final body = serializers.serializeWith(serializer, request.body);

    return super.convertRequest(request.copyWith(body: body));
  }

  @override
  FutureOr<Response<BodyType>> convertResponse<BodyType, SingleItemType>(
  Response<dynamic> response,
  ) async {
    final dynamicResponse =
    await super.convertResponse<dynamic, dynamic>(response);

    final customBody =
    _convertToCustomObject<SingleItemType>(dynamicResponse.body)
            as BodyType?;

    return dynamicResponse.copyWith<BodyType>(body: customBody);
  }

  dynamic _convertToCustomObject<SingleItemType>(dynamic element) {
    if (element is SingleItemType) return element;

    if (element is List) {
      return _deserializeListOf<SingleItemType>(element);
    } else if (element is Map<String, dynamic>?) {
      return _deserialize<SingleItemType>(element);
    } else {
      log.e('Unknown response body type: $element');

      return null;
    }
  }

  List<SingleItemType> _deserializeListOf<SingleItemType>(
  List<dynamic> dynamicList,
  ) {
    // Make a BuiltList holding individual custom objects
    final iterables = dynamicList.map((element) {
    if (element is SingleItemType) {
      return element;
    } else {
      return _deserialize<SingleItemType>(element as Map<String, dynamic>);
    }
    });

    return List<SingleItemType>.from(iterables);
  }

  SingleItemType? _deserialize<SingleItemType>(
  Map<String, dynamic>? value,
          ) {
    final serializer = serializers.serializerForType(SingleItemType);

    if (serializer == null) {
      throw Exception(
              'No serializer exists for response for type $SingleItemType for $value',
              );
    }

    return serializers.deserializeWith<SingleItemType?>(
            serializer as Serializer<SingleItemType?>, value);
  }
}
