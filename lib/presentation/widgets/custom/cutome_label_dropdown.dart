import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../themes/app_colors.dart';

class LabelWithDropDownField<T> extends StatelessWidget {
  const LabelWithDropDownField({
    super.key,
    required this.textDropDownLabel,
    this.hintText,
    this.labelText,
    this.onChanged,
    required this.items,
    this.icon,
    this.showSelectedItems = true,
    this.itemAsString,
    this.alignLabelWithHint,
    this.hintStyle,
    this.labelStyle,
  });
  final String textDropDownLabel;
  final String? hintText;
  final String? labelText;
  final List<T> Function(String, LoadProps?)? items;
  final ValueChanged<T>? onChanged;
  final bool? alignLabelWithHint;
  final Widget? icon;
  final bool showSelectedItems;
  final String Function(T)? itemAsString;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(textDropDownLabel,
            style: GoogleFonts.poppins(
                color: AppColors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400)),
        const SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            shape: BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 7,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          width: w,
          child: DropdownSearch<T>(
            popupProps: PopupProps.menu(
              fit: FlexFit.loose,
              showSelectedItems: showSelectedItems,
            ),
            items: items,
            decoratorProps: DropDownDecoratorProps(
              decoration: InputDecoration(
                alignLabelWithHint: alignLabelWithHint,
                icon: icon,
                fillColor: AppColors.white,
                filled: true,
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: AppColors.greyText,
                      width: 0.3,
                    )),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 0.3,
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: AppColors.greyText,
                      width: 0.3,
                    )),
                disabledBorder: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.all(15),
                hintText: hintText ?? "",
                hintStyle: hintStyle ??
                    GoogleFonts.poppins(color: AppColors.grey, fontSize: 14),
                labelText: labelText ?? "",
                labelStyle: labelStyle??GoogleFonts.poppins(color: AppColors.grey, fontSize: 14),
              ),
            ),
            onChanged: (value) {
              if (onChanged != null) {
                onChanged!(value!);
              }
            },
            itemAsString: itemAsString,
          ),
        ),
      ],
    );
  }
}
