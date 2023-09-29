import 'package:ToGather/category/category.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/users/models/models.dart';
import 'package:ToGather/utilities/utilities.dart';

class ClubTestModelService extends ClubModelService {
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
  Future<Club?> getItem({required ItemParameters itemParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return Club(
        id: 1,
        title: "Sylvest Club",
        ratingCount: 12,
        postPolicy: false,
        reviewAverage: 5,
        locationDescription: "Bilkent G-132",
        about: "Greatest club known in existence",
        verified: true,
        image: NetworkImageData(
            url:
                "https://media.licdn.com/dms/image/D4D0BAQHQ23kC-1m6XA/company-logo_200_200/0/1682842696823?e=1697068800&v=beta&t=LsI2gwABnDmVrXR7Kes44xrYXIew3Tl3i6Y6v36bbUI"),
        banner: NetworkImageData(
            url:
                "https://www.thisiscolossal.com/wp-content/uploads/2014/03/120430.gif"),
        category: Category(
            id: 1,
            title: "Üniversite Kulübü",
            image: NetworkImageData(
                url: "https://cdn-icons-png.flaticon.com/512/252/252025.png")),
        events: 63,
        links: [LinkData(url: "aaa", type: "whatsapp")],
        posts: 356,
        tags: ["sosyal", "kebab"],
        eventAttends: 231551,
        members: 10000000,
        requestData: ClubRequestData(
            allowedActions: ClubAllowedActions(
                canUpdate: false,
                canDelete: false,
                canHide: true,
                canReport: true,
                canJoin: true,
                canEdit: false,
                canModerate: false,
                canPost: false,
                canEvent: false),
            isJoined: true),
        location: null);
  }

  @override
  Future<List<Club>?> getList({QueryParameters? queryParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    canCallNext = true;
    hasNext = true;
    return [
      Club(
          id: 1,
          title: "Club 1",
          ratingCount: 12,
          postPolicy: false,
          verified: true,
          reviewAverage: 5,
          locationDescription: "Bilkent G-132",
          about: "Greatest club known in existence",
          links: [LinkData(url: "aaa", type: "whatsapp")],
          image: NetworkImageData(
              url:
                  "https://media.licdn.com/dms/image/D4D0BAQHQ23kC-1m6XA/company-logo_200_200/0/1682842696823?e=1697068800&v=beta&t=LsI2gwABnDmVrXR7Kes44xrYXIew3Tl3i6Y6v36bbUI"),
          banner: NetworkImageData(
              url:
                  "https://www.thisiscolossal.com/wp-content/uploads/2014/03/120430.gif"),
          category: Category(
              id: 1,
              title: "Üniversite Kulübü",
              image: NetworkImageData(
                  url:
                      "https://cdn-icons-png.flaticon.com/512/252/252025.png")),
          events: 63,
          posts: 356,
          tags: ["sosyal", "kebab"],
          members: 10000000,
          eventAttends: 231551,
          requestData: ClubRequestData(
              allowedActions: ClubAllowedActions(
                  canUpdate: false,
                  canDelete: false,
                  canHide: true,
                  canReport: true,
                  canJoin: true,
                  canEdit: false,
                  canModerate: false,
                  canPost: false,
                  canEvent: false),
              isJoined: true),
          location: null),
      Club(
          id: 2,
          title: "Club 2",
          ratingCount: 12,
          postPolicy: false,
          locationDescription: "Bilkent G-132",
          links: [LinkData(url: "aaa", type: "whatsapp")],
          category: Category(
              id: 1,
              title: "Üniversite Kulübü",
              image: NetworkImageData(
                  url:
                      "https://cdn-icons-png.flaticon.com/512/252/252025.png")),
          reviewAverage: 5,
          about: "Greatest club known in existence",
          verified: true,
          image: NetworkImageData(
              url:
                  "https://media.licdn.com/dms/image/D4D0BAQHQ23kC-1m6XA/company-logo_200_200/0/1682842696823?e=1697068800&v=beta&t=LsI2gwABnDmVrXR7Kes44xrYXIew3Tl3i6Y6v36bbUI"),
          banner: NetworkImageData(
              url:
                  "https://www.thisiscolossal.com/wp-content/uploads/2014/03/120430.gif"),
          events: 63,
          posts: 356,
          eventAttends: 231551,
          tags: ["sosyal", "kebab"],
          members: 10000000,
          requestData: ClubRequestData(
              allowedActions: ClubAllowedActions(
                  canUpdate: false,
                  canDelete: false,
                  canHide: true,
                  canReport: true,
                  canJoin: true,
                  canEdit: false,
                  canModerate: false,
                  canPost: false,
                  canEvent: false),
              isJoined: true),
          location: null),
      Club(
          id: 3,
          title: "Club 3",
          ratingCount: 12,
          postPolicy: false,
          about: "Greatest club known in existence",
          locationDescription: "Bilkent G-132",
          verified: true,
          links: [LinkData(url: "aaa", type: "whatsapp")],
          reviewAverage: 5,
          image: NetworkImageData(
              url:
                  "https://media.licdn.com/dms/image/D4D0BAQHQ23kC-1m6XA/company-logo_200_200/0/1682842696823?e=1697068800&v=beta&t=LsI2gwABnDmVrXR7Kes44xrYXIew3Tl3i6Y6v36bbUI"),
          banner: NetworkImageData(
              url:
                  "https://www.thisiscolossal.com/wp-content/uploads/2014/03/120430.gif"),
          category: Category(
              id: 1,
              title: "Üniversite Kulübü",
              image: NetworkImageData(
                  url:
                      "https://cdn-icons-png.flaticon.com/512/252/252025.png")),
          events: 63,
          posts: 356,
          tags: ["sosyal", "kebab"],
          members: 10000000,
          eventAttends: 231551,
          requestData: ClubRequestData(
              allowedActions: ClubAllowedActions(
                  canUpdate: false,
                  canDelete: false,
                  canHide: true,
                  canReport: true,
                  canJoin: true,
                  canEdit: false,
                  canModerate: false,
                  canPost: false,
                  canEvent: false),
              isJoined: true),
          location: null),
      Club(
          id: 4,
          title: "Club 4",
          ratingCount: 12,
          postPolicy: false,
          about: "Greatest club known in existence",
          locationDescription: "Bilkent G-132",
          verified: true,
          reviewAverage: 5,
          links: [LinkData(url: "aaa", type: "whatsapp")],
          image: NetworkImageData(
              url:
                  "https://media.licdn.com/dms/image/D4D0BAQHQ23kC-1m6XA/company-logo_200_200/0/1682842696823?e=1697068800&v=beta&t=LsI2gwABnDmVrXR7Kes44xrYXIew3Tl3i6Y6v36bbUI"),
          banner: NetworkImageData(
              url:
                  "https://www.thisiscolossal.com/wp-content/uploads/2014/03/120430.gif"),
          category: Category(
              id: 1,
              title: "Üniversite Kulübü",
              image: NetworkImageData(
                  url:
                      "https://cdn-icons-png.flaticon.com/512/252/252025.png")),
          events: 63,
          posts: 356,
          tags: ["sosyal", "kebab"],
          members: 10000000,
          eventAttends: 231551,
          requestData: ClubRequestData(
              allowedActions: ClubAllowedActions(
                  canUpdate: false,
                  canDelete: false,
                  canHide: true,
                  canReport: true,
                  canJoin: true,
                  canEdit: false,
                  canModerate: false,
                  canPost: false,
                  canEvent: false),
              isJoined: true),
          location: null),
      Club(
          id: 5,
          title: "Club 5",
          ratingCount: 12,
          postPolicy: false,
          about: "Greatest club known in existence",
          locationDescription: "Bilkent G-132",
          links: [LinkData(url: "aaa", type: "whatsapp")],
          image: NetworkImageData(
              url:
                  "https://media.licdn.com/dms/image/D4D0BAQHQ23kC-1m6XA/company-logo_200_200/0/1682842696823?e=1697068800&v=beta&t=LsI2gwABnDmVrXR7Kes44xrYXIew3Tl3i6Y6v36bbUI"),
          banner: NetworkImageData(
              url:
                  "https://www.thisiscolossal.com/wp-content/uploads/2014/03/120430.gif"),
          category: Category(
              id: 1,
              title: "Üniversite Kulübü",
              image: NetworkImageData(
                  url:
                      "https://cdn-icons-png.flaticon.com/512/252/252025.png")),
          events: 63,
          posts: 356,
          tags: ["sosyal", "kebab"],
          verified: true,
          reviewAverage: 5,
          members: 10000000,
          eventAttends: 231551,
          requestData: ClubRequestData(
              allowedActions: ClubAllowedActions(
                  canUpdate: false,
                  canDelete: false,
                  canHide: true,
                  canReport: true,
                  canJoin: true,
                  canEdit: false,
                  canModerate: false,
                  canPost: false,
                  canEvent: false),
              isJoined: true),
          location: null)
    ];
  }

  @override
  Future<int?> getListCount({QueryParameters? queryParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return 5;
  }

  @override
  Future<Club?> updateItem(
      {required Club updatedItem,
      required ItemParameters itemParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return updatedItem;
  }

  @override
  Future<Club?> postItem({required Club item}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return item;
  }

  @override
  Future<bool?> join({required ItemParameters itemParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return true;
  }
}
