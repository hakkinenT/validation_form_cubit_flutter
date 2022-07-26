import 'package:flutter/material.dart';

class CustomDropDownButton extends StatelessWidget {
  CustomDropDownButton(
      {Key? key,
      required this.hintText,
      this.initialValue,
      this.focusNode,
      //required this.items,
      required this.onChanged,
      this.validator,
      required this.width,
      //required this.height,
      this.prefixIcon,
      this.onTap,
      this.errorText,
      this.enabled = true})
      : super(key: key);

  final Function()? onTap;
  final String hintText;
  final String? initialValue;
  final FocusNode? focusNode;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  //final List<String> items;
  final double width;
  //final double height;
  final Widget? prefixIcon;
  final String? errorText;
  bool enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 52, maxHeight: 80),
      width: width,
      //height: height,
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          isExpanded: true,
          validator: validator,
          itemHeight: 50,
          onTap: onTap,
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              prefixIcon: prefixIcon,
              errorText: errorText,
              label: const Text('Tipo'),
              border: const OutlineInputBorder()),
          items: <String>['Cachorro', 'Gato']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                ));
          }).toList(),
          hint: Text(
            hintText,
          ),
          onChanged: enabled ? onChanged : null,
          disabledHint: enabled
              ? null
              : Text(
                  initialValue!,
                ),
          value: initialValue,
          icon: const Icon(
            Icons.expand_more,
          ),
          focusNode: focusNode,
        ),
      ),
    );
  }
}
