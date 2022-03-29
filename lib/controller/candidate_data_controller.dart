import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:veripol/models/models.dart';

class CandidateDataController extends ChangeNotifier {
  Map<String, dynamic> _mappedData = {};
  List<CandidateData> _candidates = [];
  void readCandidateJson() async {
    final String response =
        await rootBundle.loadString('assets/data/narrowed_data.json');
    final data = await json.decode(response);

    _mappedData = data;
  }

  List<CandidateData> getPresidents() {
    List<CandidateData> temp = [];
    for (var candidate in _mappedData["candidate_data"]) {
      if (candidate["filed_candidacies"][0]["position"] == "PRESIDENT") {
        temp.add(
          CandidateData(
              id: candidate["id"],
              name: candidate["name"],
              sex: candidate["sex"] ?? "",
              imgURL: candidate["imgURL"] ?? "",
              filedCandidacies: candidate["filed_candidacies"] ?? [],
              searchKeys: candidate["search_keys"][0] ?? [],
              houseBills: candidate["housebills"] ?? [],
              senateBills: candidate["senatebills"] ?? []),
        );
      }
    }
    _candidates = temp;
    return _candidates;
  }

  List<CandidateData> getVicePresidents() {
    List<CandidateData> temp = [];
    for (var candidate in _mappedData["candidate_data"]) {
      if (candidate["filed_candidacies"][0]["position"] == "VICE-PRESIDENT") {
        temp.add(
          CandidateData(
              id: candidate["id"],
              name: candidate["name"],
              sex: candidate["sex"] ?? "",
              imgURL: candidate["imgURL"] ?? "",
              filedCandidacies: candidate["filed_candidacies"] ?? [],
              searchKeys: candidate["search_keys"][0] ?? [],
              houseBills: candidate["housebills"] ?? [],
              senateBills: candidate["senatebills"] ?? []),
        );
      }
    }

    _candidates = temp;
    return _candidates;
  }

  List<CandidateData> getSenators() {
    List<CandidateData> temp = [];
    for (var candidate in _mappedData["candidate_data"]) {
      if (candidate["filed_candidacies"][0]["position"] == "SENATOR") {
        temp.add(
          CandidateData(
              id: candidate["id"],
              name: candidate["name"],
              sex: candidate["sex"] ?? "",
              imgURL: candidate["imgURL"] ?? "",
              filedCandidacies: candidate["filed_candidacies"] ?? [],
              searchKeys: candidate["search_keys"][0] ?? [],
              houseBills: candidate["housebills"] ?? [],
              senateBills: candidate["senatebills"] ?? []),
        );
      }
    }

    _candidates = temp;
    return _candidates;
  }

  List<CandidateData> getPartyLists() {
    List<CandidateData> temp = [];
    for (var candidate in _mappedData["candidate_data"]) {
      if (candidate["filed_candidacies"][0]["position"] == "PARTY LIST") {
        temp.add(
          CandidateData(
            id: candidate["id"],
            name: candidate["name"] ?? "",
            sex: candidate["sex"] ?? "",
            imgURL: candidate["imgURL"] ?? "",
            filedCandidacies: candidate["filed_candidacies"] ?? [],
            searchKeys: candidate["search_keys"][0] ?? [],
            houseBills: candidate["housebills"] ?? [],
            senateBills: candidate["senatebills"] ?? [],
          ),
        );
      }
    }

    _candidates = temp;
    return _candidates;
  }

  List<CandidateData> getMayor(String province, String city) {
    List<CandidateData> temp = [];
    for (var candidate in _mappedData["candidate_data"]) {
      if (candidate["filed_candidacies"][0]["position"] == "MAYOR" &&
          candidate["filed_candidacies"][0]["location"]["province"] ==
              province.toUpperCase() &&
          candidate["filed_candidacies"][0]["location"]["municipality"] ==
              city.toUpperCase()) {
        temp.add(
          CandidateData(
            id: candidate["id"],
            name: candidate["name"] ?? "",
            sex: candidate["sex"] ?? "",
            imgURL: candidate["imgURL"] ?? "",
            filedCandidacies: candidate["filed_candidacies"] ?? [],
            searchKeys: candidate["search_keys"][0] ?? [],
            houseBills: candidate["housebills"] ?? [],
            senateBills: candidate["senatebills"] ?? [],
          ),
        );
      }
    }
    _candidates = temp;
    return _candidates;
  }

  List<CandidateData> getViceMayors(String province, String city) {
    List<CandidateData> temp = [];
    for (var candidate in _mappedData["candidate_data"]) {
      if (candidate["filed_candidacies"][0]["position"] == "VICE-MAYOR" &&
          candidate["filed_candidacies"][0]["location"]["province"] ==
              province.toUpperCase() &&
          candidate["filed_candidacies"][0]["location"]["municipality"] ==
              city.toUpperCase()) {
        temp.add(
          CandidateData(
            id: candidate["id"],
            name: candidate["name"] ?? "",
            sex: candidate["sex"] ?? "",
            imgURL: candidate["imgURL"] ?? "",
            filedCandidacies: candidate["filed_candidacies"] ?? [],
            searchKeys: candidate["search_keys"][0] ?? [],
            houseBills: candidate["housebills"] ?? [],
            senateBills: candidate["senatebills"] ?? [],
          ),
        );
      }
    }

    _candidates = temp;
    return _candidates;
  }

  List<CandidateData> getCouncilors(String province, String city) {
    List<CandidateData> temp = [];
    for (var candidate in _mappedData["candidate_data"]) {
      if (candidate["filed_candidacies"][0]["position"] == "VICE-MAYOR" &&
          candidate["filed_candidacies"][0]["location"]["province"] ==
              province.toUpperCase() &&
          candidate["filed_candidacies"][0]["location"]["municipality"] ==
              city.toUpperCase()) {
        temp.add(
          CandidateData(
            id: candidate["id"],
            name: candidate["name"] ?? "",
            sex: candidate["sex"] ?? "",
            imgURL: candidate["imgURL"] ?? "",
            filedCandidacies: candidate["filed_candidacies"] ?? [],
            searchKeys: candidate["search_keys"][0] ?? [],
            houseBills: candidate["housebills"] ?? [],
            senateBills: candidate["senatebills"] ?? [],
          ),
        );
      }
    }

    _candidates = temp;
    return _candidates;
  }

  clearRunTimeData() {
    _mappedData.clear();
    _candidates.clear();
  }
}
