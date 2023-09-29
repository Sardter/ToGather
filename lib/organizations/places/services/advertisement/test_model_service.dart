import 'package:ToGather/organizations/places/places.dart';
import 'package:ToGather/utilities/utilities.dart';

class PlaceAdvertisementTestModelService
    extends ModelService<PlaceAdvertisement> {
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
  Future<PlaceAdvertisement?> getItem(
      {required ItemParameters itemParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return PlaceAdvertisement(
        id: 1,
        description: "%50 indirim!",
        image: NetworkImageData(
            url:
                "https://img.restaurantguru.com/ra24-Bilkent-York-Street-Food-Company-design.jpg"));
  }

  @override
  Future<List<PlaceAdvertisement>?> getList(
      {QueryParameters? queryParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return [
      PlaceAdvertisement(
          id: 1,
          description: "Advertisement",
          image: NetworkImageData(
              url:
                  "https://img.restaurantguru.com/ra24-Bilkent-York-Street-Food-Company-design.jpg")),
      PlaceAdvertisement(
          id: 2,
          description: "Advertisement",
          image: NetworkImageData(
              url:
                  "https://img.restaurantguru.com/ra24-Bilkent-York-Street-Food-Company-design.jpg")),
      PlaceAdvertisement(
          id: 3,
          description: "Advertisement",
          image: NetworkImageData(
              url:
                  "https://img.restaurantguru.com/ra24-Bilkent-York-Street-Food-Company-design.jpg")),
      PlaceAdvertisement(
          id: 4,
          description: "Advertisement",
          image: NetworkImageData(
              url:
                  "https://img.restaurantguru.com/ra24-Bilkent-York-Street-Food-Company-design.jpg")),
      PlaceAdvertisement(
          id: 5,
          description: "Advertisement",
          image: NetworkImageData(
              url:
                  "https://img.restaurantguru.com/ra24-Bilkent-York-Street-Food-Company-design.jpg")),
    ];
  }

  @override
  Future<int?> getListCount({QueryParameters? queryParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return 5;
  }

  @override
  Future<PlaceAdvertisement?> updateItem(
      {required PlaceAdvertisement updatedItem,
      required ItemParameters itemParameters}) async {
    return updatedItem;
  }

  @override
  Future<PlaceAdvertisement?> postItem(
      {required PlaceAdvertisement item}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return item;
  }
}
