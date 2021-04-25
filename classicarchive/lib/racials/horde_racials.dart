import 'package:classicarchive/racials/racial_card.dart';
import 'package:classicarchive/racials/racial_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HordeRacialsPage extends RacialsPage {
  @override
  _HordeRacialsPageState createState() => _HordeRacialsPageState();
}

class _HordeRacialsPageState extends RacialsPageState {
  @override
  void initState() {
    super.initState();
  }

  @override
  void initializeBackground() {
    background = AssetImage("assets/images/orgrimmar.jpg");
  }

  @override
  void initializeRaces() {
    races = [];
    races.add(Race(
        name: "Orc",
        raceIcon: AssetImage("assets/images/race_orc_male.jpg"),
        homeCity: "Orgrimmar",
        racials: [
          RacialAbility(
            name: "Axe Specialization",
            icon: AssetImage("assets/images/orc_racial_axe.jpg"),
            description: "Skill with Axes and Two-Handed Axes increased by 5.",
          ),
          RacialAbility(
            name: "Blood Fury",
            icon: AssetImage("assets/images/orc_racial_blood.jpg"),
            description:
                "Increases base melee attack power by 25% for 15 sec and reduces healing effects on you by 50% for 25 sec.",
          ),
          RacialAbility(
            name: "Command",
            icon: AssetImage("assets/images/orc_racial_command.jpg"),
            description:
                "Damage dealt by Hunter and Warlock pets increased by 5%.",
          ),
          RacialAbility(
            name: "Hardiness",
            icon: AssetImage("assets/images/orc_racial_hardiness.jpg"),
            description:
                "Chance to resist Stun effects increased by an additional 25%.",
          ),
        ]));
    races.add(Race(
        name: "Troll",
        raceIcon: AssetImage("assets/images/race_troll_male.jpg"),
        homeCity: "Orgrimmar",
        racials: [
          RacialAbility(
            name: "Beast Slaying",
            icon: AssetImage("assets/images/troll_racial_beast.jpg"),
            description: "Damage dealt versus Beasts increased by 5%.",
          ),
          RacialAbility(
            name: "Berserking",
            icon: AssetImage("assets/images/troll_racial_berserking.jpg"),
            description:
                "Increases your casting and attack speed by 10% to 30%. At full health the speed increase is 10% with a greater effect up to 30% if you are badly hurt when you activate Berserking. Lasts 10 sec.",
          ),
          RacialAbility(
            name: "Bow Specialization",
            icon: AssetImage("assets/images/troll_racial_bow.jpg"),
            description: "Skill with Bow Weapons increased by 5.",
          ),
          RacialAbility(
            name: "Regeneration",
            icon: AssetImage("assets/images/troll_racial_regeneration.jpg"),
            description:
                "Health regeneration rate increased by 10%. 10% of total Health regeneration may continue during combat.",
          ),
          RacialAbility(
            name: "Throwing Specialization",
            icon: AssetImage("assets/images/troll_racial_throwing.jpg"),
            description: "Skill with Throwing Weapons increased by 5.",
          ),
        ]));
    races.add(Race(
        name: "Tauren",
        raceIcon: AssetImage("assets/images/race_tauren_male.jpg"),
        homeCity: "Thunder Bluff",
        racials: [
          RacialAbility(
            name: "Cultivation",
            icon: AssetImage("assets/images/tauren_racial_cultivation.jpg"),
            description: "Herbalism skill increased by 15.",
          ),
          RacialAbility(
            name: "Endurance",
            icon: AssetImage("assets/images/tauren_racial_endurance.jpg"),
            description: "Total Health increased by 5%.",
          ),
          RacialAbility(
            name: "Nature Resistance",
            icon: AssetImage("assets/images/tauren_racial_nature.jpg"),
            description: "Nature Resistance increased by 10.",
          ),
          RacialAbility(
            name: "War Stomp",
            icon: AssetImage("assets/images/tauren_racial_war.jpg"),
            description: "Stuns up to 5 enemies within 8 yds for 2 sec.",
          )
        ]));
    races.add(Race(
        name: "Undead",
        raceIcon: AssetImage("assets/images/race_forsaken_male.jpg"),
        homeCity: "The Undercity",
        racials: [
          RacialAbility(
            name: "Cannibalize",
            icon: AssetImage("assets/images/undead_racial_cannibalize.jpg"),
            description:
                "When activated, regenerates 7% of total health every 2 sec for 10 sec. Only works on Humanoid or Undead corpses within 5 yds. Any movement, action, or damage taken while Cannibalizing will cancel the effect.",
          ),
          RacialAbility(
            name: "Shadow Resistance",
            icon: AssetImage("assets/images/undead_racial_shadow.jpg"),
            description: "Shadow Resistance increased by 10.",
          ),
          RacialAbility(
            name: "Underwater Breathing",
            icon: AssetImage("assets/images/undead_racial_underwater.jpg"),
            description: "Underwater breath lasts 300% longer than normal.",
          ),
          RacialAbility(
            name: "Will of the Forsaken",
            icon: AssetImage("assets/images/undead_racial_will.jpg"),
            description:
                "Provides immunity to Charm, Fear and Sleep while active. May also be used while already afflicted by Charm, Fear or Sleep. Lasts 5 sec.",
          )
        ]));
  }
}
