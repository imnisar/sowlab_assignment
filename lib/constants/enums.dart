import '../config/app_utils.dart';

extension SizeExtension on num {
  double get h => CustomScreenUtil.height(toDouble());
  double get w => CustomScreenUtil.width(toDouble());
}

final Map<String, Map<String, String>> powerUpConfig = {
  "Boosting gloves": {
    "title": "Boosting Gloves",
    "description": "Increases your gift impact during this host's stream.",
    "image": "assets/images/pkBattleAssets/gloves.png",
  },
  "Magic mist": {
    "title": "Magic Mist",
    "description": "Temporarily boosts your visibility to the audience.",
    "image": "assets/images/pkBattleAssets/magic_mist.png",
  },
  "Time maker": {
    "title": "Time Maker",
    "description": "Gives you extra spotlight time during the stream.",
    "image": "assets/images/pkBattleAssets/timer_maker.png",
  },
  "Stun hammer": {
    "title": "Stun Hammer",
    "description": "Temporarily stuns others' gifts and boosts yours.",
    "image": "assets/images/pkBattleAssets/stun_hammer.png",
  },
};