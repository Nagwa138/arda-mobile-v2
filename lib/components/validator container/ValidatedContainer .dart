import 'package:flutter/material.dart';

class ValidatedContainer extends StatefulWidget {
  final String? Function()? validator;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final void Function(bool isValid)? onValidate;

  ValidatedContainer({
    required this.child,
    this.validator,
    this.padding,
    this.onValidate,
    Key? key,
  }) : super(key: key);

  @override
  _ValidatedContainerState createState() => _ValidatedContainerState();
}

class _ValidatedContainerState extends State<ValidatedContainer> {
  String? _errorText;

  void validate() {
    setState(() {
      _errorText = widget.validator?.call();
      widget.onValidate?.call(_errorText == null);
    });
  }

  @override
  void initState() {
    super.initState();
    validate(); // Initial validation if needed
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: widget.padding,
          decoration: BoxDecoration(
            border: Border.all(
              color: _errorText == null ? Colors.grey : Colors.red,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: widget.child,
        ),
        if (_errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              _errorText!,
              style: TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }
}
