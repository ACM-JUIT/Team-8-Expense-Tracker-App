import 'package:basecode/components/add_expense_tile.dart';
import 'package:basecode/components/my_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController expenseController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController datecontroller = TextEditingController();
  final TextEditingController categorycontroller = TextEditingController();
  DateTime selectedDate = DateTime.now();

  List<String> myIcons = [
    'entertainment',
    'food',
    'home',
    'pet',
    'shopping',
    'tech',
    'travel'
  ];

  void pickDate() async {
    DateTime? newdate = await showDatePicker(
      initialDate: selectedDate,
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );
    if (newdate != null) {
      setState(() {
        datecontroller.text = DateFormat('dd/MM/yyyy').format(newdate);
        selectedDate = newdate;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    datecontroller.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  @override
  void dispose() {
    super.dispose();
    expenseController.dispose();
    nameController.dispose();
    descriptionController.dispose();
    categorycontroller.dispose();
    datecontroller.dispose();
    categorycontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFF0F0F2),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF0F0F2),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text(
            "Expenses",
            style: TextStyle(
              color: const Color(0xFF322F50),
              fontWeight: FontWeight.w600,
              fontSize: 25,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AddExpenseTile(
                  controller: expenseController,
                  hint: "Expense",
                  onTap: () {},
                ),
                const SizedBox(height: 30),
                TextFormField(
                  readOnly: true,
                  onTap: () {},
                  controller: categorycontroller,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (
                              context,
                            ) {
                              bool isExpanded = false;
                              String iconSelected = '';
                              Color colorSelected = Colors.white;
                              return StatefulBuilder(
                                builder: (context, setState) {
                                  return AlertDialog(
                                    title: const Text("Create a Category"),
                                    actions: [
                                      MyButton(
                                          text: "Save",
                                          onTap: () {},
                                          color: const Color(0xFF322F50))
                                    ],
                                    content: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextFormField(
                                            controller: nameController,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            decoration: InputDecoration(
                                              hintText: "Name",
                                              fillColor: Colors.white,
                                              filled: true,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          TextFormField(
                                            onTap: () {
                                              setState(() {
                                                isExpanded = !isExpanded;
                                              });
                                            },
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              suffixIcon: IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  isExpanded
                                                      ? CupertinoIcons
                                                          .chevron_up
                                                      : CupertinoIcons
                                                          .chevron_down,
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
                                                        topLeft:
                                                            Radius.circular(12),
                                                        topRight:
                                                            Radius.circular(12))
                                                    : BorderRadius.circular(12),
                                              ),
                                            ),
                                          ),
                                          isExpanded
                                              ? Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 200,
                                                  decoration: const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomLeft: Radius
                                                                  .circular(12),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          12)),
                                                      color: Colors.white),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10.0),
                                                    child: GridView.builder(
                                                      gridDelegate:
                                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                                              crossAxisCount: 3,
                                                              mainAxisSpacing:
                                                                  3,
                                                              crossAxisSpacing:
                                                                  5),
                                                      itemCount: myIcons.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        final icon =
                                                            myIcons[index];
                                                        return GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              iconSelected =
                                                                  icon;
                                                            });
                                                          },
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              border:
                                                                  Border.all(
                                                                color: icon ==
                                                                        iconSelected
                                                                    ? const Color(
                                                                        0xFF322F50)
                                                                    : Colors
                                                                        .grey
                                                                        .shade100,
                                                                width: 2,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              image:
                                                                  DecorationImage(
                                                                image: AssetImage(
                                                                    'assets/$icon.png'),
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
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      actions: [
                                                        MyButton(
                                                          text: "Save",
                                                          onTap: () {},
                                                          color: const Color(
                                                              0xFF322F50),
                                                        )
                                                      ],
                                                      content: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          ColorPicker(
                                                              pickerColor:
                                                                  colorSelected,
                                                              onColorChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  colorSelected =
                                                                      value;
                                                                });
                                                              }),
                                                        ],
                                                      ),
                                                    );
                                                  });
                                            },
                                            readOnly: true,
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
                                                borderRadius:
                                                    BorderRadius.circular(12),
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
                        },
                        icon: Icon(
                          FontAwesomeIcons.plus,
                          size: 18,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      hintText: "Category",
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      hintStyle: TextStyle(color: Colors.grey)),
                  textAlignVertical: TextAlignVertical.center,
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: datecontroller,
                  readOnly: true,
                  onTap: () async {
                    pickDate();
                  },
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    hintText: "Date",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () async {
                        pickDate();
                      },
                      icon: Icon(Icons.date_range_rounded),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                AddExpenseTile(
                  controller: descriptionController,
                  hint: "Description",
                  onTap: () {},
                ),
                const SizedBox(height: 120),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 30),
                  child: MyButton(
                    text: "Add Expense",
                    onTap: () {},
                    color: const Color(0xFF322F50),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
