import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

class Userlist extends StatefulWidget {
  const Userlist({super.key});

  @override
  State<Userlist> createState() => _UserlistState();
}

class _UserlistState extends State<Userlist> {
  bool isTextFieldVisible = false;
  double textFieldOpacity = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: isTextFieldVisible
            ? Container(
                height: (MediaQuery.of(context).size.height) / 15,
                width: (MediaQuery.of(context).size.width),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.only(top: 18),
                      hintText: "Search User",
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Icon(PhosphorIcons.magnifying_glass,
                            size: 20, color: AppColors.textcolour),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: CircleAvatar(
                            radius: 15,
                            backgroundColor: AppColors.iconcolor,
                            child: IconButton(
                              icon: Icon(
                                color: AppColors.scaffoldBackgroundColor,
                                PhosphorIcons.funnel_simple,
                              ),
                              onPressed: () {},
                            )),
                      ),
                    )),
              )
            : Text(
                'User List',
                style: GoogleFonts.nunitoSans(
                  textStyle: TextStyle(
                    color: AppColors.scaffoldBackgroundColor,
                    letterSpacing: .5,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isTextFieldVisible = !isTextFieldVisible;
                print(isTextFieldVisible);
              });
            },
            icon: (!isTextFieldVisible)
                ? const Icon(
                    PhosphorIcons.magnifying_glass,
                    size: 20,
                  )
                : const Icon(
                    PhosphorIcons.x,
                    size: 20,
                  ),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundImage: (index.isEven)
                            ? const NetworkImage(
                                'https://lh3.googleusercontent.com/pw/AJFCJaVakgcOcb0L15VHkYyFs_3tTIGPP8OjBUc6io11-GlaM1E3eUoZ8SYSuXhdGDew1uNHcwTUeXbo9Gr-pOelHsSMCP27lM197wjiQ8C65gF3TuvIGqtv3KVPC0uD3YxfybsRUiIt54mWMjuw9W5PtSyi=w1067-h1422-s-no?authuser=0')
                            : const NetworkImage(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQaYXAEbhjwPG22qOBDO-bBDC8bUL6AEwkex1zes2-59vOp0qOk-svdY3k7TwtD6xy6cOU&usqp=CAU"),
                      ),
                      trailing: Icon(
                        PhosphorIcons.caret_right,
                        size: 20,
                        color: AppColors.primaryColor,
                      ),
                      subtitle: const Text("Kootam - Pillar Kulam"),
                      title: (index.isEven)
                          ? Text("Vicky $index")
                          : Text("Tamil $index"))),
            );
          }),
    );
  }
}
