-- 在原有汉化的基础上 by 汐何 / Saurtya#6886 增加修改
local AuriChinese = RegisterMod("Auri Chinese", 1)
AuriChineseMod = AuriChinese
-- 在auri mod中正则搜索这一串， 找到所有这种情况的道具
-- local COLLECTIBLE.*Isaac.GetItemIdByName
-- 这两个道具需要特殊方式取值
local COLLECTIBLE_LITTLE_AURI = Isaac.GetItemIdByName("Little Auri") -- 迷你auri
local COLLECTIBLE_PRINCESS_BABY = Isaac.GetItemIdByName("Princess Baby") -- 公主宝宝
function AuriChinese:OnGameStart()
  if EID and AuriMod then
    EID:setModIndicatorName("Little Auri")
    EID:addBirthright(Isaac.GetPlayerTypeByName("Auri"),
      "光明之冠的效果始终处于激活状态 #{{ColorRed}}当有空的心之容器时拾取红心会失去此效果",
      "Auri", "zh_cn")
    EID:addBirthright(Isaac.GetPlayerTypeByName("Aurii", true),
      "{{ColorSilver}}对敌人进行扭曲攻击#{{ColorSilver}}与某些项目有特殊的交互。", "堕化Auri",
      "zh_cn")
    EID:addBirthright(Isaac.GetPlayerTypeByName("Dark Auri"), "尚未实现", "Auri-黑暗", "zh_cn")
    EID:addBirthright(Isaac.GetPlayerTypeByName("Dark Corrupted Auri"),
      "当只有三颗心时会开始失去心 #在困难模式下延长时间（当没有心脏时）",
      "堕化Auri-黑暗", "zh_cn")
    EID:addBirthright(Isaac.GetPlayerTypeByName("Mage Auri"),
      "魔法书现在会使Auri-巫师在激活它时发射出火焰", "Auri-巫师", "zh_cn")
    EID:addBirthright(Isaac.GetPlayerTypeByName("Milcah"),
      "当她只有一颗心脏而不是半颗心脏时，死亡效果激活(没明白这句话什么意思)",
      "Auri-暗影公主", "zh_cn")
    EID:addBirthright(Isaac.GetPlayerTypeByName("Dark Princess Auri Tainted"), "不！", "Auri-堕化暗影公主",
      "zh_cn")
    EID:addBirthright(Isaac.GetPlayerTypeByName("Glitch Auri"),
      "所有恢复类道具都可以来自任何类型的项目池", "Auri-错误", "zh_cn")
    EID:addBirthright(Isaac.GetPlayerTypeByName("Error Auri"), "NULL", "Auri-错误", "zh_cn")
    EID:addBirthright(Isaac.GetPlayerTypeByName("Azrael"), "正在制作", "死神", "zh_cn")
    EID:addBirthright(Isaac.GetPlayerTypeByName("Fallen Auri"), "尚未实现", "失身的Auri", "zh_cn")
    EID:addBirthright(Isaac.GetPlayerTypeByName("Naamah"), "增加 10% 概率发射心型眼泪", "恶魔", "zh_cn")

    EID:addTrinket(TrinketType.TRINKET_AURI_CROWN,
      "攻击力 x 1.5 #{{ColorRed}}当受到伤害时会被摧毁（不包括如献祭类的自伤行为）",
      "Auri的王冠", "zh_cn")
    EID:addTrinket(TrinketType.TRINKET_DARK_AURI_CROWN,
      "{{ColorPurple}}受到伤害时有50%概率获得1颗碎心 #每有1颗碎心{{ArrowUp}}+0.5伤害",
      "黑暗王冠", "zh_cn")
    EID:addTrinket(TrinketType.TRINKET_DARK_HEART,
      "{{ColorPurple}}每当你进入新的一层时，给予你1颗碎心和{{ArrowUp}}+0.5伤害", "堕化Auri的心",
      "zh_cn")
    EID:addTrinket(TrinketType.TRINKET_CROWN_OF_DEATH,
      "{{Warning}}{{Warning}}{{Warning}} #攻击力 x 2.5#{{ColorRed}}受到伤害会立即杀死你 #{{ColorRed}}受伤时有几率被吞掉（熔炉效果）",
      "死亡王冠", "zh_cn")
    EID:addTrinket(TrinketType.TRINKET_DARK_PENNY,
      "{{ColorPurple}}当捡起硬币时，有几率生成1颗碎心或是{{ArrowUp}}+0.1伤害#{{ColorPurple}}有小概率在捡起硬币时吞噬该饰品",
      "黑暗硬币", "zh_cn")
    EID:addTrinket(TrinketType.TRINKET_ENCHANT_PENNY, "当捡起硬币时，有25%几率获得{{Luck}}+0.5运气",
      "附魔硬币", "zh_cn")
    EID:addTrinket(TrinketType.TRINKET_AURI_HAIR_CLIP,
      "进入房间时，有几率魅惑敌人 #{{ColorGreen}}这个效果被激活的几率取决于你的运气属性",
      "Auri的发卡", "zh_cn")
    EID:addTrinket(TrinketType.TRINKET_FIRE_SPELL_SCROLL, "进入房间时，有几率激活火焰魔法书的效果",
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
      "当进入新的一层时，若你在前两层中未曾受到过伤害，那么你会获得奖励 #即使你受到过伤害，你仍可以携带此饰品在新的一层进行挑战 #{{Warning}} 你需要携带此饰品挑战Boss房，如果你跳过了Boss战斗，那么你将不会获得奖励",
      "挑战王冠", "zh_cn")
    EID:addTrinket(TrinketType.TRINKET_GLOWING_ORB, "运气 ↑ +3 #随机显示财富词条", "发光球体", "zh_cn")

    EID:addCollectible(COLLECTIBLE_BROKEN_GLOWING_HOURGLASS, "1/9的几率回溯时间", "破碎的发光沙漏",
      "zh_cn")
    EID:addCollectible(COLLECTIBLE_DARK_GLOWING_HOURGLASS, "使用后在当前房间不会回溯时间", "黑暗沙漏",
      "zh_cn")
    EID:addCollectible(COLLECTIBLE_GLITCH_KNIFE,
      "赋予你一段时间的妈妈的菜刀的效果 #如果角色为堕化Auri，则赋予更多时间",
      "Auri的错误菜刀", "zh_cn")
    EID:addCollectible(COLLECTIBLE_CORRUPTED_DATA, "生成1个错误道具", "被腐化的数据块", "zh_cn")
    EID:addCollectible(COLLECTIBLE_THE_MEMORY,
      "{{ArrowUp}}+射速、伤害、运气 #+5魂心 #{{ColorSilver}}在角色身旁生成迷你以撒进行战斗",
      "回忆", "zh_cn")
    EID:addCollectible(COLLECTIBLE_ENCHANTED_BOOK, "使用时，给予当前楼层{{ArrowUp}}+2的运气", "魔法书",
      "zh_cn")
    EID:addCollectible(COLLECTIBLE_BLOODY_HOURGLASS,
      "使用时，消耗1颗红心并给予当前房间{{ArrowUp}}+0.9射速和{{ArrowUp}}+0.05 移速(可叠加) #激活时加速本房间（类似坏表加速）",
      "染血沙漏", "zh_cn")
    EID:addCollectible(COLLECTIBLE_PRINCESS_BOX,
      "{{Warning}}一次性使用 #80%几率生成染血王冠，邪恶王冠，神圣王冠 #30%几率生成碎裂的王冠 #25%几率生成恶魔王冠 #15%几率生成盛装男孩 #9%几率生成Auri的王冠，黑暗王冠，挑战王冠#5%几率生成光明之冠，黑王子之冠 #3%几率生成死亡王冠 #1%几率生成错误王冠",
      "王冠之盒", "zh_cn")
    EID:addCollectible(COLLECTIBLE_MAGE_HAT, "{{ArrowUp}} +5运气 #{{ArrowUp}} +1魂心", "巫师帽", "zh_cn")
    EID:addCollectible(COLLECTIBLE_MAGE_ROBE,
      "{{ArrowUp}} +1运气 #{{ArrowUp}} +1魂心 #{{ArrowUp}} +你的运气值/2的攻击力", "巫师袍", "zh_cn")
    EID:addCollectible(COLLECTIBLE_WAIT_A_SEC,
      "生成友好的便便 #能够生成不同类型的友好便便，取决于你所拥有的道具和饰品",
      "等一下!", "zh_cn")
    EID:addCollectible(COLLECTIBLE_FIRE_SPELLBOOK,
      "使用时，发射几秒钟的火焰 #当你持有火焰魔法书书页饰品或纵火狂时, 持续更长时间",
      "火焰魔法书", "zh_cn")
    EID:addCollectible(COLLECTIBLE_CALM_MIND,
      "被动效果，获得伤害加成 #当受到伤害时，失去加成效果30秒", "平静的内心", "zh_cn")
    EID:addCollectible(COLLECTIBLE_OLD_ROPE,
      "1/3的几率获得以下效果之一 #获得倒吊人卡牌效果 #获得倒吊人?卡牌效果 #受到1颗心伤害并对本房间的所有敌人造成40点伤害",
      "旧绳子", "zh_cn")
    EID:addCollectible(COLLECTIBLE_DYING,
      "当只有半颗红心或半颗魂心或一颗空骨心时 #攻击力 x 1.5 #{{ArrowUp}}+3攻击力 # 攻击间隔/1.5 (Milcah 为 2.5) #{{ColorRainbow}}随机眼泪效果",
      "濒死", "zh_cn")
    EID:addCollectible(COLLECTIBLE_GOLDEN_PINK_HOURGLASS,
      "回溯时间#如果旁边房间有道具，它会被重置#如果房间有敌人，它会被降级#{{ColorRed}}在当前楼层使用3次后，有50%的几率损坏#{{ColorGreen}}如果没有损坏，在新楼层重置",
      "金色墨水沙漏", "zh_cn")
    EID:addCollectible(COLLECTIBLE_SEDUCE,
      "魅惑房间内的所有敌人#有机会永久魅惑敌人#永久魅惑的敌人在房间间跟随你#{{ColorRainbow}}Naamah有5%的机会射出心泪",
      "勾引", "zh_cn")
    EID:addCollectible(COLLECTIBLE_RANDOMNESS, "授予每个未清除房间随机道具效果。", "随意", "zh_cn")
    EID:addCollectible(COLLECTIBLE_WITCHS_BROOM,
      "获得飞行#{{ArrowUp}} +3运气#{{ArrowUp}} +0.1速度#{{ArrowUp}} +1魂心", "女巫的扫帚", "zh_cn")
    EID:addCollectible(COLLECTIBLE_WITCH_CAULDRON,
      "拾取饰品将自动熔炼它#熔炼10个饰品后，产生随机物品并移除该道具#{{ColorRed}}有25%的几率摧毁饰品#{{ColorGreen}}运气越高，摧毁饰品的几率越低",
      "女巫的炼药锅", "zh_cn")
    EID:addCollectible(COLLECTIBLE_MENTAL_BREAKDOWN, "我不敢相信..", "精神崩溃", "zh_cn")
    EID:addCollectible(COLLECTIBLE_LITTLE_AURI,
      "生成一个发射高伤害钻石眼泪的跟班 #每次射击造成5.4点伤害 #有几率发射魅惑眼泪",
      "迷你Auri", "zh_cn")
    EID:assignTransformation("collectible", COLLECTIBLE_LITTLE_AURI, EID.TRANSFORMATION["CONJOINED"])
    EID:addCollectible(COLLECTIBLE_PRINCESS_BABY,
      "生成一个发射红色钻石眼泪的跟班 #高射速，每次射击造成3点伤害 #拥有国王宝宝时，会提升更多射速 #有几率发射恐惧眼泪",
      "公主宝宝", "zh_cn")
    EID:assignTransformation("collectible", COLLECTIBLE_PRINCESS_BABY, EID.TRANSFORMATION["CONJOINED"])
    EID:addCollectible(COLLECTIBLE_DARK_PRINCESS_CROWN, "+1.5 射程#+2.0 射速#+0.20 弹速", "黑暗公主王冠",
      "zh_cn")
  end

  for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
    if EID and player:GetPlayerType() ~= Isaac.GetPlayerTypeByName("Auri") or EID and player:GetPlayerType() ~=
      Isaac.GetPlayerTypeByName("Aurii", true) then
      EID:addCollectible(CollectibleType.COLLECTIBLE_GLOWING_HOUR_GLASS,
        "回溯时间，让你回到前一个房间，回到你当时的状态", "发光沙漏", "zh_cn")
      EID:addCollectible(CollectibleType.COLLECTIBLE_LAZARUS_RAGS, "角色死亡时，复活为拉撒路",
        "拉撒路的绷带", "zh_cn")
      EID:addCollectible(CollectibleType.COLLECTIBLE_JUDAS_SHADOW,
        "角色死亡时, 复活为黑暗犹大#{{Damage}}他有2倍的伤害乘数", "犹大的影子", "zh_cn")
      EID:addCollectible(CollectibleType.COLLECTIBLE_ANKH, "角色死亡时, 复活为???", "安卡十字", "zh_cn")
      EID:addCollectible(CollectibleType.COLLECTIBLE_MY_SHADOW,
        "身后跟随一个小阴影#当敌人碰到阴影时，它会产生一个友好的黑色战马#充电器每秒造成5点伤害",
        "我的影子", "zh_cn")
      EID:addCollectible(COLLECTIBLE_LITTLE_AURI,
        "生成一个能发射高伤害钻石眼泪的跟班#每发造成5.4点伤害#有机会射出魅惑眼泪",
        "迷你Auri", "zh_cn")
      EID:assignTransformation("collectible", COLLECTIBLE_LITTLE_AURI, EID.TRANSFORMATION["CONJOINED"])
      EID:addCollectible(COLLECTIBLE_PRINCESS_BABY,
        "生成一个发射红色钻石眼泪的跟班#高射速，每发造成3点伤害#国王宝宝减少更多的射速#有机会发射恐惧眼泪",
        "公主宝宝", "zh_cn")
      EID:assignTransformation("collectible", COLLECTIBLE_PRINCESS_BABY, EID.TRANSFORMATION["CONJOINED"])
    end
  end

  for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
    if EID and player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") then
      EID:addCollectible(CollectibleType.COLLECTIBLE_GLOWING_HOUR_GLASS,
        "当角色为Auri持有时 #死亡时会触发发光沙漏的效果，随后成为破碎的发光沙漏 #受到伤害时，有一定几率使房间内所有敌人减速，与运气属性相关",
        "发光沙漏", "zh_cn")
      EID:addCollectible(CollectibleType.COLLECTIBLE_LAZARUS_RAGS,
        "角色死亡时，令角色复活并将心之容器变为1颗，并获得贫血", "拉撒路的绷带", "zh_cn")
      EID:addCollectible(CollectibleType.COLLECTIBLE_JUDAS_SHADOW,
        "角色死亡时, 令角色复活成为Auri-暗影公主并使攻击力 x 2", "犹大的影子", "zh_cn")
      EID:addCollectible(CollectibleType.COLLECTIBLE_ANKH, "角色死亡时, 令角色复活成为Dead Auri",
        "安卡十字", "zh_cn")
      EID:addCollectible(CollectibleType.COLLECTIBLE_MY_SHADOW,
        "每进入一个房间，就有1/9的几率变成Auri-暗影公主", "我的影子", "zh_cn")
      EID:addCollectible(COLLECTIBLE_LITTLE_AURI, "哦!那个小小的我，不是吗?", "迷你Auri", "zh_cn")
      EID:assignTransformation("collectible", COLLECTIBLE_LITTLE_AURI, EID.TRANSFORMATION["CONJOINED"])
      EID:addCollectible(COLLECTIBLE_PRINCESS_BABY, "看!它是小小的我，但是是黑色的! *笑*",
        "公主宝宝", "zh_cn")
      EID:assignTransformation("collectible", COLLECTIBLE_PRINCESS_BABY, EID.TRANSFORMATION["CONJOINED"])
    end
  end

  for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
    if EID and player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii") then
      EID:addCollectible(CollectibleType.COLLECTIBLE_SATANIC_BIBLE,
        "在Boss战前使用则Boss房道具会变成恶魔交易#!!! 交易道具则会锁定在本局只能进行恶魔交易 #堕化Auri: +1生命值  +1碎心",
        "撒但圣经", "zh_cn")
      EID:addCollectible(CollectibleType.COLLECTIBLE_BOOK_OF_REVELATIONS,
        "更高的天启骑士生成率# +17.5%恶魔房开启几率#堕化Auri: 移除1颗碎心", "启示录", "zh_cn")
      EID:addCollectible(CollectibleType.COLLECTIBLE_THE_NAIL,
        "{{ArrowUp}}+半颗红心 #{{ArrowUp}}+2.0攻击力 #{{ArrowDown}}-0.18移速 #接触伤害 #粉碎经过的岩石",
        "钉子", "zh_cn")
      EID:addCollectible(CollectibleType.COLLECTIBLE_GLOWING_HOUR_GLASS, "背水一战")
      EID:addCollectible(COLLECTIBLE_BROKEN_GLOWING_HOURGLASS, "不再回溯时间", "破碎的发光沙漏", "zh_cn")
      EID:addCollectible(CollectibleType.COLLECTIBLE_LAZARUS_RAGS,
        "角色死亡时，令角色复活并将心之容器变为1颗，并获得贫血", "拉撒路的绷带", "zh_cn")
      EID:addCollectible(CollectibleType.COLLECTIBLE_JUDAS_SHADOW,
        "角色死亡时, 令角色复活成为Auri-暗影公主并使攻击力 x 2", "犹大的影子", "zh_cn")
      EID:addCollectible(CollectibleType.COLLECTIBLE_ANKH,
        "角色死亡时, 令角色复活，并转变为Auri-???形态（类似小蓝人外观）", "安卡十字",
        "zh_cn")
      EID:addCollectible(CollectibleType.COLLECTIBLE_MY_SHADOW,
        "每进入一个房间，就有1/9的几率变成Auri-暗影公主", "我的影子", "zh_cn")
      EID:addCollectible(COLLECTIBLE_LITTLE_AURI, "这是..我？", "迷你Auri", "zh_cn")
      EID:assignTransformation("collectible", COLLECTIBLE_LITTLE_AURI, EID.TRANSFORMATION["CONJOINED"])
      EID:addCollectible(COLLECTIBLE_PRINCESS_BABY, "看起来挺邪恶的", "公主宝宝", "zh_cn")
      EID:assignTransformation("collectible", COLLECTIBLE_PRINCESS_BABY, EID.TRANSFORMATION["CONJOINED"])
    end
  end
end
AuriChinese:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, AuriChinese.OnGameStart)
