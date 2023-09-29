import 'package:ToGather/category/category.dart';
import 'package:ToGather/utilities/utilities.dart';

class TagTestModelService extends ModelService<Tag> {
  @override
  Future<bool> deleteItem({required ItemParameters itemParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return true;
  }

  @override
  Future<Tag?> getItem({required ItemParameters itemParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return Tag(id: 1, name: "aa");
  }

  @override
  Future<List<Tag>?> getList({QueryParameters? queryParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return [
      Tag(id: 1, name: "aa"),
      Tag(id: 2, name: "bb"),
      Tag(id: 3, name: "cc"),
      Tag(id: 4, name: "dd"),
      Tag(id: 5, name: "ee"),
      Tag(id: 6, name: "ff"),
      Tag(id: 7, name: "gg"),
    ];
  }

  @override
  Future<int?> getListCount({QueryParameters? queryParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return 7;
  }

  @override
  Future<Tag?> updateItem(
      {required Tag updatedItem,
      required ItemParameters itemParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return updatedItem;
  }

  @override
  Future<Tag?> postItem({required Tag item}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return item;
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
}
