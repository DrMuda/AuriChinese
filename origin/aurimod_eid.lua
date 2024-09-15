print("Auri mod EID load!")
if EID then
  local Auriz = Aurimod
  EID:setModIndicatorName("Little Auri")

  EID:addBirthright(Isaac.GetPlayerTypeByName("Auri"),
    "Crown of light effect always active#{{ColorRed}}pickup red heart when she has empty heart container will make her lost the effect")
  EID:addBirthright(Isaac.GetPlayerTypeByName("Dark Auri"), "not implemented yet")
  EID:addBirthright(Isaac.GetPlayerTypeByName("Mage Auri"),
    "Book of enchant now make Mage Auri cast fire spell when activated")
  EID:addBirthright(Isaac.GetPlayerTypeByName("Milcah"),
    "Dying effects active when she has only 1 heart instead of half a heart")
  EID:addBirthright(Isaac.GetPlayerTypeByName("Dark Princess Auri Tainted"), "NO")
  EID:addBirthright(Isaac.GetPlayerTypeByName("Naamah"), "+10% chance for shooting heart tears")

  EID:addTrinket(TrinketType.TRINKET_AURI_CROWN, "Damage x 1.5#{{ColorRed}}Destroys itself when character take damage")
  EID:addTrinket(TrinketType.TRINKET_CROWN_OF_DEATH,
    "{{Warning}}{{Warning}}{{Warning}} #Gain damage *2.5#{{ColorRed}}Taking damage will kill character instantly#{{ColorRed}}Chance to gulp itself while held")
  EID:addTrinket(TrinketType.TRINKET_ENCHANT_PENNY, "25% Chance to get {{Luck}}+0.5 luck up when picking up a coin")
  EID:addTrinket(TrinketType.TRINKET_AURI_HAIR_CLIP,
    "Chance for enemies to get charmed when entering a room #{{ColorGreen}}The chance for this effect to activate is affected by characters Luck stat")
  EID:addTrinket(TrinketType.TRINKET_FIRE_SPELL_SCROLL, "Chance to activate Fire spell book when entering a room")
  EID:addTrinket(TrinketType.TRINKET_SOUL_PENNY, "25% Chance to gain a wisp when picking up a coin")
  EID:addTrinket(TrinketType.TRINKET_MORPH_PENNY, "25% Chance to spawn mini isaac when picking up a coin")
  EID:addTrinket(TrinketType.TRINKET_MINE_PENNY,
    "100% Chance to explode when picking up sticky nickel #50% Chance to explode when picking up a coin# 0% Chance with lucky penny and nickel")
  EID:addTrinket(TrinketType.TRINKET_LESSER_KEY,
    "12% Chance to get a lemegeton wisp when picking up a key# 50% Chance with golden key")
  EID:addTrinket(TrinketType.TRINKET_CHALLENGE_CROWN,
    "After start of a new floor, if character don't take damage for 2 stages it'll drop a reward#If character take damage you can take the challange again by going to a new floor#{{Warning}} {{ColorRed}}Character need to go to bossroom with this trinket, if character skip bossroom, it won't count")
  EID:addTrinket(TrinketType.TRINKET_GLOWING_ORB, "↑ +3 luck up#Randomly show fortune text while holding this")

  EID:addTrinket(TrinketType.TRINKET_DARK_PENNY,
    "{{ColorPurple}}{{Blank}} Dark item#{{ColorPurple}}Chance to get a broken heart or +0.1 damage up when picking up a coin#{{ColorPurple}}have a small chance to gulp itself when pickup a coin")
  EID:addTrinket(TrinketType.TRINKET_DARK_HEART,
    "{{ColorPurple}}{{Blank}} Dark item#{{ColorPurple}}Gives character +1 Broken Heart and +0.5 damage up every time character enter a new floor")
  EID:addTrinket(TrinketType.TRINKET_DARK_AURI_CROWN,
    "{{ColorPurple}}{{Blank}} Dark item#{{ColorPurple}}Taking damage has a 50% chance of granting +1 broken heart.#Gain +0.5 damage increase for every broken heart")

  EID:addCollectible(COLLECTIBLE_BROKEN_GLOWING_HOURGLASS, "1/9 chance to rewind time")
  EID:addCollectible(COLLECTIBLE_DARK_GLOWING_HOURGLASS,
    "{{ColorPurple}}{{Blank}} Dark item#{{ColorPurple}}Use to not rewind time when taking damage in current room")

  EID:addCollectible(COLLECTIBLE_CORRUPTED_DATA, "Spawn a Glitch item")
  EID:addCollectible(COLLECTIBLE_THE_MEMORY,
    "Tears+damage+speed+luck up#+5 soul hearts#{{ColorSilver}}spawn little isaac to fight by my side.")
  EID:addCollectible(COLLECTIBLE_ENCHANTED_BOOK, "Upon use, gives {{Luck}} +2 Luck up which lasts for the current floor")
  EID:addCollectible(COLLECTIBLE_BLOODY_HOURGLASS,
    "Upon use, consumes 1 red heart and gives #{{TearsSmall}} +0.9 tears up and #{{SpeedSmall}} +0.05 speed which lasts for the current room (stackable)#{{Heart}} when a hostiles room is cleared, if this item activation, heal red hearts for 50% of the total amount spent#{{ColorRed}}speed up current room when activated")

  EID:addCollectible(COLLECTIBLE_PRINCESS_BOX,
    "SINGLE USE {{Warning}}{{Warning}}{{Warning}} #80% chance to spawn Bloody Crown, Wicked Crown, Holy Crown #30% chance to spawn Cracked Crown#25% chance to spawn Devil's Crown#15% chance to spawn Pageant Boy#9% chance to spawn Auri's Crown, Dark Crown, Challenge Crown#5% chance to spawn Crown of Light, Dark Prince's Crown#3% chance to spawn Crown of Death#1% chance to spawn Glitched Crown")
  EID:addCollectible(COLLECTIBLE_MAGE_HAT, "↑ +5 luck up#+1 Soul heart")
  EID:addCollectible(COLLECTIBLE_MAGE_ROBE,
    "↑ +1 luck up#+1 Soul heart#↑ Gain damage up equal half of characters luck")
  EID:addCollectible(COLLECTIBLE_WAIT_A_SEC,
    "Spawn a friendly poop# Can spawn any variant of friendly poop depending on poop trinkets and items that the character has")
  EID:addCollectible(COLLECTIBLE_FIRE_SPELLBOOK,
    "while cast, shoot flames for a few seconds#casting while holding a fire spell scroll or Pyromaniac, will make the effect last longer")
  EID:addCollectible(COLLECTIBLE_CALM_MIND,
    "Passively gain small damage up overtime#{{ColorRed}}Stop gaining damage for 30 seconds when taking damage")
  EID:addCollectible(COLLECTIBLE_OLD_ROPE,
    "1 in 3 chance to get one of these effect:# the hanged man card# the hanged man? card# take damage and deal 40 damage to the entire room")
  EID:addCollectible(COLLECTIBLE_DYING,
    "When at only half a heart left:#\1 damage *1.5#↑ damage +3#\1 fire delay / 1.5#{{ColorRainbow}}\1 (2.5 as Milcah)#and shoot random tears effects")
  EID:addCollectible(COLLECTIBLE_GOLDEN_PINK_HOURGLASS,
    "Rewind time. #if the next room had collectibles, it will reroll them.#If the room had enemies, it will downgrade them#{{ColorRed}}has 50% chance to break after 3 use on current floor #{{ColorGreen}}reset on new floor if not break")
  EID:addCollectible(COLLECTIBLE_SEDUCE,
    "Charm all enemies in the room#has a chance to permanently charm enemies#permanently charmed enemies follow character between rooms#{{ColorRainbow}}+5% chance for Naamah to shoot heart tears")
  EID:addCollectible(COLLECTIBLE_RANDOMNESS, "Grants a random items effect each unclear room.")

  EID:addCollectible(COLLECTIBLE_WITCHS_BROOM,
    "Grants flight while held#↑ +3 luck up#↑ +0.1 speed#+1 Soul Heart#Using the item dashes in the direction of charcter's movement")
  EID:addCollectible(COLLECTIBLE_WITCH_CAULDRON,
    "Picking up trinkets will auto smelt them#After smelting 10 trinkets, spawns random item and removes this item#{{ColorRed}}has 25% chance to destroy the trinket#{{ColorGreen}}having more luck reduces the chance to destroy the trinket")
  EID:addCollectible(COLLECTIBLE_DARK_PRINCESS_CROWN, "+1.5 Range Up#+2.0 Tears Up#+0.20 Shot Speed Up")

  EID:addCollectible(COLLECTIBLE_LITTLE_AURI,
    "Spawns a familiar that fires high damage diamond tears that deal 5.4 damage per shot#has a chance to shoot charming tears")
  EID:assignTransformation("collectible", COLLECTIBLE_LITTLE_AURI, EID.TRANSFORMATION["CONJOINED"])
  EID:addCollectible(COLLECTIBLE_PRINCESS_BABY,
    "Spawns a familiar that rapidly fires red diamond tears that deal 3 damage per shot#reduce more fire rate with king baby#has a chance to shoot fear tears")
  EID:assignTransformation("collectible", COLLECTIBLE_PRINCESS_BABY, EID.TRANSFORMATION["CONJOINED"])

  EID:addCollectible(COLLECTIBLE_ENERGY_SHIELD,
    "Damage is negated when it fully charge#Do damage to near enemy when it negate damage or when character using it")
  EID:addCollectible(COLLECTIBLE_MAGE_STAFF,
    "{{Luck}} {{ColorGreen}}x 2 Luck Multiplier #{{ArrowUp}} +0.2 Tears Up#{{ArrowUp}} +0.5 Damage Up#{{ArrowUp}} +1.25 Range Up#{{ArrowDown}} -0.2 Shot Speed Down")
  EID:addCollectible(COLLECTIBLE_CANDY, "+1 Eternal heart#gulp current trinket if you have one")
  EID:addCollectible(COLLECTIBLE_SELF_HARM,
    "Deal damage to yourself without taking any health #not give character invincibility frame")

  EID:addCollectible(COLLECTIBLE_LIL_NAAMAH,
    "Spawns a familiar that shoots heart tears and charms enemies#has a very low tear rate")
  EID:assignTransformation("collectible", COLLECTIBLE_LIL_NAAMAH, EID.TRANSFORMATION["CONJOINED"])
  EID:addCollectible(COLLECTIBLE_LITTLE_PYROMANCER,
    "Spawns a familiar that shoots flames#flames have a chance to explode and apply burn to enemies")
  EID:assignTransformation("collectible", COLLECTIBLE_LITTLE_PYROMANCER, EID.TRANSFORMATION["CONJOINED"])

  EID:addCollectible(COLLECTIBLE_POCKET_BAG,
    "Set characters starting active item to the pocket slot if character is still holding it#gulp characters starting trinket if character still holding it")
  EID:addCollectible(COLLECTIBLE_WITCHS_SOUP,
    "↑ {{Luck}} +30 Luck#The luck up wears off over time#Distort the screen upon pickup")
  EID:addTrinket(TrinketType.TRINKET_MILCAHS_FAITH,
    "After clearing a room, heal for 1 red heart if the character does not have soul or black hearts")

  EID:addTrinket(TrinketType.TRINKET_BRITTLE_PENNY, "25% Chance to get bone orbital when picking up a coin")
  EID:addTrinket(TrinketType.TRINKET_HANSENS_PENNY,
    "20% Chance to get leprocy orbital when picking up a coin#a maximum of 3 leprocy orbitals can be active at one time")
  EID:addTrinket(TrinketType.TRINKET_TECH_PENNY, "spawn laser ring when picking up a coin")
  EID:addTrinket(TrinketType.TRINKET_MODED_CARTRIDGE,
    "Grants 10% base chance to trigger The Gamekid effect upon enter a new room#Gain +0.5 Speed while in the Gamekid effect")
  EID:addTrinket(TrinketType.TRINKET_NECRO_PENNY, "15% Chance to summon a friendly Bony when picking up a coin")
  EID:addTrinket(TrinketType.TRINKET_POWER_PELLETS,
    "When enter a new room, this trinket will drop in random position in the room#When pickup trigger The Gamekid effect")
  EID:addTrinket(TrinketType.TRINKET_POOPPY_PENNY, "25% Chance to spawn friendly dip when picking up a coin")
  EID:addTrinket(TrinketType.TRINKET_NAIL_PENNY,
    "When picking up a coin, have a chance to deal fake damage to yourself without losing any health#This does not provide the character invincibility")

end

function Auriz:OnGameStart()

  for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)

    if EID and player:GetPlayerType() ~= Isaac.GetPlayerTypeByName("Auri") or EID and player:GetPlayerType() ~=
      Isaac.GetPlayerTypeByName("Aurii", true) then
      EID:addCollectible(CollectibleType.COLLECTIBLE_GLOWING_HOUR_GLASS,
        "Rewind time and put you back in the previous room, in the same state you were in at that moment")
      EID:addCollectible(CollectibleType.COLLECTIBLE_LAZARUS_RAGS, "{{Player11}} When dead, revive as Lazarus (Risen)")
      EID:addCollectible(CollectibleType.COLLECTIBLE_JUDAS_SHADOW,
        "{{Player12}} When dead, respawn as Dark Judas#{{Damage}} He has a 2x Damage Multiplier")
      EID:addCollectible(CollectibleType.COLLECTIBLE_ANKH, "{{Player4}} Respawn as ??? (Blue Baby) on death")
      EID:addCollectible(CollectibleType.COLLECTIBLE_MY_SHADOW,
        "A small shadow follows Isaac#When an enemy touches the shadow, it spawns a friendly black charger#The charger deals 5 damage per second")

      EID:addCollectible(COLLECTIBLE_LITTLE_AURI,
        "Spawns a familiar that fires high damage diamond tears#deal 5.4 damage per shot#have a chance to shoot charming tears")
      EID:assignTransformation("collectible", COLLECTIBLE_LITTLE_AURI, EID.TRANSFORMATION["CONJOINED"])
      EID:addCollectible(COLLECTIBLE_PRINCESS_BABY,
        "Spawns a familiar that fires red diamond tears#high fire rate and deal 3 damage per shot#reduce more fireRate with king baby#have a chance to shoot fear tears")
      EID:assignTransformation("collectible", COLLECTIBLE_PRINCESS_BABY, EID.TRANSFORMATION["CONJOINED"])
    end
  end

  for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)

    if EID and player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") then
      EID:addCollectible(CollectibleType.COLLECTIBLE_GLOWING_HOUR_GLASS,
        "{{ColorRainbow}}When Auri hold this#{{ColorRainbow}}She'll rewind time when she died#{{ColorRainbow}}Has a chance to slow all enemy in the room when Auri take damage. (scales with luck)")
      EID:addCollectible(CollectibleType.COLLECTIBLE_LAZARUS_RAGS,
        "{{ColorRainbow}}When dead, turn into Risen Auri and set Auri heart to 1 heart and gain the Anemic item")
      EID:addCollectible(CollectibleType.COLLECTIBLE_JUDAS_SHADOW,
        "{{ColorRainbow}}When dead, turn into Shadow Auri and gain Damage x 2")
      EID:addCollectible(CollectibleType.COLLECTIBLE_ANKH, "{{ColorRainbow}}Turn into Dead Auri on death")
      EID:addCollectible(CollectibleType.COLLECTIBLE_MY_SHADOW,
        "{{ColorRainbow}}Every time enter a room there's 1/9 chance to turn Auri into Shadow Auri")

      EID:addCollectible(COLLECTIBLE_LITTLE_AURI, "{{ColorSilver}}Oh! that little me isn't it!!??")
      EID:assignTransformation("collectible", COLLECTIBLE_LITTLE_AURI, EID.TRANSFORMATION["CONJOINED"])
      EID:addCollectible(COLLECTIBLE_PRINCESS_BABY, "{{ColorSilver}}Look! it's little me but black! *giggle*")
      EID:assignTransformation("collectible", COLLECTIBLE_PRINCESS_BABY, EID.TRANSFORMATION["CONJOINED"])
    end
  end
  for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)

    if EID and player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) then
      EID:addCollectible(CollectibleType.COLLECTIBLE_SATANIC_BIBLE,
        "{{ColorRainbow}}+1 Health up#{{ColorRainbow}}+1 Broken heart#{{ColorRainbow}}When used before a boss fight, the boss room item will be a devil deal")
      EID:addCollectible(CollectibleType.COLLECTIBLE_BOOK_OF_REVELATIONS,
        "{{ColorRainbow}}Remove 1 Broken heart#{{ColorRainbow}}Higher horsemen chance if used#{{ColorRainbow}}+17.5% devil deal chance")
      EID:addCollectible(CollectibleType.COLLECTIBLE_THE_NAIL,
        "{{ColorRainbow}}+ Half Red heart#{{ColorRainbow}}+2.0 Damage up#{{ColorRainbow}}-0.18 Speed down#{{ColorRainbow}}Deal contact Damage#{{ColorRainbow}}Crush rocks")
      EID:addCollectible(CollectibleType.COLLECTIBLE_GLOWING_HOUR_GLASS, "{{ColorSilver}}No turning back.")
      EID:addCollectible(COLLECTIBLE_BROKEN_GLOWING_HOURGLASS, "{{ColorSilver}}No chance to rewind time")

      EID:addCollectible(CollectibleType.COLLECTIBLE_LAZARUS_RAGS,
        "{{ColorRainbow}}When dead, turn into Risen Auri and set Auri heart to 1 heart and gain the Anemic item")
      EID:addCollectible(CollectibleType.COLLECTIBLE_JUDAS_SHADOW,
        "{{ColorRainbow}}When dead, turn into Shadow Auri and gain Damage x 2")
      EID:addCollectible(CollectibleType.COLLECTIBLE_ANKH, "{{ColorRainbow}}Turn into Dead Auri on death")
      EID:addCollectible(CollectibleType.COLLECTIBLE_MY_SHADOW,
        "{{ColorRainbow}}Every time enter a room there's 1/9 chance to turn Auri into Shadow Auri")

      EID:addCollectible(COLLECTIBLE_LITTLE_AURI, "{{ColorSilver}}..me?")
      EID:assignTransformation("collectible", COLLECTIBLE_LITTLE_AURI, EID.TRANSFORMATION["CONJOINED"])

    end
  end
end

Auriz:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, Auriz.OnGameStart)

