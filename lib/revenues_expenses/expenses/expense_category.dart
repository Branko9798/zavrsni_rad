import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExpenseCategory {
  final IconData icon;
  final String name;
  final String id;

  const ExpenseCategory(this.icon, this.name, this.id);

  static const categories = <ExpenseCategory>[
    ExpenseCategory(
      FontAwesomeIcons.house,
      "House",
      "2490CC64-A729-429D-8547-FACCFA5DD3CD",
    ),
    ExpenseCategory(
      FontAwesomeIcons.receipt,
      "Bills",
      "2545516C-A27B-4DFD-B5BB-A978B155C76B",
    ),
    ExpenseCategory(
      Icons.face_2,
      "Girlfriend",
      "AD2AF3BF-A9B1-4879-A8CE-1A50C914333A",
    ),
    ExpenseCategory(
      Icons.face_6,
      "Boyfriend",
      "62E4E715-72F2-4544-9E81-69D20F322710",
    ),
    ExpenseCategory(FontAwesomeIcons.babyCarriage, "Babysitter",
        "1776B960-3F74-40F3-A21C-AFDEF0009C5B"),
    ExpenseCategory(
      FontAwesomeIcons.child,
      "Child",
      "827D718B-C5A5-4ACD-BAF1-FB667375F8F8",
    ),
    ExpenseCategory(
      FontAwesomeIcons.personCane,
      "Family",
      "495E4B51-B22C-48C9-A2D0-20CFCB90710D",
    ),
    ExpenseCategory(
      FontAwesomeIcons.dog,
      "Pet",
      "01BC7E90-332A-40BB-B572-A75BFA0AD86E",
    ),
    ExpenseCategory(
      FontAwesomeIcons.burger,
      "Food",
      "97FD1EBF-B07B-4B55-8C72-12E33464DBAF",
    ),
    ExpenseCategory(
      FontAwesomeIcons.mugSaucer,
      "Drinks",
      "5AB8C3CE-41BF-46E4-8882-253A1E9196F2",
    ),
    ExpenseCategory(
      FontAwesomeIcons.car,
      "Car",
      "5A526F89-DF4B-45BA-922C-7D5C8A66121E",
    ),
    ExpenseCategory(
      FontAwesomeIcons.trainSubway,
      "Transport",
      "2D76D1BE-DFF3-49D3-BA29-A61D1A8EC5A9",
    ),
    ExpenseCategory(
      FontAwesomeIcons.cartShopping,
      "Grocery",
      "6969F001-969A-42D4-A8A7-F68B03E233D0",
    ),
    ExpenseCategory(
      FontAwesomeIcons.briefcase,
      "Buisness",
      "72C03AAC-D111-42BF-8ED0-1A76A791A373",
    ),
    ExpenseCategory(
      FontAwesomeIcons.gifts,
      "Gifts",
      "E85268B4-A3B8-499C-9124-BB0AA08AFA4A",
    ),
    ExpenseCategory(
      FontAwesomeIcons.shirt,
      "Clothes",
      "8719A56F-AB80-49FB-9AF0-3C27FD69A7F6",
    ),
    ExpenseCategory(
      FontAwesomeIcons.scissors,
      "Haircut",
      "58C142EF-4671-41A7-9099-1E97107838A3",
    ),
    ExpenseCategory(
      FontAwesomeIcons.computer,
      "Tehnology",
      "959884A4-6E43-4154-9B56-853BD8DA8B3F",
    ),
    ExpenseCategory(
      FontAwesomeIcons.paintRoller,
      "Housing",
      "2F71BEB0-6286-4485-8E6E-FC593FF08423",
    ),
    ExpenseCategory(
      FontAwesomeIcons.couch,
      "Furniture",
      "7EB57E4F-67FB-4DB1-86D6-60DE3BFAE185",
    ),
    ExpenseCategory(
      FontAwesomeIcons.wineBottle,
      "Party",
      "9E06821B-AB13-4771-80F6-6B0FE455D59C",
    ),
    ExpenseCategory(
      FontAwesomeIcons.futbol,
      "Sport",
      "19EFAD07-E8F5-4622-BC6C-6B901D919B98",
    ),
    ExpenseCategory(
      FontAwesomeIcons.airbnb,
      "Vacation",
      "9EE6182E-E01E-4833-984B-052D36461141",
    ),
    ExpenseCategory(
      FontAwesomeIcons.hammer,
      "Repair",
      "04547756-9B28-474A-8FAB-5F639B55FD0F",
    ),
    ExpenseCategory(
      FontAwesomeIcons.heartPulse,
      "Health",
      "5546AF53-DD98-4DB6-A804-9CAF2594EFD5",
    ),
    ExpenseCategory(
      FontAwesomeIcons.handHoldingDollar,
      "Donate",
      "11371D80-4C0F-4457-ABC0-ED8E252A78F5",
    ),
    ExpenseCategory(
      FontAwesomeIcons.planeUp,
      "Travel",
      "6E340235-1E0B-45D3-9CE8-99F60A565D23",
    ),
    ExpenseCategory(
      FontAwesomeIcons.dice,
      "Gambling",
      "560CF766-12C4-47C3-B370-FB3A6AA2DE76",
    ),
  ];

  static ExpenseCategory? findCategoryId(
    String id,
  ) {
    return categories.firstWhere((category) => category.id == id);
  }
}
