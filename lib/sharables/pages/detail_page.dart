import 'package:ToGather/sharables/filters/comment_query_params.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/sharables/sharables.dart';
import 'package:ToGather/users/users.dart';
import 'package:ToGather/users/widgets/listed_user.dart';
import 'package:ToGather/utilities/utilities.dart';

class PostDetailPage extends StatefulWidget {
  PostDetailPage({required this.id});
  final int id;

  @override
  State<PostDetailPage> createState() => PostDetailPageState();
}

class PostDetailPageState extends State<PostDetailPage> {
  final _commentManager = ModelServiceFactory.COMMENT;
  late final _commentEdittorController =
      CommentEdittorController(postId: widget.id);

  List<Comment> _comments = [];
  Post? _postData;

  Widget _commentsWidget() {
    return Container(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 70),
      child: Column(
        children: _comments
            .map((e) =>
                CommentWidget(data: e, onCommentSelected: _onCommentSelected))
            .toList(),
      ),
    );
  }

  void _onCommentSelected(int? commentId, String? author) {
    _commentEdittorController.selectComment(commentId, author);
  }

  Future<List<Widget>?> _onRefresh() async {
    _postData = await ModelServiceFactory.POST
        .getItem(itemParameters: ItemParameters(id: widget.id));
    _commentManager.reset();

    if (_postData == null) {
      Navigator.pop(context);
      return null;
    }

    _comments = (await _commentManager.getList(
            queryParameters: CommentQueryParameters(postId: widget.id))) ??
        [];

    return [
      PostWidget(
        data: _postData!,
        isDetail: true,
        onCommentSelected: _onCommentSelected,
      ),
      _commentsWidget()
    ];
  }

  Future<List<Widget>?> _onLoad() async {
    if (!_commentManager.next()) return null;
    _comments += (await _commentManager.getList())!;
    return [_commentsWidget()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          RefreshablePage(
            onRefresh: _onRefresh,
            onLoad: _onLoad,
          ),
          CommentEdittor(
              postId: widget.id,
              controller: _commentEdittorController,
              onPostRefresh: () {
                closePage(context);
                launchPage(context, PostDetailPage(id: widget.id));
              })
        ],
      ),
    );
  }
}

class CommentEdittorController {
  int? selectedCommentId;
  String? selectedCommentAuthor;
  bool anonymous = false;
  void Function(void Function())? setState;
  final int postId;

  CommentEdittorController(
      {required this.postId,
      this.selectedCommentAuthor,
      this.setState,
      this.selectedCommentId});

  bool get isCommentSelected => selectedCommentId != null;

  void selectComment(int? selectedCommentId, String? selectedCommentAuthor) {
    setState!(() {
      this.selectedCommentId = selectedCommentId;
      this.selectedCommentAuthor = selectedCommentAuthor;
    });
  }

  Future<bool> publish(BuildContext context, String text) async {
    /* if (!AuthService().isLogedIn) {
      /* APIService.displayMesssage(
          LanguageService().data.errors.loginNeccesary, context); */
      return false;
    } */

    final comment = Comment(
        media: [],
        content: text,
        id: 0,
        commentCount: 0,
        datePosted: DateTime.now(),
        ratingAverage: 0,
        author: PostAnonymousAuthor(),
        isAnonymous: anonymous,
        relatedData: RelatedData(postId: postId, commentId: selectedCommentId),
        rateCount: 0,
        requestData: null);

    if (comment.content?.isNotEmpty ?? false) {
      try {
        final result =
            await ModelServiceFactory.COMMENT.postItem(item: comment);
        if (result != null) selectComment(null, null);

        await showSylvestSnackbar(
            context: context,
            message: result != null ? "Yorum paylaşıldı" : "Paylaşılamadı",
            type: result != null
                ? DisplayMessageType.Success
                : DisplayMessageType.Danger);

        return result != null;
      } catch (e) {
        print("comment error: $e");
        return false;
      }
    } else {
      await showSylvestSnackbar(
          context: context,
          message: LanguageService().data.errors.emptyComment,
          type: DisplayMessageType.Danger);
      return false;
    }
  }
}

class CommentEdittor extends StatefulWidget {
  CommentEdittor(
      {Key? key,
      required this.postId,
      required this.controller,
      required this.onPostRefresh})
      : super(key: key);
  final int postId;
  final CommentEdittorController controller;
  final void Function() onPostRefresh;

  @override
  State<CommentEdittor> createState() => _CommentEdittorState();
}

class _CommentEdittorState extends State<CommentEdittor> {
  final _userSearchKey = GlobalKey<UserTagSearchState>();

  final _textController = TextEditingController();
  late final UserTagSearchController _userSearchController =
      UserTagSearchController(onSelect: (user) {
    final index = _textController.text.lastIndexOf('@');
    _textController.text =
        "${_textController.text.substring(0, index)}@${user.username} ";
    _textController.selection = TextSelection.fromPosition(
        TextPosition(offset: _textController.text.length));
    _userSearchController.query.value = null;
    setState(() {});
  });

  bool get searchForUsers =>
      _textController.text.isNotEmpty &&
      _textController.text.split(' ').last.startsWith('@');

  String? get userSearchQuery =>
      searchForUsers ? _textController.text.split('@').last : null;

  @override
  void initState() {
    super.initState();
    widget.controller.setState = setState;
  }

  Widget _field(context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: RoundedTextField(
        type: TextInputType.multiline,
        onChanged: (text) => setState(() {
          _userSearchController.query.value = userSearchQuery;
          _userSearchKey.currentState?.onSearch();
        }),
        controller: _textController,
        isMultiLine: true,
        hint: LanguageService().data.hints.createComment,
      ),
    );
  }

  Widget _selectedCommentIndicator() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        children: [
          Text(
            LanguageService().data.builder.replyingTo,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            "@" + widget.controller.selectedCommentAuthor!,
            style: TextStyle(
                fontFamily: ThemeService.headlineFont,
                color: ThemeService.eventColor),
          ),
          Expanded(
              child: IconButton(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.zero,
            icon: Icon(LineIcons.times),
            iconSize: 17,
            onPressed: () {
              widget.controller.selectComment(null, null);
            },
          ))
        ],
      ),
    );
  }

  Future<void> _onPublish() async {
    final published =
        await widget.controller.publish(context, _textController.text);
    if (published) {
      setState(() {
        _textController.clear();
      });
      widget.onPostRefresh();
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: ValueListenableBuilder<String?>(
          valueListenable: _userSearchController.query,
          builder: (context, value, child) => Column(
                children: [
                  if (value != null)
                    UserTagSearch(
                      key: _userSearchKey,
                      controller: _userSearchController,
                    ),
                  Container(
                    decoration: BoxDecoration(
                        color: ThemeService.menuBackground,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 2,
                              blurRadius: 5)
                        ]),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        if (widget.controller.isCommentSelected)
                          _selectedCommentIndicator(),
                        Row(
                          children: [
                            Expanded(child: _field(context)),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  foregroundColor: ThemeService.clubColor,
                                  padding: const EdgeInsets.all(10),
                                  shape: CircleBorder()),
                              child: Icon(widget.controller.anonymous
                                  ? LineIcons.eyeSlash
                                  : LineIcons.eye),
                              onPressed: () => setState(() {
                                widget.controller.anonymous =
                                    !widget.controller.anonymous;
                              }),
                            ),
                            if (_textController.text.isNotEmpty)
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    foregroundColor: ThemeService.eventColor,
                                    padding: const EdgeInsets.all(10),
                                    shape: CircleBorder()),
                                child: Icon(LineIcons.share),
                                onPressed: _textController.text.isEmpty
                                    ? null
                                    : () async => await _onPublish(),
                              ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )),
    );
  }
}

class UserTagSearchController {
  final query = ValueNotifier<String?>(null);

  final void Function(Profile user) onSelect;

  UserTagSearchController({required this.onSelect});
}

class UserTagSearch extends StatefulWidget {
  const UserTagSearch({super.key, required this.controller, this.height = 200});
  final UserTagSearchController controller;
  final double height;

  @override
  State<UserTagSearch> createState() => UserTagSearchState();
}

class UserTagSearchState extends State<UserTagSearch> {
  final _userManager = ModelServiceFactory.PROFILE;
  List<Profile> _users = [];
  bool _isSearching = false;

  Future<void> onSearch() async {
    if (widget.controller.query.value == null ||
        widget.controller.query.value!.isEmpty) return;
    _isSearching = true;
    setState(() {});

    _users = await _userManager.getList(
            queryParameters:
                QueryParameters(searchQuery: widget.controller.query.value)) ??
        [];

    _isSearching = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SylvestCard(
      height: widget.height,
      margin: EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width - 30,
      child: _users.isEmpty || _isSearching
          ? Center(
              child: _isSearching
                  ? LoadingIndicator()
                  : Text("Kullanıcı Etiketle",
                      style: TextStyle(color: ThemeService.disabledColor)),
            )
          : ListView(
              shrinkWrap: true,
              children: _users
                  .map((e) => GestureDetector(
                        onTap: () {
                          widget.controller.onSelect(e);
                          _users.clear();
                          setState(() {});
                        },
                        child: AbsorbPointer(child: ListedUserWidget(user: e)),
                      ))
                  .toList(),
            ),
    );
  }
}
