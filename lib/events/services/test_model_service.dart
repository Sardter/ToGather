import 'package:ToGather/category/category.dart';
import 'package:ToGather/events/events.dart';
import 'package:ToGather/forms/forms_responses/form_responses.dart';
import 'package:ToGather/users/models/models.dart';
import 'package:ToGather/utilities/utilities.dart';
import 'package:latlong2/latlong.dart';

class EventTestModelService extends EventModelService {
  @override
  Future<bool> deleteItem({required ItemParameters itemParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return true;
  }

  @override
  Future<Event?> getItem({required ItemParameters itemParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return Event(
        id: 1,
        isOnline: false,
        isPrivate: false,
        ratingCount: 12,
        locationDescription: "Bilkent G-132",
        links: [
          LinkData(
              url: "https://www.whatsapp.com",
              type:
                  "https://png.pngtree.com/png-clipart/20190517/original/pngtree-whatsapp-social-media-icon-design-template-vector-png-image_3654884.jpg")
        ],
        location: LatLng(39.868379, 32.748474),
        media: [
          NetworkImageData(
              url:
                  "https://media.tenor.com/mqzuK_iOjzYAAAAC/leonardo-dicaprio-cheers.gif"),
          NetworkImageData(
              url:
                  "https://media.tenor.com/mqzuK_iOjzYAAAAC/leonardo-dicaprio-cheers.gif"),
          NetworkImageData(
              url:
                  "https://media.tenor.com/mqzuK_iOjzYAAAAC/leonardo-dicaprio-cheers.gif"),
          NetworkImageData(
              url:
                  "https://media.tenor.com/mqzuK_iOjzYAAAAC/leonardo-dicaprio-cheers.gif"),
          NetworkImageData(
              url:
                  "https://media.tenor.com/mqzuK_iOjzYAAAAC/leonardo-dicaprio-cheers.gif"),
          NetworkImageData(
              url:
                  "https://media.tenor.com/mqzuK_iOjzYAAAAC/leonardo-dicaprio-cheers.gif"),
        ],
        host: EventClubHost.fromClub((await ModelServiceFactory.CLUB
            .getItem(itemParameters: ItemParameters()))!),
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse imperdiet libero eu aliquet condimentum. Mauris et mauris non velit efficitur ultrices ut eu mi. Nullam at purus laoreet, condimentum dolor ac, accumsan lacus. Vestibulum fringilla ultricies faucibus. Fusce porttitor diam dolor, vel consequat tellus efficitur ut. Maecenas tempor arcu a lobortis mattis. Duis congue sollicitudin quam vel dapibus. \n"
            "In sem neque, tristique eget odio eget, sollicitudin vulputate lectus. Vivamus quis urna sed urna efficitur sodales. Nam imperdiet elit nec aliquet sollicitudin. Fusce ultrices nisi elementum neque placerat, eget fermentum dui auctor. Pellentesque vestibulum dictum accumsan. Aliquam luctus nisi lacus, quis varius mauris tempus vitae. Morbi porta vestibulum imperdiet. \n"
            "Nulla facilisi. Nam sed gravida mi. Vestibulum tellus orci, lobortis id sem at, elementum lacinia est. Duis mi urna, ornare quis pretium quis, bibendum eget est. Vivamus at aliquam libero, sit amet egestas arcu. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Donec ac metus nibh. Sed ultrices, enim id consectetur laoreet, ipsum nisi sodales mi, eu ultrices tellus dui sit amet diam. \n"
            "Nunc malesuada ultricies pellentesque. Proin imperdiet dignissim ultricies. Nam vel enim ut mi accumsan cursus. Donec elit ante, feugiat eget blandit ut, aliquet sit amet lorem. Quisque vestibulum commodo vehicula. Sed hendrerit sapien tincidunt libero ultricies dignissim. Aliquam hendrerit, lacus in ullamcorper viverra, ipsum quam semper dolor, ut suscipit nisi ipsum vel felis. Integer id nunc turpis. \n",
        requestData: EventRequestData(
            isAttending: false,
            isHosting: true,
            userRate: 5,
            allowedActions: EventAllowedActions(
                canUpdate: false,
                canDelete: false,
                canForm: true,
                canRate: true,
                canAttend: true,
                canHide: true,
                canPost: false,
                canReport: true)),
        tags: ["party", "gatsby"],
        reviewsAverage: 4.8,
        startDate: DateTime.now().add(Duration(days: 1)),
        formData: null,
        attendees: 318,
        title: "Great Gatsby Party",
        endDate: DateTime.now().add(Duration(days: 5)),
        category: Category(
            id: 1,
            title: "Party",
            image: NetworkImageData(
                url:
                    "https://cdn-icons-png.flaticon.com/512/7626/7626666.png")),
        verified: true);
  }

  @override
  Future<List<Event>?> getList({QueryParameters? queryParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    canCallNext = true;
    hasNext = true;
    return [
      Event(
          id: 1,
          isOnline: false,
          isPrivate: false,
          ratingCount: 12,
          locationDescription: "Bilkent G-132",
          links: [
            LinkData(
                url: "https://www.whatsapp.com",
                type:
                    "https://png.pngtree.com/png-clipart/20190517/original/pngtree-whatsapp-social-media-icon-design-template-vector-png-image_3654884.jpg")
          ],
          location: LatLng(39.863379, 32.748474),
          description:
              "Merhaba arkadaşlar! Üniversite Eğlence Kulübü olarak kampüsün en eğlenceli etkinliğine, 'Rastgele Karaoke Gecesi' ne sizleri davet ediyoruz! 🎤🎶 Müzik, dans ve tabii ki karaoke! Mikrofonu kapıp sahneye çıkmak için cesareti olan varsa, hadi gelin! Eğlenceye doyamayacaksınız. Biz snacks ve içeceklerle hazırız, siz sadece kendinizi getirin! Kütüphane bahçesinde, bu Cuma, saat 19.00'da görüşmek üzere! 🎉🎤📚",
          media: [
            NetworkImageData(
                url:
                    "https://media.tenor.com/mqzuK_iOjzYAAAAC/leonardo-dicaprio-cheers.gif")
          ],
          host: EventClubHost.fromClub((await ModelServiceFactory.CLUB
              .getItem(itemParameters: ItemParameters()))!),
          requestData: EventRequestData(
              userRate: 5,
              isAttending: false,
              isHosting: false,
              allowedActions: EventAllowedActions(
                  canUpdate: false,
                  canDelete: false,
                  canPost: false,
                  canRate: true,
                  canForm: true,
                  canAttend: true,
                  canHide: true,
                  canReport: true)),
          tags: ["party", "gatsby"],
          reviewsAverage: 4.8,
          startDate: DateTime.now().add(Duration(days: 1)),
          formData: null,
          attendees: 318,
          title: "Karaoke Gecesi",
          endDate: DateTime.now().add(Duration(days: 2)),
          category: Category(
              id: 1,
              title: "Party",
              image: NetworkImageData(
                  url:
                      "https://cdn-icons-png.flaticon.com/512/7626/7626666.png")),
          verified: true),
      Event(
          id: 2,
          isOnline: false,
          ratingCount: 12,
          isPrivate: false,
          locationDescription: "Bilkent G-132",
          links: [
            LinkData(
                url: "https://www.whatsapp.com",
                type:
                    "https://png.pngtree.com/png-clipart/20190517/original/pngtree-whatsapp-social-media-icon-design-template-vector-png-image_3654884.jpg")
          ],
          location: LatLng(39.867, 32.748474),
          media: [],
          description:
              "Üniversite kulübümüz 'TeknoGeeks' olarak sizi, bu Cuma akşamı düzenleyeceğimiz 'Geceyi Kodlayarak Geçir' etkinliğimize davet ediyoruz! Kodun, kahvenin ve eğlencenin mükemmel bir karışımını yaşayın. Siz gelin, biz de eğlenceli projeler, yarışmalar ve hediye kartlarıyla hazır olalım! Unutmayın, her seviyeden katılımcıya uygun olacak şekilde hazırlıklıyız. Görüşmek üzere! 🎉💻🚀",
          host: EventClubHost.fromClub((await ModelServiceFactory.CLUB
              .getItem(itemParameters: ItemParameters()))!),
          requestData: EventRequestData(
              userRate: 5,
              isAttending: false,
              isHosting: true,
              allowedActions: EventAllowedActions(
                  canUpdate: false,
                  canDelete: false,
                  canAttend: true,
                  canRate: true,
                  canPost: false,
                  canForm: true,
                  canHide: true,
                  canReport: true)),
          tags: ["party", "gatsby"],
          reviewsAverage: 4.8,
          startDate: DateTime.now().add(Duration(days: 1)),
          formData: null,
          attendees: 318,
          title: "CodeNight",
          endDate: DateTime.now().add(Duration(days: 2)),
          category: Category(
              id: 1,
              title: "Party",
              image: NetworkImageData(
                  url:
                      "https://cdn-icons-png.flaticon.com/512/7626/7626666.png")),
          verified: true),
      Event(
          id: 3,
          isOnline: false,
          ratingCount: 12,
          isPrivate: false,
          locationDescription: "Bilkent G-132",
          links: [
            LinkData(
                url: "https://www.whatsapp.com",
                type:
                    "https://png.pngtree.com/png-clipart/20190517/original/pngtree-whatsapp-social-media-icon-design-template-vector-png-image_3654884.jpg")
          ],
          location: LatLng(39.868379, 32.747474),
          media: [],
          description: "Event Description",
          host: EventClubHost.fromClub((await ModelServiceFactory.CLUB
              .getItem(itemParameters: ItemParameters()))!),
          requestData: EventRequestData(
              userRate: 5,
              isAttending: false,
              isHosting: true,
              allowedActions: EventAllowedActions(
                  canUpdate: false,
                  canDelete: false,
                  canAttend: true,
                  canPost: false,
                  canForm: true,
                  canRate: true,
                  canHide: true,
                  canReport: true)),
          tags: ["party", "gatsby"],
          reviewsAverage: 4.8,
          startDate: DateTime.now().add(Duration(days: 1)),
          formData: null,
          attendees: 318,
          title: "Yaratıcı Eller:",
          endDate: DateTime.now().add(Duration(days: 2)),
          category: Category(
              id: 1,
              title: "Party",
              image: NetworkImageData(
                  url:
                      "https://cdn-icons-png.flaticon.com/512/7626/7626666.png")),
          verified: true),
      Event(
          id: 4,
          isOnline: false,
          ratingCount: 12,
          isPrivate: false,
          locationDescription: "Bilkent G-132",
          links: [
            LinkData(
                url: "https://www.whatsapp.com",
                type:
                    "https://png.pngtree.com/png-clipart/20190517/original/pngtree-whatsapp-social-media-icon-design-template-vector-png-image_3654884.jpg")
          ],
          location: LatLng(39.868979, 32.748674),
          media: [],
          description: "Event Description",
          host: EventClubHost.fromClub((await ModelServiceFactory.CLUB
              .getItem(itemParameters: ItemParameters()))!),
          requestData: EventRequestData(
              userRate: 5,
              isAttending: false,
              isHosting: true,
              allowedActions: EventAllowedActions(
                  canUpdate: false,
                  canDelete: false,
                  canAttend: true,
                  canPost: false,
                  canForm: true,
                  canRate: true,
                  canHide: true,
                  canReport: true)),
          tags: ["party", "gatsby"],
          reviewsAverage: 4.8,
          startDate: DateTime.now().add(Duration(days: 1)),
          formData: null,
          attendees: 318,
          title: "Kariyer Yolculuğu",
          endDate: DateTime.now().add(Duration(days: 2)),
          category: Category(
              id: 1,
              title: "Party",
              image: NetworkImageData(
                  url:
                      "https://cdn-icons-png.flaticon.com/512/7626/7626666.png")),
          verified: true),
      Event(
          id: 5,
          isOnline: false,
          ratingCount: 12,
          isPrivate: false,
          locationDescription: "Bilkent G-132",
          links: [
            LinkData(
                url: "https://www.whatsapp.com",
                type:
                    "https://png.pngtree.com/png-clipart/20190517/original/pngtree-whatsapp-social-media-icon-design-template-vector-png-image_3654884.jpg")
          ],
          location: LatLng(39.868379, 32.748474),
          media: [],
          description: "Event Description",
          host: EventClubHost.fromClub((await ModelServiceFactory.CLUB
              .getItem(itemParameters: ItemParameters()))!),
          requestData: EventRequestData(
              userRate: 5,
              isAttending: false,
              isHosting: true,
              allowedActions: EventAllowedActions(
                  canUpdate: false,
                  canDelete: false,
                  canAttend: true,
                  canPost: false,
                  canRate: true,
                  canForm: true,
                  canHide: true,
                  canReport: true)),
          tags: ["party", "gatsby"],
          reviewsAverage: 4.8,
          startDate: DateTime.now().add(Duration(days: 1)),
          formData: null,
          attendees: 318,
          title: "Sinema Altında Yıldızlar",
          endDate: DateTime.now().add(Duration(days: 2)),
          category: Category(
              id: 1,
              title: "Party",
              image: NetworkImageData(
                  url:
                      "https://cdn-icons-png.flaticon.com/512/7626/7626666.png")),
          verified: true),
    ];
  }

  @override
  Future<Event?> updateItem(
      {required Event updatedItem,
      required ItemParameters itemParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return updatedItem;
  }

  @override
  Future<Event?> postItem({required Event item}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return item;
  }

  @override
  Future<int?> getListCount({QueryParameters? queryParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return 5;
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
  Future<bool?> attend(
      {required ItemParameters itemParameters,
      required FormResponse? formResponse}) async {
    return true;
  }

  @override
  Future<String?> getQRData({required ItemParameters itemParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return "qr data";
  }

  @override
  Future<double?> rate(
      {required ItemParameters itemParameters, required double? score}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return score;
  }

  @override
  Future<bool?> verifyAttendeeStatus(
      {required ItemParameters eventParameters,
      required ItemParameters userParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return true;
  }
}
