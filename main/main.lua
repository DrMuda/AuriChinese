local AuriChinese = RegisterMod("Auri Chinese", 1)

print("Auri Chinese mod EID load!")
if EID and AuriMod then
  local Auriz = Aurimod
  EID:setModIndicatorName("Little Auri")

  EID:addBirthright(Isaac.GetPlayerTypeByName("Auri"),
    "光明之冠的效果始终激活#{{ColorRed}}当她在有空心容器时拾取红心，则失去该效果。",
    "Auri", "zh_cn")
  EID:addBirthright(Isaac.GetPlayerTypeByName("Dark Auri"), "尚未实现。", "Auri-黑暗", "zh_cn")
  EID:addBirthright(Isaac.GetPlayerTypeByName("Mage Auri"),
    "魔法书现在会使 Auri-巫师 在激活它时发射出火焰", "Auri-巫师", "zh_cn")
  EID:addBirthright(Isaac.GetPlayerTypeByName("Milcah"),
    "濒死效果在她只有一颗心时激活，而不是半颗心。", "Auri-暗影公主", "zh_cn")
  EID:addBirthright(Isaac.GetPlayerTypeByName("Dark Princess Auri Tainted"), "不！", "Auri-堕化黑暗公主",
    "zh_cn")
  EID:addBirthright(Isaac.GetPlayerTypeByName("Naamah"), "增加 10% 概率发射心型眼泪", "Naamah", "zh_cn")

  EID:addTrinket(TrinketType.TRINKET_AURI_CROWN,
    "伤害x1.5#{{ColorRed}}当角色受到伤害时会被摧毁(不包括献祭之类的自伤)", "Auri的王冠",
    "zh_cn")
  EID:addTrinket(TrinketType.TRINKET_CROWN_OF_DEATH,
    "{{Warning}}{{Warning}}{{Warning}} #获得伤害提升*2.5#{{ColorRed}}受到伤害将立即导致角色死亡#{{ColorRed}}持有时有几率自动吞噬自己",
    "死亡王冠", "zh_cn")
  EID:addTrinket(TrinketType.TRINKET_ENCHANT_PENNY, "捡到硬币时25%几率获得 {{Luck}}+0.5 幸运",
    "魔法硬币", "zh_cn")
  EID:addTrinket(TrinketType.TRINKET_AURI_HAIR_CLIP,
    "进入房间时，有几率魅惑敌人 #{{ColorGreen}}这个效果被激活的几率取决于你的运气属性",
    "Auri的发卡", "zh_cn")
  EID:addTrinket(TrinketType.TRINKET_FIRE_SPELL_SCROLL, "进入房间时有几率激活火焰魔法书效果",
    "火焰魔法书书页", "zh_cn")
  EID:addTrinket(TrinketType.TRINKET_SOUL_PENNY, "当捡起硬币时，有25%几率生成一个小幽灵之火跟班",
    "灵魂硬币", "zh_cn")
  EID:addTrinket(TrinketType.TRINKET_MORPH_PENNY, "当捡起硬币时，有25%几率生成一个迷你以撒跟班",
    "形体硬币", "zh_cn")
  EID:addTrinket(TrinketType.TRINKET_MINE_PENNY,
    "捡到粘性镍币时100%几率产生爆炸 #捡到硬币时50%几率产生爆炸 #捡到幸运硬币或镍币时0%几率产生爆炸",
    "爆炸硬币", "zh_cn")
  EID:addTrinket(TrinketType.TRINKET_LESSER_KEY,
    "当捡起钥匙时，有12%几率生成1个被动道具火焰跟班（所罗门魔典）#50%几率获得金钥匙",
    "灵异钥匙", "zh_cn")
  EID:addTrinket(TrinketType.TRINKET_CHALLENGE_CROWN,
    "连续两个楼层没有受伤，则获得奖励#{{Warning}} {{ColorRed}}需要带着这个饰品进入 Boss 房间，如果跳过 Boss 房间，则不会计数",
    "挑战王冠", "zh_cn")
  EID:addTrinket(TrinketType.TRINKET_GLOWING_ORB, "运气 ↑ +3 #随机显示财富词条", "发光球体", "zh_cn")

  EID:addTrinket(TrinketType.TRINKET_DARK_PENNY,
    "{{ColorPurple}}{{Blank}} 黑暗饰品#{{ColorPurple}}捡到硬币时有概率获得破碎的心或+0.1 的伤害#{{ColorPurple}}捡到硬币时有低概率吞掉该饰品",
    "黑暗硬币", "zh_cn")
  EID:addTrinket(TrinketType.TRINKET_DARK_HEART,
    "{{ColorPurple}}{{Blank}} 黑暗饰品#{{ColorPurple}}每次进入新楼层时，给予角色 +1 破碎的心和 +0.5 伤害",
    "黑暗的心", "zh_cn")
  EID:addTrinket(TrinketType.TRINKET_DARK_AURI_CROWN,
    "{{ColorPurple}}{{Blank}} 黑暗饰品#{{ColorPurple}}受到伤害时有 50% 几率获得 +1 破碎的心#每个破碎的心会增加 +0.5 伤害",
    "'Auri-黑暗'的王冠", "zh_cn")

  EID:addCollectible(COLLECTIBLE_BROKEN_GLOWING_HOURGLASS, "1/9的几率回溯时间(沙漏)", "破碎的发光沙漏",
    "zh_cn")
  EID:addCollectible(COLLECTIBLE_DARK_GLOWING_HOURGLASS,
    "{{ColorPurple}}{{Blank}} 黑暗物品#{{ColorPurple}}使用时在当前房间受到伤害时不会回溯时间",
    "黑暗沙漏", "zh_cn")

  EID:addCollectible(COLLECTIBLE_CORRUPTED_DATA, "生成一个错误道具", "被腐化的数据块", "zh_cn")
  EID:addCollectible(COLLECTIBLE_THE_MEMORY,
    "{{ArrowUp}}+射速、伤害、运气 #+5魂心 #{{ColorSilver}}在角色身旁生成迷你以撒进行战斗",
    "回忆", "zh_cn")
  EID:addCollectible(COLLECTIBLE_ENCHANTED_BOOK,
    "使用后，给予 {{Luck}} +2 幸运提升，效果持续到当前楼层", "魔法书", "zh_cn")
  EID:addCollectible(COLLECTIBLE_BLOODY_HOURGLASS,
    "使用后，消耗 1 颗红心，并在当前房间内提供 #{{TearsSmall}} +0.9 射速和 #{{SpeedSmall}} +0.05 移速（可叠加）#{{Heart}} 当清除房间时，如果激活了此物品，将为恢复已花费的一半红心#{{ColorRed}} 激活时当前房间的速度提升(坏表加速效果)",
    "染血沙漏", "zh_cn")

  EID:addCollectible(COLLECTIBLE_PRINCESS_BOX,
    "只能用一次 {{Warning}}{{Warning}}{{Warning}} #80% 几率生成 染血王冠、邪恶王冠、神圣王冠 #30% 几率生成 破碎王冠 #25% 几率生成 恶魔王冠 #15% 几率生成 盛装男孩 #9% 几率生成 Auri王冠、黑暗王冠、挑战王冠 #5% 几率生成 光明王冠、黑王子王冠 #3% 几率生成 死亡王冠 #1% 几率生成 错误王冠",
    "王冠之盒", "zh_cn")
  EID:addCollectible(COLLECTIBLE_MAGE_HAT, "{{ArrowUp}} +5 幸运#{{ArrowUp}} +1 魂芯", "巫师帽", "zh_cn")
  EID:addCollectible(COLLECTIBLE_MAGE_ROBE,
    "{{ArrowUp}} +1 幸运#{{ArrowUp}}+1 魂心#{{ArrowUp}}增加一半幸运值的攻击力", "巫师袍", "zh_cn")
  EID:addCollectible(COLLECTIBLE_WAIT_A_SEC,
    "生成一个友好的便便# 可以生成任何类型的友好便便，具体取决于角色拥有的便便饰品和物品",
    "等一下!", "zh_cn")
  EID:addCollectible(COLLECTIBLE_FIRE_SPELLBOOK,
    "施放时发射火焰持续几秒钟#如果在持有火焰魔法书书页或纵火狂的情况下施放，将使效果持续时间更长",
    "火焰魔法书", "zh_cn")
  EID:addCollectible(COLLECTIBLE_CALM_MIND, "30秒内逐渐提升伤害#{{ColorRed}}受到伤害时停止该效果",
    "平静的内心", "zh_cn")
  EID:addCollectible(COLLECTIBLE_OLD_ROPE,
    "有 1/3 几率获得以下效果之一：# 倒吊人卡牌效果# 倒吊人？卡牌效果# 受到伤害并对整个房间造成 40 点伤害",
    "旧绳子", "zh_cn")
  EID:addCollectible(COLLECTIBLE_DYING,
    "当只剩半颗心或一颗骨心或一颗腐心时：#\1 伤害 *1.5#↑ 伤害 +3#\1 攻击间隔 / 1.5#{{ColorRainbow}}\1 (Milcah 则为2.5)#随机眼泪效果",
    "濒死", "zh_cn")
  EID:addCollectible(COLLECTIBLE_GOLDEN_PINK_HOURGLASS,
    "回溯时间。#使用后进入的下一个房间如果有道具，将重置它们。#使用后进入的下一个房间如果有敌人，将降低它们的等级。#{{ColorRed}}在当前楼层使用 3 次后有 50% 几率破碎#{{ColorGreen}}如果未破碎，将在新楼层重置",
    "金色墨水沙漏", "zh_cn")
  EID:addCollectible(COLLECTIBLE_SEDUCE,
    "使房间内的所有敌人迷惑#有机会永久迷惑敌人#永久迷惑的敌人会在房间之间跟随角色#{{ColorRainbow}}+5% 几率使 Naamah 发射心形眼泪",
    "魅惑", "zh_cn")
  EID:addCollectible(COLLECTIBLE_RANDOMNESS, "授予每个未清除房间随机道具效果。", "随意", "zh_cn")

  EID:addCollectible(COLLECTIBLE_WITCHS_BROOM,
    "持有时赋予飞行能力#↑ +3 幸运#↑ +0.1 移速#+1 魂心#使用时将朝着角色移动的方向冲刺",
    "女巫的扫帚", "zh_cn")
  EID:addCollectible(COLLECTIBLE_WITCH_CAULDRON,
    "捡到饰品会自动吞掉它们#吞掉 10 个饰品后，会生成一个随机道具并移除本道具#{{ColorRed}}有 25% 几率摧毁饰品#{{ColorGreen}}幸运值越高，摧毁饰品的几率越小",
    "女巫的炼药锅", "zh_cn")
  EID:addCollectible(COLLECTIBLE_DARK_PRINCESS_CROWN, "+1.5 射程#+2.0 射速#+0.20 弹速", "黑暗公主王冠",
    "zh_cn")

  EID:addCollectible(COLLECTIBLE_LITTLE_AURI,
    "生成一个迷你Auri，它发射高伤害的钻石眼泪，每次射击造成 5.4 点伤害#概率发射迷惑泪滴",
    "迷你Auri", "zh_cn")
  EID:assignTransformation("collectible", COLLECTIBLE_LITTLE_AURI, EID.TRANSFORMATION["CONJOINED"])
  EID:addCollectible(COLLECTIBLE_PRINCESS_BABY,
    "生成一个宝宝，它快速发射红色钻石泪滴，每次射击造成 3 点伤害#拥有国王宝宝时，提升更多射速#概率发射恐惧泪滴",
    "公主宝宝", "zh_cn")
  EID:assignTransformation("collectible", COLLECTIBLE_PRINCESS_BABY, EID.TRANSFORMATION["CONJOINED"])

  EID:addCollectible(COLLECTIBLE_ENERGY_SHIELD,
    "当满充能时，可以抵消一次伤害(对献血机等自伤行为有效)#抵消伤害或使用时，对附近敌人造成伤害", "能量护盾",
    "zh_cn")
  EID:addCollectible(COLLECTIBLE_MAGE_STAFF,
    "{{Luck}} {{ColorGreen}}幸运 x 2 #{{ArrowUp}} +0.2 射速#{{ArrowUp}} +0.5 伤害#{{ArrowUp}} +1.25 射程#{{ArrowDown}} -0.2 弹速",
    "巫师法杖", "zh_cn")
  EID:addCollectible(COLLECTIBLE_CANDY, "+1 永恒之心#吞掉当前饰品", "糖果", "zh_cn")
  EID:addCollectible(COLLECTIBLE_SELF_HARM,
    "对自己造成伤害而不损失任何生命值 #不会给予角色无敌时间", "自我伤害", "zh_cn")

  EID:addCollectible(COLLECTIBLE_LIL_NAAMAH,
    "生成一个宝宝，它发射心形眼泪并迷惑敌人#眼泪射速非常低", "小NAAMAH", "zh_cn")
  EID:assignTransformation("collectible", COLLECTIBLE_LIL_NAAMAH, EID.TRANSFORMATION["CONJOINED"])
  EID:addCollectible(COLLECTIBLE_LITTLE_PYROMANCER,
    "生成一个宝宝，它发射火焰#火焰有机会爆炸并对敌人造成燃烧效果", "小火焰法师",
    "zh_cn")
  EID:assignTransformation("collectible", COLLECTIBLE_LITTLE_PYROMANCER, EID.TRANSFORMATION["CONJOINED"])

  EID:addCollectible(COLLECTIBLE_POCKET_BAG,
    "如果仍持有初始主动道具，设置该道具到副手主动槽#如果仍持有初始饰品，吞掉该饰品",
    "提包", "zh_cn")
  EID:addCollectible(COLLECTIBLE_WITCHS_SOUP,
    "↑ {{Luck}} +30 幸运#提升的幸运会逐渐下降#捡到时扭曲屏幕", "女巫的汤", "zh_cn")
  EID:addTrinket(TrinketType.TRINKET_MILCAHS_FAITH,
    "清除房间后，如果角色没有魂心或黑心，则恢复 1 颗红心", "MILCAHS的信仰", "zh_cn")

  EID:addTrinket(TrinketType.TRINKET_BRITTLE_PENNY, "捡到硬币时有 25% 几率获得骨头环绕物(亡者之书)",
    "易碎硬币", "zh_cn")
  EID:addTrinket(TrinketType.TRINKET_HANSENS_PENNY,
    "捡到硬币时有 20% 几率获得麻风环绕物#最多可以生成 3 个", "HANSENS硬币", "zh_cn")
  EID:addTrinket(TrinketType.TRINKET_TECH_PENNY, "捡到硬币时生成科技X光环", "科技硬币", "zh_cn")
  EID:addTrinket(TrinketType.TRINKET_MODED_CARTRIDGE,
    "进入新房间时，赋予 10% 基础几率触发掌机游戏效果#在掌机游戏效果下获得 +0.5 速度",
    "mod卡带", "zh_cn")
  EID:addTrinket(TrinketType.TRINKET_NECRO_PENNY, "捡到硬币时有 15% 几率召唤一个友好的骨头小鬼",
    "亡灵硬币", "zh_cn")
  EID:addTrinket(TrinketType.TRINKET_POWER_PELLETS,
    "当进入新房间时，此饰品会在房间内随机位置掉落#捡到后触发掌机游戏效果(仅当有敌人时触发)",
    "力量胶囊", "zh_cn")
  EID:addTrinket(TrinketType.TRINKET_POOPPY_PENNY, "捡到硬币时有 25% 几率生成友好的便便", "便便硬币",
    "zh_cn")
  EID:addTrinket(TrinketType.TRINKET_NAIL_PENNY,
    "捡到硬币时，有机会对自己造成伤害而不损失生命值#不会给予角色无敌状态",
    "钉子硬币", "zh_cn")

end

function AuriChinese:OnGameStart()

  for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)

    if EID and player:GetPlayerType() ~= Isaac.GetPlayerTypeByName("Auri") or EID and player:GetPlayerType() ~=
      Isaac.GetPlayerTypeByName("Aurii", true) then
      EID:addCollectible(CollectibleType.COLLECTIBLE_GLOWING_HOUR_GLASS,
        "回溯时间，让你回到前一个房间，回到你当时的状态", "发光沙漏", "zh_cn")
      EID:addCollectible(CollectibleType.COLLECTIBLE_LAZARUS_RAGS, "{{Player11}}角色死亡时，复活为拉撒路",
        "拉撒路的绷带", "zh_cn")
      EID:addCollectible(CollectibleType.COLLECTIBLE_JUDAS_SHADOW,
        "{{Player12}} 角色死亡时, 复活为黑暗犹大#{{Damage}}他有2倍的伤害乘数", "犹大的影子",
        "zh_cn")
      EID:addCollectible(CollectibleType.COLLECTIBLE_ANKH, "{{Player4}} 角色死亡时, 复活为???", "安卡十字",
        "zh_cn")
      EID:addCollectible(CollectibleType.COLLECTIBLE_MY_SHADOW,
        "身后跟随一个小阴影#当敌人碰到阴影时，它会产生一个友好的黑色的蛆#友好的黑色的蛆每秒造成5点伤害",
        "我的影子", "zh_cn")

      EID:addCollectible(COLLECTIBLE_LITTLE_AURI,
        "生成一个能发射高伤害钻石眼泪的跟班#每发造成5.4点伤害#有机会射出魅惑眼泪",
        "迷你Auri", "zh_cn")
      EID:assignTransformation("collectible", COLLECTIBLE_LITTLE_AURI, EID.TRANSFORMATION["CONJOINED"])
      EID:addCollectible(COLLECTIBLE_PRINCESS_BABY,
        "生成一个发射红色钻石眼泪的跟班#高射速，每发造成3点伤害#国王宝宝会提升更多射速#有机会发射恐惧眼泪",
        "公主宝宝", "zh_cn")
      EID:assignTransformation("collectible", COLLECTIBLE_PRINCESS_BABY, EID.TRANSFORMATION["CONJOINED"])
    end
  end

  for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)

    if EID and player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") then
      EID:addCollectible(CollectibleType.COLLECTIBLE_GLOWING_HOUR_GLASS,
        "{{ColorRainbow}}当 Auri 持有时#{{ColorRainbow}}她会在死亡时回溯时间#{{ColorRainbow}}受伤时概率减速敌人 (幸运相关)",
        "发光沙漏", "zh_cn")
      EID:addCollectible(CollectibleType.COLLECTIBLE_LAZARUS_RAGS,
        "{{ColorRainbow}} 死亡时变成复活的Auri，将Auri的生命值设置为 1 颗心，并获得贫血",
        "拉撒路的绷带", "zh_cn")
      EID:addCollectible(CollectibleType.COLLECTIBLE_JUDAS_SHADOW,
        "{{ColorRainbow}}角色死亡时, 复活为Auri-暗影公主并使攻击力 x 2", "犹大的影子", "zh_cn")
      EID:addCollectible(CollectibleType.COLLECTIBLE_ANKH, "{{ColorRainbow}}死亡时复活为 Dead Auri",
        "安卡十字", "zh_cn")
      EID:addCollectible(CollectibleType.COLLECTIBLE_MY_SHADOW,
        "{{ColorRainbow}}每次进入房间时，有 1/9 的几率变成Auri-暗影公主", "我的影子", "zh_cn")

      EID:addCollectible(COLLECTIBLE_LITTLE_AURI, "{{ColorSilver}}哦!那个小小的我，不是吗?", "迷你Auri",
        "zh_cn")
      EID:assignTransformation("collectible", COLLECTIBLE_LITTLE_AURI, EID.TRANSFORMATION["CONJOINED"])
      EID:addCollectible(COLLECTIBLE_PRINCESS_BABY, "{{ColorSilver}}看!它是小小的我，但是是黑色的! *笑*",
        "公主宝宝", "zh_cn")
      EID:assignTransformation("collectible", COLLECTIBLE_PRINCESS_BABY, EID.TRANSFORMATION["CONJOINED"])
    end
  end
  for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)

    if EID and player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) then
      EID:addCollectible(CollectibleType.COLLECTIBLE_SATANIC_BIBLE,
        "{{ColorRainbow}}+1 生命值#{{ColorRainbow}}+1 碎心#{{ColorRainbow}}在 Boss 战前使用时，Boss 房间的物品将变成魔鬼交易",
        "撒旦圣经", "zh_cn")
      EID:addCollectible(CollectibleType.COLLECTIBLE_BOOK_OF_REVELATIONS,
        "{{ColorRainbow}}移除 1 破碎的心#{{ColorRainbow}}使用时增加天启骑士生成率#{{ColorRainbow}}+17.5% 恶魔房开启概率",
        "启示录", "zh_cn")
      EID:addCollectible(CollectibleType.COLLECTIBLE_THE_NAIL,
        "{{ColorRainbow}}+ 半颗红心#{{ColorRainbow}}+2.0 伤害#{{ColorRainbow}}-0.18 移速#{{ColorRainbow}}造成接触伤害#{{ColorRainbow}}粉碎经过的岩石",
        "钉子", "zh_cn")
      EID:addCollectible(CollectibleType.COLLECTIBLE_GLOWING_HOUR_GLASS, "{{ColorSilver}}背水一战", "发光沙漏",
        "zh_cn")
      EID:addCollectible(COLLECTIBLE_BROKEN_GLOWING_HOURGLASS, "{{ColorSilver}}不再回溯时间",
        "破碎的发光沙漏", "zh_cn")

      EID:addCollectible(CollectibleType.COLLECTIBLE_LAZARUS_RAGS,
        "{{ColorRainbow}} 死亡时变成复活的Auri，将Auri的生命值设置为 1 颗心，并获得贫血",
        "拉撒路的绷带", "zh_cn")
      EID:addCollectible(CollectibleType.COLLECTIBLE_JUDAS_SHADOW,
        "{{ColorRainbow}}角色死亡时, 复活为Auri-暗影公主并使攻击力 x 2", "犹大的影子", "zh_cn")
      EID:addCollectible(CollectibleType.COLLECTIBLE_ANKH, "{{ColorRainbow}}死亡时复活为 Dead Auri",
        "安卡十字", "zh_cn")
      EID:addCollectible(CollectibleType.COLLECTIBLE_MY_SHADOW,
        "{{ColorRainbow}}每次进入房间时，有 1/9 的几率变成Auri-暗影公主", "我的影子", "zh_cn")

      EID:addCollectible(COLLECTIBLE_LITTLE_AURI, "{{ColorSilver}}这是..我？", "迷你Auri", "zh_cn")
      EID:assignTransformation("collectible", COLLECTIBLE_LITTLE_AURI, EID.TRANSFORMATION["CONJOINED"])

    end
  end
end

AuriChinese:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, AuriChinese.OnGameStart)
