import 'package:ToGather/category/category.dart';
import 'package:ToGather/utilities/utilities.dart';

class CategoryTestModelService extends ModelService<Category> {
  @override
  Future<bool> deleteItem({required ItemParameters itemParameters}) async {
    return true;
  }

  @override
  Future<Category?> getItem({required ItemParameters itemParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return Category(
        id: 1,
        title: "Category",
        image: NetworkImageData(
            url: "https://cdn-icons-png.flaticon.com/512/252/252025.png"));
  }

  @override
  Future<List<Category>?> getList({QueryParameters? queryParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));

    return [
      Category(
          id: 1,
          title: "Parti",
          image: NetworkImageData(
              url: "https://cdn-icons-png.flaticon.com/512/7626/7626666.png")),
      Category(
          id: 2,
          title: "Üniversite",
          image: NetworkImageData(
              url: "https://cdn-icons-png.flaticon.com/512/2201/2201570.png")),
      Category(
          id: 3,
          title: "Konser",
          image: NetworkImageData(
              url: "https://cdn-icons-png.flaticon.com/512/1776/1776598.png")),
      Category(
          id: 4,
          title: "Film Gösterimi",
          image: NetworkImageData(
              url: "https://cdn-icons-png.flaticon.com/512/3658/3658959.png")),
      Category(
          id: 5,
          title: "Category 5",
          image: NetworkImageData(
              url: "https://cdn-icons-png.flaticon.com/512/252/252025.png")),
      Category(
          id: 6,
          title: "Category 6",
          image: NetworkImageData(
              url: "https://cdn-icons-png.flaticon.com/512/252/252025.png")),
      Category(
          id: 7,
          title: "Category 7",
          image: NetworkImageData(
              url: "https://cdn-icons-png.flaticon.com/512/252/252025.png")),
    ];
  }

  @override
  Future<int?> getListCount({QueryParameters? queryParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return 7;
  }

  @override
  Future<Category?> updateItem(
      {required Category updatedItem,
      required ItemParameters itemParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return updatedItem;
  }

  @override
  Future<Category?> postItem({required Category item}) async {
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
