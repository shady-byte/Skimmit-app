import 'package:flutter/material.dart';
import '../classes/validateMixin.dart';

class MineralsScreen extends StatelessWidget with VaildateMixin {
  var screenSize;
  Widget build(context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              mineralCard(
                  'Sodium',
                  'Needed for proper fluid balance, nerve transmission, and muscle contraction',
                  'Table salt, soy sauce, large amounts in processed foods, small amounts in milk, breads, vegetables, and unprocessed meats'),
              mineralCard(
                  'Potassium',
                  'Needed for proper fluid balance, nerve transmission, and muscle contraction',
                  'Meats, milk, fresh fruits and vegetables, whole grains, legumes'),
              mineralCard(
                  'Calcium',
                  'Important for healthy bones and teeth; helps muscles relax and contract; important in nerve functioning, blood clotting, blood pressure regulation, immune system health',
                  'Milk and milk products, canned fish with bones (salmon, sardines), fortified tofu and fortified soy milk, greens (broccoli, mustard greens), legumes'),
              mineralCard(
                  'Phosphorus',
                  'Important for healthy bones and teeth; found in every cell; part of the system that maintains acid-base balance',
                  'Meat, fish, poultry, eggs, milk, processed foods (including soda pop)'),
              mineralCard(
                  'Magnesium',
                  'Found in bones, needed for making protein, muscle contraction, nerve transmission, immune system health',
                  'Nuts and seeds, legumes, leafy, green vegetables, seafood, chocolate, artichokes, "hard" drinking water'),
              mineralCard(
                  'Iron',
                  'Part of a molecule (hemoglobin) found in red blood cells that carries oxygen in the body; needed for energy metabolism',
                  'Organ meats; red meats, fish; poultry, shellfish (especially clams), egg yolks, legumes, dried fruits, dark, leafy greens; iron-enriched breads and cereals, and fortified cereals'),
              mineralCard(
                  'Zinc',
                  'Part of many enzymes, needed for making protein and genetic material, has a function in taste perception, wound healing, normal fetal development, production of sperm, normal growth and sexual maturation, immune system health',
                  'Meats, fish, poultry, leavened whole grains, vegetables'),
              mineralCard(
                  'Copper',
                  'Part of many enzymes, needed for iron metabolism',
                  'Legumes, nuts and seeds, whole grains, organ meats, drinking water'),
              mineralCard('Manganese', 'Part of many enzymes',
                  'Widespread in foods, especially plant foods'),
              Padding(
                  padding: EdgeInsets.only(bottom: screenSize.height * 0.06)),
            ],
          ),
        ),
      ),
    );
  }

  Widget mineralCard(String title, function, sources) {
    return Card(
      margin:
          EdgeInsets.only(left: 10, right: 10, top: screenSize.height * 0.021),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: colorChange('#E8E8E8'), width: 2),
      ),
      color: Colors.white,
      elevation: 0,
      child: ListTile(
        title: Padding(
          padding: EdgeInsets.only(top: 5),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 27.0,
              fontFamily: 'Bree Serif',
              color: Colors.black,
            ),
          ),
        ),
        leading: Image.asset(
          'assets/images/$title.jpg',
          width: 35,
          height: 35,
        ),
        subtitle: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  'Function',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontFamily: 'Bree Serif',
                    color: colorChange('#502171'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 7),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  function,
                  style: TextStyle(
                    fontSize: 13.0,
                    fontFamily: 'Bree Serif',
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenSize.height * 0.015),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Sources',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontFamily: 'Bree Serif',
                    color: colorChange('#502171'),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 7, bottom: screenSize.height * 0.017),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  sources,
                  style: TextStyle(
                    fontSize: 13.0,
                    fontFamily: 'Bree Serif',
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
