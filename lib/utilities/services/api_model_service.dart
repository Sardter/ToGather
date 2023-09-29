import 'package:flutter/widgets.dart';

import '../filters/filters.dart';
import '../models/models.dart';
import 'services.dart';

abstract class APIModelService<T extends Model> extends ModelService<T> {
  String get url;

  String get modelType;

  @protected
  final api = APIService();

  Future<Map<String, dynamic>?> _getAPIItem(
      {required ItemParameters itemParameters}) async {
    return await api.actionAndGetResponseItems(url: "$url$itemParameters");
  }

  Future<List<Map<String, dynamic>>?> _getAPIList(
      {QueryParameters? queryParameters}) async {
    final data = await api.actionAndGetResponseItems(
        context: null,
        url:
            "$url?${queryParameters == null ? '' : queryParameters}&page=$pageIndex");

    if (data == null) return null;

    this.canCallNext = true;
    this.hasNext = data['has_next'] ?? false;
    return data['results'] == null
        ? null
        : List<Map<String, dynamic>>.from(data['results']);
  }

  Future<int?> _getAPIListCount(
      {required QueryParameters? queryParameters}) async {
    final data = await api.actionAndGetResponseItems(
        context: null,
        url:
            "$url?${queryParameters == null ? '' : queryParameters}&page=$pageIndex");
    return data?['count'];
  }

  Future<bool?> _deleteAPIItem({required ItemParameters itemParameters}) async {
    return await api.actionAndGetResponseItems(
            url: "$url$itemParameters", action: APIAction.Delete) ==
        null;
  }

  Future<Map<String, dynamic>?> _updateAPIItem(
      {required Map<String, dynamic> updatedItem,
      required ItemParameters itemParameters}) async {
    return await api.actionAndGetResponseItems(
        context: null,
        url: "$url$itemParameters",
        action: APIAction.Put,
        body: updatedItem);
  }

  Future<Map<String, dynamic>?> _postAPIItem(
      {required Map<String, dynamic> item}) async {
    return await api.actionAndGetResponseItems(
        context: null, url: "$url", action: APIAction.Post, body: item);
  }

  Future<bool?> _hideItem({required ItemParameters itemParameters}) async {
    return await api.actionAndGetResponseItems(
        url: URLManager.hides,
        action: APIAction.Post,
        body: {'item_id': itemParameters.id, 'item_type': modelType});
  }

  Future<bool?> _reportItem(
      {required ItemParameters itemParameters, required String reason}) async {
    return await api.actionAndGetResponseItems(
        url: URLManager.hides,
        action: APIAction.Post,
        body: {
          'item_id': itemParameters.id,
          'item_type': modelType,
          'reason': reason
        });
  }

  Future<void> _uploadMeidaItem(
      UnUploadedMediaData item, FileMediaData file) async {
    await FileService.postFile(item.url, file.file, item.fields);
  }

  Future<void> _uploadMedia(
      {required List<UnUploadedMediaData> media,
      required List<FileMediaData> files}) async {
    await Future.wait(List.generate(
        media.length, (i) => _uploadMeidaItem(media[i], files[i])));
  }

  @override
  Future<T?> getItem({required ItemParameters itemParameters}) async {
    final item = await _getAPIItem(itemParameters: itemParameters);

    if (item == null) return null;

    return Model.fromJson(item, T) as T;
  }

  @override
  Future<List<T>?> getList({QueryParameters? queryParameters}) async {
    final items = await _getAPIList(queryParameters: queryParameters);

    return items?.map((item) => Model.fromJson(item, T) as T).toList();
  }

  @override
  Future<int?> getListCount({QueryParameters? queryParameters}) async {
    return await _getAPIListCount(queryParameters: queryParameters);
  }

  @override
  Future<bool> deleteItem({required ItemParameters itemParameters}) async {
    return await _deleteAPIItem(itemParameters: itemParameters) ?? false;
  }

  @override
  Future<T?> updateItem(
      {required T updatedItem, required ItemParameters itemParameters}) async {
    final item = await _updateAPIItem(
        updatedItem: updatedItem.toJson(), itemParameters: itemParameters);

    if (item?['updated'] == null) return null;

    onModelWithMedia(item!, updatedItem);

    return Model.fromJson(item['updated'], T) as T;
  }

  @protected
  Future<void> onModelWithMedia(Map<String, dynamic> uploaded, T item) async {
    if (item is ModelWithMedia) {
      final mediaToUpload =
          List<Map<String, dynamic>>.from(uploaded['media_upload'])
              .map((e) => UnUploadedMediaData.fromJson(e));

      final media = item.media
          .where((element) => element is FileMediaData)
          .cast<FileMediaData>();

      await _uploadMedia(media: mediaToUpload.toList(), files: media.toList());
    }
  }

  @override
  Future<T?> postItem({required T item}) async {
    final posted = await _postAPIItem(item: item.toJson());

    if (posted?['created'] == null) return null;

    onModelWithMedia(posted!, item);

    return Model.fromJson(posted['created'], T) as T;
  }

  @override
  Future<bool?> hideItem({required ItemParameters itemParameters}) {
    return _hideItem(itemParameters: itemParameters);
  }

  @override
  Future<bool?> reportItem(
      {required ItemParameters itemParameters, required String reason}) {
    return _reportItem(itemParameters: itemParameters, reason: reason);
  }
}
