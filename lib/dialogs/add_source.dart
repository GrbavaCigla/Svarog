import 'package:flutter/material.dart';
import 'package:svarog/widgets/settings.dart';

class AddSourceDialog extends StatefulWidget {
  const AddSourceDialog({Key? key}) : super(key: key);

  @override
  State<AddSourceDialog> createState() => _AddSourceDialogState();
}

class _AddSourceDialogState extends State<AddSourceDialog> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add source'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _textController,
          validator: (String? source) => source == null
              ? 'Field cannot be empty'
              : Uri.tryParse(source) == null
                  ? 'Not valid URL'
                  : Uri.parse(source).isAbsolute
                      ? null
                      : 'Not a valid URL',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // TODO: Optimize this
            if (_formKey.currentState!.validate()) {
              Set<Uri> newSources =
                  Set.from(DynamicSettings.of(context).sources);

              newSources.add(Uri.parse(_textController.text));

              DynamicSettings.of(context).sources = newSources;
              Navigator.of(context).pop();
            }
          },
          child: const Text('Ok'),
        ),
      ],
    );
  }
}
