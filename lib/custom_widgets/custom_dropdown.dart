import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flutter/material.dart';

import '../resources/text_utility.dart';

class CustomDropdownButton2<T> extends StatelessWidget {
  final String hintText;
  final String searchHintText;
  final List<T> items;
  final T? value;
  final String Function(T)? displayText;
  final void Function(T?)? onChanged;
  final TextEditingController? searchController;
  final double? borderRadius;

  const CustomDropdownButton2({
    Key? key,
    required this.hintText,
    this.searchHintText='',
    required this.items,
    required this.value,
    required this.displayText,
    required this.onChanged,
    this.searchController,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<T>(
        isExpanded: true,
        hint: addText400(hintText,color: AppColors.greyColor ,fontSize: 14),
        items: items.map((item) => DropdownMenuItem<T>(
          value: item,
          child: Text(
            displayText!(item) ?? '',
            style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: AppColors.textColor1),
          ),
        )).toList(),
        value: value,
        onChanged: onChanged,
        iconStyleData: IconStyleData(
        icon: Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.greyColor,) ),
        menuItemStyleData: const MenuItemStyleData(height: 40),
        buttonStyleData: ButtonStyleData(
          height: 60,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(left: 12, right: 12),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(borderRadius ?? 10),
            border: Border.all(
              color: AppColors.containerBorderColor,
            ),
            // boxShadow: [boxShadowTextField()],
            // color: AppColors.whiteColor,
          ),
        ),
        dropdownStyleData: DropdownStyleData(

          maxHeight: 250,
          // width: 200,
          // width: MediaQuery.of(context).size.width*0.94,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.whiteColor,
          ),
        ),
        dropdownSearchData: searchController != null
            ? DropdownSearchData<T>(
          searchController: searchController!,
          searchInnerWidgetHeight: 50,
          searchInnerWidget: Container(
            height: 50,
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 4,
              right: 8,
              left: 8,
            ),
            child: TextFormField(
              expands: true,
              maxLines: null,
              controller: searchController,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                hintText: searchHintText,
                hintStyle: const TextStyle(fontSize: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          searchMatchFn: (item, searchValue) {
            return displayText!(item.value as T).toLowerCase().contains(searchValue.toLowerCase());
          },
        )
            : null,
        // This to clear the search value when you close the menu
        onMenuStateChange: (isOpen) {
          if (!isOpen && searchController != null) {
            searchController!.clear();
          }
        },
      ),
    );
  }
}