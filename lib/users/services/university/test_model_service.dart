import 'package:ToGather/users/models/models.dart';
import 'package:ToGather/utilities/utilities.dart';

class UniversityTestModelService extends ModelService<University> {
  @override
  Future<bool> deleteItem({required ItemParameters itemParameters}) async {
    return true;
  }

  @override
  Future<University?> getItem({required ItemParameters itemParameters}) async {
    return University(schoolName: "Bilkent", id: 1, location: null, locationDescription: null);
  }

  @override
  Future<bool?> reportItem({required ItemParameters itemParameters, required String reason}) async {
    return true;
  }
  
  @override
  Future<bool?> hideItem({required ItemParameters itemParameters}) async {
    return true;
  }

  @override
  Future<List<University>?> getList({QueryParameters? queryParameters}) async {
    return [
      University(schoolName: "Bilkent", id: 1, location: null, locationDescription: null),
      University(schoolName: "ODTÜ", id: 2, location: null, locationDescription: null),
      University(schoolName: "Ankara", id: 3, location: null, locationDescription: null),
      University(schoolName: "Hacettepe", id: 4, location: null, locationDescription: null),
      University(schoolName: "Başkent", id: 5, location: null, locationDescription: null),
    ];
  }

  @override
  Future<int?> getListCount({QueryParameters? queryParameters}) async {
    return 5;
  }

  @override
  Future<University?> updateItem(
      {required University updatedItem,
      required ItemParameters itemParameters}) async {
    return updatedItem;
  }

  @override
  Future<University?> postItem({required University item}) async {
    return item;
  }
  
}