import 'package:ToGather/organizations/places/places.dart';
import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/utilities.dart';
import 'package:latlong2/latlong.dart';

class PlaceTestModelService extends ModelService<Place> {
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
  Future<Place?> getItem({required ItemParameters itemParameters}) async {
    await Future.delayed(Duration(milliseconds: 750));

    return Place(
        id: 1,
        title: "York",
        ratingCount: 12,
        locationDescription: "Bilkent G-132",
        links: [LinkData(url: "aaa", type: "whatsapp")],
        image: NetworkImageData(
            url:
                "https://media-cdn.tripadvisor.com/media/photo-s/1c/b2/9e/7c/bilkent-york-street-food.jpg"),
        location: LatLng(39.866379, 32.743474),
        banner: NetworkImageData(
            url:
                "https://media-cdn.tripadvisor.com/media/photo-s/1c/b2/9e/7c/bilkent-york-street-food.jpg"),
        verified: true,
        about: "Bilkent yakınında bir yer",
        tags: ["Sushi", "Bilkent"],
        posts: 28,
        events: 63,
        eventAttends: 356,
        category: (await ModelServiceFactory.CATEGORY
            .getItem(itemParameters: ItemParameters()))!,
        requestData: PlaceRequestData(
            allowedActions: PlaceAllowedActions(
                canUpdate: true,
                canDelete: true,
                canHide: true,
                canReport: true,
                canPost: true)),
        reviewAverage: 4.8);
  }

  @override
  Future<List<Place>?> getList({QueryParameters? queryParameters}) async {
    await Future.delayed(Duration(milliseconds: 750));

    return [
      Place(
          id: 1,
          title: "York",
          ratingCount: 12,
          locationDescription: "Bilkent G-132",
          links: [LinkData(url: "aaa", type: "whatsapp")],
          image: NetworkImageData(
              url:
                  "https://media-cdn.tripadvisor.com/media/photo-s/1c/b2/9e/7c/bilkent-york-street-food.jpg"),
          location: LatLng(39.827379, 32.747474),
          banner: NetworkImageData(
              url:
                  "https://media-cdn.tripadvisor.com/media/photo-s/1c/b2/9e/7c/bilkent-york-street-food.jpg"),
          verified: true,
          about: "Bilkent yakınında bir yer",
          tags: ["Sushi", "Bilkent"],
          posts: 28,
          events: 63,
          eventAttends: 356,
          category: (await ModelServiceFactory.CATEGORY
              .getItem(itemParameters: ItemParameters()))!,
          requestData: PlaceRequestData(
              allowedActions: PlaceAllowedActions(
                  canUpdate: true,
                  canDelete: true,
                  canHide: true,
                  canReport: true,
                  canPost: true)),
          reviewAverage: 4.8),
      Place(
          id: 2,
          title: "Burger",
          ratingCount: 12,
          locationDescription: "Bilkent G-132",
          links: [LinkData(url: "aaa", type: "whatsapp")],
          image: NetworkImageData(
              url:
                  "https://media-cdn.tripadvisor.com/media/photo-s/1c/b2/9e/7c/bilkent-york-street-food.jpg"),
          location: LatLng(39.866379, 32.745474),
          banner: NetworkImageData(
              url:
                  "https://media-cdn.tripadvisor.com/media/photo-s/1c/b2/9e/7c/bilkent-york-street-food.jpg"),
          verified: true,
          about: "Bilkent yakınında bir yer",
          tags: ["Sushi", "Bilkent"],
          posts: 28,
          events: 63,
          eventAttends: 356,
          category: (await ModelServiceFactory.CATEGORY
              .getItem(itemParameters: ItemParameters()))!,
          requestData: PlaceRequestData(
              allowedActions: PlaceAllowedActions(
                  canUpdate: true,
                  canDelete: true,
                  canHide: true,
                  canReport: true,
                  canPost: true)),
          reviewAverage: 4.8),
      Place(
          id: 3,
          title: "Sözer Döner",
          ratingCount: 12,
          locationDescription: "Bilkent G-132",
          links: [LinkData(url: "aaa", type: "whatsapp")],
          image: NetworkImageData(
              url:
                  "https://media-cdn.tripadvisor.com/media/photo-s/1c/b2/9e/7c/bilkent-york-street-food.jpg"),
          location: LatLng(39.867319, 32.747574),
          banner: NetworkImageData(
              url:
                  "https://media-cdn.tripadvisor.com/media/photo-s/1c/b2/9e/7c/bilkent-york-street-food.jpg"),
          verified: true,
          about: "Bilkent yakınında bir yer",
          tags: ["Sushi", "Bilkent"],
          posts: 28,
          events: 63,
          eventAttends: 356,
          category: (await ModelServiceFactory.CATEGORY
              .getItem(itemParameters: ItemParameters()))!,
          requestData: PlaceRequestData(
              allowedActions: PlaceAllowedActions(
                  canUpdate: true,
                  canDelete: true,
                  canHide: true,
                  canReport: true,
                  canPost: true)),
          reviewAverage: 4.8),
      Place(
          id: 4,
          title: "Sofa",
          ratingCount: 12,
          locationDescription: "Bilkent G-132",
          links: [LinkData(url: "aaa", type: "whatsapp")],
          image: NetworkImageData(
              url:
                  "https://media-cdn.tripadvisor.com/media/photo-s/1c/b2/9e/7c/bilkent-york-street-food.jpg"),
          location: LatLng(39.864379, 32.748874),
          banner: NetworkImageData(
              url:
                  "https://media-cdn.tripadvisor.com/media/photo-s/1c/b2/9e/7c/bilkent-york-street-food.jpg"),
          verified: true,
          about: "Bilkent yakınında bir yer",
          tags: ["Sushi", "Bilkent"],
          posts: 28,
          events: 63,
          eventAttends: 356,
          category: (await ModelServiceFactory.CATEGORY
              .getItem(itemParameters: ItemParameters()))!,
          requestData: PlaceRequestData(
              allowedActions: PlaceAllowedActions(
                  canUpdate: true,
                  canDelete: true,
                  canHide: true,
                  canReport: true,
                  canPost: true)),
          reviewAverage: 4.8),
      Place(
          id: 5,
          title: "York",
          ratingCount: 12,
          locationDescription: "Bilkent G-132",
          links: [LinkData(url: "aaa", type: "whatsapp")],
          image: NetworkImageData(
              url:
                  "https://media-cdn.tripadvisor.com/media/photo-s/1c/b2/9e/7c/bilkent-york-street-food.jpg"),
          location: LatLng(39.862379, 32.767474),
          banner: NetworkImageData(
              url:
                  "https://media-cdn.tripadvisor.com/media/photo-s/1c/b2/9e/7c/bilkent-york-street-food.jpg"),
          verified: true,
          about: "Bilkent yakınında bir yer",
          tags: ["Sushi", "Bilkent"],
          posts: 28,
          events: 63,
          eventAttends: 356,
          category: (await ModelServiceFactory.CATEGORY
              .getItem(itemParameters: ItemParameters()))!,
          requestData: PlaceRequestData(
              allowedActions: PlaceAllowedActions(
                  canUpdate: true,
                  canDelete: true,
                  canHide: true,
                  canReport: true,
                  canPost: true)),
          reviewAverage: 4.8)
    ];
  }

  @override
  Future<int?> getListCount({QueryParameters? queryParameters}) async {
    await Future.delayed(Duration(milliseconds: 750));

    return 5;
  }

  @override
  Future<Place?> updateItem(
      {required Place updatedItem,
      required ItemParameters itemParameters}) async {
    await Future.delayed(Duration(milliseconds: 750));

    return updatedItem;
  }

  @override
  Future<Place?> postItem({required Place item}) async {
    await Future.delayed(Duration(milliseconds: 750));

    return item;
  }
}
