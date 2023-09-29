class LanguageService {
  static final LanguageService _api = LanguageService._internal();
  factory LanguageService() {
    return _api;
  }
  LanguageService._internal();

  LanguageData? _data;

  LanguageData get data => _data!;

  Future<void> initializeData() async {
    //print(URLManager.languagesRoot);
    //final response = await http.get(Uri.parse(URLManager.languagesRoot));
    //final js = json.decode(utf8.decode(response.bodyBytes));

    final js = {
      "appTitle": "sylvest",
      "siteLink": "http://165.232.79.247:8000/",
      "navigationItems": {
        "home": "Anasayfa",
        "discover": "Keşfet",
        "next": "İleri",
        "prev": "Geri",
        "done": "Bitir",
        "notifications": "Bildirmler",
        "profile": "Profil"
      },
      "titles": {
        "posts": "Gönderiler",
        "activities": "Aktiviteler",
        "clubs": "Topluluklar",
        "events": "Etkinlikler",
        "subCommunities": "Alt-Topluluklar",
        "profiles": "Profiller",
        "reviews": "Değerlendirmeler",
        "locations": "Mekanlar",
        "attendees": "Katılanlar",
        "responses": "Cevaplar",
        "connections": "Bağlantılar",
        "post": "Gönderi",
        "event": "Etkinlik",
        "subClub": "Alt-Klüp",
        "activity": "Aktivite",
        "review": "Değerlendirme"
      },
      "pages": {
        "eventBuilderTitle": "Etkinlik Düzenleyici",
        "activityBuilderTitle": "Aktivite Düzenleyici",
        "clubBuilderTitle": "Klüp Düzenleyici",
        "postBuilderTitle": "Gönderi Düzenleyici",
        "profileBuilderTitle": "Profil Düzenleyici",
        "commentBuilderTitle": "Yorum Düzenleyici",
        "authentication": "Kullanıcı Girişi",
        "formResponses": "Form Cevapları",
        "settings": "Ayarlar",
        "map": "Harita",
        "notifications": "Bildirimler",
        "profile": "Profil"
      },
      "dashboard": {
        "title": "Alanım",
        "attending": "Katılınan Etkinlikler",
        "joined": "Üyesi olunan Topluluklar",
        "starred": "Yıldızlanan Aktiviteler",
        "responses": "Form Cevaplarım"
      },
      "errors": {
        "notFound": "Bulunamadı",
        "passwordResetFailed": "Şifre değiştirme başarısız oldu",
        "emailEmpty": "Email adresi alanı boş kalamaz",
        "usernameEmpty": "Kullanıcı alanı ismi kalamaz",
        "passwrod1Empty": "Şifre alanı boş kalamaz",
        "password2Empty": "Şifre kontrol alanı boş kalamaz",
        "emailNotValid": "Email adresi geçerli değildir",
        "passNotValid": "Şifre 8 harften uzun olmak zorundadır",
        "pass1NotEQPass2": "Şifreler uyuşmuyor",
        "roleNotAdded": "Klüp Rolü eklenemedi",
        "roleNotUpdated": "Klüp Rolü güncellenemedi",
        "roleNotDeleted": "Klüp Rolü silinemedi",
        "fieldEmpty": "Alan boş bırakılamaz",
        "fieldMoreThan255": "Karakter sayısı 255 haneyi geçemez",
        "noOptionSelected": "Hiç bir seçenek seçilmedi",
        "formInvalid": "Form doğru doldurulmadı",
        "questionEmpty": "Soru boş bırakılamaz",
        "choicesEmpty": "Seçenekler boş olamaz",
        "checkBoxEmpty": "Kutucuk isimleri boş bırakılamaz",
        "emptyComment": "Yorum boş olamaz",
        "notificationSetup": "Bildrimleri kurarken bir sorun ile karşılaşıldı",
        "cannotAttend": "Bu etkinliğe katılamazsın",
        "loginNeccesary": "Önce giriş yapman lazım",
        "notConnected": "Sunuculara bağlanılamadı",
        "somethingWentWrong": "Bir şeyler ters gitti",
        "unableToLogin": "Giriş yapılamadı: şifre ve kullanıcı ismi uyuşmuyor",
        "verificationFailed": "Onaylanamadı",
        "passwordChangeFailed": "Şifre değiştirelmedi",
        "profileIncomplete": "Profilini tamamlaman lazım"
      },
      "alerts": {
        "sentPasswordReset":
            "Belirtilen email adresine şifre değiştrimek için mail gönderildi",
        "sentVerification":
            "Hesap başarı ile oluşturuldu. Giriş yapabilmek için mail adresinden hesabını doğrula",
        "roleAdded": "Klüp rolü eklendi",
        "roleUpdated": "Klüp rolü güncellendi",
        "roleDeleted": "Klüp rolü silindi",
        "loggedOut": "Çıkış yapıldı",
        "deleted": "Silindi",
        "published": "Paylaşıldı",
        "updated": "Güncellendi",
        "verificationSucceeded": "Onaylandı",
        "passwordChangeSucceeded": "Şifre değiştirildi"
      },
      "hints": {
        "createComment": "Fikirlerini paylaş",
        "emptyNotifications": "Bildirimlerin burada gözükecek",
        "paragraph": "Buraya bir şeyler yaz",
        "formPlaceholder": "Form burada gözükecek",
        "pickFromGallery": "Galeriden seç",
        "pickFromCamera": "Fotoğraf çek",
        "roleTitle": "Rolün ismi",
        "eventReview": "Etkinlik Değerlendirmesi"
      },
      "noItems": {
        "noPosts": "Daha hiç göderi yok",
        "noActivities": "Daha hiç aktivite yok",
        "noClubs": "Daha hiç klüp yok",
        "noUsers": "Kullanıcı yok",
        "noItems": "Bir şey yok"
      },
      "tutorialData": [
        {
          "title": "Sylvest",
          "body": "Etkinlik sosyal medyası",
          "image":
              "https://www.thisiscolossal.com/wp-content/uploads/2014/03/120430.gif"
        }
      ],
      "verificationMail": {
        "subject": "Hesap Onayı",
        "resetSubject": "Şifre Sıfırlama",
        "greeting": "Merhabalar, ",
        "intro":
            "Bu mesaj email hesabını doğrulamak için gönderildi. Eğer bu kişi sen değilsen, lütfen görmezden gel.",
        "verify": "Hesabını onaylamak için buraya tıkla: ",
        "verify2": "Eğer yukardıdaki düğme çalışmıyor ise bu linke tıkla. ",
        "thanks": "Teşekkürler,",
        "team": "Sylvest takımı"
      },
      "passwordResetMail": {
        "subject": "Hesap Onayı",
        "greeting": "Merhabalar, ",
        "intro":
            "Bu mesaj Sylvest hesabının şifresinini yenilemen için gönderildi. Eğer bu kişi sen değilsen, lütfen görmezden gel.",
        "detail": "Buradan yeni bir şifre oluştur: ",
        "thanks": "Teşekkürler,",
        "team": "Sylvest takımı"
      },
      "filter": {
        "recommended": "Önerilenler",
        "joinedClubs": "Katıldığın Topluluklar",
        "showEvents": "Etkinlik gönderileri"
      },
      "sharable": {
        "confirm": "Onayla",
        "update": "Güncelle",
        "delete": "Sil",
        "cancel": "Vazgeç",
        "deleteActivityConfirmation":
            "Bu aktiviteyi silmek istediğinden emin misin?",
        "deleteEventConfirmation":
            "Bu etkinliği silmek istediğinden emin misin?",
        "deletePostConfirmation":
            "Bu gönderiyi silmek istediğinden emin misin?",
        "deleteCommentConfirmation":
            "Bu yorumu silmek istediğinden emin misin?",
        "deleteClubConfirmation": "Bu klübü silmek istediğinden emin misin?",
        "deleteResponseConfirmation":
            "Bu form cevabını silmek istediğinden emin misin?",
        "deleteReviewConfirmation":
            "Bu etkinlik değerlendirmesini silmek istediğinden emin misin?",
        "latestEvent": "En yakındaki etkinlik",
        "showOnMap": "Harita üzerinde göster",
        "noResponse": "Cevap yok",
        "attend": "Katıl",
        "attending": "Katılıyorum",
        "date": "Tarih",
        "duration": "Süre",
        "likedBy": "Beğenenler",
        "qrTitle": "QR Kodu",
        "qrExplantation":
            "Etkinliğe katılan kullanıclara katıldıklarını onaylamak için okut"
      },
      "club": {
        "members": "Üyeler",
        "ban": "Klüpten At",
        "changeRole": "Rolünü değiştir",
        "profile": "Profilini incele",
        "roleDeleteConfirmation": "Bu rolü silmek istediğinden emin misin?",
        "join": "Üye ol",
        "joined": "Üyesiyim",
        "createNewClub": "Yeni klüp oluştur",
        "addNewRole": "Yeni rol ekle",
        "roles": {
          "randomNames": [
            "Şövalye",
            "Lord",
            "Ölümsüz",
            "Kurtadam",
            "Elit",
            "Efsane",
            "Bülbül",
            "Vekil",
            "Cerrah",
            "Sekreter",
            "Köle"
          ],
          "subs": "Alt-Topluluk",
          "fest": "Aktivite",
          "edit": "Düzenleme",
          "role": "Rol",
          "user": "Kullanıcı",
          "post": "Gönderi",
          "allRoles": "Bütün Roller"
        }
      },
      "authentication": {
        "username": "Kullanıcı Adı",
        "email": "Mail Adresi",
        "password": "Şifre",
        "password2": "Şifre Kontrolü",
        "haveAcount": "Zaten hesabın var mı?",
        "dontHaveAcount": "Hesabın yok mu?",
        "signIn": "Giriş Yap",
        "signUp": "Üye ol",
        "reset": "Şifreni Sıfırla",
        "forgotPassword": "Şifreni unuttun mu?"
      },
      "user": {
        "connected": "Bağlantım Var",
        "requestSent": "İstek Gönderildi",
        "requestRecieved": "İstek Alındı",
        "notConnected": "Bağlantı Kur",
        "diConnect": "Bağlantıyı Kopar",
        "edit": "Güncelle",
        "username": "Kullanıcı İsmi",
        "email": "Email Adresi",
        "logout": "Çıkış Yap",
        "gender": "Cinsiyet",
        "bio": "Hakında",
        "firstName": "İsim",
        "schoolName": "Üniversite ismi",
        "schoolDepartment": "Üniversite bölümü",
        "schoolStartDate": "Üniversite başlangıç tarihi",
        "birth": "Doğum Tarihi",
        "schoolId": "Öğrenci numarası",
        "lastName": "Soyisim",
        "invisableField": "Aşağıdaki alan diğer kullanıcılara gözükmez"
      },
      "builder": {
        "editableTitle": "Başlık",
        "editableDescription": "Hakkında",
        "addImagePrompt": "Resim Yükle",
        "addVideoPrompt": "Video Yükle",
        "addBannerPrompt": "Afiş Yükle",
        "publish": "Paylaş",
        "update": "Güncelle",
        "startDate": "Başlangıç Tarihi",
        "endDate": "Bitiş Tarihi",
        "location": "Mekan",
        "link": "Link",
        "form": "Form",
        "online": "Online",
        "tags": "Etiketler",
        "anonymous": "Anonim",
        "addTag": "Etiket Ekle",
        "paragraphBlock": "Paragraf",
        "imageBlock": "Resimler",
        "videoBlock": "Video",
        "formBlock": "Form",
        "linkBlock": "Link",
        "replyingTo": "Yanıt veriyor"
      },
      "builderVerifier": {
        "titleEmpty": "Başlık boş kalamaz",
        "descriptionEmpty": "Hakında boş kalamaz",
        "moreThanTenTags": "Ondan fazla etiket yüklenemez",
        "tag32CharLimit": "Tag büyüklüğü 32yi geçemez",
        "endDateNotChosen": "Bitiş tarihi seçilmedi",
        "startDateNotChosen": "Başlangıç tarihi seçilmedi",
        "endDateAfterStartDate":
            "Bitiş tarihi başlangıç tarihinden önce olamaz",
        "videoNotSelected": "Video seçilmedi",
        "imageNotSelected": "Resim seçilmedi",
        "paragraphEmpty": "Paragraf boş kalamaz",
        "formNotValid": "Form doğru yapılmadı",
        "linkNotValid": "Link doğru değil",
        "urlLoadFail": "Link yüklenemedi",
        "videoLongerThan5": "Video uzunluğu 5 dakikayı geçemez",
        "videoLargerThan50": "Video büyüklüğü 50mbyi geçemez",
        "moreThan10Image": "10 dan fazla resim yüklenemez",
        "postNotValid": "Post doğru yapılmadı",
        "oneImageBlock": "Birden fazla resim elementi desteklenmemektedir",
        "oneVideoBlock": "Birden fazla video elementi desteklenmemektedir",
        "formBlockMust":
            "Eğer form var ise postun içinde form elementi bulunmak zorundadır",
        "formMust":
            "Eğer postun içinde bir form elementi var ise form olmak zorundadır",
        "max10Blocks": "10dan fazla elementen desteklenmemektedir",
        "mediaMaxSize": "Maximum medya büyüklüğü aşıldı",
        "usernameEmpty": "Kullanıcı ismi boş bırakılamaz",
        "emailEmpty": "Email adresi boş bırakılamaz"
      },
      "form": {
        "short": "Kısa Cevap",
        "long": "Uzun Cevap",
        "file": "Dosya",
        "choice": "Çoktan Seçmeli",
        "checkbox": "Kutucuklar",
        "title": "Form",
        "emptyForm": "Boş Form",
        "question": "Soru",
        "submit": "Paylaş"
      },
      "discover": {
        "search": "Ara",
        "filter": "Filtrele",
        "filters": "Filtreler"
      },
      "notifications": {
        "levelUp": "Seviye Atladın",
        "requestsTitle": "Bağlantı İstekleri",
        "requestAccepted": "Onayla",
        "requestDeclined": "Reddet",
        "like": "gönderini beğendi",
        "comment": "gönderine yorum yaptı",
        "commentLike": "yorumunu beğendi",
        "commentComment": "yorumuna cevap verdi",
        "request": "bağlantı isteği gönderdi",
        "accept": "bağlantı isteğini kabul etti",
        "join": "klübüne katıldı",
        "attend": "etkinliğine katıldı",
        "star": "aktiviteni yıldızladı",
        "event": "tarihinde başlayacak olan yeni bir etkinlik düzenliyor",
        "activity": "klübünde oluşturuldu",
        "level": "ile level yeni seviyeye atlandı"
      }
    };

    _data = LanguageData.fromJson(js);
  }
}

class NavigationItems {
  final String home;
  final String discover;
  final String notifications;
  final String profile;

  final String next;
  final String prev;
  final String done;

  NavigationItems(
      {required this.home,
      required this.discover,
      required this.notifications,
      required this.profile,
      required this.done,
      required this.next,
      required this.prev});

  factory NavigationItems.fromJson(Map json) {
    return NavigationItems(
        home: json["home"],
        discover: json["discover"],
        next: json["next"],
        prev: json["prev"],
        done: json["done"],
        notifications: json["notifications"],
        profile: json["profile"]);
  }
}

class Titles {
  final String posts;
  final String activities;
  final String clubs;
  final String events;
  final String subCommunities;
  final String profiles;
  final String locations;
  final String attendees;
  final String responses;
  final String connections;
  final String reviews;

  final String post;
  final String activity;
  final String event;
  final String subClub;
  final String review;

  Titles(
      {required this.posts,
      required this.activities,
      required this.clubs,
      required this.events,
      required this.subCommunities,
      required this.profiles,
      required this.locations,
      required this.attendees,
      required this.responses,
      required this.reviews,
      required this.connections,
      required this.post,
      required this.activity,
      required this.event,
      required this.review,
      required this.subClub});

  factory Titles.fromJson(Map json) {
    return Titles(
        posts: json["posts"],
        activities: json["activities"],
        clubs: json["clubs"],
        events: json["events"],
        reviews: json["reviews"],
        subCommunities: json["subCommunities"],
        profiles: json["profiles"],
        locations: json["locations"],
        attendees: json["attendees"],
        responses: json["responses"],
        connections: json["connections"],
        post: json["post"],
        event: json["event"],
        subClub: json["subClub"],
        activity: json["activity"],
        review: json["review"]);
  }
}

class Errors {
  final String notFound;
  final String passwordResetFailed;

  final String emailEmpty;
  final String usernameEmpty;
  final String passwrod1Empty;
  final String password2Empty;

  final String emailNotValid;
  final String passNotValid;
  final String pass1NotEQPass2;

  final String roleNotAdded;
  final String roleNotUpdated;
  final String roleNotDeleted;

  final String fieldEmpty;
  final String fieldMoreThan255;
  final String noOptionSelected;
  final String formInvalid;
  final String questionEmpty;
  final String choicesEmpty;
  final String checkBoxEmpty;

  final String emptyComment;

  final String notificationSetup;

  final String cannotAttend;

  final String loginNeccesary;

  final String notConnected;
  final String somethingWentWrong;
  final String unableToLogin;

  final String profileIncomplete;

  Errors(
      {required this.notFound,
      required this.passwordResetFailed,
      required this.emailEmpty,
      required this.usernameEmpty,
      required this.passwrod1Empty,
      required this.password2Empty,
      required this.emailNotValid,
      required this.passNotValid,
      required this.pass1NotEQPass2,
      required this.roleNotAdded,
      required this.roleNotUpdated,
      required this.roleNotDeleted,
      required this.fieldEmpty,
      required this.fieldMoreThan255,
      required this.noOptionSelected,
      required this.profileIncomplete,
      required this.formInvalid,
      required this.questionEmpty,
      required this.choicesEmpty,
      required this.checkBoxEmpty,
      required this.emptyComment,
      required this.notificationSetup,
      required this.cannotAttend,
      required this.loginNeccesary,
      required this.notConnected,
      required this.somethingWentWrong,
      required this.unableToLogin});

  factory Errors.fromJson(Map json) {
    return Errors(
        notFound: json["notFound"],
        passwordResetFailed: json["passwordResetFailed"],
        emailEmpty: json["emailEmpty"],
        usernameEmpty: json["usernameEmpty"],
        passwrod1Empty: json["passwrod1Empty"],
        password2Empty: json["password2Empty"],
        emailNotValid: json["emailNotValid"],
        passNotValid: json["passNotValid"],
        pass1NotEQPass2: json["pass1NotEQPass2"],
        roleNotAdded: json["roleNotAdded"],
        roleNotUpdated: json["roleNotUpdated"],
        roleNotDeleted: json["roleNotDeleted"],
        fieldEmpty: json["fieldEmpty"],
        fieldMoreThan255: json["fieldMoreThan255"],
        noOptionSelected: json["noOptionSelected"],
        profileIncomplete: json["profileIncomplete"],
        formInvalid: json["formInvalid"],
        questionEmpty: json["questionEmpty"],
        choicesEmpty: json["choicesEmpty"],
        checkBoxEmpty: json["checkBoxEmpty"],
        emptyComment: json["emptyComment"],
        notificationSetup: json["notificationSetup"],
        cannotAttend: json["cannotAttend"],
        loginNeccesary: json["loginNeccesary"],
        notConnected: json["notConnected"],
        somethingWentWrong: json["somethingWentWrong"],
        unableToLogin: json["unableToLogin"]);
  }
}

class Alerts {
  final String sentPasswordReset;
  final String sentVerification;
  final String roleAdded;
  final String roleUpdated;
  final String roleDeleted;

  final String loggedOut;

  final String deleted;
  final String published;
  final String updated;

  Alerts(
      {required this.sentPasswordReset,
      required this.sentVerification,
      required this.roleAdded,
      required this.roleUpdated,
      required this.roleDeleted,
      required this.loggedOut,
      required this.deleted,
      required this.published,
      required this.updated});

  factory Alerts.fromJson(Map json) {
    return Alerts(
        sentPasswordReset: json["sentPasswordReset"],
        sentVerification: json["sentVerification"],
        roleAdded: json["roleAdded"],
        roleUpdated: json["roleUpdated"],
        roleDeleted: json["roleDeleted"],
        loggedOut: json["loggedOut"],
        deleted: json["deleted"],
        published: json["published"],
        updated: json["updated"]);
  }
}

class ClubRolesLanguage {
  final List<String> randomNames;
  final String subs;
  final String fest;
  final String edit;
  final String role;
  final String user;
  final String post;
  final String allRoles;

  const ClubRolesLanguage(
      {required this.randomNames,
      required this.subs,
      required this.fest,
      required this.edit,
      required this.allRoles,
      required this.role,
      required this.user,
      required this.post});

  factory ClubRolesLanguage.fromJson(Map json) {
    return ClubRolesLanguage(
        randomNames: List<String>.from(json['randomNames']),
        subs: json['subs'],
        fest: json['fest'],
        edit: json['edit'],
        allRoles: json['allRoles'],
        role: json['role'],
        user: json['user'],
        post: json['post']);
  }
}

class Hints {
  final String createComment;
  final String emptyNotifications;
  final String paragraph;
  final String formPlaceholder;

  final String pickFromGallery;
  final String pickFromCamera;

  final String roleTitle;
  final String eventReview;

  Hints(
      {required this.createComment,
      required this.emptyNotifications,
      required this.paragraph,
      required this.roleTitle,
      required this.eventReview,
      required this.formPlaceholder,
      required this.pickFromGallery,
      required this.pickFromCamera});

  factory Hints.fromJson(Map json) {
    return Hints(
        createComment: json["createComment"],
        emptyNotifications: json["emptyNotifications"],
        paragraph: json["paragraph"],
        roleTitle: json["roleTitle"],
        eventReview: json["eventReview"],
        formPlaceholder: json["formPlaceholder"],
        pickFromGallery: json["pickFromGallery"],
        pickFromCamera: json["pickFromCamera"]);
  }
}

class NotificationsLanguage {
  final String levelUp;

  final String requestsTitle;
  final String requestAccepted;
  final String requestDeclined;

  final String like;
  final String comment;
  final String commentLike;
  final String commentComment;
  final String request;
  final String accept;
  final String join;
  final String attend;
  final String star;
  final String event;
  final String activity;
  final String level;

  NotificationsLanguage(
      {required this.levelUp,
      required this.requestsTitle,
      required this.requestAccepted,
      required this.requestDeclined,
      required this.like,
      required this.comment,
      required this.commentLike,
      required this.commentComment,
      required this.request,
      required this.accept,
      required this.join,
      required this.attend,
      required this.star,
      required this.event,
      required this.activity,
      required this.level});

  factory NotificationsLanguage.fromJson(Map json) {
    return NotificationsLanguage(
        levelUp: json["levelUp"],
        requestsTitle: json["requestsTitle"],
        requestAccepted: json["requestAccepted"],
        requestDeclined: json["requestDeclined"],
        like: json["like"],
        comment: json["comment"],
        commentLike: json["commentLike"],
        commentComment: json["commentComment"],
        request: json["request"],
        accept: json["accept"],
        join: json["join"],
        attend: json["attend"],
        star: json["star"],
        event: json["event"],
        activity: json["activity"],
        level: json["level"]);
  }
}

class NoItems {
  final String noPosts;
  final String noActivities;
  final String noClubs;
  final String noUsers;
  final String noItems;

  NoItems(
      {required this.noPosts,
      required this.noActivities,
      required this.noClubs,
      required this.noUsers,
      required this.noItems});

  factory NoItems.fromJson(Map json) {
    return NoItems(
        noPosts: json["noPosts"],
        noActivities: json["noActivities"],
        noClubs: json["noClubs"],
        noUsers: json["noUsers"],
        noItems: json["noItems"]);
  }
}

class Dashboard {
  final String title;
  final String attending;
  final String joined;
  final String starred;
  final String responses;

  Dashboard(
      {required this.title,
      required this.attending,
      required this.joined,
      required this.starred,
      required this.responses});

  factory Dashboard.fromJson(Map json) {
    return Dashboard(
        title: json["title"],
        attending: json["attending"],
        joined: json["joined"],
        starred: json["starred"],
        responses: json["responses"]);
  }
}

class UserLanguage {
  final String connected;
  final String requestSent;
  final String requestRecieved;
  final String notConnected;
  final String unConnect;
  final String edit;
  final String logout;

  final String username;
  final String email;
  final String gender;
  final String bio;
  final String firstName;
  final String lastName;
  final String schoolName;
  final String schoolDepartment;
  final String schoolId;
  final String schoolStartDate;
  final String birth;

  final String invisableField;

  UserLanguage(
      {required this.connected,
      required this.requestSent,
      required this.requestRecieved,
      required this.notConnected,
      required this.edit,
      required this.logout,
      required this.unConnect,
      required this.username,
      required this.email,
      required this.gender,
      required this.bio,
      required this.birth,
      required this.schoolStartDate,
      required this.schoolDepartment,
      required this.schoolId,
      required this.schoolName,
      required this.firstName,
      required this.lastName,
      required this.invisableField});

  factory UserLanguage.fromJson(Map json) {
    return UserLanguage(
        connected: json["connected"],
        requestSent: json["requestSent"],
        requestRecieved: json["requestRecieved"],
        notConnected: json["notConnected"],
        edit: json["edit"],
        birth: json["birth"],
        schoolStartDate: json["schoolStartDate"],
        username: json["username"],
        email: json["email"],
        logout: json["logout"],
        schoolDepartment: json["schoolDepartment"],
        schoolId: json["schoolId"],
        schoolName: json["schoolName"],
        gender: json["gender"],
        unConnect: json["diConnect"],
        bio: json["bio"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        invisableField: json["invisableField"]);
  }
}

class FormLanguage {
  final String title;

  final String short;
  final String long;
  final String file;
  final String choice;
  final String checkbox;

  final String emptyForm;
  final String question;

  final String submit;

  FormLanguage(
      {required this.short,
      required this.long,
      required this.file,
      required this.choice,
      required this.checkbox,
      required this.title,
      required this.emptyForm,
      required this.question,
      required this.submit});

  factory FormLanguage.fromJson(Map json) {
    return FormLanguage(
        short: json["short"],
        long: json["long"],
        file: json["file"],
        choice: json["choice"],
        checkbox: json["checkbox"],
        title: json["title"],
        emptyForm: json["emptyForm"],
        question: json["question"],
        submit: json["submit"]);
  }
}

class AuthenticationLanguage {
  final String username;
  final String email;
  final String password;
  final String password2;

  final String haveAcount;
  final String dontHaveAcount;
  final String forgotPassword;

  final String signIn;
  final String signUp;
  final String reset;

  AuthenticationLanguage(
      {required this.username,
      required this.email,
      required this.password,
      required this.password2,
      required this.haveAcount,
      required this.dontHaveAcount,
      required this.signIn,
      required this.signUp,
      required this.reset,
      required this.forgotPassword});

  factory AuthenticationLanguage.fromJson(Map json) {
    return AuthenticationLanguage(
        username: json["username"],
        email: json["email"],
        password: json["password"],
        password2: json["password2"],
        haveAcount: json["haveAcount"],
        dontHaveAcount: json["dontHaveAcount"],
        signIn: json["signIn"],
        signUp: json["signUp"],
        reset: json["reset"],
        forgotPassword: json["forgotPassword"]);
  }
}

class ClubLanguage {
  final String members;
  final String ban;
  final String changeRole;
  final String profile;

  final String roleDeleteConfirmation;
  final String join;
  final String joined;

  final String createNewClub;
  final String addNewRole;

  final ClubRolesLanguage rolesLanguage;

  ClubLanguage(
      {required this.members,
      required this.ban,
      required this.changeRole,
      required this.profile,
      required this.addNewRole,
      required this.createNewClub,
      required this.rolesLanguage,
      required this.roleDeleteConfirmation,
      required this.join,
      required this.joined});

  factory ClubLanguage.fromJson(Map json) {
    return ClubLanguage(
        members: json["members"],
        ban: json["ban"],
        changeRole: json["changeRole"],
        rolesLanguage: ClubRolesLanguage.fromJson(json["roles"]),
        profile: json["profile"],
        createNewClub: json["createNewClub"],
        addNewRole: json["addNewRole"],
        roleDeleteConfirmation: json["roleDeleteConfirmation"],
        join: json["join"],
        joined: json["joined"]);
  }
}

class SharableLanguage {
  final String update;
  final String confirm;
  final String delete;
  final String cancel;

  final String deleteActivityConfirmation;
  final String deleteEventConfirmation;
  final String deletePostConfirmation;
  final String deleteCommentConfirmation;
  final String deleteClubConfirmation;
  final String deleteResponseConfirmation;
  final String deleteReviewConfirmation;

  final String latestEvent;

  final String showOnMap;

  final String noResponse;

  final String attend;
  final String attending;
  final String date;
  final String duration;

  final String likedBy;

  final String qrTitle;
  final String qrExplantation;

  SharableLanguage(
      {required this.confirm,
      required this.delete,
      required this.cancel,
      required this.deleteActivityConfirmation,
      required this.deleteEventConfirmation,
      required this.deletePostConfirmation,
      required this.deleteCommentConfirmation,
      required this.deleteClubConfirmation,
      required this.deleteResponseConfirmation,
      required this.deleteReviewConfirmation,
      required this.latestEvent,
      required this.update,
      required this.showOnMap,
      required this.noResponse,
      required this.attend,
      required this.attending,
      required this.qrTitle,
      required this.qrExplantation,
      required this.date,
      required this.duration,
      required this.likedBy});

  factory SharableLanguage.fromJson(Map json) {
    return SharableLanguage(
        confirm: json["confirm"],
        delete: json["delete"],
        cancel: json["cancel"],
        update: json["update"],
        deleteActivityConfirmation: json["deleteActivityConfirmation"],
        deleteEventConfirmation: json["deleteEventConfirmation"],
        deletePostConfirmation: json["deletePostConfirmation"],
        deleteCommentConfirmation: json["deleteCommentConfirmation"],
        deleteClubConfirmation: json["deleteClubConfirmation"],
        deleteResponseConfirmation: json["deleteResponseConfirmation"],
        deleteReviewConfirmation: json["deleteReviewConfirmation"],
        latestEvent: json["latestEvent"],
        showOnMap: json["showOnMap"],
        noResponse: json["noResponse"],
        attend: json["attend"],
        attending: json["attending"],
        qrExplantation: json["qrExplantation"],
        qrTitle: json["qrTitle"],
        date: json["date"],
        duration: json["duration"],
        likedBy: json["likedBy"]);
  }
}

class Pages {
  final String eventBuilderTitle;
  final String activityBuilderTitle;
  final String clubBuilderTitle;
  final String postBuilderTitle;
  final String profileBuilderTitle;
  final String commentBuilderTitle;

  final String authentication;
  final String formResponses;
  final String map;
  final String notifications;
  final String profile;
  final String settings;

  Pages(
      {required this.eventBuilderTitle,
      required this.activityBuilderTitle,
      required this.clubBuilderTitle,
      required this.postBuilderTitle,
      required this.profileBuilderTitle,
      required this.commentBuilderTitle,
      required this.authentication,
      required this.formResponses,
      required this.map,
      required this.settings,
      required this.notifications,
      required this.profile});

  factory Pages.fromJson(Map json) {
    return Pages(
        eventBuilderTitle: json["eventBuilderTitle"],
        activityBuilderTitle: json["activityBuilderTitle"],
        clubBuilderTitle: json["clubBuilderTitle"],
        postBuilderTitle: json["postBuilderTitle"],
        profileBuilderTitle: json["profileBuilderTitle"],
        commentBuilderTitle: json["commentBuilderTitle"],
        authentication: json["authentication"],
        formResponses: json["formResponses"],
        settings: json["settings"],
        map: json["map"],
        notifications: json["notifications"],
        profile: json["profile"]);
  }
}

class BuilderLanguage {
  final String editableTitle;
  final String editableDescription;
  final String addImagePrompt;
  final String addVideoPrompt;
  final String addBannerPrompt;
  final String publish;
  final String update;

  final String startDate;
  final String endDate;

  final String location;
  final String link;
  final String form;
  final String online;
  final String tags;
  final String addTag;
  final String anonymous;

  final String paragraphBlock;
  final String imageBlock;
  final String videoBlock;
  final String formBlock;
  final String linkBlock;

  final String replyingTo;

  BuilderLanguage(
      {required this.editableTitle,
      required this.editableDescription,
      required this.addImagePrompt,
      required this.addVideoPrompt,
      required this.addBannerPrompt,
      required this.publish,
      required this.update,
      required this.startDate,
      required this.endDate,
      required this.location,
      required this.paragraphBlock,
      required this.imageBlock,
      required this.videoBlock,
      required this.formBlock,
      required this.linkBlock,
      required this.replyingTo,
      required this.link,
      required this.form,
      required this.addTag,
      required this.online,
      required this.tags,
      required this.anonymous});

  factory BuilderLanguage.fromJson(Map json) {
    return BuilderLanguage(
        editableTitle: json["editableTitle"],
        editableDescription: json["editableDescription"],
        addImagePrompt: json["addImagePrompt"],
        addVideoPrompt: json["addVideoPrompt"],
        addBannerPrompt: json["addBannerPrompt"],
        publish: json["publish"],
        update: json["update"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        location: json["location"],
        link: json["link"],
        addTag: json["addTag"],
        form: json["form"],
        online: json["online"],
        tags: json["tags"],
        anonymous: json["anonymous"],
        paragraphBlock: json["paragraphBlock"],
        imageBlock: json["imageBlock"],
        videoBlock: json["videoBlock"],
        formBlock: json["formBlock"],
        linkBlock: json["linkBlock"],
        replyingTo: json["replyingTo"]);
  }
}

class BuilderVerifierLanguge {
  final String titleEmpty;
  final String descriptionEmpty;
  final String moreThanTenTags;
  final String tag32CharLimit;

  final String endDateNotChosen;
  final String startDateNotChosen;
  final String endDateAfterStartDate;

  final String videoNotSelected;
  final String imageNotSelected;
  final String paragraphEmpty;

  final String formNotValid;
  final String linkNotValid;
  final String urlLoadFail;
  final String videoLongerThan5;
  final String videoLargerThan50;
  final String moreThan10Image;

  final String postNotValid;
  final String oneImageBlock;
  final String oneVideoBlock;
  final String formBlockMust;
  final String formMust;
  final String max10Blocks;

  final String mediaMaxSize;

  final String usernameEmpty;
  final String emailEmpty;

  BuilderVerifierLanguge(
      {required this.titleEmpty,
      required this.descriptionEmpty,
      required this.moreThanTenTags,
      required this.tag32CharLimit,
      required this.endDateNotChosen,
      required this.startDateNotChosen,
      required this.endDateAfterStartDate,
      required this.videoNotSelected,
      required this.imageNotSelected,
      required this.paragraphEmpty,
      required this.formNotValid,
      required this.linkNotValid,
      required this.urlLoadFail,
      required this.videoLongerThan5,
      required this.videoLargerThan50,
      required this.moreThan10Image,
      required this.postNotValid,
      required this.oneImageBlock,
      required this.oneVideoBlock,
      required this.formBlockMust,
      required this.formMust,
      required this.max10Blocks,
      required this.mediaMaxSize,
      required this.usernameEmpty,
      required this.emailEmpty});

  factory BuilderVerifierLanguge.fromJson(Map json) {
    return BuilderVerifierLanguge(
        titleEmpty: json["titleEmpty"],
        descriptionEmpty: json["descriptionEmpty"],
        moreThanTenTags: json["moreThanTenTags"],
        tag32CharLimit: json["tag32CharLimit"],
        endDateNotChosen: json["endDateNotChosen"],
        startDateNotChosen: json["startDateNotChosen"],
        endDateAfterStartDate: json["endDateAfterStartDate"],
        videoNotSelected: json["videoNotSelected"],
        imageNotSelected: json["imageNotSelected"],
        paragraphEmpty: json["paragraphEmpty"],
        formNotValid: json["formNotValid"],
        linkNotValid: json["linkNotValid"],
        urlLoadFail: json["urlLoadFail"],
        videoLongerThan5: json["videoLongerThan5"],
        videoLargerThan50: json["videoLargerThan50"],
        moreThan10Image: json["moreThan10Image"],
        postNotValid: json["postNotValid"],
        oneImageBlock: json["oneImageBlock"],
        oneVideoBlock: json["oneVideoBlock"],
        formBlockMust: json["formBlockMust"],
        formMust: json["formMust"],
        max10Blocks: json["max10Blocks"],
        mediaMaxSize: json["mediaMaxSize"],
        usernameEmpty: json["usernameEmpty"],
        emailEmpty: json["emailEmpty"]);
  }
}

class DiscoverLanguage {
  final String search;
  final String filters;
  final String filter;

  DiscoverLanguage(
      {required this.search, required this.filter, required this.filters});

  factory DiscoverLanguage.fromJson(Map json) {
    return DiscoverLanguage(
        search: json["search"],
        filter: json['filter'],
        filters: json['filters']);
  }
}

class TutorialData {
  final String title;
  final String body;
  final String image;

  TutorialData({required this.title, required this.body, required this.image});

  factory TutorialData.fromJson(Map json) {
    return TutorialData(
        title: json['title'], body: json['body'], image: json['image']);
  }
}

class FilterLanguage {
  final String recommended;
  final String joinedClubs;
  final String showEvents;

  FilterLanguage(
      {required this.recommended,
      required this.joinedClubs,
      required this.showEvents});

  factory FilterLanguage.fromJson(Map json) {
    return FilterLanguage(
        recommended: json["recommended"],
        joinedClubs: json["joinedClubs"],
        showEvents: json["showEvents"]);
  }
}

class LanguageData {
  final String appTitle;
  final String siteLink;

  final NavigationItems navigationItems;
  final Titles titles;
  final Pages pages;
  final Dashboard dashboard;

  final Errors errors;
  final Alerts alerts;
  final Hints hints;
  final NoItems noItems;

  final SharableLanguage sharable;
  final ClubLanguage club;
  final AuthenticationLanguage authentication;
  final UserLanguage user;

  final BuilderLanguage builder;
  final BuilderVerifierLanguge builderVerifier;
  final FormLanguage form;
  final DiscoverLanguage discover;
  final NotificationsLanguage notifications;
  final List<TutorialData> tutorialData;
  final FilterLanguage filterLanguage;

  const LanguageData(
      {required this.appTitle,
      required this.siteLink,
      required this.navigationItems,
      required this.titles,
      required this.pages,
      required this.dashboard,
      required this.errors,
      required this.alerts,
      required this.hints,
      required this.noItems,
      required this.sharable,
      required this.club,
      required this.authentication,
      required this.user,
      required this.builder,
      required this.tutorialData,
      required this.builderVerifier,
      required this.form,
      required this.filterLanguage,
      required this.discover,
      required this.notifications});

  factory LanguageData.fromJson(Map json) {
    return LanguageData(
        appTitle: json["appTitle"],
        siteLink: json["siteLink"],
        navigationItems: NavigationItems.fromJson(json["navigationItems"]),
        titles: Titles.fromJson(json["titles"]),
        pages: Pages.fromJson(json["pages"]),
        dashboard: Dashboard.fromJson(json["dashboard"]),
        tutorialData: json["tutorialData"]
            .map<TutorialData>((e) => TutorialData.fromJson(e))
            .toList(),
        errors: Errors.fromJson(json["errors"]),
        alerts: Alerts.fromJson(json["alerts"]),
        hints: Hints.fromJson(json["hints"]),
        noItems: NoItems.fromJson(json["noItems"]),
        sharable: SharableLanguage.fromJson(json["sharable"]),
        club: ClubLanguage.fromJson(json["club"]),
        authentication: AuthenticationLanguage.fromJson(json["authentication"]),
        user: UserLanguage.fromJson(json["user"]),
        builder: BuilderLanguage.fromJson(json["builder"]),
        builderVerifier:
            BuilderVerifierLanguge.fromJson(json["builderVerifier"]),
        filterLanguage: FilterLanguage.fromJson(json["filter"]),
        form: FormLanguage.fromJson(json["form"]),
        discover: DiscoverLanguage.fromJson(json["discover"]),
        notifications: NotificationsLanguage.fromJson(json["notifications"]));
  }
}
