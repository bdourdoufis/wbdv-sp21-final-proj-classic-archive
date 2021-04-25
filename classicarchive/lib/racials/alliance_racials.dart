import 'package:classicarchive/racials/racial_card.dart';
import 'package:classicarchive/racials/racial_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A [RacialsPage] which will contain information regarding Alliance races.
/// Since the [RacialsPage] is generic, all we need to do here is override
/// the initializeRaces() and initailizeBackround() methods in the state,
/// and pass in the Alliance-specific data.
class AllianceRacialsPage extends RacialsPage {
  @override
  _AllianceRacialsPageState createState() => _AllianceRacialsPageState();
}

/// The state of an [AllianceRacialsPage].
class _AllianceRacialsPageState extends RacialsPageState {
  @override
  void initState() {
    super.initState();
  }

  @override
  void initializeBackground() {
    background = AssetImage("assets/images/stormwind.jpg");
  }

  @override
  void initializeRaces() {
    races = [];
    races.add(Race(
        name: "Human",
        raceIcon: AssetImage("assets/images/race_human_male.jpg"),
        homeCity: "Stormwind",
        racials: [
          RacialAbility(
            name: "Diplomacy",
            icon: AssetImage("assets/images/human_racial_diplomacy.jpg"),
            description: "Reputation gains increased by 10%.",
          ),
          RacialAbility(
            name: "Mace Specialization",
            icon: AssetImage("assets/images/human_racial_mace.jpg"),
            description:
                "Skill with Maces and Two-Handed Maces increased by 5.",
          ),
          RacialAbility(
            name: "Perception",
            icon: AssetImage("assets/images/human_racial_perception.jpg"),
            description: "Dramatically increases stealth detection for 20 sec.",
          ),
          RacialAbility(
            name: "Sword Specialization",
            icon: AssetImage("assets/images/human_racial_sword.jpg"),
            description:
                "Skill with Swords and Two-Handed Swords increased by 5.",
          ),
          RacialAbility(
            name: "The Human Spirit",
            icon: AssetImage("assets/images/human_racial_spirit.jpg"),
            description: "Spirit increased by 5%.",
          ),
        ]));
    races.add(Race(
        name: "Dwarf",
        raceIcon: AssetImage("assets/images/race_dwarf_male.jpg"),
        homeCity: "Ironforge",
        racials: [
          RacialAbility(
            name: "Find Treasure",
            icon: AssetImage("assets/images/dwarf_racial_treasure.jpg"),
            description:
                "Allows the dwarf to sense nearby treasure, making it appear on the minimap.",
          ),
          RacialAbility(
            name: "Frost Resistance",
            icon: AssetImage("assets/images/dwarf_racial_frost.jpg"),
            description: "Increases Frost Resistance by 10.",
          ),
          RacialAbility(
            name: "Gun Specialization",
            icon: AssetImage("assets/images/dwarf_racial_gun.jpg"),
            description: "Guns skill increased by 5.",
          ),
          RacialAbility(
            name: "Stoneform",
            icon: AssetImage("assets/images/dwarf_racial_stoneform.jpg"),
            description:
                "While active, grants immunity to Bleed, Poison, and Disease effects. In addition, Armor increased by 10%. Lasts 8 sec.",
          )
        ]));
    races.add(Race(
        name: "Gnome",
        raceIcon: AssetImage("assets/images/race_gnome_male.jpg"),
        homeCity: "Gnomeregan",
        racials: [
          RacialAbility(
            name: "Arcane Resistance",
            icon: AssetImage("assets/images/gnome_racial_arcane.jpg"),
            description: "Arcane Resistance increased by 10.",
          ),
          RacialAbility(
            name: "Expansive Mind",
            icon: AssetImage("assets/images/gnome_racial_expansive.jpg"),
            description: "Intelligence increased by 5%.",
          ),
          RacialAbility(
            name: "Engineering Specialization",
            icon: AssetImage("assets/images/gnome_racial_engineering.jpg"),
            description: "Engineering skill increased by 15.",
          ),
          RacialAbility(
            name: "Escape Artist",
            icon: AssetImage("assets/images/gnome_racial_escape.jpg"),
            description:
                "Escape the effects of any immobilization or movement speed reduction effect.",
          )
        ]));
    races.add(Race(
        name: "Night Elf",
        raceIcon: AssetImage("assets/images/race_nightelf_male.jpg"),
        homeCity: "Darnassus",
        racials: [
          RacialAbility(
            name: "Nature Resistance",
            icon: AssetImage("assets/images/tauren_racial_nature.jpg"),
            description: "Nature Resistance increased by 10.",
          ),
          RacialAbility(
            name: "Wisp Spirit",
            icon: AssetImage("assets/images/nelf_racial_wisp.jpg"),
            description:
                "Transform into a wisp upon death, increasing movement speed by 50%.",
          ),
          RacialAbility(
            name: "Quickness",
            icon: AssetImage("assets/images/nelf_racial_quickness.jpg"),
            description: "Dodge chance increased by 1%.",
          ),
          RacialAbility(
            name: "Shadowmeld",
            icon: AssetImage("assets/images/nelf_racial_shadowmeld.jpg"),
            description:
                "Activate to slip into the shadows, reducing the chance for enemies to detect your presence. Lasts until cancelled or upon moving. Night Elf Rogues and Druids with Shadowmeld are more difficult to detect while stealthed or prowling.",
          )
        ]));
  }
}
