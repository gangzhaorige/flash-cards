import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import 'locator.dart';

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final builders = {
    DialogType.basic: (context, sheetRequest, completer) =>
      _BasicDialog(request: sheetRequest, completer: completer),
  };
  dialogService.registerCustomDialogBuilders(builders);
  print('nani');
}

enum DialogType {
  basic,
  form
}

class _BasicDialog extends StatefulWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const _BasicDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  State<_BasicDialog> createState() => _BasicDialogState();
}

class _BasicDialogState extends State<_BasicDialog> {

  late TextEditingController topicController;

  @override
  void initState() {
    topicController = TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.request.title!,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.request.description!,
                style: const TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: topicController,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Please enter your topic here.'
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              GestureDetector(
                // Complete the dialog when you're done with it to return some data
                onTap: () => widget.completer(
                  DialogResponse(
                    confirmed: true,
                    data: {
                      'topic' : topicController.text,
                      'isPublic' : true,
                    }
                  ),
                ),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: widget.request.showIconInMainButton!
                      ? const Icon(Icons.check_circle)
                      : Text(widget.request.mainButtonTitle!),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                // Complete the dialog when you're done with it to return some data
                onTap: () => widget.completer(DialogResponse(confirmed: false)),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: widget.request.showIconInMainButton!
                      ? const Icon(Icons.check_circle)
                      : Text(widget.request.additionalButtonTitle!),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}