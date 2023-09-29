import 'package:flutter/material.dart';
import 'package:ToGather/forms/forms_responses/form_responses.dart';
import 'package:ToGather/utilities/utilities.dart';

class FormResponseWidget extends StatelessWidget {
  final FormResponse formResponse;

  const FormResponseWidget({Key? key, required this.formResponse})
      : super(key: key);

  List<Widget> _responseItems() {
    return formResponse.data.map<Widget>((response) {
      switch (response.type) {
        case 'short':
          return ShortFormResponse(
              name: response.type,
              question: response.question,
              questionRequired: response.isRequired,
              data: response.data);
        case 'long':
          return LongFormResponse(
              name: response.type,
              question: response.question,
              questionRequired: response.isRequired,
              data: response.data);
        case 'check_box':
          return CheckBoxFormResponse(
              name: response.type,
              question: response.question,
              questionRequired: response.isRequired,
              data: response.data);
        case 'choices':
          return MultipleChoiceFormResponse(
              name: response.type,
              question: response.question,
              questionRequired: response.isRequired,
              data: response.data);
        default:
          throw Exception('Unexpected type: ${response.type}');
      }
    }).toList();
  }

  @override
  Widget build(context) {
    return GestureDetector(
      //onTap: () => _onTap(context),
      child: SylvestCard(
        padding: const EdgeInsets.all(10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                      child: Row(children: [
                    SylvestImageProvider(
                      image: formResponse.author.profileImage,
                      defaultImage: /*DefaultImageManager.user*/ null,
                    ),
                    const SizedBox(width: 10),
                    Text(formResponse.author.username,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ])),
                  if (formResponse.allowedActions != null) AllowedActionsWidget<AllowedActions, FormResponse>(
                    actions: formResponse.allowedActions!,
                    model: formResponse,
                    modelService: ModelServiceFactory.FORMRESPONSE,
                  )
                ],
              ),
              ..._responseItems()
            ]),
      ),
    );
  }
}
