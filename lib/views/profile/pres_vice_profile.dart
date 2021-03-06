import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';
import 'package:veripol/controller/my_candidate_data_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/full_name_card.dart';
import '../../components/no_information_available.dart';
import '../../components/themes.dart';
import '../../controller/data_controller.dart';
import '../../models/models.dart';

class PresidentViceCandidateProfile extends StatefulWidget {
  const PresidentViceCandidateProfile({
    Key? key,
    required this.data,
  }) : super(key: key);

  final CandidateData data;
  @override
  State<PresidentViceCandidateProfile> createState() =>
      _PresidentViceCandidateProfileState();
}

class _PresidentViceCandidateProfileState
    extends State<PresidentViceCandidateProfile> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scale = mockUpWidth / size.width;
    final textScale = size.width / mockUpWidth;
    final dataController = Provider.of<DataController>(context);
    final myCandidatesController =
        Provider.of<MyCandidatesDataController>(context);
    return Scaffold(
      backgroundColor: veripolColors.background,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Positioned(
              top: 86 / mockUpHeight * size.height,
              child: Image.asset(
                "assets/bg_pattern.png",
                scale: scale,
              ),
            ),
            DefaultTabController(
              length: 5,
              child: Container(
                width: size.width,
                height: size.height,
                padding: EdgeInsets.only(
                  top: 48 / mockUpHeight * size.height,
                ),
                child: Column(
                  children: [
                    Container(
                      width: 375 / mockUpWidth * size.width,
                      height: 56 / mockUpHeight * size.height,
                      padding: EdgeInsets.only(
                        top: 12 / mockUpHeight * size.height,
                        left: 16 / mockUpWidth * size.width,
                        right: 16 / mockUpWidth * size.width,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.arrow_back),
                            iconSize: 30 / mockUpWidth * size.width,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 32 / mockUpWidth * size.width,
                          ),
                          Text(
                            "Candidate",
                            textScaleFactor: textScale,
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                fontStyle: FontStyle.normal,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                height: 1.27,
                                letterSpacing: 0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          widget.data.filedCandidacies["May 9, 2022"]
                                      ["position"] ==
                                  "PRESIDENT"
                              ? GestureDetector(
                                  onTap: () async {
                                    if (dataController.userData["my_candidates"]
                                                ["president"] ==
                                            null ||
                                        dataController.userData["my_candidates"]
                                                ["president"] ==
                                            "") {
                                      myCandidatesController.setMyPresident(1);
                                      myCandidatesController
                                          .setMyPresidentRunTime(
                                              widget.data.id);
                                      await myCandidatesController
                                          .storeMyPresidentToDb(widget.data.id)
                                          .whenComplete(() async {
                                        await myCandidatesController
                                            .cacheMyPresident(widget.data.id)
                                            .whenComplete(() async {
                                          if (dataController.userData[
                                                          "my_candidates"]
                                                      ["president"] !=
                                                  "" &&
                                              dataController.userData[
                                                          "my_candidates"]
                                                      ["president"] !=
                                                  null) {
                                            await myCandidatesController
                                                .readPresident(
                                                    dataController.userData[
                                                            "my_candidates"]
                                                        ["president"])
                                                .whenComplete(() {
                                              myCandidatesController
                                                  .getMyPresident(
                                                      widget.data.id);
                                            });
                                          }
                                        });
                                      });
                                    } else {
                                      if (dataController
                                                  .userData["my_candidates"]
                                              ["president"] ==
                                          widget.data.id) {
                                        myCandidatesController
                                            .setMyPresident(-1);
                                        myCandidatesController
                                            .setMyPresidentRunTime("");
                                        await myCandidatesController
                                            .storeMyPresidentToDb("")
                                            .whenComplete(() async {
                                          await myCandidatesController
                                              .cacheMyPresident("");

                                          myCandidatesController
                                              .setMyPresidentDataToNull();
                                        });
                                      } else {
                                        myCandidatesController
                                            .setMyPresidentRunTime(
                                                widget.data.id);
                                        await myCandidatesController
                                            .storeMyPresidentToDb(
                                                widget.data.id)
                                            .whenComplete(() async {
                                          await myCandidatesController
                                              .cacheMyPresident(widget.data.id);
                                        });
                                        await myCandidatesController
                                            .readPresident(dataController
                                                    .userData["my_candidates"]
                                                ["president"])
                                            .whenComplete(() {
                                          myCandidatesController
                                              .getMyPresident(widget.data.id);
                                        });
                                      }
                                    }
                                  },
                                  child: dataController
                                                      .userData["my_candidates"]
                                                  ["president"] ==
                                              null ||
                                          dataController
                                                      .userData["my_candidates"]
                                                  ["president"] ==
                                              ''
                                      ? Image.asset(
                                          'assets/heart_outlined.png',
                                          scale: scale,
                                          width: 24 / mockUpWidth * size.width,
                                          height:
                                              22 / mockUpHeight * size.height,
                                        )
                                      : dataController.userData["my_candidates"]
                                                  ["president"] ==
                                              widget.data.id
                                          ? Image.asset(
                                              'assets/heart_filled.png',
                                              scale: scale,
                                              width:
                                                  24 / mockUpWidth * size.width,
                                              height: 22 /
                                                  mockUpHeight *
                                                  size.height,
                                            )
                                          : Image.asset(
                                              'assets/heart_outlined.png',
                                              scale: scale,
                                              width:
                                                  24 / mockUpWidth * size.width,
                                              height: 22 /
                                                  mockUpHeight *
                                                  size.height,
                                            ),
                                )
                              : GestureDetector(
                                  onTap: () async {
                                    if (dataController.userData["my_candidates"]
                                                ["vicePresident"] ==
                                            null ||
                                        dataController.userData["my_candidates"]
                                                ["vicePresident"] ==
                                            "") {
                                      myCandidatesController
                                          .setMyVicePresident(1);
                                      myCandidatesController
                                          .setMyVicePresidentRunTime(
                                              widget.data.id);
                                      await myCandidatesController
                                          .storeMyVicePresidentToDb(
                                              widget.data.id)
                                          .whenComplete(() async {
                                        await myCandidatesController
                                            .cacheMyVicePresident(
                                                widget.data.id);
                                        if (dataController.userData[
                                                        "my_candidates"]
                                                    ["vicePresident"] !=
                                                "" &&
                                            dataController.userData[
                                                        "my_candidates"]
                                                    ["vicePresident"] !=
                                                null) {
                                          await myCandidatesController
                                              .readVicePresident(dataController
                                                      .userData["my_candidates"]
                                                  ["vicePresident"]);
                                        }
                                      });
                                    } else {
                                      if (dataController
                                                  .userData["my_candidates"]
                                              ["vicePresident"] ==
                                          widget.data.id) {
                                        myCandidatesController
                                            .setMyVicePresident(-1);
                                        myCandidatesController
                                            .setMyVicePresidentRunTime("");
                                        await myCandidatesController
                                            .storeMyVicePresidentToDb("")
                                            .whenComplete(() async {
                                          await myCandidatesController
                                              .cacheMyVicePresident("");
                                          myCandidatesController
                                              .setMyVicePresidentDataToNull();
                                        });
                                      } else {
                                        myCandidatesController
                                            .setMyVicePresidentRunTime(
                                                widget.data.id);
                                        await myCandidatesController
                                            .storeMyVicePresidentToDb(
                                                widget.data.id)
                                            .whenComplete(() async {
                                          await myCandidatesController
                                              .cacheMyVicePresident(
                                                  widget.data.id);
                                          await myCandidatesController
                                              .readVicePresident(dataController
                                                      .userData["my_candidates"]
                                                  ["vicePresident"]);
                                        });
                                      }
                                    }
                                  },
                                  child: dataController
                                                      .userData["my_candidates"]
                                                  ["vicePresident"] ==
                                              null ||
                                          dataController
                                                      .userData["my_candidates"]
                                                  ["vicePresident"] ==
                                              ''
                                      ? Image.asset(
                                          'assets/heart_outlined.png',
                                          scale: scale,
                                          width: 24 / mockUpWidth * size.width,
                                          height:
                                              22 / mockUpHeight * size.height,
                                        )
                                      : dataController.userData["my_candidates"]
                                                  ["vicePresident"] ==
                                              widget.data.id
                                          ? Image.asset(
                                              'assets/heart_filled.png',
                                              scale: scale,
                                              width:
                                                  24 / mockUpWidth * size.width,
                                              height: 22 /
                                                  mockUpHeight *
                                                  size.height,
                                            )
                                          : Image.asset(
                                              'assets/heart_outlined.png',
                                              scale: scale,
                                              width:
                                                  24 / mockUpWidth * size.width,
                                              height: 22 /
                                                  mockUpHeight *
                                                  size.height,
                                            ),
                                ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: size.width,
                      height: size.height - 104 / mockUpHeight * size.height,
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          Container(
                            width: size.width,
                            decoration: const BoxDecoration(
                              color: Color(0xff141414),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned(
                                  top: -30 / mockUpHeight * size.height,
                                  right: -10 / mockUpWidth * size.width,
                                  child: Text(
                                    "#" +
                                        widget
                                            .data
                                            .filedCandidacies["May 9, 2022"]
                                                ["ballot_number"]
                                            .toString(),
                                    textScaleFactor: textScale,
                                    style: TextStyle(
                                      fontFamily: "MountainScript",
                                      fontSize: 150,
                                      fontWeight: FontWeight.w400,
                                      height: 1.467,
                                      letterSpacing: 0.06,
                                      color: Colors.white.withOpacity(0.10),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          height:
                                              24 / mockUpHeight * size.height),
                                      Text(
                                        "CAMPAIGNING FOR",
                                        style: veripolTextStyles.labelSmall
                                            .copyWith(
                                          color: const Color(0xffFFFFF0),
                                        ),
                                      ),
                                      Text(
                                        widget.data.filedCandidacies[
                                                        "May 9, 2022"]
                                                    ["position"] ==
                                                "PRESIDENT"
                                            ? "President of the Philippines"
                                            : "Vice President of the Philippines",
                                        textScaleFactor: textScale,
                                        style: veripolTextStyles.titleMedium
                                            .copyWith(
                                          color: const Color(0xffFFFFF0),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10 / mockUpHeight * size.height,
                                      ),
                                      Container(
                                        width: 105 / mockUpWidth * size.width,
                                        height: 105 / mockUpWidth * size.width,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              offset: Offset(
                                                  0,
                                                  8 /
                                                      mockUpHeight *
                                                      size.height),
                                              blurRadius:
                                                  12 / mockUpWidth * size.width,
                                              spreadRadius:
                                                  6 / mockUpWidth * size.width,
                                              color: Colors.black
                                                  .withOpacity(0.15),
                                            ),
                                            BoxShadow(
                                              offset: Offset(
                                                  0,
                                                  4 /
                                                      mockUpHeight *
                                                      size.height),
                                              blurRadius:
                                                  4 / mockUpWidth * size.width,
                                              spreadRadius: 0,
                                              color: Colors.black
                                                  .withOpacity(0.30),
                                            ),
                                          ],
                                          image: const DecorationImage(
                                            image: AssetImage(
                                              "assets/default_profile_img.png",
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 19 / mockUpHeight * size.height,
                                      ),
                                      Text(
                                        widget
                                                .data
                                                .filedCandidacies["May 9, 2022"]
                                                    ["ballot_number"]
                                                .toString() +
                                            ". " +
                                            widget.data.filedCandidacies[
                                                "May 9, 2022"]["ballot_name"],
                                        textScaleFactor: textScale,
                                        style: veripolTextStyles.titleMedium
                                            .copyWith(
                                          color: const Color(0xffFFFFF0),
                                        ),
                                      ),
                                      Text(
                                        widget.data
                                                .filedCandidacies["May 9, 2022"]
                                            ["political_party"],
                                        textAlign: TextAlign.center,
                                        textScaleFactor: textScale,
                                        style: veripolTextStyles.titleSmall
                                            .copyWith(
                                          color: const Color(0xffFFFFF0),
                                        ),
                                      ),
                                      SizedBox(
                                          height:
                                              29 / mockUpHeight * size.height),
                                      SizedBox(
                                        height: 26 / mockUpHeight * size.height,
                                        child: TabBar(
                                          labelPadding: EdgeInsets.zero,
                                          padding: EdgeInsets.zero,
                                          indicatorColor:
                                              veripolColors.sunYellow,
                                          indicatorSize:
                                              TabBarIndicatorSize.label,
                                          indicatorWeight:
                                              5 / mockUpHeight * size.height,
                                          isScrollable: true,
                                          unselectedLabelColor:
                                              Colors.white.withOpacity(0.50),
                                          labelColor: veripolColors.sunYellow,
                                          tabs: [
                                            Container(
                                              width: 125 /
                                                  mockUpWidth *
                                                  size.width,
                                              padding: EdgeInsets.only(
                                                bottom: 5 /
                                                    mockUpHeight *
                                                    size.height,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Overview",
                                                  style: veripolTextStyles
                                                      .labelMedium,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 125 /
                                                  mockUpWidth *
                                                  size.width,
                                              padding: EdgeInsets.only(
                                                bottom: 5 /
                                                    mockUpHeight *
                                                    size.height,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Platforms",
                                                  style: veripolTextStyles
                                                      .labelMedium,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 125 /
                                                  mockUpWidth *
                                                  size.width,
                                              padding: EdgeInsets.only(
                                                bottom: 5 /
                                                    mockUpHeight *
                                                    size.height,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Accomplishments",
                                                  style: veripolTextStyles
                                                      .labelMedium,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 125 /
                                                  mockUpWidth *
                                                  size.width,
                                              padding: EdgeInsets.only(
                                                bottom: 5 /
                                                    mockUpHeight *
                                                    size.height,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Advocacies",
                                                  style: veripolTextStyles
                                                      .labelMedium,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 153 /
                                                  mockUpWidth *
                                                  size.width,
                                              padding: EdgeInsets.only(
                                                bottom: 5 /
                                                    mockUpHeight *
                                                    size.height,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Relevant Exeperiences",
                                                  style: veripolTextStyles
                                                      .labelMedium,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: size.width,
                            height:
                                size.height - 395 / mockUpHeight * size.height,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: TabBarView(
                                    children: [
                                      //  ABOUT THE CANDIDATE
                                      ListView(
                                        padding: EdgeInsets.symmetric(
                                          vertical:
                                              20 / mockUpHeight * size.height,
                                        ),
                                        children: [
                                          Container(
                                            width: size.width,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10 /
                                                    mockUpWidth *
                                                    size.width),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "About the the Candidate",
                                                  textScaleFactor: textScale,
                                                  style: veripolTextStyles
                                                      .labelLarge
                                                      .copyWith(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5 /
                                                      mockUpWidth *
                                                      size.width,
                                                ),
                                                Expanded(
                                                  child: Divider(
                                                    height: 20 /
                                                        mockUpHeight *
                                                        size.height,
                                                    thickness: 1 /
                                                        mockUpHeight *
                                                        size.height,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height:
                                                10 / mockUpHeight * size.height,
                                          ),
                                          widget.data.name != ""
                                              ? FullNameCard(
                                                  fullName: widget.data.name)
                                              : const NoInformationAvailable(),
                                        ],
                                      ),

                                      //  PLATFORMS

                                      ListView(
                                        padding: EdgeInsets.symmetric(
                                          vertical:
                                              20 / mockUpHeight * size.height,
                                        ),
                                        children: [
                                          Container(
                                            width: size.width,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10 /
                                                    mockUpWidth *
                                                    size.width),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Platforms",
                                                  textScaleFactor: textScale,
                                                  style: veripolTextStyles
                                                      .labelLarge
                                                      .copyWith(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5 /
                                                      mockUpWidth *
                                                      size.width,
                                                ),
                                                Expanded(
                                                  child: Divider(
                                                    height: 20 /
                                                        mockUpHeight *
                                                        size.height,
                                                    thickness: 1 /
                                                        mockUpHeight *
                                                        size.height,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height:
                                                10 / mockUpHeight * size.height,
                                          ),
                                          const NoInformationAvailable(),
                                        ],
                                      ),

                                      // ACCOMPLISHMENTS

                                      ListView(
                                        padding: EdgeInsets.symmetric(
                                          vertical:
                                              20 / mockUpHeight * size.height,
                                        ),
                                        children: [
                                          Container(
                                            width: size.width,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10 /
                                                    mockUpWidth *
                                                    size.width),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Overview",
                                                  textScaleFactor: textScale,
                                                  style: veripolTextStyles
                                                      .labelLarge
                                                      .copyWith(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5 /
                                                      mockUpWidth *
                                                      size.width,
                                                ),
                                                Expanded(
                                                  child: Divider(
                                                    height: 20 /
                                                        mockUpHeight *
                                                        size.height,
                                                    thickness: 1 /
                                                        mockUpHeight *
                                                        size.height,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height:
                                                10 / mockUpHeight * size.height,
                                          ),
                                          const NoInformationAvailable(),
                                          SizedBox(
                                            height:
                                                20 / mockUpHeight * size.height,
                                          ),
                                          Container(
                                            width: size.width,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10 /
                                                    mockUpWidth *
                                                    size.width),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Major Accomplishments",
                                                  textScaleFactor: textScale,
                                                  style: veripolTextStyles
                                                      .labelLarge
                                                      .copyWith(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5 /
                                                      mockUpWidth *
                                                      size.width,
                                                ),
                                                Expanded(
                                                  child: Divider(
                                                    height: 20 /
                                                        mockUpHeight *
                                                        size.height,
                                                    thickness: 1 /
                                                        mockUpHeight *
                                                        size.height,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height:
                                                10 / mockUpHeight * size.height,
                                          ),
                                          const NoInformationAvailable(),
                                        ],
                                      ),

                                      // Advocacies

                                      ListView(
                                        padding: EdgeInsets.symmetric(
                                          vertical:
                                              20 / mockUpHeight * size.height,
                                        ),
                                        children: [
                                          Container(
                                            width: size.width,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10 /
                                                    mockUpWidth *
                                                    size.width),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Major Advocacies",
                                                  textScaleFactor: textScale,
                                                  style: veripolTextStyles
                                                      .labelLarge
                                                      .copyWith(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5 /
                                                      mockUpWidth *
                                                      size.width,
                                                ),
                                                Expanded(
                                                  child: Divider(
                                                    height: 20 /
                                                        mockUpHeight *
                                                        size.height,
                                                    thickness: 1 /
                                                        mockUpHeight *
                                                        size.height,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height:
                                                10 / mockUpHeight * size.height,
                                          ),
                                          const NoInformationAvailable(),
                                        ],
                                      ),

                                      // Relevant Experiences

                                      ListView(
                                        padding: EdgeInsets.symmetric(
                                          vertical:
                                              20 / mockUpHeight * size.height,
                                        ),
                                        children: [
                                          Container(
                                            width: size.width,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10 /
                                                    mockUpWidth *
                                                    size.width),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Relevant Experiences",
                                                  textScaleFactor: textScale,
                                                  style: veripolTextStyles
                                                      .labelLarge
                                                      .copyWith(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5 /
                                                      mockUpWidth *
                                                      size.width,
                                                ),
                                                Expanded(
                                                  child: Divider(
                                                    height: 20 /
                                                        mockUpHeight *
                                                        size.height,
                                                    thickness: 1 /
                                                        mockUpHeight *
                                                        size.height,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height:
                                                10 / mockUpHeight * size.height,
                                          ),
                                          const NoInformationAvailable(),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 15 / mockUpHeight * size.height),
                                  child: InkWell(
                                    onTap: () async {
                                      final query = widget.data.name
                                          .replaceAll(",", "")
                                          .split(" ")
                                          .join("+");
                                      final url =
                                          "https://www.google.com/search?q=$query";
                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      }
                                    },
                                    child: Container(
                                      width: 345 / mockUpWidth * size.width,
                                      height: 60 / mockUpHeight * size.height,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 4),
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.transparent,
                                      ),
                                      child: Center(
                                        child: SizedBox(
                                          width: 250 / mockUpWidth * size.width,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Search Candidate on Google',
                                                textScaleFactor: textScale,
                                                style: veripolTextStyles
                                                    .labelLarge
                                                    .copyWith(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Image.asset(
                                                  'assets/google_logo.png')
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 30 / mockUpHeight * size.height),
                                  child: InkWell(
                                    onTap: () async {
                                      final url = widget.data.profileURL;
                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      }
                                    },
                                    child: Container(
                                      width: 345 / mockUpWidth * size.width,
                                      height: 60 / mockUpHeight * size.height,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 4),
                                        borderRadius: BorderRadius.circular(5),
                                        color: const Color(0xFF141414),
                                      ),
                                      child: Center(
                                        child: SizedBox(
                                          width: 280 / mockUpWidth * size.width,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'View Candidate Dashboard on',
                                                textScaleFactor: textScale,
                                                style: veripolTextStyles
                                                    .labelLarge
                                                    .copyWith(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Image.asset(
                                                  'assets/votepilipinas_logo.png')
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
