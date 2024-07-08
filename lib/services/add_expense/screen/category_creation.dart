import 'package:basecode/components/my_button.dart';
import 'package:basecode/model/category_model.dart';
import 'package:basecode/services/add_expense/repository/expense_repository.dart';
import 'package:basecode/services/auth/repository/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

Future getCategoryCreation(BuildContext context, String id) {
  List<String> myIcons = [
    'entertainment',
    'food',
    'home',
    'pet',
    'shopping',
    'tech',
    'travel'
  ];
  print("add category $id");
  return showDialog(
    context: context,
    builder: (
      context,
    ) {
      bool isExpanded = false;
      String iconSelected = '';
      Color colorSelected = Colors.white;
      TextEditingController categoryNameController = TextEditingController();
      TextEditingController categoryIconController = TextEditingController();
      TextEditingController categoryColorController = TextEditingController();
      Category category = Category.empty;
      String uid = context.read<AuthRepository>().currentUid;

      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text("Create a Category"),
            actions: [
              MyButton(
                text: "Save",
                onTap: () {
                  setState(() {
                    category.color = colorSelected.value;
                    category.name = categoryNameController.text;
                    category.icon = iconSelected;
                    category.id = id;
                  });
                  context
                      .read<ExpenseRepository>()
                      .addCategory(uid, category, context);
                  Navigator.of(context).pop();
                },
                color: const Color(0xFF322F50),
              )
            ],
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: categoryNameController,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      hintText: "Name",
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: categoryIconController,
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    textAlignVertical: TextAlignVertical.center,
                    readOnly: true,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          isExpanded
                              ? CupertinoIcons.chevron_up
                              : CupertinoIcons.chevron_down,
                          size: 18,
                        ),
                      ),
                      hintText: "Icon",
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: isExpanded
                            ? const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12))
                            : BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  isExpanded
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12)),
                              color: Colors.white),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 3,
                                      crossAxisSpacing: 5),
                              itemCount: myIcons.length,
                              itemBuilder: (context, index) {
                                final icon = myIcons[index];
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      iconSelected = icon;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: icon == iconSelected
                                            ? const Color(0xFF322F50)
                                            : Colors.grey.shade100,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        image: AssetImage('assets/$icon.png'),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : Container(),
                  const SizedBox(height: 16),
                  TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              actions: [
                                MyButton(
                                  text: "Save Color",
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  color: const Color(0xFF322F50),
                                )
                              ],
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ColorPicker(
                                      pickerColor: colorSelected,
                                      onColorChanged: (value) {
                                        setState(() {
                                          colorSelected = value;
                                        });
                                      }),
                                ],
                              ),
                            );
                          });
                    },
                    readOnly: true,
                    controller: categoryColorController,
                    decoration: InputDecoration(
                      hintText: "Color",
                      filled: true,
                      fillColor: Colors.white,
                      suffix: Container(
                        width: 23,
                        height: 23,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorSelected,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
