import 'package:ToGather/sharables/models/models.dart';
import 'package:ToGather/sharables/services/comment/comment_model_service.dart';
import 'package:ToGather/utilities/utilities.dart';

class CommentTestModelService extends CommentModelService {
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
  Future<Comment?> getItem({required ItemParameters itemParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return Comment(
        relatedData: RelatedData(postId: 1, commentId: null),
        media: [],
        isAnonymous: true,
        content: "Mükemmel ve komik bir yorum",
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
        commentCount: 5,
        datePosted: DateTime.now(),
        ratingAverage: 4.8,
        author: PostAnonymousAuthor(),
        rateCount: 12);
  }

  @override
  Future<List<Comment>?> getList({QueryParameters? queryParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    canCallNext = true;
    hasNext = true;
    return [
      Comment(
          relatedData: RelatedData(postId: 1, commentId: null),
          media: [],
          isAnonymous: true,
          content: "Mükemmel ve komik bir yorum",
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
          commentCount: 5,
          datePosted: DateTime.now(),
          ratingAverage: 4.8,
          author: PostAnonymousAuthor(),
          rateCount: 12),
      Comment(
          relatedData: RelatedData(postId: 1, commentId: null),
          media: [],
          isAnonymous: true,
          content: "Mükemmel ve komik bir yorum",
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
          commentCount: 5,
          datePosted: DateTime.now(),
          ratingAverage: 4.8,
          author: PostAnonymousAuthor(),
          rateCount: 12),
      Comment(
          relatedData: RelatedData(postId: 1, commentId: null),
          media: [],
          isAnonymous: true,
          content: "Mükemmel ve komik bir yorum",
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
          commentCount: 5,
          datePosted: DateTime.now(),
          ratingAverage: 4.8,
          author: PostAnonymousAuthor(),
          rateCount: 12),
      Comment(
          relatedData: RelatedData(postId: 1, commentId: null),
          media: [],
          isAnonymous: true,
          content: "Mükemmel ve komik bir yorum",
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
          commentCount: 5,
          datePosted: DateTime.now(),
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
  Future<Comment?> updateItem(
      {required Comment updatedItem,
      required ItemParameters itemParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return updatedItem;
  }

  @override
  Future<Comment?> postItem({required Comment item}) async {
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
