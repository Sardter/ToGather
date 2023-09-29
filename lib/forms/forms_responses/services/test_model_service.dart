import 'package:ToGather/forms/blocks/blocks.dart';
import 'package:ToGather/forms/forms_responses/form_responses.dart';
import 'package:ToGather/utilities/utilities.dart';

class FormResponseTestModelService extends ModelService<FormResponse> {
  @override
  Future<bool> deleteItem({required ItemParameters itemParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return true;
  }

  @override
  Future<bool?> reportItem(
      {required ItemParameters itemParameters, required String reason}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return true;
  }

  @override
  Future<bool?> hideItem({required ItemParameters itemParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return true;
  }

  @override
  Future<FormResponse?> getItem(
      {required ItemParameters itemParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return FormResponse(
        id: 1,
        author: (await ModelServiceFactory.PROFILE
            .getItem(itemParameters: ItemParameters()))!,
        event: (await ModelServiceFactory.EVENT
            .getItem(itemParameters: ItemParameters()))!,
        date: DateTime.now(),
        allowedActions: AllowedActions(
            canUpdate: true, canDelete: true, canHide: true, canReport: true),
        data: [
          {
            'question': 'sss',
            'required': false,
            'type': 'short',
            'data': {'text': null}
          },
          {
            'question': 'asdasd',
            'required': true,
            'type': 'long',
            'data': {'text': null}
          }
        ].map((e) => FormBlockData.fromJson(e)).toList());
  }

  @override
  Future<List<FormResponse>?> getList(
      {QueryParameters? queryParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return [
      (await getItem(itemParameters: ItemParameters()))!,
      (await getItem(itemParameters: ItemParameters()))!,
      (await getItem(itemParameters: ItemParameters()))!,
      (await getItem(itemParameters: ItemParameters()))!,
      (await getItem(itemParameters: ItemParameters()))!,
    ];
  }

  @override
  Future<int?> getListCount({QueryParameters? queryParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return 5;
  }

  @override
  Future<FormResponse?> updateItem(
      {required FormResponse updatedItem,
      required ItemParameters itemParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return updatedItem;
  }

  @override
  Future<FormResponse?> postItem({required FormResponse item}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return item;
  }
}
