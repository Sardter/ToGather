import 'package:ToGather/sharables/sharables.dart';
import 'package:ToGather/utilities/utilities.dart';
import 'package:latlong2/latlong.dart';

class PostTestModelService extends PostModelService {
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
  Future<Post?> getItem({required ItemParameters itemParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return Post(
        media: [],
        locationDescription: "Bilkent G-132",
        content: "@arda Mükemmel     ve komik bir post @sardter @nuti @tuna",
        isAnonymous: true,
        event: null,
        club: null,
        requestData: SharableRequestData(
            sharedByClubAdmin: false,
            allowedActions: SharableAllowedActions(
                canUpdate: true,
                canDelete: true,
                canComment: true,
                canRate: true,
                canHide: true,
                canReport: true),
            rateOfUser: null,
            isAuthor: false),
        id: 1,
        title: "WOW",
        commentCount: 5,
        isPrivate: false,
        tags: ["aa", "bb"],
        datePosted: DateTime.now(),
        location: null,
        ratingAverage: 4.8,
        author: PostAnonymousAuthor(),
        rateCount: 12);
  }

  @override
  Future<List<Post>?> getList({QueryParameters? queryParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return [
      Post(
          media: [],
          locationDescription: "Bilkent G-132",
          content: "Mükemmel ve komik bir post",
          isAnonymous: true,
          event: null,
          club: null,
          requestData: SharableRequestData(
              sharedByClubAdmin: false,
              allowedActions: SharableAllowedActions(
                  canUpdate: true,
                  canDelete: true,
                  canComment: true,
                  canRate: true,
                  canHide: true,
                  canReport: true),
              rateOfUser: null,
              isAuthor: false),
          id: 1,
          title: "Post 1",
          commentCount: 5,
          isPrivate: false,
          tags: ["aa", "bb"],
          location: LatLng(39.767379, 32.147474),
          datePosted: DateTime.now(),
          ratingAverage: 4.8,
          author: PostAnonymousAuthor(),
          rateCount: 12),
      Post(
          media: [],
          locationDescription: "Bilkent G-132",
          content: "Mükemmel ve komik bir post",
          isAnonymous: true,
          event: null,
          club: null,
          requestData: SharableRequestData(
              sharedByClubAdmin: false,
              allowedActions: SharableAllowedActions(
                  canUpdate: true,
                  canDelete: true,
                  canComment: true,
                  canRate: true,
                  canHide: true,
                  canReport: true),
              rateOfUser: null,
              isAuthor: false),
          id: 2,
          title: "Post 2",
          isPrivate: false,
          tags: ["aa", "bb"],
          commentCount: 5,
          location: LatLng(39.757379, 32.137474),
          datePosted: DateTime.now(),
          ratingAverage: 4.8,
          author: PostAnonymousAuthor(),
          rateCount: 12),
      Post(
          media: [],
          locationDescription: "Bilkent G-132",
          content: "Mükemmel ve komik bir post",
          isAnonymous: true,
          event: null,
          club: null,
          requestData: SharableRequestData(
              sharedByClubAdmin: false,
              allowedActions: SharableAllowedActions(
                  canUpdate: true,
                  canDelete: true,
                  canComment: true,
                  canRate: true,
                  canHide: true,
                  canReport: true),
              rateOfUser: null,
              isAuthor: false),
          id: 3,
          title: "Post 3",
          commentCount: 5,
          isPrivate: false,
          tags: ["aa", "bb"],
          datePosted: DateTime.now(),
          location: LatLng(39.762379, 32.147474),
          ratingAverage: 4.8,
          author: PostAnonymousAuthor(),
          rateCount: 12),
      Post(
          media: [],
          locationDescription: "Bilkent G-132",
          content: "Mükemmel ve komik bir post",
          isAnonymous: true,
          event: null,
          club: null,
          requestData: SharableRequestData(
              sharedByClubAdmin: false,
              allowedActions: SharableAllowedActions(
                  canUpdate: true,
                  canDelete: true,
                  canComment: true,
                  canRate: true,
                  canHide: true,
                  canReport: true),
              rateOfUser: null,
              isAuthor: false),
          id: 4,
          title: "Post 4",
          commentCount: 5,
          isPrivate: false,
          tags: ["aa", "bb"],
          datePosted: DateTime.now(),
          location: LatLng(39.767379, 32.247474),
          ratingAverage: 4.8,
          author: PostAnonymousAuthor(),
          rateCount: 12),
      Post(
          media: [],
          locationDescription: "Bilkent G-132",
          content: "Mükemmel ve komik bir post",
          isAnonymous: true,
          event: null,
          club: null,
          requestData: SharableRequestData(
              sharedByClubAdmin: false,
              allowedActions: SharableAllowedActions(
                  canUpdate: true,
                  canDelete: true,
                  canComment: true,
                  canRate: true,
                  canHide: true,
                  canReport: true),
              rateOfUser: null,
              isAuthor: false),
          id: 5,
          title: "Post 5",
          commentCount: 5,
          isPrivate: false,
          tags: ["aa", "bb"],
          datePosted: DateTime.now(),
          location: LatLng(39.767379, 32.167474),
          ratingAverage: 4.8,
          author: PostAnonymousAuthor(),
          rateCount: 12),
    ];
  }

  @override
  Future<int?> getListCount({QueryParameters? queryParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return 5;
  }

  @override
  Future<Post?> updateItem(
      {required Post updatedItem,
      required ItemParameters itemParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return updatedItem;
  }

  @override
  Future<Post?> postItem({required Post item}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return item;
  }

  @override
  Future<double?> rate(
      {required ItemParameters itemParameters, required double? score}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return score;
  }
}
