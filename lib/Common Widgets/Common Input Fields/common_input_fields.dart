import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonComponents {
  static Column defaultTextField(context,
      {TextEditingController? controller,
      String? title = '',
      String? hintText,
      String? errorText,
      bool? readOnly = false,
      bool? enable = true,
      bool? filled = false,
      Icon? prefixIcon,
      Widget? suffixIcon,
      int? maxLength,
      // int? maxLines,
      // int? minLines,
      bool? obscureText = false,
      List<TextInputFormatter>? inputFormatters,
      TextInputAction? textInputAction,
      TextInputType? keyboardType,
      FocusNode? focusNode,
      TextCapitalization? textCapitalization,
      InputDecoration? decoration,
      validator,
      void Function(String?)? onSaved,
      void Function()? onTap,
      void Function()? onEditingComplete,
      void Function(String)? onChange,
      void Function(String)? onFieldSubmitted}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != ''
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title!,
                    style: TextStyle(color: Theme.of(context).colorScheme.surface),
                  ),
                  Container(
                    height: 8,
                  ),
                ],
              )
            : Container(),
        TextFormField(
          autofocus: false,
          maxLength: maxLength,
          readOnly: readOnly!,
          enabled: enable,
          controller: controller,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          focusNode: focusNode,
          textInputAction: textInputAction,
          // maxLines: maxLines,
          // minLines: minLines,
          obscureText: obscureText!,
          keyboardType: keyboardType,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: inputFormatters,
          cursorColor: Theme.of(context).colorScheme.primary,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          decoration: InputDecoration(counterText: '', hintText: hintText, prefixIcon: prefixIcon, suffixIcon: suffixIcon, filled: true),
          onChanged: onChange,
          onFieldSubmitted: onFieldSubmitted,
          onSaved: onSaved,
          onTap: onTap,
          validator: validator,
          onEditingComplete: onEditingComplete,
        ),
        Container(
          height: 2,
        ),
        errorText != null
            ? Text(
                errorText,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.red),
              )
            : Container(),
      ],
    );
  }

  static Column defaultDropdownSearch<T>(
    context, {
    Key? key,
    Icon? prefixIcon,
    String? title,
    String? hintText,
    bool? enabled,
    Color? filledColor,
    List<T>? items,
    validator,
    Future<List<T>> Function(String)? asyncItems,
    compareFn,
    disableItemFn,
    itemAsString,
    selectedItem,
    onChanged,
    itemBuilder,
  }) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
      title != ''
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title!,
                  style: TextStyle(color: Theme.of(context).colorScheme.surface),
                ),
                Container(
                  height: 8,
                ),
              ],
            )
          : Container(),
      DropdownSearch<T>(
          autoValidateMode: AutovalidateMode.onUserInteraction,
          asyncItems: asyncItems ?? asyncItems,
          items: items ?? [],
          key: ValueKey(title),
          dropdownButtonProps: DropdownButtonProps(
              icon: Icon(
            Icons.keyboard_arrow_down,
            color: Theme.of(context).colorScheme.surface,
          )),
          // clearButtonProps: const ClearButtonProps(isVisible: true),
          validator: validator,
          compareFn: compareFn,
          enabled: enabled ?? true,
          dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle: TextStyle(color: Theme.of(context).colorScheme.surface),
            dropdownSearchDecoration: InputDecoration(
              fillColor: filledColor,
              filled: filledColor != null ? false : true,
              // disabledBorder: UnderlineInputBorder(
              //     borderSide: BorderSide(style: BorderStyle.solid, width: 3, color: Theme.of(context).colorScheme.secondaryContainer),
              //     borderRadius: BorderRadius.circular(5.0)),
              // enabledBorder: UnderlineInputBorder(
              //     borderSide: BorderSide(style: BorderStyle.solid, width: 3, color: Theme.of(context).colorScheme.secondaryContainer),
              //     borderRadius: BorderRadius.circular(5.0)),
              // focusedBorder: UnderlineInputBorder(
              //     borderSide: BorderSide(style: BorderStyle.solid, width: 3, color: Theme.of(context).colorScheme.secondaryContainer),
              //     borderRadius: BorderRadius.circular(5.0)),
              // border: UnderlineInputBorder(
              //     borderSide: BorderSide(style: BorderStyle.solid, width: 3, color: Theme.of(context).colorScheme.secondaryContainer),
              //     borderRadius: BorderRadius.circular(5.0)),
              // prefixIcon: prefixIcon,
              hintText: "$hintText $title",
              errorStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.red),
              // filled: true,
              // fillColor: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.1),
            ),
          ),
          popupProps: PopupPropsMultiSelection.modalBottomSheet(
              disabledItemFn: disableItemFn,
              showSelectedItems: true,
              showSearchBox: true,
              itemBuilder: itemBuilder,
              fit: FlexFit.tight,
              searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                // enabledBorder: UnderlineInputBorder(
                //     borderSide: BorderSide(style: BorderStyle.solid, width: 3, color: Theme.of(context).colorScheme.secondaryContainer),
                //     borderRadius: BorderRadius.circular(5.0)),
                // focusedBorder: UnderlineInputBorder(
                //     borderSide: BorderSide(style: BorderStyle.solid, width: 3, color: Theme.of(context).colorScheme.secondaryContainer),
                //     borderRadius: BorderRadius.circular(5.0)),
                // border: UnderlineInputBorder(
                //     borderSide: BorderSide(style: BorderStyle.solid, width: 3, color: Theme.of(context).colorScheme.secondaryContainer),
                // borderRadius: BorderRadius.circular(5.0)),
                suffixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.primary,
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.secondaryContainer,
                hintText: 'Search Here',
              )),
              modalBottomSheetProps: ModalBottomSheetProps(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  )),
              title: Container(
                height: 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Center(
                  child: Text(
                    title!,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              )),
          itemAsString: itemAsString,
          selectedItem: selectedItem,
          onChanged: onChanged)
    ]);
  }

  static Column defaultDropdownSearchMultipleSelection<T>(
    context, {
    Key? key,
    String? title,
    String? hintText,
    bool? enabled,
    List<T>? items,
    validator,
    asyncItems,
    compareFn,
    itemAsString,
    selectedItem,
    onChanged,
    onCheckBoxChanged,
    itemBuilder,
  }) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        title!,
        style: TextStyle(color: Theme.of(context).colorScheme.surface),
      ),
      Container(height: 10),
      DropdownSearch<T>.multiSelection(
          autoValidateMode: AutovalidateMode.onUserInteraction,
          asyncItems: asyncItems ?? asyncItems,
          // items: items ?? [],
          key: ValueKey(title),
          dropdownButtonProps: DropdownButtonProps(
              icon: Icon(
            Icons.keyboard_arrow_down,
            color: Theme.of(context).colorScheme.surface,
          )),
          // clearButtonProps: const ClearButtonProps(isVisible: true),
          validator: validator,
          compareFn: compareFn,
          enabled: enabled ?? true,
          dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle: TextStyle(color: Theme.of(context).colorScheme.surface),
            dropdownSearchDecoration: InputDecoration(
              // disabledBorder: UnderlineInputBorder(
              //     borderSide: BorderSide(style: BorderStyle.solid, width: 3, color: Theme.of(context).colorScheme.secondaryContainer),
              //     borderRadius: BorderRadius.circular(5.0)),
              // enabledBorder: UnderlineInputBorder(
              //     borderSide: BorderSide(style: BorderStyle.solid, width: 3, color: Theme.of(context).colorScheme.secondaryContainer),
              //     borderRadius: BorderRadius.circular(5.0)),
              // focusedBorder: UnderlineInputBorder(
              //     borderSide: BorderSide(style: BorderStyle.solid, width: 3, color: Theme.of(context).colorScheme.secondaryContainer),
              //     borderRadius: BorderRadius.circular(5.0)),
              // border: UnderlineInputBorder(
              //     borderSide: BorderSide(style: BorderStyle.solid, width: 3, color: Theme.of(context).colorScheme.secondaryContainer),
              //     borderRadius: BorderRadius.circular(5.0)),
              // prefixIcon: prefixIcon,
              hintText: "Select $title",
              errorStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.red),
              // filled: true,
              // fillColor: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.1),
            ),
          ),
          popupProps: PopupPropsMultiSelection.modalBottomSheet(
              // validationWidgetBuilder: (ctx, selectedItems) {
              //   return SizedBox(
              //     height: 80,
              //     child: Stack(
              //       children: [
              //         Positioned(
              //           bottom: 30,
              //           right: 20,
              //           child: MaterialButton(
              //             child: const GradientContainer(
              //                 width: 80,
              //                 child: Center(
              //                     child: Text(
              //                   'OK',
              //                   style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
              //                 ))),
              //             onPressed: () {
              //               Get.back();
              //               // _popupCustomValidationKey.currentState?.popupOnValidate();
              //             },
              //           ),
              //         ),
              //       ],
              //     ),
              //   );
              // },
              showSelectedItems: true,
              showSearchBox: true,
              itemBuilder: itemBuilder,
              fit: FlexFit.tight,
              searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                // enabledBorder: UnderlineInputBorder(
                //     borderSide: BorderSide(style: BorderStyle.solid, width: 3, color: Theme.of(context).colorScheme.secondaryContainer),
                //     borderRadius: BorderRadius.circular(5.0)),
                // focusedBorder: UnderlineInputBorder(
                //     borderSide: BorderSide(style: BorderStyle.solid, width: 3, color: Theme.of(context).colorScheme.secondaryContainer),
                //     borderRadius: BorderRadius.circular(5.0)),
                // border: UnderlineInputBorder(
                //     borderSide: BorderSide(style: BorderStyle.solid, width: 3, color: Theme.of(context).colorScheme.secondaryContainer),
                //     borderRadius: BorderRadius.circular(5.0)),
                suffixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.surface,
                ),
                // filled: true,
                // fillColor: Colors.grey[100],
                hintText: 'Search Here',
              )),
              modalBottomSheetProps: ModalBottomSheetProps(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  )),
              title: Container(
                height: 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondaryContainer,
                    ),
                  ),
                ),
              )),
          itemAsString: itemAsString,
          // selectedItems: selectedItem,
          onChanged: onChanged)
    ]);
  }

  // bottom sheet widget
}
