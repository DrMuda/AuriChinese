Auriz = RegisterMod("Little Auri", 1)

local sfx = SFXManager()
local game = Game()
local rng = RNG()
local ItemPool = Game():GetItemPool()
local seeds = game:GetSeeds()
local mombox = Isaac.GetItemIdByName("Mom's Box")
local carbat = Isaac.GetItemIdByName("Car Battery")
local Birthright = CollectibleType.COLLECTIBLE_BIRTHRIGHT
local BlackCandle = CollectibleType.COLLECTIBLE_BLACK_CANDLE
AuriMod = Auriz 
SoundEffect.IRIS_HURT = Isaac.GetSoundIdByName("IristeruHurt")
SoundEffect.SOUND_BROKEN = Isaac.GetSoundIdByName("Broken")
SoundEffect.AURI_HURT = Isaac.GetSoundIdByName("AuriHurt")
SoundEffect.AURI_DIE = Isaac.GetSoundIdByName("AuriDie")
SoundEffect.AURI_GLITCH = Isaac.GetSoundIdByName("AuriGlitch")
SoundEffect.MECHA_AURI_FLY = Isaac.GetSoundIdByName("Mechafly")
SoundEffect.MECHA_AURI_SHOOT = Isaac.GetSoundIdByName("Mechashoot")
SoundEffect.MECHA_AURI_TRAN = Isaac.GetSoundIdByName("Mechatran")
SoundEffect.MECHA_AURI_WALK = Isaac.GetSoundIdByName("Mechawalk")
SoundEffect.MECHA_AURI_HURT = Isaac.GetSoundIdByName("MechaAuriHurt")
SoundEffect.AURI_GIGGLE = Isaac.GetSoundIdByName("Aurigiggle")
SoundEffect.AURI_BERSERK_END = Isaac.GetSoundIdByName("AuriBerserkend")
SoundEffect.AURI_BERSERK_END2 = Isaac.GetSoundIdByName("AuriBerserkend2")
SoundEffect.DEATH_CARD_RE = Isaac.GetSoundIdByName("Deathcardre")
COLLECTIBLE_AZRAELROBE = Isaac.GetItemIdByName("Azraelrobe")

local json = require("json")

include('aurimod.aurimod_repento')
include('aurimod.aurimod_extra')
include('aurimod.aurimod_willremovesoon')
include('aurimod.aurimod_repentogon')

function Auriz:StartRun(_,player,IsContinued,isSave)
  if Auriz:HasData() then
    local table = json.decode(Auriz:LoadData())

    LoadData(table.AuriAchievements)

 end
   for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
    player:AddCacheFlags(CacheFlag.CACHE_ALL)
	player:EvaluateItems()
	end

	Auri_Marks_Check = false

		if Isaac.GetChallenge() == Challenge.CHALLENGE_SOLAR_SYSTEM 
		or Isaac.GetChallenge() == Challenge.CHALLENGE_CAT_GOT_YOUR_TONGUE
		or Isaac.GetChallenge() == Challenge.CHALLENGE_BEANS
		or Isaac.GetChallenge() == Challenge.CHALLENGE_BLUE_BOMBER
		or Isaac.GetChallenge() == Challenge.CHALLENGE_BRAINS
		or Isaac.GetChallenge() == Challenge.CHALLENGE_GUARDIAN
		or Isaac.GetChallenge() == Challenge.CHALLENGE_SCAT_MAN
		or Isaac.GetChallenge() == Challenge.CHALLENGE_BAPTISM_BY_FIRE
		or Isaac.GetChallenge() == Challenge.CHALLENGE_HOT_POTATO
		then

    local itemPool = game:GetItemPool()
          itemPool:RemoveCollectible(COLLECTIBLE_FIRE_SPELLBOOK)
          itemPool:RemoveCollectible(COLLECTIBLE_AQUA_SPELLBOOK)
		  itemPool:RemoveCollectible(COLLECTIBLE_ZAP_SPELLBOOK)
		  itemPool:RemoveCollectible(COLLECTIBLE_HOLY_SPELLBOOK)
		  itemPool:RemoveCollectible(COLLECTIBLE_TERRA_SPELLBOOK)
		  itemPool:RemoveCollectible(COLLECTIBLE_MAGICAL_CHEST)
		  itemPool:RemoveTrinket(TrinketType.TRINKET_FIRE_SPELL_SCROLL)
        end

end

Auriz:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, Auriz.StartRun) 

function Auriz:Exit(shouldSave)

  local saveData = {

    AuriAchievements = SaveData(),

  }
  Auriz:SaveData(json.encode(saveData))
end
Auriz:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, Auriz.Exit)

function Auriz:AuriSaveData()
  local saveData = {
    AuriAchievements = SaveData(),
  }
  Auriz:SaveData(json.encode(saveData))
  print("AuriMod Data is saved!")
end

function Auriz:Render()
  DisplaySprites()
end
Auriz:AddCallback(ModCallbacks.MC_POST_RENDER, Auriz.Render)

function Auriz:Update()
  UpdateSprites()
end
Auriz:AddCallback(ModCallbacks.MC_POST_UPDATE, Auriz.Update)

function Auriz:OnUpdate(player)
    if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") then

        player:AddSoulHearts(6)

        player:AddCollectible(415, 0, false)

        player:GetSprite():Load("gfx/Auri_base.anm2", true) 

    end

    if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Auri") then
        player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/dark_auri_hair.anm2"))

		if AuriAchievements.UnlockPocketDarkHour then
            player:AddCollectible(COLLECTIBLE_DARK_GLOWING_HOURGLASS, 3, false)
        end

        if math.random(5, 9) == 9 then
            sfx:Play(SoundEffect.AURI_GIGGLE, 6, 0, false, 1)
        end
        player:GetSprite():Load("gfx/Auri_dark.anm2", true)

    end
    if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Milcah") then
        player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/dpc_auri_hair.anm2"))

        player:AddCollectible(442) 
        player:AddMaxHearts(4)
        player:AddHearts(4)
        player:AddCollectible(COLLECTIBLE_DYING)
        if AuriAchievements.Unlock_BloodyHourGlass then
            player:AddCollectible(COLLECTIBLE_BLOODY_HOURGLASS)

        end
        player:GetSprite():Load("gfx/Auri_dpc.anm2", true)
    end

    if (player:GetName() == "Mage Auri") then
        player:GetSprite():Load("gfx/Auri_mage.anm2", true)
        player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/mage_auri_hat_newhair.anm2"))

        local Magerobe = Isaac.GetItemConfig():GetCollectible(COLLECTIBLE_MAGE_ROBE)
        player:AddCostume(Magerobe, false)

        player:AddCollectible(COLLECTIBLE_ENCHANTED_BOOK, 2, false) 
        player:AddCollectible(358, 0, false) 

    end

    if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Naamah") then
        player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/demonic_auri_hair.anm2"))
        player:AddCollectible(699, 6, false)
        player:AddCollectible(COLLECTIBLE_SEDUCE, 4, false)
        player:GetSprite():Load("gfx/Auri_demonic.anm2", true)

    end

    if (player:GetName() == "Demonic Auri WIP") then
        player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/aurihair.anm2"))
		game:FinishChallenge()

    end

    if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Depressed Auri") then
        player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/depressed_auri_hair.anm2"))
        player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auri_hanggirl.anm2"))
        player:AddCollectible(469, 0, false) 
        player:AddCollectible(694, 0, false) 

        player:AddBrokenHearts(-3)
        player:AddCollectible(COLLECTIBLE_OLD_ROPE, 4, false)
        player:GetSprite():Load("gfx/Auri_hang.anm2", true)

        seeds:AddSeedEffect(SeedEffect.SEED_SLOW_MUSIC)

    end

    if FiendFolio and player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) then
        game:GetHUD():ShowItemText("More enemies to kill.")
    end
    if not EID and player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri", false) then
        game:GetHUD():ShowItemText("Auri respects you.")
    end

end

Auriz:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, Auriz.OnUpdate)

local function onStart(_,player,IsContinued)
local player = Isaac.GetPlayer(0);
    player:AddCacheFlags(CacheFlag.CACHE_ALL)
	player:EvaluateItems()

local level = Game():GetLevel()
    if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Azrael") then

	end

	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Auri") then
	player:AddBrokenHearts(-12)
	end

local itemPool = game:GetItemPool() 
        if player:GetPlayerType() == PlayerType.PLAYER_AURI
        or player:GetPlayerType() == PlayerType.PLAYER_TAINTED_AURII
        or player:GetPlayerType() == PlayerType.PLAYER_DARK_AURI
        or player:GetPlayerType() == PlayerType.PLAYER_TAINTED_DARK_AURI
        or player:GetPlayerType() == PlayerType.PLAYER_MAGE_AURI
        or player:GetPlayerType() == PlayerType.PLAYER_NECROMANTRESS_AURI
        or player:GetPlayerType() == PlayerType.PLAYER_DEPRESSED_AURI
        or player:GetPlayerType() == PlayerType.PLAYER_CURSED_AURI
        or player:GetPlayerType() == PlayerType.PLAYER_DARK_PRINCESS_AURI
		or player:GetPlayerType() == PlayerType.PLAYER_QUEEN_AURI
		or player:GetPlayerType() == PlayerType.PLAYER_ASCEND_AURI
		or player:GetPlayerType() == PlayerType.PLAYER_FALLEN_AURI
		or player:GetPlayerType() == PlayerType.PLAYER_DEMONIC_AURI
		or player:GetPlayerType() == PlayerType.PLAYER_WIP_AURI
		or player:GetPlayerType() == PlayerType.PLAYER_GLITCH_AURI
		or player:GetPlayerType() == PlayerType.PLAYER_ERROR_AURI
		or player:GetPlayerType() == PlayerType.PLAYER_SOULBOUND_AURI
		or player:GetPlayerType() == PlayerType.PLAYER_SPIRIT_SHACKLES_AURI
		or player:GetPlayerType() == PlayerType.PLAYER_ROTTEN_AURI
		or player:GetPlayerType() == PlayerType.PLAYER_ZOMBIE_AURI
		or player:GetPlayerType() == PlayerType.PLAYER_WIPP_AURI
		or player:GetPlayerType() == PlayerType.PLAYER_WIPPP_AURI

        then
			itemPool:RemoveTrinket(TrinketType.TRINKET_FOUND_SOUL)
		end
end
Auriz:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, onStart) 

Auriz:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, function()
	if #Isaac.FindByType(EntityType.ENTITY_PLAYER) == 0 then
		Isaac.ExecuteCommand("reloadshaders")
	end
end)

function Auriz:onInit()
	doYon = false
	HasBcandle = false
	DeadAuri = false
	ShadowAuri = false
	ShadowAurii = false
	RaisenAuri = false
	DarkprincesAuri = false
	BerSerkAuri = false
	ShaAuri = false
	scaredoYon = false
	ErrorAuri = false
	SpooAuri = false
	AuriSecondForm = false
	MechaAuri = false
	ShadowAuriiFlyna = false
	ShadowAuriFlyna = false
	Errorflyna = false
	DeadAuriFlyna = false
	Mechaflyna = false
	Crowngethit = false
	Holdknife = false
	undying = false
	AuriiUndyingfirst = false
    HasUndying = false
	HasLibra = false
	corsfxeff = false
	heartbeatsfx = false
	AuriiSoulCollect = 0

	AfterlifeAuri = 10

	toothhead = false
	toothhead2 = false
	HasSoulboundBC = false
    GenoAuriStart = false
	RottenBirth = false

	UseBloodyHour = true 
	CorruptHeart = 0 
	AuriUnlockCheck = false
	ErrorBuybirth = false
	BlessD6count = 0
	retime = 60
	CoDGulp = false
	Darkpennystack = 0

	aurimod_souldamage = 0 
	AuriHeartless = false 
	HasRogustHoodie = false 
	HasShadowVenus = false 
	Luckypennyformage = 0 
	IsGuppyz = false
	DpenyGulp = false

	GoldenCrownStarto = false
	GoldenCrownStartotwo = false
	Goldenbossroo = false
	Goldenbossroom = false
	GoldenCrowngethit = false
	GoldenCrownDone = false
	playhitsoundG = false
	Auribirthright = false 
	DyingActive = false
    Heartsive = false
	Saheart = false
	Qpass = false
	Qstart = false
	HasRedemp = false
	Azcended1 = false
	Azcended2 = false
	Azcended3 = false
	Azcended4 = false

	witchbrew = 0
	DyingCheck = false
	Heartlessangelcheck = false
	BloodyHeart = 0 

Fleetfoothit = false
eatentrinketATK = 0
eatentrinketRANG = 0
eatentrinketTEARS = 0
eatentrinketSHOTSPD = 0
eatentrinketSPD = 0
delilahtempDMG = 0
delilahlogtempDMG = 0

retime = 40
MindbreakCD = 900
Calmmindbreak = false 
halototime = 150
JudementHit = false
judgementCD = 300

Auri_hitcountunlock = 0
DelilahTreasureVisit = 0
flowercrownroompass = 0
auri_watermeloncount = 0
auri_watermelonjanocount = 0

	Auri_Marks_Check = false

end 

Auriz:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, Auriz.onInit) 

function Auriz:TrinketInit(player) 

	            if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") then

				elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Auri") then
				player:AddTrinket(TrinketType.TRINKET_DARK_AURI_CROWN)
				player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER, false, false, true, true)

				elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Milcah") then
				player:AddTrinket(TrinketType.TRINKET_MILCAHS_FAITH)

				elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Depressed Auri") then
				player:AddTrinket(TrinketType.TRINKET_KEEPERS_BARGAIN)
				player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER, false, false, true, true)

				elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Naamah") then
				player:AddTrinket(TrinketType.TRINKET_AZAZELS_STUMP)
				player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER, false, false, true, true)

				elseif player:GetName() == "Famish" then

				player:AddTrinket(TrinketType.TRINKET_CRICKET_LEG)
				player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER, false, false, true, true)

                elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Delilah") then
				player:AddTrinket(TrinketType.TRINKET_SAMSONS_LOCK)

				elseif player:GetName() == "Glitch Auri" then
				player:AddTrinket(138)
				player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER, false, false, true, true)
				elseif player:GetName() == "Error Auri" then

				player:AddTrinket(75)
				player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER, false, false, true, true)

        end
end

Auriz:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, Auriz.TrinketInit)

function Auriz:onUpdate()

	if game:GetFrameCount() == 1 then

       AuriAchievements.JustHasCorruptedHeart = false
	   AuriAchievements.JustHasCorruptedHeart_Beth = false
	   AuriAchievements.JustHasCorruptedHeart_Keeper = false
	   AuriAchievements.JustHasCorruptedHeart_Forgotten = false
	   AuriAchievements.JustHasCorruptedHeart_Jacob = false 
	   AuriAchievements.JustHasCorruptedHeart_Esau = false 

	   AuriAchievements.EnchantedBookLuck = 0
	   AuriAchievements.CalmmindDmg = 0
	   AuriAchievements.witchsoupluck = 30
	   AuriAchievements.Enchantpennystack = 0
	   AuriAchievements.HorCoffeeboost = 2
	   AuriAchievements.Candy = 0
	   AuriAchievements.H_Coffee = 0
	   AuriAchievements.V_accine = 0
	   AuriAchievements.Y_meat = 0
	   AuriAchievements.Gp_ears = 0

    end

	 local player = Isaac.GetPlayer(0)
	if game:GetFrameCount() == 1 then
       if AuriAchievements.Unlockhourglass 
	   and player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri")
	   and not player:HasCollectible(422) then
	   player:AddCollectible(422, 3, false)

	   end

       if AuriAchievements.UnlockPocketDarkHour
	   and player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Auri")
	   and not player:HasCollectible(COLLECTIBLE_DARK_GLOWING_HOURGLASS) then
	   player:AddCollectible(COLLECTIBLE_DARK_GLOWING_HOURGLASS, 3, false)

	   end

	   if AuriAchievements.Unlock_BloodyHourGlass
	   and player:GetPlayerType() == Isaac.GetPlayerTypeByName("Milcah")
	   and not player:HasCollectible(COLLECTIBLE_BLOODY_HOURGLASS) then
	   player:AddCollectible(COLLECTIBLE_BLOODY_HOURGLASS)

	   end

    end

end

Auriz:AddCallback(ModCallbacks.MC_POST_UPDATE, Auriz.onUpdate)

local IncubusAltskin = Isaac.GetEntityVariantByName("Incubus")

function Auriz:IncubusUpdate(Incubus)
  local player = Isaac.GetPlayer(0);
  local sprite = Incubus:GetSprite()
  if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") then
    sprite:ReplaceSpritesheet(0,"gfx/familiar/iris_incubus.png")
    sprite:LoadGraphics()
    Incubus:GetData().PlayerType = playertype
  end
  if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) then
    sprite:ReplaceSpritesheet(0,"gfx/familiar/darkiris_incubus.png")
    sprite:LoadGraphics()
    Incubus:GetData().PlayerType = playertype
  end
   if (player:GetName() == "Iristeru") then
    sprite:ReplaceSpritesheet(0,"gfx/familiar/darkiris_incubus.png")
    sprite:LoadGraphics()
    Incubus:GetData().PlayerType = playertype
  end
  if (player:GetName() == "Iris") then
    sprite:ReplaceSpritesheet(0,"gfx/familiar/darkiris_incubus.png")
    sprite:LoadGraphics()
    Incubus:GetData().PlayerType = playertype
  end
  if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Auri") then
    sprite:ReplaceSpritesheet(0,"gfx/familiar/darkiris_incubus.png")
    sprite:LoadGraphics()
    Incubus:GetData().PlayerType = playertype
  end
  if (player:GetName() == "Dark Corrupted Auri") then
    sprite:ReplaceSpritesheet(0,"gfx/familiar/darkiris_incubus.png")
    sprite:LoadGraphics()
    Incubus:GetData().PlayerType = playertype
  end
  if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Milcah") then
    sprite:ReplaceSpritesheet(0,"gfx/familiar/darkiris_incubus.png")
    sprite:LoadGraphics()
    Incubus:GetData().PlayerType = playertype
  end
  if (player:GetName() == "Mage Auri") then
    sprite:ReplaceSpritesheet(0,"gfx/familiar/darkiris_incubus.png")
    sprite:LoadGraphics()
    Incubus:GetData().PlayerType = playertype
  end
  if (player:GetName() == "Dark Mage Auri") then
    sprite:ReplaceSpritesheet(0,"gfx/familiar/darkiris_incubus.png")
    sprite:LoadGraphics()
    Incubus:GetData().PlayerType = playertype
  end

end

local MiniSkinColor = {
    [-1]=".png",
	[0]="_white.png",
	[1]="_black.png",
	[2]="_blue.png",
	[3]="_red.png",
	[4]="_green.png",
	[5]="_grey.png"
}

function Auriz:ReplaceSpritesheet(minisaac)
    local player = minisaac.Player
    local sprite = minisaac:GetSprite()
	local playercolor = player:GetHeadColor()

	if player:HasCollectible(COLLECTIBLE_THE_MEMORY) then return end
	  if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Auri")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Corrupted Auri", true)

    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Queen Auri", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Mage Auri")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Mage Auri", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Depressed Auri")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Cursed Auri", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Soulbound Auri")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Soul Shackles Auri", true)

    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Zombie Auri", true)

    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Fallen Auri", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Glitch Auri")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Error Auri", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Naamah")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Demonic Auri WIP", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Genocide Auri?")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Genocide Auri?", true)

    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Future Auri", true)
then
        sprite:ReplaceSpritesheet(0, "gfx/familiar/familiar_minisaac_auri"..MiniSkinColor[playercolor])
        sprite:ReplaceSpritesheet(1, "gfx/familiar/familiar_minisaac_auri"..MiniSkinColor[playercolor])

    end
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Milcah") then
	    sprite:ReplaceSpritesheet(0, "gfx/familiar/familiar_minisaac_milcah_black.png")
        sprite:ReplaceSpritesheet(1, "gfx/familiar/familiar_minisaac_milcah_black.png")
	end
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Delilah") then
        sprite:ReplaceSpritesheet(0, "gfx/familiar/familiar_minisaac_delilah"..MiniSkinColor[playercolor])
        sprite:ReplaceSpritesheet(1, "gfx/familiar/familiar_minisaac_delilah"..MiniSkinColor[playercolor])
    end
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Azrael") then
        sprite:ReplaceSpritesheet(0, "gfx/familiar/familiar_minisaac_azrael"..MiniSkinColor[playercolor])
        sprite:ReplaceSpritesheet(1, "gfx/familiar/familiar_minisaac_azrael"..MiniSkinColor[playercolor])
    end
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Naamah") then
        sprite:ReplaceSpritesheet(0, "gfx/familiar/familiar_minisaac_naamah"..MiniSkinColor[playercolor])
        sprite:ReplaceSpritesheet(1, "gfx/familiar/familiar_minisaac_naamah"..MiniSkinColor[playercolor])
    end
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Famish") then
        sprite:ReplaceSpritesheet(0, "gfx/familiar/familiar_minisaac_famish"..MiniSkinColor[playercolor])
        sprite:ReplaceSpritesheet(1, "gfx/familiar/familiar_minisaac_famish"..MiniSkinColor[playercolor])
    end

  sprite:LoadGraphics()
end

Auriz:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Auriz.ReplaceSpritesheet, FamiliarVariant.MINISAAC)

local  Auri = { 
    DAMAGE = 0, 
    SPEED = -0.1,
	TEARS = 0,
    SHOTSPEED = 0.1,
    TEARHEIGHT = 0,
    TEARFALLINGSPEED = 0,
    LUCK = 0,
    FLYING = false,                                 
    TEARFLAG = 0,
    TEARCOLOR = Color(1.0, 1.0, 1.0, 1.0, 0, 0, 0)
}

local Mechatears = {
  TEARCOLOR = Color(255, 141, 64, 1, 80, 0, 0)
}

function Auri:onCache(player, cacheFlag)
    if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") then
        if cacheFlag == CacheFlag.CACHE_DAMAGE then
            player.Damage = player.Damage + Auri.DAMAGE
        end
		if cacheFlag == CacheFlag.CACHE_DAMAGE then
		  if ShadowAuri or ShaAuri or DeadAuri or RaisenAuri then
			player.Damage = player.Damage + 1.6
		  end
		end

		if cacheFlag == CacheFlag.CACHE_DAMAGE then
		  if not player:GetEffects():GetCollectibleEffect(CollectibleType.COLLECTIBLE_CROWN_OF_LIGHT) then
			player.Damage = player.Damage / 2
		  end
		end
		if cacheFlag == CacheFlag.CACHE_DAMAGE then
		  if player:GetEffects():GetCollectibleEffect(CollectibleType.COLLECTIBLE_CROWN_OF_LIGHT) then
			player.Damage = player.Damage -2
		  end
		end

		if cacheFlag == CacheFlag.CACHE_DAMAGE then
		  if DarkprincesAuri then
			player.Damage = player.Damage + 1.9
			player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_PACT, true)
			player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/dpc_auri_hair_old_for_auri.anm2"))
		  end
		end
		if cacheFlag == CacheFlag.CACHE_DAMAGE then
		 if BerSerkAuri then
			player.Damage = player.Damage + 9.99

		  end
		end
		if cacheFlag == CacheFlag.CACHE_DAMAGE then
		 if player:HasCollectible(COLLECTIBLE_THE_MEMORY) then
			player.Damage = player.Damage + 0.9
		  end
		end
		if cacheFlag == CacheFlag.CACHE_FIREDELAY  then

        end
		if cacheFlag == CacheFlag.CACHE_FIREDELAY  then
		if player:HasCollectible(COLLECTIBLE_THE_MEMORY) then
            player.MaxFireDelay = fromTears(toTears(player.MaxFireDelay) + 1)
        end
		end
		 if cacheFlag == CacheFlag.CACHE_SPEED then
		 if player:HasCollectible(COLLECTIBLE_THE_MEMORY) then
            player.MoveSpeed = player.MoveSpeed + 0.4
			end
        end
        if cacheFlag == CacheFlag.CACHE_SHOTSPEED then
            player.ShotSpeed = player.ShotSpeed + Auri.SHOTSPEED
        end
        if cacheFlag == CacheFlag.CACHE_RANGE then
            player.TearHeight = player.TearHeight - Auri.TEARHEIGHT
            player.TearFallingSpeed = player.TearFallingSpeed + Auri.TEARFALLINGSPEED
        end
        if cacheFlag == CacheFlag.CACHE_SPEED then
            player.MoveSpeed = player.MoveSpeed + Auri.SPEED
        end

        if cacheFlag == CacheFlag.CACHE_LUCK then
            player.Luck = player.Luck + Auri.LUCK
        end

		 if cacheFlag == CacheFlag.CACHE_LUCK then
		 if player:HasCollectible(COLLECTIBLE_THE_MEMORY) then
            player.Luck = player.Luck + 3
        end
		end
        if cacheFlag == CacheFlag.CACHE_FLYING and Auri.FLYING then
            player.CanFly = true
        end
        if cacheFlag == CacheFlag.CACHE_TEARFLAG then
            player.TearFlags = player.TearFlags | Auri.TEARFLAG
        end
        if cacheFlag == CacheFlag.CACHE_TEARCOLOR then
            player.TearColor = Auri.TEARCOLOR
        end

    end
end

Auriz:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Auri.onCache)

function Auriz:onRender()

    for i = 1, Game():GetNumPlayers() do 
        local player = Isaac.GetPlayer(i - 1)
        if
            player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and not MechaAuri or
                player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and DeadAuri or
                player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and RaisenAuri or
                player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and ShadowAuri or
                player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and DarkprincesAuri or
                player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and ErrorAuri or
                player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Auri") or
                player:GetPlayerType() == Isaac.GetPlayerTypeByName("Milcah") or
                (player:GetName() == "Mage Auri") or
                player:GetPlayerType() == Isaac.GetPlayerTypeByName("Depressed Auri") or
                (player:GetName() == "Glitch Auri") or
                (player:GetName() == "Error Auri") or
                player:GetPlayerType() == Isaac.GetPlayerTypeByName("Naamah") or
                (player:GetName() == "Famish") or
				(player:GetName() == "Delilah") or
                (player:GetName() == "Dark Corrupted Auri") or
                (player:GetName() == "Queen Auri") or
                (player:GetName() == "Dark Mage Auri") or
                (player:GetName() == "Cursed Auri") or
                (player:GetName() == "Soulbound Auri") or
                (player:GetName() == "Soul Shackles Auri") or
                (player:GetName() == "Zombie Auri") or
                player:GetPlayerType() == Isaac.GetPlayerTypeByName("Azrael") or
                (player:GetName() == "Fallen Auri") or
				(player:GetName() == "Aurimp") 

         then

            if sfx:IsPlaying(SoundEffect.SOUND_ISAAC_HURT_GRUNT) then
                sfx:Stop(SoundEffect.SOUND_ISAAC_HURT_GRUNT)
                sfx:Play(SoundEffect.AURI_HURT, 1, 0, false, 1)
            end
            if sfx:IsPlaying(SoundEffect.SOUND_ISAACDIES) then
                sfx:Stop(SoundEffect.SOUND_ISAACDIES)
                sfx:Play(SoundEffect.AURI_DIE, 1, 0, false, 1)
            end
        elseif
            player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and not MechaAuri or
                player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and DeadAuri or
                player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and RaisenAuri or
                player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and ShadowAuri or
                player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and DarkprincesAuri or
                player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and ErrorAuri
         then
            if sfx:IsPlaying(SoundEffect.SOUND_ISAAC_HURT_GRUNT) then
                sfx:Stop(SoundEffect.SOUND_ISAAC_HURT_GRUNT)
                sfx:Play(SoundEffect.AURI_HURT, 1, 0, false, 1)
            end
            if sfx:IsPlaying(SoundEffect.SOUND_ISAACDIES) then
                sfx:Stop(SoundEffect.SOUND_ISAACDIES)
                sfx:Play(SoundEffect.AURI_DIE, 1, 0, false, 1)
            end
        end
    end
    local player = Isaac.GetPlayer(0)
    if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and MechaAuri then 
        if sfx:IsPlaying(SoundEffect.SOUND_ISAAC_HURT_GRUNT) then
            sfx:Stop(SoundEffect.SOUND_ISAAC_HURT_GRUNT)
            sfx:Play(SoundEffect.MECHA_AURI_HURT, 1, 0, false, 1)
        end
        if sfx:IsPlaying(SoundEffect.SOUND_ISAACDIES) then
            sfx:Stop(SoundEffect.SOUND_ISAACDIES)
            sfx:Play(SoundEffect.AURI_DIE, 1, 0, false, 1)
        end
    elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and MechaAuri then
        if sfx:IsPlaying(SoundEffect.SOUND_ISAAC_HURT_GRUNT) then
            sfx:Stop(SoundEffect.SOUND_ISAAC_HURT_GRUNT)
            sfx:Play(SoundEffect.MECHA_AURI_HURT, 1, 0, false, 1)
        end
        if sfx:IsPlaying(SoundEffect.SOUND_ISAACDIES) then
            sfx:Stop(SoundEffect.SOUND_ISAACDIES)
            sfx:Play(SoundEffect.AURI_DIE, 1, 0, false, 1)
        end
    end

    local player = Isaac.GetPlayer(0)
    if (player:GetName() == "Iris") or (player:GetName() == "Iristeru") then
        if sfx:IsPlaying(SoundEffect.SOUND_ISAAC_HURT_GRUNT) then
            sfx:Stop(SoundEffect.SOUND_ISAAC_HURT_GRUNT)
            sfx:Play(SoundEffect.IRIS_HURT, 15, 0, false, 1)
        end
        if sfx:IsPlaying(SoundEffect.SOUND_ISAACDIES) then
            sfx:Stop(SoundEffect.SOUND_ISAACDIES)

        end
    end

    local player = Isaac.GetPlayer(0)

    if player:HasCollectible(COLLECTIBLE_THE_MEMORY) then
        if sfx:IsPlaying(SoundEffect.SOUND_MOM_AND_DAD_1) then
            sfx:Stop(SoundEffect.SOUND_MOM_AND_DAD_1)
            sfx:Play(SoundEffect.AURI_HURT, 9, 0, false, 1) 
        end
        if sfx:IsPlaying(SoundEffect.SOUND_MOM_AND_DAD_2) then
            sfx:Stop(SoundEffect.SOUND_MOM_AND_DAD_2)
            sfx:Play(SoundEffect.AURI_HURT, 9, 0, false, 1)
        end
        if sfx:IsPlaying(SoundEffect.SOUND_MOM_AND_DAD_3) then
            sfx:Stop(SoundEffect.SOUND_MOM_AND_DAD_3)
            sfx:Play(SoundEffect.AURI_HURT, 9, 0, false, 1)
        end
        if sfx:IsPlaying(SoundEffect.SOUND_MOM_AND_DAD_4) then
            sfx:Stop(SoundEffect.SOUND_MOM_AND_DAD_4)
            sfx:Play(SoundEffect.AURI_HURT, 9, 0, false, 1)
        end
    end
end

Auriz:AddCallback(ModCallbacks.MC_POST_RENDER, Auriz.onRender)

function ZombieAuri()

	for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
      if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and DeadAuri 
	  or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and ShadowAuri 
	  or (player:GetName() == "Dark Corrupted Auri") 

	  or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Depressed Auri") then
	    if player:GetMaxHearts() >0 then
           GotMaxHealth = player:GetMaxHearts()
           player:AddMaxHearts(-GotMaxHealth)
           player:AddSoulHearts(GotMaxHealth)
           GotMaxHealth = 0
        end
	   end
    end

	for i = 1, Game():GetNumPlayers() do  
    local player = Isaac.GetPlayer(i - 1)
      if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri test") then
	    if player:GetPlayerType() == PlayerType.PLAYER_NOTYET and player:GetMaxHearts() >0 then
		   MaxheartToRemove = player:GetMaxHearts()
		   player:AddMaxHearts(-MaxheartToRemove)
		   player:AddBoneHearts(MaxheartToRemove/2)
		   player:AddHearts(MaxheartToRemove)
		end
      end
   end
end

Auriz:AddCallback(ModCallbacks.MC_POST_UPDATE, ZombieAuri)

function AuriHour()
  local player = Isaac.GetPlayer(0);
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and player:HasCollectible(422) then
	chancetoslow = math.random(0, 99) + player.Luck*1.5
	if chancetoslow >= 95  then
	player:UseActiveItem(CollectibleType.COLLECTIBLE_HOURGLASS,false,false,false,false)
	end
	elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and player:HasCollectible(422) then
	chancetoslow = math.random(0, 99) + player.Luck*1.5
	if chancetoslow >= 95  then
	player:UseActiveItem(CollectibleType.COLLECTIBLE_HOURGLASS,false,false,false,false)
	end
  end
end

Auriz:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, AuriHour, EntityType.ENTITY_PLAYER)

function Auripassive()
	local player = Isaac.GetPlayer(0) 

		if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and
	    player:IsDead() and player:GetExtraLives() <= 1 and player:HasCollectible(422) then

		player:Revive()
		player:UseActiveItem(CollectibleType.COLLECTIBLE_GLOWING_HOUR_GLASS)
		doYon = true

		elseif (player:GetName() == "aurisomthing") and 
	    player:IsDead() and player:GetExtraLives() <= 1 and player:HasCollectible(422) 
		or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Milcah") and
	    player:IsDead() and player:GetExtraLives() <= 1 and player:HasCollectible(422)
		or (player:GetName() == "Mage Auri") and
	    player:IsDead() and player:GetExtraLives() <= 1 and player:HasCollectible(422)
		or (player:GetName() == "Dark Mage Auri") and
	    player:IsDead() and player:GetExtraLives() <= 1 and player:HasCollectible(422)
		or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Depressed Auri") and
	    player:IsDead() and player:GetExtraLives() <= 1 and player:HasCollectible(422)
		or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Naamah") and
	    player:IsDead() and player:GetExtraLives() <= 1 and player:HasCollectible(422)
		then

		player:Revive()
		player:UseActiveItem(CollectibleType.COLLECTIBLE_GLOWING_HOUR_GLASS)
		doYon = true

	    end
		if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and
	    player:IsDead() and player:GetExtraLives() <= 1 and player:HasCollectible(COLLECTIBLE_DARK_GLOWING_HOURGLASS) then
		player:Revive()
		player:UseActiveItem(CollectibleType.COLLECTIBLE_GLOWING_HOUR_GLASS)
		scaredoYon = true

		elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and
	    player:IsDead() and player:GetExtraLives() <= 1 and player:HasCollectible(COLLECTIBLE_DARK_GLOWING_HOURGLASS) then

		player:Revive()
		player:UseActiveItem(CollectibleType.COLLECTIBLE_GLOWING_HOUR_GLASS)
		scaredoYon = true

    end
end

Auriz:AddCallback(ModCallbacks.MC_POST_UPDATE, Auripassive)

function Brokenitem()
	for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
        if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and doYon then
		player:RemoveCollectible(422)
		player:AddCollectible(COLLECTIBLE_BROKEN_GLOWING_HOURGLASS, 0, false)

		sfx:Play(SoundEffect.SOUND_GLASS_BREAK, 1, 0, false, 1)
		doYon = false
		elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and scaredoYon then
		player:RemoveCollectible(COLLECTIBLE_DARK_GLOWING_HOURGLASS)
		player:AddCollectible(COLLECTIBLE_BROKEN_GLOWING_HOURGLASS, 0, false)

		sfx:Play(SoundEffect.SOUND_MIRROR_BREAK, 1, 0, false, 2)

		scaredoYon = false
	    end
		if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and doYon then
		player:RemoveCollectible(422)
		player:AddCollectible(COLLECTIBLE_BROKEN_GLOWING_HOURGLASS, 0, false)

		sfx:Play(SoundEffect.SOUND_GLASS_BREAK, 1, 0, false, 1)
		doYon = false
		elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and scaredoYon then
		player:RemoveCollectible(COLLECTIBLE_DARK_GLOWING_HOURGLASS)
		player:AddCollectible(COLLECTIBLE_BROKEN_GLOWING_HOURGLASS, 0, false)

		sfx:Play(SoundEffect.SOUND_GLASS_BREAK, 1, 0, false, 1)
		scaredoYon = false
		end

		if (player:GetName() == "Mage Auri") and doYon
        or (player:GetName() == "Dark Mage Auri") and doYon	
		or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Milcah") and doYon
		or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Depressed Auri") and doYon	
		or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Naamah") and doYon
		then
		player:RemoveCollectible(422)
		player:AddCollectible(COLLECTIBLE_BROKEN_GLOWING_HOURGLASS, 0, false)

		sfx:Play(SoundEffect.SOUND_GLASS_BREAK, 1, 0, false, 1)
		doYon = false
	    end
		if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and deliauri then
	    player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auridelirious.anm2"))
		deliauri = false
        end
		if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and nailauri then
	    player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/aurihair_black.anm2"))
		nailauri = false
        end
		if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and nailauri then
	    player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/corrupted_auri_hair_black.anm2"))
		nailauri = false
        end
	    if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and glitchauri then
	    player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auriheadglitch.anm2"))
		player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auribodyglitch.anm2"))
		player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auribodyglitchfly.anm2"))
		glitchauri = false
        end
        local player = Isaac.GetPlayer(0);
        if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and SpooAuri then
	    player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auricorrupt.anm2"))
	    SpooAuri = false
        end
		if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and glitchauri then
	    player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auriiheadglitch.anm2"))
		player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auribodyglitch.anm2"))
		player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auribodyglitchfly.anm2"))
		glitchauri = false
        end
		if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and CorruptedAuriiHead then
	    player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auricorrupt9.anm2"))
		player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auriibodyberserk.anm2"))
		CorruptedAuriiHead = false
		end
		if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Naamah") and deliauri then
	    player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/demonic_auri_hair_delirious.anm2"))
		deliauri = false
        end
		local player = Isaac.GetPlayer(0)
	    if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") or (player:GetName() == "Glitch Auri") or (player:GetName() == "Mage Auri") then
	    if player.CanFly == true then
		    if DeadAuri then
	    player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/deadaurifly.anm2"))
		elseif ShadowAuri and ErrorAuri then
	    player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/aurishadowbodyfly.anm2"))
		elseif ErrorAuri or (player:GetName() == "Glitch Auri") then
	    player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auri_error_bodyfly.anm2"))
		elseif ShadowAuri then
	    player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/aurishadowbodyfly.anm2"))
		elseif ShadowAurii then
	    player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auriishadowbodyfly.anm2"))
		elseif AuriSecondForm then
	    player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/aurisecondfly.anm2"))
        end
		end
		end
		local player = Isaac.GetPlayer(0)
	    if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) then
	    if player.CanFly == true then
		    if DeadAuri then
	    player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/deadaurifly.anm2"))
		elseif ShadowAuri and ErrorAuri then
	    player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auriishadowbodyfly.anm2"))
		elseif ErrorAuri then
	    player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auri_error_bodyfly.anm2"))
		elseif ShadowAuri then
	    player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auriishadowbodyfly.anm2"))
		elseif ShadowAurii then
	    player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/aurishadowbodyfly.anm2"))
        end
		end
		end
  end
end

Auriz:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, Brokenitem)

local function DeliAuri()
	local player = Isaac.GetPlayer(0);
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") then
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auridelirious.anm2"))
	deliauri = true
	end
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") then
	if player.CanFly == true then
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auridelirious.anm2"))
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/deliaurifly.anm2"))
	deliauri = true
	end
	end
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Naamah") then
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/demonic_auri_hair_delirious.anm2"))
	deliauri = true
	end
end
local function NailAuri()
	local player = Isaac.GetPlayer(0);
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") then
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/aurihair_black.anm2"))
	nailauri = true
	end
	local player = Isaac.GetPlayer(0);
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) then
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/corrupted_auri_hair_black.anm2"))
	nailauri = true
	end
end
local function GlitchAuri()
	local player = Isaac.GetPlayer(0);
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") then
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auribodyglitch.anm2"))
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auriheadglitch.anm2"))
	glitchauri = true
	end
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") then
	if player.CanFly == true then
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auriheadglitch.anm2"))
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auribodyglitchfly.anm2"))
	glitchauri = true
	end
	end
	local player = Isaac.GetPlayer(0);  
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) then 
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auribodyglitch.anm2"))
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auriiheadglitch.anm2"))
	glitchauri = true
	end
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) then
	if player.CanFly == true then                           
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auriiheadglitch.anm2"))
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auribodyglitchfly.anm2"))
	glitchauri = true
	end
	end
end

Auriz:AddCallback(ModCallbacks.MC_USE_ITEM, NailAuri, CollectibleType.COLLECTIBLE_THE_NAIL)
Auriz:AddCallback(ModCallbacks.MC_USE_ITEM, DeliAuri, CollectibleType.COLLECTIBLE_DELIRIOUS)

COLLECTIBLE_BROKEN_GLOWING_HOURGLASS = Isaac.GetItemIdByName("Broken Glowing Hourglass")

local function BrokenHourglass()

	local player = Auriz:GetPlayerUsingItemz()
	if (player:GetName() ~= "Aurii") then 
	rerere = math.random(1, 9)
	if rerere == 9 then
	player:UseActiveItem(422)
	brokenhourglasswork = true
	elseif rerere ~= 9 then
	sfx:Play(SoundEffect.SOUND_THUMBS_DOWN, 1, 0, false, 1)
	player:AnimateSad()
	end
	end
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) then
	sfx:Play(SoundEffect.SOUND_THUMBS_DOWN, 1, 0, false, 1)
	player:RemoveCollectible(579) 
	player:AnimateSad()

  end
end

Auriz:AddCallback(ModCallbacks.MC_USE_ITEM, BrokenHourglass, COLLECTIBLE_BROKEN_GLOWING_HOURGLASS)

COLLECTIBLE_DARK_GLOWING_HOURGLASS = Isaac.GetItemIdByName("Dark Glowing Hourglass")

local function DarkGlowingHourglass()

	local player = Auriz:GetPlayerUsingItemz()

	if not player:HasCollectible(Birthright) then
	UseDarkHourGlass = true
	sfx:Play(SoundEffect.SOUND_DEATH_CARD, 1, 0, false, 1)
    return true
	end

  if player:HasCollectible(Birthright) then

  if UseDarkHourGlass then
  UseDarkHourGlass = false
  sfx:Play(SoundEffect.SOUND_DEATH_CARD, 1, 0, false, 1)
  player:AnimateCollectible(COLLECTIBLE_DARK_GLOWING_HOURGLASS, "UseItem", "Idle")

   return end
  end

  if not UseDarkHourGlass then
  UseDarkHourGlass = true
  sfx:Play(SoundEffect.SOUND_DEATH_CARD, 1, 0, false, 1)

   return true
  end
end

Auriz:AddCallback(ModCallbacks.MC_USE_ITEM, DarkGlowingHourglass, COLLECTIBLE_DARK_GLOWING_HOURGLASS)

COLLECTIBLE_NULLTIMEZ = Isaac.GetItemIdByName("Null Time")

local function DarkGlowingHourglasspass(_,npc,amount,flags,source,countdown)
	for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
	if player:HasCollectible(COLLECTIBLE_DARK_GLOWING_HOURGLASS) and not UseDarkHourGlass and
	flags & DamageFlag.DAMAGE_CURSED_DOOR == 0 and
	flags & DamageFlag.DAMAGE_IV_BAG == 0 and
	flags & DamageFlag.DAMAGE_CHEST == 0 and
	flags & DamageFlag.DAMAGE_RED_HEARTS == 0 and
    flags & DamageFlag.DAMAGE_SPIKES == 0 
	then
	player:UseActiveItem(CollectibleType.COLLECTIBLE_GLOWING_HOUR_GLASS,false,false,false,false)

	sfx:Play(SoundEffect.SOUND_DEATH_CARD, 1, 0, false, 1)
	Darkhourhit = true 
	Darkhourhitff = true 
end
end
for i = 1, Game():GetNumPlayers() do 
    local player = Isaac.GetPlayer(i - 1)
	local room = game:GetRoom()
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Auri") and not player:HasCollectible(COLLECTIBLE_DARK_GLOWING_HOURGLASS) and not UseDarkHourGlass and
	flags & DamageFlag.DAMAGE_CURSED_DOOR == 0 and
	flags & DamageFlag.DAMAGE_IV_BAG == 0 and
	flags & DamageFlag.DAMAGE_CHEST == 0 and
	flags & DamageFlag.DAMAGE_RED_HEARTS == 0 and
    flags & DamageFlag.DAMAGE_SPIKES == 0
	and not room:HasCurseMist() 
	then

	player:UseActiveItem(CollectibleType.COLLECTIBLE_GLOWING_HOUR_GLASS,false,false,false,false)
	sfx:Play(SoundEffect.SOUND_DEATH_CARD, 1, 0, false, 1)
	Darkhourhit = true
	Darkhourhitff = true 
end
end

for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) and player:HasCollectible(CollectibleType.COLLECTIBLE_CROWN_OF_LIGHT) then
	Auribirthright = true
	end
	end
end

Auriz:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, DarkGlowingHourglasspass, EntityType.ENTITY_PLAYER)

function Auriz:onRender()
for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
	if Darkhourhit and player:IsHoldingItem() then
		Darkhourhit = false

	    player:AnimateCollectible(COLLECTIBLE_DARK_GLOWING_HOURGLASS, "UseItem", "PlayerPickup")

	end
	if brokenhourglasswork and player:IsHoldingItem() then
		brokenhourglasswork = false
	    player:AnimateCollectible(COLLECTIBLE_BROKEN_GLOWING_HOURGLASS, "UseItem", "PlayerPickup")
	end

	end
end
Auriz:AddCallback(ModCallbacks.MC_POST_RENDER, Auriz.onRender)

function DarkRee() 
    for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
	if player:HasCollectible(COLLECTIBLE_DARK_GLOWING_HOURGLASS) then
	UseDarkHourGlass = false
	end
  end
   for i = 1, Game():GetNumPlayers() do 
    local player = Isaac.GetPlayer(i - 1)
	if not player:HasCollectible(COLLECTIBLE_DARK_GLOWING_HOURGLASS) and player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Auri") then
	UseDarkHourGlass = false
	end
  end
  for i = 1, Game():GetNumPlayers() do
   local player = Isaac.GetPlayer(i - 1)
  if Darkhourhit and player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Auri")
  or Darkhourhit and player:HasCollectible(COLLECTIBLE_DARK_GLOWING_HOURGLASS)
  then 
   player:AddBrokenHearts(1)

  end
 end

   for i = 1, Game():GetNumPlayers() do
   local player = Isaac.GetPlayer(i - 1)
 if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Auri") and

		player:GetExtraLives() >= 1 and player:HasCollectible(81) 
		and player:GetBrokenHearts() == 11 
		and not game:GetRoom():IsClear()
		then 
		player:UseActiveItem(COLLECTIBLE_DARK_GLOWING_HOURGLASS,true,false,false,false)

	end
  end
end

Auriz:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, DarkRee)

local NewAuriBirthright = 1
local Nulltime = 60
local DarkAuriFFfixed = 9
function Somethingelsehappend()

    for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
	if Auribirthright and player:HasCollectible(CollectibleType.COLLECTIBLE_CROWN_OF_LIGHT)
	and player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") 
	then
	   NewAuriBirthright = NewAuriBirthright - 1
	   if NewAuriBirthright <= 0 then
	   NewAuriBirthright = 1
	   Auribirthright = false

       player:RemoveCollectible(CollectibleType.COLLECTIBLE_CROWN_OF_LIGHT)
	   player:AddCollectible(CollectibleType.COLLECTIBLE_CROWN_OF_LIGHT,false,false,false,false)

	end
   end
  end

     for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
	 if FiendFolio and Darkhourhitff 
  then
	   DarkAuriFFfixed = DarkAuriFFfixed - 1
	   if DarkAuriFFfixed <= 0 then
	   DarkAuriFFfixed = 9
	    player:AddBrokenHearts(1)
	   Darkhourhitff = false

	end
   end
  end

end

Auriz:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Somethingelsehappend)

function Notdarkp() 
    for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
	    if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and DarkprincesAuri and not player:HasCollectible(442) then
		player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/aurishadow.anm2")) 
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/aurihair.anm2"))
		DarkprincesAuri = false
		end
	end
	 for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
	    if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and toothhead and not player:HasCollectible(663) then
		player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auri_tooth_head.anm2")) 
		toothhead = false
	end
	end
	 for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
	    if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and toothhead2 and not player:HasCollectible(663) and not player:HasCollectible(729) then
		player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auri_tooth_head2.anm2")) 
		toothhead2 = false
	end
	end

	 for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
		if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) and player:HasCollectible(CollectibleType.COLLECTIBLE_CROWN_OF_LIGHT) then
	   player:RemoveCollectible(CollectibleType.COLLECTIBLE_CROWN_OF_LIGHT)
	   player:AddCollectible(CollectibleType.COLLECTIBLE_CROWN_OF_LIGHT,false,false,false,false)
	end
	end
end

Auriz:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, Notdarkp)

function Auriz:auritear(tear)
    local player = Isaac.GetPlayer(0)
        if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and
	    player:HasCollectible(333) and player:HasCollectible(334) and player:HasCollectible(335) then
		holytear = math.random(0, 100) + player.Luck*0.5
		if holytear >= 90 then
		tear.TearFlags = tear.TearFlags |TearFlags.TEAR_GLOW
		end
	end
	 local player = Isaac.GetPlayer(0)
        if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and
	    player:HasCollectible(333) and player:HasCollectible(334) and player:HasCollectible(335) and player:HasCollectible(374) then
		holytear = math.random(0, 100) + player.Luck*0.5
		if holytear >= 70 then
		tear.TearFlags = tear.TearFlags |TearFlags.TEAR_GLOW
		end
	end

end

Auriz:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, Auriz.auritear)

function AuriBers() 
    local player = Isaac.GetPlayer(0);
    if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and not BerSerkAuri then
    BDEM = math.random(1, 99)
	if BDEM == 99  then

	sfx:Play(SoundEffect.SOUND_HAND_LASERS, 0.7, 0, false, 1)
	sfx:Play(SoundEffect.SOUND_BERSERK_START, 1, 0, false,1)

	game:Fart(player.Position, 85, player, 1.5, 1, Color(0.75, 0, 1))
	sfx:Stop(SoundEffect.SOUND_FART)
	Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.SHOCKWAVE_RANDOM, 0, player.Position, Vector(0,0), player)
	game:ShakeScreen(9)

	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auri_berserk_head.anm2"))

	player.Damage = player.Damage * 2
	BerSerkAuri = true
	end
 end

 end

Auriz:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, AuriBers, EntityType.ENTITY_PLAYER)

function Auriturnb()
	local player = Isaac.GetPlayer(0);
       if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and BerSerkAuri then
	   if player.FrameCount % 1499 == 0 then
	   player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auri_berserk_head.anm2"))
	   player:UseActiveItem(COLLECTIBLE_A_RERERE,false,false,false,false)

	   BerSerkAuri = false
    end
  end
end

Auriz:AddCallback(ModCallbacks.MC_POST_UPDATE, Auriturnb)

function Aurishaturnb()

	for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
    if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and ShaAuri or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and ShaAuri then
	player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auriishadowhead.anm2"))
	player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/aurishadowhead.anm2"))
	player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/aurishadowbody.anm2"))
	player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/aurishadowbodyfly.anm2"))
	player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auriishadowbodyfly.anm2"))
	player:UseActiveItem(COLLECTIBLE_A_RERERE,false,false,false,false)
	ShaAuri = false
    end
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and player:HasCollectible(433) and not ShaAuri and not ShadowAuri then
    BSD = math.random(1, 9)
	if BSD == 9 and player.CanFly == false then
	sfx:Play(SoundEffect.SOUND_DEVILROOM_DEAL, 1, 0, false, 1)
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auriishadowhead.anm2"))
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/aurishadowbody.anm2"))
    player.Damage = player.Damage * 2
	player:UseActiveItem(COLLECTIBLE_A_RERERE,false,false,false,false)
	player:AddCacheFlags(CacheFlag.CACHE_ALL)
	player:EvaluateItems()
	ShaAuri = true
	end
	if BSD == 9 and player.CanFly == true then
	sfx:Play(SoundEffect.SOUND_DEVILROOM_DEAL, 1, 0, false, 1)
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auriishadowhead.anm2"))
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/aurishadowbodyfly.anm2"))
	player.Damage = player.Damage * 2
	player:UseActiveItem(COLLECTIBLE_A_RERERE,false,false,false,false)
	player:AddCacheFlags(CacheFlag.CACHE_ALL)
	player:EvaluateItems()
	ShaAuri = true
    end
    end
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and player:HasCollectible(433) and not ShaAuri and not ShadowAuri then
    BSD = math.random(1, 9)
	if BSD == 9 and player.CanFly == false then
	sfx:Play(SoundEffect.SOUND_DEVILROOM_DEAL, 1, 0, false, 1)
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/aurishadowhead.anm2"))
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/aurishadowbody.anm2"))
	player.Damage = player.Damage * 2
	player:UseActiveItem(COLLECTIBLE_A_RERERE,false,false,false,false)
	player:AddCacheFlags(CacheFlag.CACHE_ALL)
	player:EvaluateItems()
	ShaAuri = true
	end
	if BSD == 9 and player.CanFly == true then
	sfx:Play(SoundEffect.SOUND_DEVILROOM_DEAL, 1, 0, false, 1)
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/aurishadowhead.anm2"))
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auriishadowbodyfly.anm2"))
	player.Damage = player.Damage * 2
	player:UseActiveItem(COLLECTIBLE_A_RERERE,false,false,false,false)
	player:AddCacheFlags(CacheFlag.CACHE_ALL)
	player:EvaluateItems()
	ShaAuri = true
    end
    end
end
end
Auriz:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, Aurishaturnb)

function AuriSpoo()
    for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
    if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and not BerSerkAuri and not SpooAuri and not DeadAuri and not ShaAuri and not ShadowAuri and not RaisenAuri and not DarkprincesAuri and not ErrorAuri and not MechaAuri then
    Spoo = math.random(1, 999)
	if Spoo == 99  then
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auricorrupt.anm2"))
	SpooAuri = true
	end
  end
end

end

Auriz:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, AuriSpoo, EntityType.ENTITY_PLAYER)

function AuriSpoob()
	for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
       if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and SpooAuri then
	      if player.FrameCount % 499 == 0 then
	   player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auricorrupt.anm2"))
	   SpooAuri = false
	   end
    end
	end

end

Auriz:AddCallback(ModCallbacks.MC_POST_UPDATE, AuriSpoob)

function Auriglitchhit() 
    local player = Isaac.GetPlayer(0);
    if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and ErrorAuri then
    git = math.random(1, 9)
	if git == 9  then
	player:UseActiveItem(CollectibleType.COLLECTIBLE_DATAMINER,false,false,false,false) 
	end
 end
  local player = Isaac.GetPlayer(0);
    if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and ErrorAuri then
    git = math.random(1, 9)
	if git == 9  then
	player:UseActiveItem(CollectibleType.COLLECTIBLE_DATAMINER,false,false,false,false) 
	end
 end
 local player = Isaac.GetPlayer(0)
  if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and MechaAuri or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and MechaAuri then
 sfx:Play(SoundEffect.SOUND_HAND_LASERS , 0.3, 0, false, 5.0);
 player:FireTechXLaser(player.Position,Vector(0,19),9) 
 player:FireTechXLaser(player.Position,Vector(19,0),9)
 player:FireTechXLaser(player.Position,Vector(0,-19),9)
 player:FireTechXLaser(player.Position,Vector(-19,0),9)
 player:FireTechXLaser(player.Position,Vector(19,19),9)
 player:FireTechXLaser(player.Position,Vector(-19,-19),9)
 player:FireTechXLaser(player.Position,Vector(19,-19),9)
 player:FireTechXLaser(player.Position,Vector(-19,19),9)
 local techbo = player:FireTechXLaser(player.Position,Vector(0,0),99)
    techbo.Timeout = 10

end

end

Auriz:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, Auriglitchhit, EntityType.ENTITY_PLAYER)

function Errorrandomstatus()  
    local player = Isaac.GetPlayer(0);
    if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and ErrorAuri then
	player:UseActiveItem(CollectibleType.COLLECTIBLE_D8,false,false,false,false) 
	end
    local player = Isaac.GetPlayer(0);
    if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and ErrorAuri then
	player:UseActiveItem(CollectibleType.COLLECTIBLE_D8,false,false,false,false) 
	end
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and MechaAuri and Mechaflyna or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and MechaAuri and Mechaflyna then
	if player.CanFly == false then
	Mechaflyna = false
	end
	end
	 local player = Isaac.GetPlayer(0)
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and Errorflyna or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and DeadAuriFlyna or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and ShadowAuriFlyna or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and ShadowAuriiFlyna then
		player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auri_error_bodyfly.anm2"))
		player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/deadaurifly.anm2"))
		player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/aurishadowbodyfly.anm2"))
		player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auriishadowbodyfly.anm2"))
		Errorflyna = false
		DeadAuriFlyna = false
		ShadowAuriFlyna = false
		ShadowAuriiFlyna = false
	end
 end

 Auriz:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, Errorrandomstatus)

 function Auriz:Mechafly()
    local player = Isaac.GetPlayer(0)
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and MechaAuri and not Mechaflyna or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and MechaAuri and not Mechaflyna then
		if player.CanFly == true then
		sfx:Play(SoundEffect.MECHA_AURI_FLY, 1, 0, false, 1)
		Mechaflyna = true
		end
	end
	local player = Isaac.GetPlayer(0)
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and player:HasTrinket(TrinketType.TRINKET_BAT_WING) and DeadAuri and not DeadAuriFlyna or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and player:HasTrinket(TrinketType.TRINKET_BAT_WING) and DeadAuri and not DeadAuriFlyna then
		if player.CanFly == true then
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/deadaurifly.anm2"))
		DeadAuriFlyna = true
		end
	end
	 local player = Isaac.GetPlayer(0)
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and player:HasTrinket(TrinketType.TRINKET_BAT_WING) and ErrorAuri and not Errorflyna or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and player:HasTrinket(TrinketType.TRINKET_BAT_WING) and ErrorAuri and not Errorflyna then
		if player.CanFly == true then
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auri_error_bodyfly.anm2"))
		Errorflyna = true
		end
	end
	 local player = Isaac.GetPlayer(0)
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and player:HasTrinket(TrinketType.TRINKET_BAT_WING) and ShaAuri and not ShadowAuriFlyna or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and player:HasTrinket(TrinketType.TRINKET_BAT_WING) and ShadowAuri and not ShadowAuriFlyna then
		if player.CanFly == true then
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/aurishadowbodyfly.anm2"))
		ShadowAuriFlyna = true
		end
	end
	 local player = Isaac.GetPlayer(0)
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and player:HasTrinket(TrinketType.TRINKET_BAT_WING) and ShadowAurii and not ShadowAuriiFlyna then
		if player.CanFly == true then
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auriishadowbodyfly.anm2"))
		ShadowAuriiFlyna = true
		end
    end
end
Auriz:AddCallback(ModCallbacks.MC_POST_UPDATE, Auriz.Mechafly)

 function MechaAuri9()
for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
	local mechaitems = 0
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and not MechaAuri or (player:GetName() == "Auriiii") and not MechaAuri then
	    if player:HasCollectible(68) then  
       mechaitems = mechaitems + 1
	   end
	    if player:HasCollectible(152) then 
       mechaitems = mechaitems + 1
	   end
	    if player:HasCollectible(244) then 
       mechaitems = mechaitems + 1
	   end

	    if player:HasCollectible(395) then 
       mechaitems = mechaitems + 1
	   end
	    if player:HasCollectible(524) then 
       mechaitems = mechaitems + 1
	   end
	    if player:HasCollectible(95) then 
       mechaitems = mechaitems + 1
	   end
	    if player:HasCollectible(267) then 
       mechaitems = mechaitems + 1
	   end
	    if player:HasCollectible(63) then 
       mechaitems = mechaitems + 1
	   end
	    if player:HasCollectible(255) then 
       mechaitems = mechaitems + 1
	   end
	    if player:HasCollectible(449) then 
       mechaitems = mechaitems + 1
	   end

	   if mechaitems > 2 then

	    sfx:Play(SoundEffect.SOUND_POWERUP_SPEWER, 1, 0, false, 1)
		game:GetHUD():ShowItemText("Mecha Auri")

		player:DropTrinket(player.Position, true)
		player:AddTrinket(TrinketType.TRINKET_BAT_WING)
        player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER, false, false, true, true)
		player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/aurii_dead_head.anm2")) 
		player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auriheaddead.anm2"))
		player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auribodydead.anm2")) 
		player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/aurishadowhead.anm2")) 
		player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/aurishadowbody.anm2")) 
		player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/aurihair.anm2")) 
		player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auricorrupt.anm2")) 
		player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/aurilabody.anm2"))
		player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/aurilahead.anm2"))
		player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auriilabody.anm2"))
		player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auriilahead.anm2"))
		player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auri_error_body.anm2")) 
		player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auri_error_head.anm2")) 
		player:TryRemoveCollectibleCostume(449, false)

		aurimerandom = math.random(1, 6)
		if aurimerandom == 1 then
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/mecha_auri_head.anm2"))
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/mecha_auri_bodyfly.anm2"))
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/mecha_auri_body.anm2"))
		elseif aurimerandom == 2 then
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/mecha_auri_head2.anm2"))
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/mecha_auri_bodyfly2.anm2"))
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/mecha_auri_body2.anm2"))
		elseif aurimerandom == 3 then
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/mecha_auri_head3.anm2"))
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/mecha_auri_bodyfly3.anm2"))
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/mecha_auri_body3.anm2"))
		elseif aurimerandom == 4 then
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/mecha_auri_head4.anm2"))
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/mecha_auri_bodyfly4.anm2"))
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/mecha_auri_body4.anm2"))
		elseif aurimerandom == 5 then
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/mecha_auri_head5.anm2"))
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/mecha_auri_bodyfly5.anm2"))
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/mecha_auri_body5.anm2"))
		elseif aurimerandom == 6 then
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/mecha_auri_head6.anm2"))
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/mecha_auri_bodyfly6.anm2"))
		player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/mecha_auri_body6.anm2"))
		end

		MechaAuri = true
		end
	end
end
end
	Auriz:AddCallback(ModCallbacks.MC_POST_UPDATE, MechaAuri9)

function Auriz:Auriipewpew(tear)
	local player =Isaac.GetPlayer(0)
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and MechaAuri or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and MechaAuri then
	sfx:Play(SoundEffect.MECHA_AURI_SHOOT, 0.8, 0,false, 1)
	end
end

Auriz:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, Auriz.Auriipewpew)

Auri.Trinket = {
Isaac.GetTrinketIdByName("Auri's Crown"),
}

TrinketType.TRINKET_AURI_CROWN = Isaac.GetTrinketIdByName("Auri's Crown")

function Auriz:onCache(player, flags)

    if player:HasTrinket(Isaac.GetTrinketIdByName("Auri's Crown")) and not Crowngethit 

	then
	 if flags == CacheFlag.CACHE_DAMAGE then
       player.Damage = player.Damage * 1.5 
	   * player:GetTrinketMultiplier(TrinketType.TRINKET_AURI_CROWN)

	  Crowngethit = false

	  end
    end

end

Auriz:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Auriz.onCache)

function Crowngothit(_,npc,amount,flags,source,countdown)
  for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
    if player:HasTrinket(Isaac.GetTrinketIdByName("Auri's Crown")) and not Crowngethit and
        flags & DamageFlag.DAMAGE_CURSED_DOOR == 0 and
     	flags & DamageFlag.DAMAGE_IV_BAG == 0 and
	    flags & DamageFlag.DAMAGE_CHEST == 0 and
     	flags & DamageFlag.DAMAGE_RED_HEARTS == 0 and
        flags & DamageFlag.DAMAGE_SPIKES == 0
	then
	  player:DropTrinket(player.Position, true)
	  player:TryRemoveTrinket(TrinketType.TRINKET_AURI_CROWN)
	  sfx:Play(SoundEffect.SOUND_THUMBS_DOWN, 1, 0, false, 1)
	  Crowngethit = true
	  player:UseActiveItem(COLLECTIBLE_A_RERERE,false,false,false,false)

	  end
   end

    for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)

	if GoldenCrownStarto and 
        flags & DamageFlag.DAMAGE_CURSED_DOOR == 0 and
     	flags & DamageFlag.DAMAGE_IV_BAG == 0 and
	    flags & DamageFlag.DAMAGE_CHEST == 0 and
     	flags & DamageFlag.DAMAGE_RED_HEARTS == 0 and
        flags & DamageFlag.DAMAGE_SPIKES == 0
	then

	  GoldenCrowngethit = true

	  end
   end

     for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
	if player:HasCollectible(COLLECTIBLE_CALM_MIND) and
        flags & DamageFlag.DAMAGE_CURSED_DOOR == 0 and
     	flags & DamageFlag.DAMAGE_IV_BAG == 0 and
	    flags & DamageFlag.DAMAGE_CHEST == 0 and
     	flags & DamageFlag.DAMAGE_RED_HEARTS == 0 and
        flags & DamageFlag.DAMAGE_SPIKES == 0
	then

	  Calmmindbreak = true

	  end
   end

 end

Auriz:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, Crowngothit, EntityType.ENTITY_PLAYER)

function Crowngone()
  local entities = Isaac.GetRoomEntities()
  for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
	for i = 1, #entities do 
	local e = entities[i]
    if e.SubType == TrinketType.TRINKET_AURI_CROWN and Crowngethit then
	  player:DropTrinket(player.Position, true)

	  retime = retime - 1
	  if retime <= 0 then
	   Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, -1, entities[i].Position, entities[i].Velocity, AuriCrown)
	   e:Remove()
	   retime = 40
    end
   end
   end
   end
   local entities = Isaac.GetRoomEntities() 
  for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
	for i = 1, #entities do 
	local e = entities[i]
    if e.SubType == TrinketType.TRINKET_AURI_CROWN | TrinketType.TRINKET_GOLDEN_FLAG and Crowngethit then
	  player:DropTrinket(player.Position, true)

	  retime = retime - 1
	  if retime <= 0 then
	   Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, -1, entities[i].Position, entities[i].Velocity, AuriCrown)
	   e:Remove()
	   retime = 40
    end
   end
   end
   end

   if Crowngethit and not playhitsound then
   sfx:Play(SoundEffect.SOUND_THUMBS_DOWN, 1, 0, false, 1)
   playhitsound = true
   end

   if GoldenCrowngethit and not playhitsoundG then
   sfx:Play(SoundEffect.SOUND_THUMBS_DOWN, 1, 0, false, 1)
   game:GetHUD():ShowItemText("You failed.. let's try again")
   playhitsoundG = true
   end

    for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
	if player:HasTrinket(Isaac.GetTrinketIdByName("Crown of Death")) and not CoDGulp and not player:HasCollectible(BlackCandle) then
	 CodDie = math.random(1, 999)
	if CodDie >= 999  then
	player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER,false, false, true, true) 
	sfx:Play(SoundEffect.SOUND_VAMP_GULP, 1, 0, false, 1)
	CoDGulp = true
   end
  end
 end

  for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
    if player:HasCollectible(COLLECTIBLE_CALM_MIND) and Calmmindbreak then
	  MindbreakCD = MindbreakCD - 1
	  if MindbreakCD <= 0 then
	   MindbreakCD = 900
	   Calmmindbreak = false
   end
   end
   end

end
Auriz:AddCallback(ModCallbacks.MC_POST_UPDATE, Crowngone)

TrinketType.TRINKET_CROWN_OF_DEATH = Isaac.GetTrinketIdByName("Crown of Death")

TrinketType.TRINKET_DARK_AURI_CROWN = Isaac.GetTrinketIdByName("Dark Crown") 

function DarkCrown(_,npc,amount,flags,source,countdown) 
  for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
    if player:HasTrinket(Isaac.GetTrinketIdByName("Dark Crown")) and not UseDarkHourGlass and player.Variant == 0 and player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Auri") then
	 if flags & DamageFlag.DAMAGE_CURSED_DOOR == 0 and
     	flags & DamageFlag.DAMAGE_IV_BAG == 0 and
	    flags & DamageFlag.DAMAGE_CHEST == 0 and
     	flags & DamageFlag.DAMAGE_RED_HEARTS == 0 and
        flags & DamageFlag.DAMAGE_SPIKES == 0
		then
		sfx:Play(SoundEffect.SOUND_BONE_BREAK, 1, 0, false, 1)
        player:AddBrokenHearts(1)
		player:UseActiveItem(COLLECTIBLE_A_RERERE,false,false,false,false)

	  end
	  end

	   if player:HasTrinket(Isaac.GetTrinketIdByName("Dark Crown")) and not UseDarkHourGlass and player.Variant == 0 and player:GetPlayerType() ~= Isaac.GetPlayerTypeByName("Dark Auri") and math.random(1,2) == 2 then
	 if flags & DamageFlag.DAMAGE_CURSED_DOOR == 0 and
     	flags & DamageFlag.DAMAGE_IV_BAG == 0 and
	    flags & DamageFlag.DAMAGE_CHEST == 0 and
     	flags & DamageFlag.DAMAGE_RED_HEARTS == 0 and
        flags & DamageFlag.DAMAGE_SPIKES == 0
		then
		sfx:Play(SoundEffect.SOUND_BONE_BREAK, 1, 0, false, 1)
        player:AddBrokenHearts(1)
		player:UseActiveItem(COLLECTIBLE_A_RERERE,false,false,false,false)

	  end
	  end

    if player:HasTrinket(Isaac.GetTrinketIdByName("Crown of Death")) then
	if flags & DamageFlag.DAMAGE_CURSED_DOOR == 0 and
	flags & DamageFlag.DAMAGE_IV_BAG == 0 and
	flags & DamageFlag.DAMAGE_CHEST == 0 and
	flags & DamageFlag.DAMAGE_RED_HEARTS == 0 and
    flags & DamageFlag.DAMAGE_SPIKES == 0 then
	 COD = math.random(0, 99)
	if COD ~= 99 and (player:GetName() ~= "Dark Auri") then
	player:Kill()

	local CrownOfDeath_Rtext = math.random(#Auriz.CrownOfDeath_Text)
	game:GetHUD():ShowItemText("So you chosen DEATH?", Auriz.CrownOfDeath_Text[CrownOfDeath_Rtext])

	end
	end
  end
 end
end

Auriz:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, DarkCrown, EntityType.ENTITY_PLAYER)

Auriz.CrownOfDeath_Text = {
	"Skip it next time",
	"Mistakes were made",
	"Who's fault again?",
	"See you next run",
	":)",
	"Keep practicing",
	"Ignore this trinket next time",
	"and death has chosen you",
	"</3",
	"Oopsie!",
	"And become back your money?",
	"Thats right! get no scopeeed!!",
	"BOOOOOOOOOOOMMMMMMM!!!!",
	"Bad decision",
	"Good decision",
	"Indeed a wise choice",
	"It's your decision",
	"Haha bullet go Brrr",
	"You smell like a death",
	"Rip",
	"Press F to pay respect",
	"I respect that",
    "What a choice",
	"Skill is..needed",
	"Bad item design?",
}

function Auriz:onCache(player, flags) 

  for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
    if player:HasTrinket(Isaac.GetTrinketIdByName("Dark Crown")) 

	then
	 if flags == CacheFlag.CACHE_DAMAGE then
	 if player:GetBrokenHearts() == 1 then
       player.Damage = player.Damage + 0.5 * player:GetTrinketMultiplier(TrinketType.TRINKET_DARK_AURI_CROWN)
	   elseif player:GetBrokenHearts() == 2 then
       player.Damage = player.Damage + 1 * player:GetTrinketMultiplier(TrinketType.TRINKET_DARK_AURI_CROWN)
	   elseif player:GetBrokenHearts() == 3 then
       player.Damage = player.Damage + 1.5 * player:GetTrinketMultiplier(TrinketType.TRINKET_DARK_AURI_CROWN)
	   elseif player:GetBrokenHearts() == 4 then
       player.Damage = player.Damage + 2 * player:GetTrinketMultiplier(TrinketType.TRINKET_DARK_AURI_CROWN)
	   elseif player:GetBrokenHearts() == 5 then
       player.Damage = player.Damage + 2.5 * player:GetTrinketMultiplier(TrinketType.TRINKET_DARK_AURI_CROWN)
	   elseif player:GetBrokenHearts() == 6 then
       player.Damage = player.Damage + 3 * player:GetTrinketMultiplier(TrinketType.TRINKET_DARK_AURI_CROWN)
	   elseif player:GetBrokenHearts() == 7 then
       player.Damage = player.Damage + 3.5 * player:GetTrinketMultiplier(TrinketType.TRINKET_DARK_AURI_CROWN)
	   elseif player:GetBrokenHearts() == 8 then
       player.Damage = player.Damage + 4 * player:GetTrinketMultiplier(TrinketType.TRINKET_DARK_AURI_CROWN)
	   elseif player:GetBrokenHearts() == 9 then
       player.Damage = player.Damage + 4.5 * player:GetTrinketMultiplier(TrinketType.TRINKET_DARK_AURI_CROWN)
	   elseif player:GetBrokenHearts() == 10 then
       player.Damage = player.Damage + 5 * player:GetTrinketMultiplier(TrinketType.TRINKET_DARK_AURI_CROWN)
	   elseif player:GetBrokenHearts() == 11 then
       player.Damage = player.Damage + 5.5 * player:GetTrinketMultiplier(TrinketType.TRINKET_DARK_AURI_CROWN)
	   elseif player:GetBrokenHearts() == 12 and player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Auri") 
	   or player:GetBrokenHearts() == 12 and player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Corrupted Auri",true) then
       player.Damage = player.Damage + 999 * player:GetTrinketMultiplier(TrinketType.TRINKET_DARK_AURI_CROWN) 
	   end
	  end
	end

  end

  if player:HasTrinket(Isaac.GetTrinketIdByName("Crown of Death")) and not player:HasCollectible(mombox) then
	 if flags == CacheFlag.CACHE_DAMAGE then
           player.Damage = player.Damage * 2.49
     end
  end
  if player:HasTrinket(Isaac.GetTrinketIdByName("Crown of Death")) and player:HasCollectible(mombox) then
	 if flags == CacheFlag.CACHE_DAMAGE then
           player.Damage = player.Damage * 2.99
     end
  end

end
Auriz:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Auriz.onCache)

function DarkCrownFix()
	 for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Auri") and player:GetBrokenHearts() == 11 
	or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Corrupted Auri",true) and player:GetBrokenHearts() == 11 
	then
	player:UseActiveItem(COLLECTIBLE_A_RERERE,false,false,false,false)
	end
  end

   for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
	local currentRoom = Game():GetRoom()
	if GoldenCrownStarto and not GoldenCrownStartotwo then
		if currentRoom:GetType() == 5 and player:HasTrinket(TrinketType.TRINKET_CHALLENGE_CROWN) then 
		   Goldenbossroo = true

		end
	elseif GoldenCrownStartotwo then
		if currentRoom:GetType() == 5 and player:HasTrinket(TrinketType.TRINKET_CHALLENGE_CROWN) then 
		   Goldenbossroom = true

		end
	end
  end
end 
Auriz:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, DarkCrownFix)

TrinketType.TRINKET_DARK_HEART = Isaac.GetTrinketIdByName("Dark Heart") 
TrinketType.TRINKET_CHALLENGE_CROWN = Isaac.GetTrinketIdByName("Challenge Crown") 

CorruptHeart = 0

function Auriz:onNewLevel()  
  for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
    if player:HasTrinket(Isaac.GetTrinketIdByName("Dark Heart")) 

	then
	    CorruptHeart = CorruptHeart + 0.5 * player:GetTrinketMultiplier(TrinketType.TRINKET_DARK_HEART)
		sfx:Play(SoundEffect.SOUND_BONE_BREAK, 1, 0, false, 1)
		sfx:Play(SoundEffect.SOUND_DEATH_REVERSE, 1, 0, false, 1)
        player:AddBrokenHearts(1)
		 player:UseActiveItem(COLLECTIBLE_A_RERERE,false,false,false,false)
	  end
   end

  for i = 1, Game():GetNumPlayers() do 
    local player = Isaac.GetPlayer(i - 1)

	if AuriAchievements.EnchantedBookLuck >= 1 then

	   player:UseActiveItem(COLLECTIBLE_A_RERERE,false,false,false,false)
	   sfx:Stop(SoundEffect.SOUND_POWERUP1)
	   sfx:Stop(SoundEffect.SOUND_POWERUP3) 
	    AuriAchievements.EnchantedBookLuck = 0

	   end
	end

    for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
    if player:HasTrinket(TrinketType.TRINKET_CHALLENGE_CROWN) and not GoldenCrownStarto then
	  GoldenCrownStarto = true

     elseif player:HasTrinket(TrinketType.TRINKET_CHALLENGE_CROWN) and GoldenCrownStarto and Goldenbossroo and not GoldenCrowngethit and not GoldenCrownStartotwo then
	  GoldenCrownStartotwo = true

	 elseif player:HasTrinket(TrinketType.TRINKET_CHALLENGE_CROWN) and GoldenCrownStartotwo and Goldenbossroom and not GoldenCrowngethit and not GoldenCrownDone then

	   player:TryRemoveTrinket(TrinketType.TRINKET_CHALLENGE_CROWN)
	   Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE,math.random(1, 732) ,Isaac.GetFreeNearPosition(player.Position, 50), Vector(0,0), nil)
		sfx:Play(SoundEffect.SOUND_THUMBSUP,1,0,false,1)
		GoldenCrownDone = true

     elseif player:HasTrinket(TrinketType.TRINKET_CHALLENGE_CROWN) and GoldenCrowngethit then

	  GoldenCrownStarto = true
	  GoldenCrownStartotwo = false
	  Goldenbossroo = false
	  Goldenbossroom = false
	  GoldenCrowngethit = false
	  playhitsoundG = false
	 end
   end

   if AgedhourUseCount >= 1 then AgedhourUseCount = 0 
   end
end
Auriz:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, Auriz.onNewLevel)

Darkpennystack = 0

Luckypennyformage = 0
TrinketType.TRINKET_DARK_PENNY = Isaac.GetTrinketIdByName("Dark Penny")
TrinketType.TRINKET_ENCHANT_PENNY = Isaac.GetTrinketIdByName("Enchant Penny")
TrinketType.TRINKET_SOUL_PENNY = Isaac.GetTrinketIdByName("Soul Penny")
TrinketType.TRINKET_MORPH_PENNY = Isaac.GetTrinketIdByName("Morph Penny")
TrinketType.TRINKET_MINE_PENNY = Isaac.GetTrinketIdByName("Mine Penny")
TrinketType.TRINKET_LESSER_KEY = Isaac.GetTrinketIdByName("Lesser Key")

function Auriz:OnPickup(pickup, collider, _)
    for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)

    if collider.Type == EntityType.ENTITY_PLAYER
    and pickup.SubType ~= CoinSubType.COIN_STICKYNICKEL
    and player:HasTrinket(TrinketType.TRINKET_DARK_PENNY)
    and not pickup:IsShopItem() then
	if math.random(1,5) == 2 then 
       player:AddBrokenHearts(1)
	   sfx:Play(SoundEffect.SOUND_BONE_BREAK, 1, 0, false, 1)
	   elseif math.random(1,10) == 9 then 

	   player:UseActiveItem(CollectibleType.COLLECTIBLE_LEMEGETON,false,false,false,false) 
	   elseif math.random(0,99) >= 97 and not DpenyGulp then 
	   sfx:Play(SoundEffect.SOUND_VAMP_GULP, 1, 0, false, 1)

	   player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER,false,false,false,false)
	   DpenyGulp = true
	   else
	   Darkpennystack = Darkpennystack + 0.1 * player:GetTrinketMultiplier(TrinketType.TRINKET_DARK_PENNY)
	   sfx:Play(SoundEffect.SOUND_DEVILROOM_DEAL, 1, 0, false, 1.99)
	   player:UseActiveItem(COLLECTIBLE_A_RERERE,false,false,false,false)
      end
    end
  end

   for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
    if collider.Type == EntityType.ENTITY_PLAYER
    and pickup.SubType ~= CoinSubType.COIN_STICKYNICKEL
    and player:HasTrinket(TrinketType.TRINKET_ENCHANT_PENNY)
    and not pickup:IsShopItem() then
	if math.random(0,99) <= 25 then 
	   sfx:Play(SoundEffect.SOUND_POWERUP1, 1, 0, false, 1.5)
	   AuriAchievements.Enchantpennystack = AuriAchievements.Enchantpennystack + 0.5 * player:GetTrinketMultiplier(TrinketType.TRINKET_ENCHANT_PENNY)
	   player:UseActiveItem(COLLECTIBLE_A_RERERE,false,false,false,false)
      end
    end
  end

  for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
    if collider.Type == EntityType.ENTITY_PLAYER
    and pickup.SubType ~= CoinSubType.COIN_STICKYNICKEL
    and player:HasTrinket(TrinketType.TRINKET_SOUL_PENNY)
    and not pickup:IsShopItem() then
	if math.random(0,99) <= 25 then 
	   sfx:Play(SoundEffect.SOUND_FLAME_BURST,1.0,0,false,2.0)

	   player:AddWisp(CollectibleType.COLLECTIBLE_DELIRIOUS, player.Position, true, false)

      end
    end
  end

   for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
    if collider.Type == EntityType.ENTITY_PLAYER
    and pickup.SubType ~= CoinSubType.COIN_STICKYNICKEL
    and player:HasTrinket(TrinketType.TRINKET_MORPH_PENNY)
    and not pickup:IsShopItem() then
	if math.random(0,99) <= 25 then 

	   sfx:Play(SoundEffect.SOUND_DEATH_REVERSE, 2, 0, false, 1.5)
	   player:AddMinisaac(player.Position, false)
	   sfx:Play(SoundEffect.SOUND_BABY_HURT, 1, 0, false, 1)
      end
    end
  end

     for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
    if collider.Type == EntityType.ENTITY_PLAYER
    and pickup.SubType ~= CoinSubType.COIN_NICKEL
    and pickup.SubType ~= CoinSubType.COIN_LUCKYPENNY
    and player:HasTrinket(TrinketType.TRINKET_MINE_PENNY)
    and not pickup:IsShopItem()
	then
	if math.random(0,99) <= 50 then 
	   player:UseActiveItem(CollectibleType.COLLECTIBLE_KAMIKAZE,false,false,false,false)
      end
    end
  end

  for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
	if player:HasCollectible(COLLECTIBLE_MAGE_ROBE) then
    if collider.Type == EntityType.ENTITY_PLAYER
    and pickup.SubType == CoinSubType.COIN_LUCKYPENNY
    and not pickup:IsShopItem() then
	 player:UseActiveItem(COLLECTIBLE_A_RERERE,false,false,false,false)
      end
    end
  end

   for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
	if not REPENTOGON then return end
	local persistentGameData = Isaac.GetPersistentGameData()
	if persistentGameData:Unlocked(Achievement.UNLOCKED_MAGE_AURI_CHARACTER) == false then
    if collider.Type == EntityType.ENTITY_PLAYER
    and pickup.SubType == CoinSubType.COIN_LUCKYPENNY
    and not pickup:IsShopItem() then
	   Luckypennyformage = Luckypennyformage + 1

      end
    end
  end

end
Auriz:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, Auriz.OnPickup, PickupVariant.PICKUP_COIN)

function Auriz:OnPickup(pickup, collider, _)
   for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
    if collider.Type == EntityType.ENTITY_PLAYER
	and pickup.SubType ~= KeySubType.KEY_GOLDEN
    and player:HasTrinket(TrinketType.TRINKET_LESSER_KEY)
    and not pickup:IsShopItem() then
	if math.random(0,99) <= 12 then 
	   player:AddItemWisp(math.random(1, 732), player.Position, true)
	   sfx:Play(SoundEffect.SOUND_FLAME_BURST, 1, 0, false, 1)
      end
    end
  end
   for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
   if collider.Type == EntityType.ENTITY_PLAYER
    and player:HasTrinket(TrinketType.TRINKET_LESSER_KEY)
	and pickup.SubType == KeySubType.KEY_GOLDEN
    and not pickup:IsShopItem() then
	if math.random(0,99) <= 50 then 
	   player:AddItemWisp(math.random(1, 732), player.Position, true)
	   sfx:Play(SoundEffect.SOUND_FLAME_BURST, 1, 0, false, 1)
	   end
    end
  end
end
Auriz:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, Auriz.OnPickup, PickupVariant.PICKUP_KEY)

TrinketType.TRINKET_AURI_HAIR_CLIP = Isaac.GetTrinketIdByName("Auri's Hair Clip")

function AuriHairClip() 
  for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
	  if player:HasTrinket(TrinketType.TRINKET_AURI_HAIR_CLIP) then
	  for i, entity in ipairs(Isaac.GetRoomEntities()) do
	  if entity:IsVulnerableEnemy() and math.random(1,30) + player.Luck >= 25  then
      entity:AddCharmed(EntityRef(player), 210)
	  end
      end
	end
  end
end 
Auriz:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, AuriHairClip)

TrinketType.TRINKET_GLOWING_ORB = Isaac.GetTrinketIdByName("Glowing Orb")

function OrbFortune()
	local player = Isaac.GetPlayer(0);
       if player:HasTrinket(TrinketType.TRINKET_GLOWING_ORB) then
	   if game:GetFrameCount() % 2999 == 0 then
	      player:AnimateTrinket(TrinketType.TRINKET_GLOWING_ORB, "UseItem", "Idle")
	      game:ShowFortune()
    end
  end
end
Auriz:AddCallback(ModCallbacks.MC_POST_UPDATE, OrbFortune)

DIRECTION_VECTOR = {
	[Direction.LEFT] = Vector(-10, 0),
	[Direction.UP] = Vector(0, -10),
	[Direction.RIGHT] = Vector(10, 0),
	[Direction.DOWN] = Vector(0, 10)
}

function Auriz:Knife(knife)
   	local player = Isaac.GetPlayer(0)
    local sprite = knife:GetSprite()
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and player:HasCollectible(CollectibleType.COLLECTIBLE_SPIRIT_SWORD) and not player:HasCollectible(CollectibleType.COLLECTIBLE_DEATHS_TOUCH) and not ShadowAurii then
    sprite:ReplaceSpritesheet(0,"gfx/effects/auri_sword_knife.png")
	sprite:ReplaceSpritesheet(1,"gfx/effects/auri_sword_knife.png")
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_BERSERK) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_NOTCHED_AXE) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_URN_OF_SOULS) then 
	return end
    sprite:LoadGraphics()
end
if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and player:HasCollectible(CollectibleType.COLLECTIBLE_SPIRIT_SWORD) and not player:HasCollectible(CollectibleType.COLLECTIBLE_DEATHS_TOUCH) and not ShadowAurii

then
    sprite:ReplaceSpritesheet(0,"gfx/effects/aurii_sword_knife.png")
	sprite:ReplaceSpritesheet(1,"gfx/effects/aurii_sword_knife.png")
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_BERSERK) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_NOTCHED_AXE) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_URN_OF_SOULS) then 
	return end
    sprite:LoadGraphics()
end 
if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and player:HasCollectible(CollectibleType.COLLECTIBLE_SPIRIT_SWORD) and ShadowAurii then
    sprite:ReplaceSpritesheet(0,"gfx/effects/aurii_sword_knife_dark.png")
	sprite:ReplaceSpritesheet(1,"gfx/effects/aurii_sword_knife_dark.png")
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_BERSERK) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_NOTCHED_AXE) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_URN_OF_SOULS) then 
	return end
    sprite:LoadGraphics()
    end 
end
Auriz:AddCallback(ModCallbacks.MC_POST_KNIFE_UPDATE,Auriz.Knife)

function Auriz:Knifejaw(knife)   
local player = Isaac.GetPlayer(0)
  local sprite = knife:GetSprite()

	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_BERSERK) then
	sprite:ReplaceSpritesheet(0,"gfx/effects/aurii_effect_knife.png")
	sprite:ReplaceSpritesheet(1,"gfx/effects/aurii_effect_knife.png")
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_BERSERK) and player:HasCollectible(CollectibleType.COLLECTIBLE_MOMS_KNIFE) then 
	return end
	 sprite:LoadGraphics()

end
end
Auriz:AddCallback(ModCallbacks.MC_POST_KNIFE_UPDATE,Auriz.Knifejaw)

function Auriz:Scythe(knife)
   	local player = Isaac.GetPlayer(0)
    local sprite = knife:GetSprite()
if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and player:HasCollectible(CollectibleType.COLLECTIBLE_SPIRIT_SWORD) and player:HasCollectible(CollectibleType.COLLECTIBLE_DEATHS_TOUCH) then
    sprite:ReplaceSpritesheet(0,"gfx/effects/auriaurii_scythe_sword.png")
	sprite:ReplaceSpritesheet(1,"gfx/effects/auriaurii_scythe_sword.png")
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_BERSERK) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_NOTCHED_AXE) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_URN_OF_SOULS) then 
	return end
    sprite:LoadGraphics()
end 
end
Auriz:AddCallback(ModCallbacks.MC_POST_KNIFE_UPDATE,Auriz.Scythe)

function Auriz:BoneKnife(knife)   
local player = Isaac.GetPlayer(0)
 local sprite = knife:GetSprite()
  local data = knife:GetData()
  if data.UpdatedCustomKnife then return end 
  local sprite = knife:GetSprite()
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_BERSERK) and player:HasCollectible(CollectibleType.COLLECTIBLE_MOMS_KNIFE) then
	sprite:ReplaceSpritesheet(0,"gfx/effects/auriaurii_effect_boneknife.png")
	sprite:ReplaceSpritesheet(1,"gfx/effects/auriaurii_effect_boneknife.png")
	sprite:LoadGraphics()
	 data.UpdatedCustomKnife = player
end
end
Auriz:AddCallback(ModCallbacks.MC_POST_KNIFE_UPDATE,Auriz.BoneKnife)

function Auriz:KnifeDS(knife)
   	local player = Isaac.GetPlayer(0)
    local sprite = knife:GetSprite()
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Auri") and player:HasCollectible(CollectibleType.COLLECTIBLE_SPIRIT_SWORD) and not player:HasCollectible(CollectibleType.COLLECTIBLE_DEATHS_TOUCH) and not ShadowAurii then
    sprite:ReplaceSpritesheet(0,"gfx/effects/darkauri_sword_knife.png")
	sprite:ReplaceSpritesheet(1,"gfx/effects/darkauri_sword_knife.png")
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Auri") and player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_BERSERK) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_NOTCHED_AXE) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_URN_OF_SOULS) then 
	return end
    sprite:LoadGraphics()

end
if (player:GetName() == "Dark Corrupted Auri") and player:HasCollectible(CollectibleType.COLLECTIBLE_SPIRIT_SWORD) and not player:HasCollectible(CollectibleType.COLLECTIBLE_DEATHS_TOUCH) then
    sprite:ReplaceSpritesheet(0,"gfx/effects/darkauri_sword_knife.png")
	sprite:ReplaceSpritesheet(1,"gfx/effects/darkauri_sword_knife.png")
	if (player:GetName() == "Dark Corrupted Auri") and player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_BERSERK) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_NOTCHED_AXE) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_URN_OF_SOULS) then 
	return end
    sprite:LoadGraphics()
end 
if (player:GetName() == "Dark Corrupted Auri") and player:HasCollectible(CollectibleType.COLLECTIBLE_SPIRIT_SWORD) and ShadowAurii then
    sprite:ReplaceSpritesheet(0,"gfx/effects/aurii_sword_knife_dark.png")
	sprite:ReplaceSpritesheet(1,"gfx/effects/aurii_sword_knife_dark.png")
	if (player:GetName() == "Dark Corrupted Auri") and player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_BERSERK) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_NOTCHED_AXE) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_URN_OF_SOULS) then 
	return end
    sprite:LoadGraphics()
    end 
end
Auriz:AddCallback(ModCallbacks.MC_POST_KNIFE_UPDATE,Auriz.KnifeDS)

function Auriz:Knifejaw(knife)   
local player = Isaac.GetPlayer(0)
  local sprite = knife:GetSprite()
	if (player:GetName() == "Dark Corrupted Auri") and player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_BERSERK) then
	sprite:ReplaceSpritesheet(0,"gfx/effects/darkauri_effect_knife.png")
	sprite:ReplaceSpritesheet(1,"gfx/effects/darkauri_effect_knife.png")
	if (player:GetName() == "Dark Corrupted Auri") and player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_BERSERK) and player:HasCollectible(CollectibleType.COLLECTIBLE_MOMS_KNIFE) then 
	return end
	 sprite:LoadGraphics()
end
end
Auriz:AddCallback(ModCallbacks.MC_POST_KNIFE_UPDATE,Auriz.Knifejaw)

function Auriz:DScythe(knife)
   	local player = Isaac.GetPlayer(0)
    local sprite = knife:GetSprite()
if (player:GetName() == "Dark Corrupted Auri") and player:HasCollectible(CollectibleType.COLLECTIBLE_SPIRIT_SWORD) and player:HasCollectible(CollectibleType.COLLECTIBLE_DEATHS_TOUCH) then
    sprite:ReplaceSpritesheet(0,"gfx/effects/auriaurii_scythe_sword.png")
	sprite:ReplaceSpritesheet(1,"gfx/effects/auriaurii_scythe_sword.png")
	if (player:GetName() == "Dark Corrupted Auri") and player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_BERSERK) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_NOTCHED_AXE) then 
	return end
    sprite:LoadGraphics()
end 
end
Auriz:AddCallback(ModCallbacks.MC_POST_KNIFE_UPDATE,Auriz.DScythe)

function Auriz:BoneKnife(knife)   
local player = Isaac.GetPlayer(0)
  local sprite = knife:GetSprite()
	if (player:GetName() == "Dark Corrupted Auri") and player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_BERSERK) and player:HasCollectible(CollectibleType.COLLECTIBLE_MOMS_KNIFE) then
	sprite:ReplaceSpritesheet(0,"gfx/effects/darkauri_effect_boneknife.png")
	sprite:ReplaceSpritesheet(1,"gfx/effects/darkauri_effect_boneknife.png")
	sprite:LoadGraphics()
end
end
Auriz:AddCallback(ModCallbacks.MC_POST_KNIFE_UPDATE,Auriz.BoneKnife)

function Auriz:BoneKnife(knife)   
local player = Isaac.GetPlayer(0)
  local sprite = knife:GetSprite()
	if (player:GetName() == "Genocide Auri") and player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_BERSERK) and player:HasCollectible(CollectibleType.COLLECTIBLE_MOMS_KNIFE) then
	sprite:ReplaceSpritesheet(0,"gfx/effects/genoauri_effect_boneknife.png")
	sprite:ReplaceSpritesheet(1,"gfx/effects/genoauri_effect_boneknife.png")
	sprite:LoadGraphics()
end
end
Auriz:AddCallback(ModCallbacks.MC_POST_KNIFE_UPDATE,Auriz.BoneKnife)

function Auriz:Rod(knife) 
   	local player = Isaac.GetPlayer(0)
    local sprite = knife:GetSprite()
if (player:GetName() == "Mage Auri") and player:HasCollectible(CollectibleType.COLLECTIBLE_SPIRIT_SWORD) then
    sprite:ReplaceSpritesheet(0,"gfx/effects/auri_mage_stuff.png")
	sprite:ReplaceSpritesheet(1,"gfx/effects/auri_mage_stuff.png")
	if (player:GetName() == "Mage Auri") and player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_BERSERK) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_NOTCHED_AXE) then 
	return end
    sprite:LoadGraphics()
end 
end
Auriz:AddCallback(ModCallbacks.MC_POST_KNIFE_UPDATE,Auriz.Rod)

function Auriz:AzraelFlamsword(knife) 
   	local player = Isaac.GetPlayer(0)
    local sprite = knife:GetSprite()
if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Azrael") and player:HasCollectible(CollectibleType.COLLECTIBLE_SPIRIT_SWORD) then
    sprite:ReplaceSpritesheet(0,"gfx/effects/azrael_flame_sword.png")
	sprite:ReplaceSpritesheet(1,"gfx/effects/azrael_flame_sword.png")
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Azrael") and player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_BERSERK) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_NOTCHED_AXE) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_URN_OF_SOULS) then 
	return end
    sprite:LoadGraphics()
end 
end
Auriz:AddCallback(ModCallbacks.MC_POST_KNIFE_UPDATE,Auriz.AzraelFlamsword)

function Auriz:Milcahsword(knife) 
   	local player = Isaac.GetPlayer(0)
    local sprite = knife:GetSprite()
if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Milcah") and player:HasCollectible(CollectibleType.COLLECTIBLE_SPIRIT_SWORD) then
    sprite:ReplaceSpritesheet(0,"gfx/effects/auri_sword_darkkatana.png")
	sprite:ReplaceSpritesheet(1,"gfx/effects/auri_sword_darkkatana.png")
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Milcah") and player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_BERSERK) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_NOTCHED_AXE) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_URN_OF_SOULS) then 
	return end
    sprite:LoadGraphics()
end 
end
Auriz:AddCallback(ModCallbacks.MC_POST_KNIFE_UPDATE,Auriz.Milcahsword)

function Auriz:Naamahsword(knife)
   	local player = Isaac.GetPlayer(0)
    local sprite = knife:GetSprite()
if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Naamah") and player:HasCollectible(CollectibleType.COLLECTIBLE_SPIRIT_SWORD) then
    sprite:ReplaceSpritesheet(0,"gfx/effects/naamah_scythe_sword.png")
	sprite:ReplaceSpritesheet(1,"gfx/effects/naamah_scythe_sword.png")
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Naamah") and player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_BERSERK) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_NOTCHED_AXE) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_URN_OF_SOULS) then 
	return end
    sprite:LoadGraphics()
end 
end
Auriz:AddCallback(ModCallbacks.MC_POST_KNIFE_UPDATE,Auriz.Naamahsword)

function Auriz:Famishsword(knife)
   	local player = Isaac.GetPlayer(0)
    local sprite = knife:GetSprite()
if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Famish") and player:HasCollectible(CollectibleType.COLLECTIBLE_SPIRIT_SWORD) then
    sprite:ReplaceSpritesheet(0,"gfx/effects/famish_sword_rust.png")
	sprite:ReplaceSpritesheet(1,"gfx/effects/famish_sword_rust.png")
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Famish") and player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_BERSERK) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_NOTCHED_AXE) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_URN_OF_SOULS) then 
	return end
    sprite:LoadGraphics()
end 
end
Auriz:AddCallback(ModCallbacks.MC_POST_KNIFE_UPDATE,Auriz.Famishsword)

function Auriz:Delilahsword(knife)
   	local player = Isaac.GetPlayer(0)
    local sprite = knife:GetSprite()
if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Delilah") and player:HasCollectible(CollectibleType.COLLECTIBLE_SPIRIT_SWORD) then
    sprite:ReplaceSpritesheet(0,"gfx/effects/delilah_scissor_sword.png")
	sprite:ReplaceSpritesheet(1,"gfx/effects/delilah_scissor_sword.png")
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Delilah") and player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_BERSERK) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_NOTCHED_AXE) or player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_URN_OF_SOULS) then 
	return end
    sprite:LoadGraphics()
end 
end
Auriz:AddCallback(ModCallbacks.MC_POST_KNIFE_UPDATE,Auriz.Delilahsword)

function Auriz:SpBeamReplace(beam)
	if beam.Variant ~= 47 then return end
	local data = beam:GetData()
	if data.UpdatedCustomBeam then return end
	local sprite = beam:GetSprite()
	local swordHolder = beam.Parent
	if not swordHolder then return end
	if (swordHolder.Type ~= EntityType.ENTITY_PLAYER) and (swordHolder.Type ~= EntityType.ENTITY_FAMILIAR) then return end
	local player = nil
	if (swordHolder.Type ~= EntityType.ENTITY_FAMILIAR) then player = swordHolder:ToPlayer() else player = swordHolder.SpawnerEntity:ToPlayer() end
	local pType = player:GetPlayerType()

	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) then
	 sprite:ReplaceSpritesheet(0,"gfx/effects/aurii_sword_knife.png")
	sprite:ReplaceSpritesheet(1,"gfx/effects/aurii_sword_knife.png")
	elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Azrael") then
    sprite:ReplaceSpritesheet(0,"gfx/effects/azrael_flame_sword.png")
	sprite:ReplaceSpritesheet(1,"gfx/effects/azrael_flame_sword.png")
	elseif (player:GetName() == "Mage Auri") then
    sprite:ReplaceSpritesheet(0,"gfx/effects/auri_mage_stuff.png")
	sprite:ReplaceSpritesheet(1,"gfx/effects/auri_mage_stuff.png")
	elseif (player:GetName() == "Dark Corrupted Auri") then
    sprite:ReplaceSpritesheet(0,"gfx/effects/darkauri_sword_knife.png")
	sprite:ReplaceSpritesheet(1,"gfx/effects/darkauri_sword_knife.png")
	elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Auri") then
    sprite:ReplaceSpritesheet(0,"gfx/effects/darkauri_sword_knife.png")
	sprite:ReplaceSpritesheet(1,"gfx/effects/darkauri_sword_knife.png")
	elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") then
    sprite:ReplaceSpritesheet(0,"gfx/effects/auri_sword_knife.png")
	sprite:ReplaceSpritesheet(1,"gfx/effects/auri_sword_knife.png")
	elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Milcah") then
    sprite:ReplaceSpritesheet(0,"gfx/effects/auri_sword_darkkatana.png")
	sprite:ReplaceSpritesheet(1,"gfx/effects/auri_sword_darkkatana.png")
	elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Naamah") then
    sprite:ReplaceSpritesheet(0,"gfx/effects/naamah_scythe_sword.png")
	sprite:ReplaceSpritesheet(1,"gfx/effects/naamah_scythe_sword.png")
	elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Famish") then
    sprite:ReplaceSpritesheet(0,"gfx/effects/famish_sword_rust.png")
	sprite:ReplaceSpritesheet(1,"gfx/effects/famish_sword_rust.png")
	elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Delilah") then
    sprite:ReplaceSpritesheet(0,"gfx/effects/delilah_scissor_sword.png")
	sprite:ReplaceSpritesheet(1,"gfx/effects/delilah_scissor_sword.png")
	end
	sprite:LoadGraphics()
	data.UpdatedCustomBeam = pType
end

Auriz:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE,Auriz.SpBeamReplace)

function Auriz:GetPlayerUsingItemz()
	local player = Isaac.GetPlayer(0)
	for i = 1, game:GetNumPlayers() do
		local p = Isaac.GetPlayer(i - 1)
		if Input.IsActionTriggered(ButtonAction.ACTION_ITEM, p.ControllerIndex) or Input.IsActionTriggered(ButtonAction.ACTION_PILLCARD, p.ControllerIndex) then
			player = p
			player:GetData().WasHoldingButton = true
			break
		end
	end
	return player
end

COLLECTIBLE_CORRUPTED_DATA = Isaac.GetItemIdByName("Corrupted Data")
local function CorruptedData(_) 

 local player = Auriz:GetPlayerUsingItemz()

  player:AddCollectible(CollectibleType.COLLECTIBLE_TMTRAINER)
  Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE,0 ,Isaac.GetFreeNearPosition(player.Position, 10), Vector(0,0), nil)

  player:RemoveCollectible(CollectibleType.COLLECTIBLE_TMTRAINER)
  game:ShowHallucination(4,BackdropType.ERROR_ROOM)
  return true 

end

Auriz:AddCallback(ModCallbacks.MC_USE_ITEM, CorruptedData, COLLECTIBLE_CORRUPTED_DATA)

COLLECTIBLE_THE_MEMORY = Isaac.GetItemIdByName("The Memory")
function Aurigoodmemories() 
    for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
	local stage = Game():GetLevel():GetStage()
        if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") then

		if stage == LevelStage.STAGE8 and player:HasCollectible(CollectibleType.COLLECTIBLE_GLOWING_HOUR_GLASS) then
       player:RemoveCollectible(CollectibleType.COLLECTIBLE_GLOWING_HOUR_GLASS)
	   Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE,COLLECTIBLE_THE_MEMORY ,Isaac.GetFreeNearPosition(player.Position, 50), Vector(0,0), nil)

	   end
        end
    end
end
Auriz:AddCallback(ModCallbacks.MC_POST_UPDATE, Aurigoodmemories)

function Thememoryitem() 
   for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
        if player:HasCollectible(COLLECTIBLE_THE_MEMORY) then
		if game:GetFrameCount() % 300 == 0 then
        player:AddMinisaac(player.Position, false)
	    sfx:Play(SoundEffect.SOUND_BABY_HURT, 0.5, 0, false, 1)
		end
  end
 end
end
Auriz:AddCallback(ModCallbacks.MC_POST_UPDATE, Thememoryitem)

COLLECTIBLE_ENCHANTED_BOOK = Isaac.GetItemIdByName("Book of Enchant") 
local function EnchantedBook(_) 

	local player = Auriz:GetPlayerUsingItemz()

	sfx:Play(SoundEffect.SOUND_POWERUP1, 1, 0, false, 1.5)
	sfx:Play(SoundEffect.SOUND_POWERUP3, 1, 0, false, 2)
    AuriAchievements.EnchantedBookLuck = AuriAchievements.EnchantedBookLuck + 2
	player:AddCacheFlags(CacheFlag.CACHE_ALL)
 	player:EvaluateItems()
	Usespellbook = true

    return true 

end

Auriz:AddCallback(ModCallbacks.MC_USE_ITEM, EnchantedBook, COLLECTIBLE_ENCHANTED_BOOK)

COLLECTIBLE_CALM_MIND = Isaac.GetItemIdByName("Calm Mind")

local FireMage = nil
function Auriz:Firemagez() 
    local player = Isaac.GetPlayer(0)
        if (player:GetName() == "Mage Auri") 
		and player:HasCollectible(619)
		and Usespellbook 
		then
		if game:GetFrameCount() % 15 == 0 and player:GetFireDirection() ~= -1 then
    local directions = {
      [0] = Vector(-1, 0),
      [1] = Vector(0, -1),
      [2] = Vector(1, 0),
      [3] = Vector(0, 1)
    }
	FireMage = player:ShootRedCandle(directions[player:GetHeadDirection()])
   sfx:Play(SoundEffect.SOUND_BEAST_FIRE_RING,1,0,false,1.5)  

   local color = Color(1, 1, 1, 1, 0, 0, 0)
          color:SetColorize(1, 3, 7, 1)

  end
  if FireMage ~= nil then
    FireMage.Angle = FireMage.Angle + 0
  end
end
end

local spelltime = 150
local Aquaspelltime = 150
local Firespelltime = 40

local Zapspelltime = 150
local Holyspelltime = 60
local Terraspelltime = 30

function EnchantActive(_, player, varData)
    for i = 1, Game():GetNumPlayers() do
        local player = Isaac.GetPlayer(i - 1)

        if (player:GetName() == "Mage Auri") and player:HasCollectible(Birthright) and spelltime <= 1 then

        end

		if
            Usespellbook and (player:GetName() == "Mage Auri") and
                not player:HasCollectible(CollectibleType.COLLECTIBLE_CAR_BATTERY)
         then 

            spelltime = spelltime - 1
            if spelltime <= 0 then
                spelltime = 150

                player:GetEffects():RemoveCollectibleEffect(CollectibleType.COLLECTIBLE_THE_WIZ, 1)
                Usespellbook = false
            end
        end

        if
            Usespellbook and (player:GetName() == "Mage Auri") and
                player:HasCollectible(CollectibleType.COLLECTIBLE_CAR_BATTERY)
         then 
            spelltime = spelltime - 0.5 
            if spelltime <= 0 then
                spelltime = 150

                player:GetEffects():RemoveCollectibleEffect(CollectibleType.COLLECTIBLE_THE_WIZ, 1)
                Usespellbook = false
            end
        end

        if Usespellbook and (player:GetName() == "Mage Auri") and spelltime == 149 then

            player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_THE_WIZ, true)
        end

		if Usespellbook and (player:GetName() == "Mage Auri") and spelltime == 149 and player:HasCollectible(Birthright) then

        end

        if AuriAchievements.witchsoupluck ~= 0 then
            AuriAchievements.witchsoupluck = AuriAchievements.witchsoupluck - 0.003
            player:AddCacheFlags(CacheFlag.CACHE_LUCK) 
            player:EvaluateItems() 

            if AuriAchievements.witchsoupluck <= 0 then
                Outofluck = true 
                AuriAchievements.witchsoupluck = 0
            end
        end

        if player:HasCollectible(COLLECTIBLE_CALM_MIND) and not Calmmindbreak then

            if CacheFlag.CACHE_DAMAGE then
                player:AddCacheFlags(CacheFlag.CACHE_DAMAGE) 
                AuriAchievements.CalmmindDmg = AuriAchievements.CalmmindDmg + 0.0003

                player:EvaluateItems() 
            end
        end
    end
end

Auriz:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, EnchantActive)

function AuriSpellCast(_, player, varData)
	if UsespellbookFire or UsespellbookAqua or UsespellbookZap or UsespellbookHoly or UsespellbookTerra then
	    if Isaac.GetChallenge() == Challenge.CHALLENGE_SOLAR_SYSTEM 
		or Isaac.GetChallenge() == Challenge.CHALLENGE_CAT_GOT_YOUR_TONGUE
		or Isaac.GetChallenge() == Challenge.CHALLENGE_BEANS
		or Isaac.GetChallenge() == Challenge.CHALLENGE_BLUE_BOMBER
		or Isaac.GetChallenge() == Challenge.CHALLENGE_BRAINS
		or Isaac.GetChallenge() == Challenge.CHALLENGE_GUARDIAN
		or Isaac.GetChallenge() == Challenge.CHALLENGE_SCAT_MAN
		or Isaac.GetChallenge() == Challenge.CHALLENGE_BAPTISM_BY_FIRE
		or Isaac.GetChallenge() == Challenge.CHALLENGE_HOT_POTATO
		then 
		UsespellbookFire = false
		UsespellbookAqua = false
		UsespellbookZap = false
		UsespellbookHoly = false
		UsespellbookTerra = false

		return end
	end

    for i = 1, Game():GetNumPlayers() do
        local player = Isaac.GetPlayer(i - 1)

        if UsespellbookFire and not player:HasCollectible(carbat) and not player:HasCollectible(223) and not UseFullFire then
            Firespelltime = Firespelltime - 1 
            if Firespelltime <= 0 then
                Firespelltime = 40
                UsespellbookFire = false
                local data = Auriz:GetPlayerData(player)
                data.canShoot = true
                local game = Game()
                local challenge = game.Challenge
                game.Challenge = 0
                player:UpdateCanShoot()
                game.Challenge = challenge
            end
        end

        if UsespellbookFire and player:HasCollectible(carbat) and not player:HasCollectible(223) and not UseFullFire then
            Firespelltime = Firespelltime - 0.5 
            if Firespelltime <= 0 then
                Firespelltime = 40
                UsespellbookFire = false
                local data = Auriz:GetPlayerData(player)
                data.canShoot = true
                local game = Game()
                local challenge = game.Challenge
                game.Challenge = 0
                player:UpdateCanShoot()
                game.Challenge = challenge
            end
        end

        if UsespellbookFire and not player:HasCollectible(carbat) and player:HasCollectible(223) and not UseFullFire then
            Firespelltime = Firespelltime - 0.4 
            if Firespelltime <= 0 then
                Firespelltime = 40
                UsespellbookFire = false
                local data = Auriz:GetPlayerData(player)
                data.canShoot = true
                local game = Game()
                local challenge = game.Challenge
                game.Challenge = 0
                player:UpdateCanShoot()
                game.Challenge = challenge
            end
        end

        if UsespellbookFire and player:HasCollectible(carbat) and player:HasCollectible(223) and not UseFullFire then
            Firespelltime = Firespelltime - 0.2 
            if Firespelltime <= 0 then
                Firespelltime = 40
                UsespellbookFire = false
                local data = Auriz:GetPlayerData(player)
                data.canShoot = true
                local game = Game()
                local challenge = game.Challenge
                game.Challenge = 0
                player:UpdateCanShoot()
                game.Challenge = challenge
            end
        end

        if
            UsespellbookFire and player:HasTrinket(TrinketType.TRINKET_FIRE_SPELL_SCROLL) and
                player:HasCollectible(COLLECTIBLE_FIRE_SPELLBOOK)
         then
            Firespelltime = Firespelltime - 0.2
            UseFullFire = true
            if Firespelltime <= 0 then
                Firespelltime = 40
                UsespellbookFire = false
                UseFullFire = false
                local data = Auriz:GetPlayerData(player)
                data.canShoot = true
                local game = Game()
                local challenge = game.Challenge
                game.Challenge = 0
                player:UpdateCanShoot()
                game.Challenge = challenge
            end
        end 

        if UsespellbookAqua then
            Aquaspelltime = Aquaspelltime - 1
            if Aquaspelltime <= 0 then
                sfx:Play(SoundEffect.SOUND_BEEP, 1.5, 0, false, 1)
                Aquaspelltime = 150
                UsespellbookAqua = false
                local data = Auriz:GetPlayerData(player)
                data.canShoot = true
                local game = Game()
                local challenge = game.Challenge
                game.Challenge = 0
                player:UpdateCanShoot()
                game.Challenge = challenge
            end
        end
        if UsespellbookZap then
            Zapspelltime = Zapspelltime - 1
            if Zapspelltime <= 0 then
                sfx:Play(SoundEffect.SOUND_BEEP, 1.5, 0, false, 1)
                Zapspelltime = 150
                UsespellbookZap = false
                local data = Auriz:GetPlayerData(player)
                data.canShoot = true
                local game = Game()
                local challenge = game.Challenge
                game.Challenge = 0
                player:UpdateCanShoot()
                game.Challenge = challenge
            end
        end
        if UsespellbookHoly then
            Holyspelltime = Holyspelltime - 1
            if Holyspelltime <= 0 then
                sfx:Play(SoundEffect.SOUND_BEEP, 1.5, 0, false, 1)
                Holyspelltime = 150
                UsespellbookHoly = false
                local data = Auriz:GetPlayerData(player)
                data.canShoot = true
                local game = Game()
                local challenge = game.Challenge
                game.Challenge = 0
                player:UpdateCanShoot()
                game.Challenge = challenge
            end
        end
        if UsespellbookTerra then
            Terraspelltime = Terraspelltime - 1
            if Terraspelltime <= 0 then
                sfx:Play(SoundEffect.SOUND_BEEP, 1.5, 0, false, 1)
                Terraspelltime = 150
                UsespellbookTerra = false
                local data = Auriz:GetPlayerData(player)
                data.canShoot = true
                local game = Game()
                local challenge = game.Challenge
                game.Challenge = 0
                player:UpdateCanShoot()
                game.Challenge = challenge
            end
        end
    end
end

Auriz:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, AuriSpellCast)

COLLECTIBLE_FIRE_SPELLBOOK = Isaac.GetItemIdByName("Fire Spell Book")

function Auriz:GetPlayerData(player)
    local data = player:GetData()
    data.USESPELL_BOOK = data.USESPELL_BOOK or {}
    return data.USESPELL_BOOK
end

function FireBook(_, player, varData) 

  for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)

	sfx:Play(SoundEffect.SOUND_POWERUP1, 1, 0, false, 1.5)
	sfx:Play(SoundEffect.SOUND_POWERUP3, 1, 0, false, 2)
	Firespelltime = 40
	UsespellbookFire = true

 local data = Auriz:GetPlayerData(player)
 local game = Game()
            data.canShoot = false
            local challenge = game.Challenge
            game.Challenge = 6
            player:UpdateCanShoot()
            game.Challenge = challenge

  return true 
  end
end

Auriz:AddCallback(ModCallbacks.MC_USE_ITEM, FireBook, COLLECTIBLE_FIRE_SPELLBOOK)

function Auriz:FireBookz()
    local player = Isaac.GetPlayer(0)

        if UsespellbookFire
		then
		if game:GetFrameCount() % 2 == 0 and player:GetFireDirection() ~= -1 then
    local directions = {
      [0] = Vector(-1.5, 0),
      [1] = Vector(0, -1.5),
      [2] = Vector(1.5, 0),
      [3] = Vector(0, 1.5)
    }
	player:ShootRedCandle(directions[player:GetHeadDirection()])

   sfx:Play(SoundEffect.SOUND_BEAST_FIRE_RING,1,0,false,1.0)  

  end

end
end
Auriz:AddCallback(ModCallbacks.MC_POST_UPDATE, Auriz.FireBookz)

BloodyHour = 0
BloodyHaste = 0
BloodyHeart = 0
COLLECTIBLE_BLOODY_HOURGLASS = Isaac.GetItemIdByName("Bloody Hourglass")
local function BloodyHourglass(_) 
 local player = Auriz:GetPlayerUsingItemz()
	local room = game:GetRoom()
	if player:GetHearts() ~= 0 and not player:HasCollectible(carbat) then
	sfx:Play(SoundEffect.SOUND_VAMP_GULP, 1, 0, false, 1)
	sfx:Play(SoundEffect.SOUND_DEATH_CARD, 1, 0, false, 1)
    BloodyHour = BloodyHour + 0.9 
	BloodyHaste = BloodyHaste + 0.05
	BloodyHeart = BloodyHeart + 1
	player:BloodExplode()
	player:AddHearts(-2)
	room:SetBrokenWatchState(2) 
    player:UseActiveItem(CollectibleType.COLLECTIBLE_DULL_RAZOR,false,false,false,false) 
    sfx:Stop(SoundEffect.SOUND_ISAAC_HURT_GRUNT)

	elseif player:GetHearts() ~= 0 and player:HasCollectible(carbat) then
	sfx:Play(SoundEffect.SOUND_VAMP_GULP, 1, 0, false, 1)
	sfx:Play(SoundEffect.SOUND_DEATH_CARD, 1, 0, false, 1)
    BloodyHour = BloodyHour + 1.8
	BloodyHaste = BloodyHaste + 0.1
	BloodyHeart = BloodyHeart + 1
	player:BloodExplode()

    player:AddHearts(-2)
	room:SetBrokenWatchState(2)
	player:UseActiveItem(CollectibleType.COLLECTIBLE_DULL_RAZOR,false,false,false,false)
    sfx:Stop(SoundEffect.SOUND_ISAAC_HURT_GRUNT)

	end
	UseBloodyHour = true
	player:AddCacheFlags(CacheFlag.CACHE_ALL)
	player:EvaluateItems()

   return true 

end

Auriz:AddCallback(ModCallbacks.MC_USE_ITEM, BloodyHourglass, COLLECTIBLE_BLOODY_HOURGLASS)

function BloodyArerere()
  for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
      if UseBloodyHour then
      BloodyHour = 0
      BloodyHaste = 0
      UseBloodyHour = false

	end
  end
end

Auriz:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, BloodyArerere)

function BloodyHeartregen()
  for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
      if UseBloodyHour then

	  sfx:Play(SoundEffect.SOUND_VAMP_GULP, 1, 0, false, 1)
	  sfx:Play(SoundEffect.SOUND_DEATH_CARD, 1, 0, false, 1.5)
	  player:AddHearts(BloodyHeart)
	  game:SpawnParticles(Vector(player.Position.X, player.Position.Y - 80),EffectVariant.HEART,1,0.3,Color(1,1,1,1,0,0,0),math.random())
	  Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HAEMO_TRAIL, 0, Vector(player.Position.X, player.Position.Y ), Vector.Zero, nil) 

	  BloodyHeart = 0
	  local color  = Color(1, 1, 1, 1, 1, 0, 0)

	  player:SetColor(color, 25, 1, true, false)
	end
  end
end

Auriz:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, BloodyHeartregen)

COLLECTIBLE_A_RERERE = Isaac.GetItemIdByName("A rerere")
local function RERERE(_) 
  for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
	player:AddCacheFlags(CacheFlag.CACHE_ALL)
 	player:EvaluateItems()
  end
end

Auriz:AddCallback(ModCallbacks.MC_USE_ITEM, RERERE, COLLECTIBLE_A_RERERE)

COLLECTIBLE_PRINCESS_BOX = Isaac.GetItemIdByName("Princess Box")

local function PrincessStarterpack(player, pickup, RNG, collectibleType) 

	local player = Auriz:GetPlayerUsingItemz()

        if math.random(1,99) <= 5 then 
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE,415 ,Isaac.GetFreeNearPosition(player.Position, 10), Vector(0,0), nil)
	    end
	    if math.random(1,99) <= 5 then 
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE,442 ,Isaac.GetFreeNearPosition(player.Position, 10), Vector(0,0), nil)
		end
		if math.random(1,99) <= 15 then 
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE,141 ,Isaac.GetFreeNearPosition(player.Position, 10), Vector(0,0), nil)
		end
		if math.random(1,99) == 99 then 
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE,689 ,Isaac.GetFreeNearPosition(player.Position, 10), Vector(0,0), nil)
		end
		if math.random(1,99) <= 80 then 
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET,111 ,Isaac.GetFreeNearPosition(player.Position, 10), Vector(0,0), nil)
		end
		if math.random(1,99) <= 30 then 
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET,92 ,Isaac.GetFreeNearPosition(player.Position, 10), Vector(0,0), nil)
		end
		if math.random(1,99) <= 80 then 
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET,161 ,Isaac.GetFreeNearPosition(player.Position, 10), Vector(0,0), nil)
		end
		if math.random(1,99) <= 80 then 
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET,155 ,Isaac.GetFreeNearPosition(player.Position, 10), Vector(0,0), nil)
		end
		if math.random(1,99) <= 25 then 
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET,146 ,Isaac.GetFreeNearPosition(player.Position, 10), Vector(0,0), nil)
		end
		if math.random(1,99) <= 9 then 
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET,TrinketType.TRINKET_AURI_CROWN ,Isaac.GetFreeNearPosition(player.Position, 10), Vector(0,0), nil)
		end
		if math.random(1,99) <= 9 then 
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET,TrinketType.TRINKET_DARK_AURI_CROWN ,Isaac.GetFreeNearPosition(player.Position, 10), Vector(0,0), nil)
		end
		if math.random(1,99) <= 3 then 
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET,TrinketType.TRINKET_CROWN_OF_DEATH ,Isaac.GetFreeNearPosition(player.Position, 10), Vector(0,0), nil)
	    if math.random(1,99) <= 9 then 
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET,TrinketType.TRINKET_CHALLENGE_CROWN ,Isaac.GetFreeNearPosition(player.Position, 10), Vector(0,0), nil)
        end
	end

   sfx:Play(SoundEffect.SOUND_CHEST_OPEN, 1, 0, false, 1)

   return {
  Discharge = false,
  Remove = true, 
  ShowAnim = true
  }
end

Auriz:AddCallback(ModCallbacks.MC_USE_ITEM, PrincessStarterpack, COLLECTIBLE_PRINCESS_BOX)

COLLECTIBLE_MAGE_HAT = Isaac.GetItemIdByName("Mage Hat")
COLLECTIBLE_WITCHS_SOUP = Isaac.GetItemIdByName("Witch's Soup")
COLLECTIBLE_MAGE_ROBE = Isaac.GetItemIdByName("Mage Robe")

COLLECTIBLE_WAIT_A_SEC = Isaac.GetItemIdByName("Wait a sec")
local function WaitAsec(_)
  local player = Auriz:GetPlayerUsingItemz()
	if not player:HasTrinket(91) 
	and not player:HasCollectible(202)
	and not player:HasCollectible(543)
	and not player:HasTrinket(2)
	then
	sfx:Play(SoundEffect.SOUND_FART, 1, 0, false, 1)
    player:AddFriendlyDip(0, player.Position)
	Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOP_EXPLOSION, -1, player.Position, player.Velocity, poopee)
	Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOP_PARTICLE, -1, player.Position, player.Velocity, poopee)

    end

	if player:HasTrinket(91) 
	and player:HasCollectible(202)
	and player:HasCollectible(543)
	and player:HasTrinket(2)
	then
	sfx:Play(SoundEffect.SOUND_FART, 1, 0, false, 1)
    player:AddFriendlyDip(4, player.Position)
	Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOP_EXPLOSION, -1, player.Position, player.Velocity, poopee)
	Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOP_PARTICLE, -1, player.Position, player.Velocity, poopee)
	return end

	if player:HasTrinket(91) then
	sfx:Play(SoundEffect.SOUND_FART, 1, 0, false, 0.9)
    player:AddFriendlyDip(5, player.Position)
	Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOP_EXPLOSION, -1, player.Position, player.Velocity, poopee)
	Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOP_PARTICLE, -1, player.Position, player.Velocity, poopee)
	end

	if player:HasCollectible(202) then
	sfx:Play(SoundEffect.SOUND_FART, 1, 0, false, 0.9)
    player:AddFriendlyDip(3, player.Position)
	Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOP_EXPLOSION, -1, player.Position, player.Velocity, poopee)
	Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOP_PARTICLE, -1, player.Position, player.Velocity, poopee)
	end

	if player:HasCollectible(543) then
	sfx:Play(SoundEffect.SOUND_FART, 1, 0, false, 0.9)
    player:AddFriendlyDip(6, player.Position)
	Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOP_EXPLOSION, -1, player.Position, player.Velocity, poopee)
	Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOP_PARTICLE, -1, player.Position, player.Velocity, poopee)
	end

	if player:HasTrinket(2) then
	sfx:Play(SoundEffect.SOUND_FART, 1, 0, false, 0.9)
    player:AddFriendlyDip(12, player.Position)
	Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOP_EXPLOSION, -1, player.Position, player.Velocity, poopee)
	Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOP_PARTICLE, -1, player.Position, player.Velocity, poopee)
	end

end

Auriz:AddCallback(ModCallbacks.MC_USE_ITEM, WaitAsec, COLLECTIBLE_WAIT_A_SEC)

COLLECTIBLE_WITCH_CAULDRON = Isaac.GetItemIdByName("Witch Cauldron")
 local witchbrew = 0

 local function WitchCauldron(player)

    local player = Isaac.GetPlayer(0)
    for i = 1, player:GetMaxTrinkets() do
        local trinket_id = player:GetTrinket(0)
		if player:HasCollectible(COLLECTIBLE_WITCH_CAULDRON) then
		local SmeltRNG = math.random(1,100) + player.Luck 
		if SmeltRNG >= 26 and trinket_id ~= TrinketType.TRINKET_NULL then

		      player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER,UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER)

			  sfx:Play(SoundEffect.SOUND_BEAST_FIRE_RING,2.0,0,false,2.5)

			  witchbrew = witchbrew + 1

			  player:AnimateCollectible(COLLECTIBLE_WITCH_CAULDRON, "UseItem", "PlayerPickupSparkle")

		elseif SmeltRNG <= 25 and trinket_id ~= TrinketType.TRINKET_NULL then
		       player:TryRemoveTrinket(trinket_id)
	           sfx:Play(SoundEffect.SOUND_BEAST_FIRE_RING,2.0,0,false,2.5)

		       witchbrew = witchbrew + 1

	           player:AnimateSad()
		end
		end
		if witchbrew >= 10 then

	          Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE,0 ,Isaac.GetFreeNearPosition(player.Position, 50), Vector(0,0), nil) 
	          witchbrew = 0
	          player:RemoveCollectible(COLLECTIBLE_WITCH_CAULDRON)
	          player:AnimateHappy()

	    end
	end
end

Auriz:AddCallback(ModCallbacks.MC_POST_UPDATE, WitchCauldron)

COLLECTIBLE_OLD_ROPE = Isaac.GetItemIdByName("Old Rope")

local function OldRopeItem(pickup, RNG)

  local player = Auriz:GetPlayerUsingItemz()
        OldRopeRNGz = math.random(1,3)
		if OldRopeRNGz == 1 then
		player:UseCard(Card.CARD_HANGED_MAN, UseFlag.USE_NOANIM) 

		elseif OldRopeRNGz == 2 then
		player:UseCard(Card.CARD_REVERSE_HANGED_MAN, UseFlag.USE_NOANIM)

	    elseif OldRopeRNGz == 3 then
        player:UseActiveItem(186,false,false,false,false)

 end
 return true 
end

Auriz:AddCallback(ModCallbacks.MC_USE_ITEM, OldRopeItem, COLLECTIBLE_OLD_ROPE)

COLLECTIBLE_DYING = Isaac.GetItemIdByName("Dying")

function DyingItem(player, flags)
   for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)

	if player.SubType == 59 and player.Variant == 1 then return end 
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Milcah") and
	    player:HasCollectible(Birthright) 
		 and player:GetHearts() == 2
		 and player:GetBlackHearts() == 0
		 and player:GetSoulHearts() == 0
		 and player:GetBoneHearts() == 0 
	     and player:HasCollectible(COLLECTIBLE_DYING) and DyingActive 
	or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Milcah") and
	    player:HasCollectible(Birthright) 
		 and player:GetHearts() == 0
		 and player:GetBlackHearts() == 1
		 and player:GetSoulHearts() == 2
		 and player:GetBoneHearts() == 0 
	     and player:HasCollectible(COLLECTIBLE_DYING) and DyingActive
	or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Milcah") and
	    player:HasCollectible(Birthright) 
		 and player:GetHearts() == 0
		 and player:GetBlackHearts() == 0
		 and player:GetSoulHearts() == 2
		 and player:GetBoneHearts() == 0 
	     and player:HasCollectible(COLLECTIBLE_DYING) and DyingActive
	or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Milcah") and
	    player:HasCollectible(Birthright) 
		 and player:GetHearts() == 0
		 and player:GetBlackHearts() == 0
		 and player:GetSoulHearts() == 0
		 and player:GetBoneHearts() == 2
	     and player:HasCollectible(COLLECTIBLE_DYING) and DyingActive then return end
        if player:HasCollectible(COLLECTIBLE_DYING)
		 and player:GetHearts() == 1 
		 and player:GetBlackHearts() == 0
		 and player:GetSoulHearts() == 0
		 and player:GetBoneHearts() == 0 
		 and not DyingActive
		 or player:HasCollectible(COLLECTIBLE_DYING) 
		 and player:GetHearts() == 0
		 and player:GetBlackHearts() == 1
		 and player:GetSoulHearts() == 1
		 and player:GetBoneHearts() == 0 
		 and not DyingActive
		 or player:HasCollectible(COLLECTIBLE_DYING) 
		 and player:GetHearts() == 0
		 and player:GetBlackHearts() == 0
		 and player:GetSoulHearts() == 1
		 and player:GetBoneHearts() == 0 
		 and not DyingActive
		 or player:HasCollectible(COLLECTIBLE_DYING) 
		 and player:GetHearts() == 0
		 and player:GetBlackHearts() == 0
		 and player:GetSoulHearts() == 0
		 and player:GetBoneHearts() == 1 
		 and not DyingActive
		 or player:HasCollectible(COLLECTIBLE_DYING) 
		 and AuriHeartless and not DyingActive
		 then
		DyingActive = true

		sfx:Play(SoundEffect.SOUND_BERSERK_START, 1, 0, false, 1.5)
		sfx:Play(SoundEffect.SOUND_ISAAC_ROAR, 1.9, 0, false, 1)
	    game:ShakeScreen(19)

		player:UseActiveItem(COLLECTIBLE_A_RERERE)

		elseif player:HasCollectible(COLLECTIBLE_DYING) 
		 and player:GetHearts() >= 2

		 and DyingActive

		 or player:HasCollectible(COLLECTIBLE_DYING) 

		 and player:GetBlackHearts() >= 1
		 and player:GetSoulHearts() >= 2

		 and DyingActive
		 or player:HasCollectible(COLLECTIBLE_DYING) 

		 and player:GetSoulHearts() >= 2

		 and DyingActive
		or player:HasCollectible(COLLECTIBLE_DYING) 

		 and player:GetBoneHearts() >= 2
		 and DyingActive

		then
		DyingActive = false
		sfx:Play(SoundEffect.SOUND_BERSERK_END, 1, 0, false, 1.5)
		player:UseActiveItem(COLLECTIBLE_A_RERERE)
		local color  = Color(1, 1, 1, 1, 0, 0, 0);
		color:SetOffset(0.9, 0.4, 0.1);
	    player:SetColor(color, 15, 1, true, false);
  end
 end

  for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
	if player:HasCollectible(COLLECTIBLE_DYING) and DyingActive and AuriHeartless
	and player:GetPlayerType() == PlayerType.PLAYER_TAINTED_AURII 
	or player:HasCollectible(COLLECTIBLE_DYING) and DyingActive and 
	player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY) 
    or player:HasCollectible(COLLECTIBLE_DYING) and DyingActive and 
	player:HasCollectible(CollectibleType.COLLECTIBLE_DR_FETUS) 
	or player:HasCollectible(COLLECTIBLE_DYING) and DyingActive and 
	player:HasCollectible(CollectibleType.COLLECTIBLE_EPIC_FETUS) 
	or player:HasCollectible(COLLECTIBLE_DYING) and DyingActive and 
	player:HasCollectible(CollectibleType.COLLECTIBLE_BRIMSTONE)
	or player:HasCollectible(COLLECTIBLE_DYING) and DyingActive and 
	player:HasCollectible(CollectibleType.COLLECTIBLE_SPIRIT_SWORD)
    or player:HasCollectible(COLLECTIBLE_DYING) and DyingActive and 
	player:HasCollectible(CollectibleType.COLLECTIBLE_MOMS_KNIFE)
	or player:HasCollectible(COLLECTIBLE_DYING) and DyingActive and 
	player:HasCollectible(CollectibleType.COLLECTIBLE_LUDOVICO_TECHNIQUE)
	or player:HasCollectible(COLLECTIBLE_DYING) and DyingActive and 
	player:HasCollectible(CollectibleType.COLLECTIBLE_TECH_X)
	 then
	  if not DyingCheck then
	    player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_FRUIT_CAKE, false)

	    DyingCheck = true 

	  end
	end
	if player:HasCollectible(COLLECTIBLE_DYING) and not DyingActive and not AuriHeartless
	and player:GetPlayerType() == PlayerType.PLAYER_TAINTED_AURII and not
	player:HasCollectible(CollectibleType.COLLECTIBLE_FRUIT_CAKE)
	and player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_FRUIT_CAKE)
	or player:HasCollectible(COLLECTIBLE_DYING) and not DyingActive and not
	player:HasCollectible(CollectibleType.COLLECTIBLE_FRUIT_CAKE)
	and player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_FRUIT_CAKE)
	  then
	  if DyingCheck then 
	     player:GetEffects():RemoveCollectibleEffect(CollectibleType.COLLECTIBLE_FRUIT_CAKE, 1)

	  DyingCheck = false
	  end
	end
  end
end
Auriz:AddCallback(ModCallbacks.MC_POST_UPDATE, DyingItem)

function Auriz:Dyingtears(tear)
for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
   if player:HasCollectible(COLLECTIBLE_DYING) and DyingActive then

        if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_HOMING
		end
		 if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_BOOGER
		end
		 if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_LASERSHOT
		end

		 if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_JACOBS
		end
		 if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_LASER
		end
		 if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_BURSTSPLIT
		end
		 if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_SPECTRAL
		end
		 if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_SLOW
		end
		 if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_POISON
		end
		 if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_FREEZE
		end
		 if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_SPLIT
		end
		 if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_GROW
		end
		 if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_BOOMERANG
		end
		 if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_PERSISTENT
		end
		 if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_WIGGLE
		end
		 if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_MULLIGAN
		end
	    if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_CHARM
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_CONFUSION
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_WAIT
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_QUADSPLIT
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_BOUNCE
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_FEAR
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_SHRINK
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_BURN
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_ATTRACTOR
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_KNOCKBACK
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_PULSE
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_SPIRAL
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_FLAT
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_SQUARE
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_GLOW
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_GISH
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_MYSTERIOUS_LIQUID_CREEP
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_SHIELDED
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_STICKY
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_CONTINUUM
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_LIGHT_FROM_HEAVEN
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_GODS_FLESH
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_EGG
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_ACID
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_BONE
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_BELIAL
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_MIDAS
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_NEEDLE
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_JACOBS
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_HORN
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_LASER
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_POP
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_ABSORB
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_HYDROBOUNCE
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_BURSTSPLIT
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_PUNCH
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_ICE
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_MAGNETIZE
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_BAIT
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_OCCULT
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_ROCK
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_TURN_HORIZONTAL
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_ECOLI
		end
		if math.random(1,50) == 50 then 
		tear.TearFlags = tear.TearFlags | TearFlags.TEAR_SPORE
		end

		end
	end

	local player = Isaac.GetPlayer(0)
      if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Mage Auri") then

	    if player.Luck == 5 or player.Luck == 6 or player.Luck == 7 or player.Luck == 8 or player.Luck == 9
	    then
		magetear25 = math.random(0, 100) 
		if magetear25 >= 75 then
		tear.TearFlags = tear.TearFlags |TearFlags.TEAR_HOMING

		end
		end

		if player.Luck == 10 or player.Luck == 11 or player.Luck == 12 or player.Luck == 13 or player.Luck == 14
		then
		magetear50 = math.random(0, 100)
		if magetear50 >= 50 then
		tear.TearFlags = tear.TearFlags |TearFlags.TEAR_HOMING

		end
		end

		if player.Luck == 15 or player.Luck == 16 or player.Luck == 17 or player.Luck == 18 or player.Luck == 19
		then
		magetear75 = math.random(0, 100)
		if magetear75 >= 25 then
		tear.TearFlags = tear.TearFlags |TearFlags.TEAR_HOMING

		end
		end

		if player.Luck >= 20 then

		tear.TearFlags = tear.TearFlags |TearFlags.TEAR_HOMING

		end
	end
end
Auriz:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, Auriz.Dyingtears)
Auriz:AddCallback(ModCallbacks.MC_POST_FIRE_TECH_LASER, Auriz.Dyingtears) 
Auriz:AddCallback(ModCallbacks.MC_POST_FIRE_TECH_X_LASER, Auriz.Dyingtears) 
Auriz:AddCallback(ModCallbacks.MC_POST_FIRE_SWORD, Auriz.Dyingtears) 
Auriz:AddCallback(ModCallbacks.MC_POST_FIRE_BRIMSTONE, Auriz.Dyingtears) 

COLLECTIBLE_GOLDEN_PINK_HOURGLASS = Isaac.GetItemIdByName("Aged Hourglass")
AuDiceCount = 0
AgedhourUseCount = 0
local function AuriDice()
 AgedhourUseCount = AgedhourUseCount + 1 

	local player = Auriz:GetPlayerUsingItemz()
	if AgedhourUseCount <= 3 then
	player:UseActiveItem(422)
	UseAuriDice = true

 end
 local player = Auriz:GetPlayerUsingItemz()
  if AgedhourUseCount >= 4 then
    AgedRNG = math.random(0,100) 
	if AgedRNG >= 50 then

  	player:RemoveCollectible(COLLECTIBLE_GOLDEN_PINK_HOURGLASS)
	player:AddCollectible(COLLECTIBLE_BROKEN_GLOWING_HOURGLASS, 0, false)
    sfx:Play(SoundEffect.SOUND_GLASS_BREAK, 1, 0, false, 1)
	player:AnimateSad()
	AgedhourUseCount = 0
  elseif AgedRNG <= 49 then

  	    player:UseActiveItem(422)
	    UseAuriDice = true

	end
  end
end

Auriz:AddCallback(ModCallbacks.MC_USE_ITEM, AuriDice, COLLECTIBLE_GOLDEN_PINK_HOURGLASS)

function AuriDiceRerere() 
local player = Auriz:GetPlayerUsingItemz()
if UseAuriDice then
 AuDiceCount = AuDiceCount + 1 
 player:StopExtraAnimation()

 end
 if UseAuriDice and AuDiceCount == 1 then 
 player:DischargeActiveItem()

 end
 if UseAuriDice and AuDiceCount == 2 then
 player:UseActiveItem(CollectibleType.COLLECTIBLE_D6,false,false,false,false)
player:UseActiveItem(CollectibleType.COLLECTIBLE_D10,false,false,false,false)
AuDiceCount = 0
UseAuriDice = false

end

end

Auriz:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, AuriDiceRerere)

COLLECTIBLE_SEDUCE = Isaac.GetItemIdByName("Seduce")

function Auriz:Seduce(_, rng, player)

 for i, entity in ipairs(Isaac.GetRoomEntities()) do
   if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Naamah") and entity:GetEntityFlags() & EntityFlag.FLAG_CHARM == EntityFlag.FLAG_CHARM and not entity:IsBoss() then
	    entity:AddCharmed(EntityRef(player), -1)
	 end
  end

	 for i, entity in ipairs(Isaac.GetRoomEntities()) do
      if entity:IsVulnerableEnemy() then

	  loveme = math.random(1,9)
	  if loveme ~= 9 then
      entity:AddCharmed(EntityRef(player), 999)

	  elseif loveme == 9 and not entity:IsBoss() then
	  entity:AddCharmed(EntityRef(player), -1)

    end
  end
end

    sfx:Play(SoundEffect.SOUND_KISS_LIPS1,1,0,false,1.2)
	return true
end
Auriz:AddCallback(ModCallbacks.MC_USE_ITEM, Auriz.Seduce, COLLECTIBLE_SEDUCE)

COLLECTIBLE_RANDOMNESS = Isaac.GetItemIdByName("Randomness")
function AuriRandomness() 
local player = Auriz:GetPlayerUsingItemz()

 for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
	if player:HasCollectible(COLLECTIBLE_RANDOMNESS) and game:GetRoom():IsFirstVisit() 
	then
	player:UseActiveItem(CollectibleType.COLLECTIBLE_METRONOME,true,false,false,false)
  end
 end

end

Auriz:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, AuriRandomness)

COLLECTIBLE_ENERGY_SHIELD = Isaac.GetItemIdByName("Energy Shield")

local function EnergySheild(_) 
   for i = 1, Game():GetNumPlayers() do
   local player = Isaac.GetPlayer(i - 1)

	if player:GetActiveItem(0) == COLLECTIBLE_ENERGY_SHIELD and player:GetActiveCharge(0) == 4 
	or player:GetActiveItem(2) == COLLECTIBLE_ENERGY_SHIELD and player:GetActiveCharge(0) == 4 
then
	sfx:Play(SoundEffect.SOUND_HOLY_MANTLE, 1, 0, false, 1.6)
	sfx:Play(SoundEffect.SOUND_LASERRING_WEAK, 1, 0, false, 1.2)
	local Eshield = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CHAIN_LIGHTNING, -1, player.Position, player.Velocity, player)
	Eshield.CollisionDamage = player.Damage * 1.5
	player:SetMinDamageCooldown(50)
    player:DischargeActiveItem(0)

  return false
  end
 end
end
Auriz:AddCallback(ModCallbacks.MC_USE_ITEM, EnergySheild, COLLECTIBLE_ENERGY_SHIELD)
Auriz:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, EnergySheild, EntityType.ENTITY_PLAYER)

COLLECTIBLE_WITCHS_BROOM = Isaac.GetItemIdByName("Witch's Broom")

function AuriNewWitchBroom()

	local player = Auriz:GetPlayerUsingItemz()

player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_MARS, true)

sfx:Play(SoundEffect.SOUND_BLACK_POOF, 1, 0, false, 1)
   return {
  Discharge = true,
  Remove = false,
  ShowAnim = false
  }
end

Auriz:AddCallback(ModCallbacks.MC_USE_ITEM, AuriNewWitchBroom, COLLECTIBLE_WITCHS_BROOM)

TrinketType.TRINKET_FIRE_SPELL_SCROLL = Isaac.GetTrinketIdByName("Fire Spell Scroll") 

function FireMagicPage()
	 for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
	if player:HasTrinket(TrinketType.TRINKET_FIRE_SPELL_SCROLL)

    and math.random(0,99) - player.Luck <= 20 and not Game():GetRoom():IsClear()
	then
	player:AnimateTrinket(TrinketType.TRINKET_FIRE_SPELL_SCROLL, "UseItem", "Idle")
	player:UseActiveItem(COLLECTIBLE_FIRE_SPELLBOOK,false,false,false,false)
	end
  end

end 
Auriz:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, FireMagicPage)

COLLECTIBLE_CANDY = Isaac.GetItemIdByName("Candy") 

local function AuriCandy()
  for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
  if player:HasCollectible(COLLECTIBLE_CANDY) 
  and AuriAchievements.Candy == 0 and player:GetCollectibleNum(COLLECTIBLE_CANDY) == 1 then
  AuriAchievements.Candy = AuriAchievements.Candy + 1
  sfx:Play(SoundEffect.SOUND_VAMP_GULP , 1, 0, false, 1)

    player:AddEternalHearts(1)
	player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER, false, false, true, true)
	elseif player:HasCollectible(COLLECTIBLE_CANDY) and AuriAchievements.Candy == 1 and
  player:GetCollectibleNum(COLLECTIBLE_CANDY) == 2 then
  AuriAchievements.Candy = AuriAchievements.Candy + 1
    sfx:Play(SoundEffect.SOUND_VAMP_GULP , 1, 0, false, 1)
    player:AddEternalHearts(1)
	player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER, false, false, true, true)

	elseif player:HasCollectible(COLLECTIBLE_CANDY) and AuriAchievements.Candy == 2 and
  player:GetCollectibleNum(COLLECTIBLE_CANDY) == 3 then
  AuriAchievements.Candy = AuriAchievements.Candy + 1
    sfx:Play(SoundEffect.SOUND_VAMP_GULP , 1, 0, false, 1)
    player:AddEternalHearts(1)
	player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER, false, false, true, true)

    end
  end
end
Auriz:AddCallback(ModCallbacks.MC_POST_UPDATE, AuriCandy)

TrinketType.TRINKET_MILCAHS_FAITH = Isaac.GetTrinketIdByName("Milcah's Faith")

function MilcahsFaith()

  local player = Isaac.GetPlayer(0)
  if player:GetBlackHearts() >= 1 then return end
    if player:GetSoulHearts() >= 1 then return end

    if player:HasTrinket(TrinketType.TRINKET_MILCAHS_FAITH) 

	then

	player:AddHearts(2* player:GetTrinketMultiplier(TrinketType.TRINKET_MILCAHS_FAITH)) 
	end
end
Auriz:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, MilcahsFaith)

COLLECTIBLE_SELF_HARM = Isaac.GetItemIdByName("Self-Harm")

local function AuriSelfHarmItem()
	local player = Auriz:GetPlayerUsingItemz()
 if (player:GetName() == "Aurii") then 
	sfx:Play(SoundEffect.SOUND_KNIFE_PULL, 1, 0, false, 1.5)

	player:RemoveCollectible(579) 
	player:UseActiveItem(CollectibleType.COLLECTIBLE_DULL_RAZOR,false,false,false,false)
	Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLOOD_PARTICLE, 0, player.Position, Vector(0,0), player)
	player:ResetDamageCooldown()
  end
 if (player:GetName() ~= "Aurii") then 
	sfx:Play(SoundEffect.SOUND_KNIFE_PULL, 1, 0, false, 1.5)
	player:UseActiveItem(CollectibleType.COLLECTIBLE_DULL_RAZOR,false,false,false,false)

	Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLOOD_PARTICLE, 0, player.Position, Vector(0,0), player)
	player:ResetDamageCooldown()

  end
end

Auriz:AddCallback(ModCallbacks.MC_USE_ITEM, AuriSelfHarmItem, COLLECTIBLE_SELF_HARM)

function Auriz:CollectHearts(entity, collider)

	if collider.Type == EntityType.ENTITY_PLAYER then
		local player = collider:ToPlayer()
		if player:GetPlayerType() == PlayerType.PLAYER_DEPRESSED_AURI then
		if entity.SubType == HeartSubType.HEART_FULL
		or entity.SubType == HeartSubType.HEART_HALF
        or entity.SubType == HeartSubType.HEART_DOUBLEPACK
		or entity.SubType == HeartSubType.HEART_ROTTEN
		or entity.SubType == HeartSubType.HEART_SCARED then
		return false
		elseif entity.SubType == HeartSubType.HEART_BLENDED and not entity:IsShopItem() then
		if player:GetSoulHearts() + player:GetBoneHearts() * 2 < 24 then
		entity:GetSprite():Play("Collect", true)
		entity:Die()
		sfx:Play(SoundEffect.SOUND_BOSS2_BUBBLES, 1, 0, false)
		player:AddSoulHearts(2)
		end
		return false
		end
	end
end

	if collider.Type == EntityType.ENTITY_PLAYER then
		local player = collider:ToPlayer()
		if player:GetPlayerType() == PlayerType.PLAYER_TAINTED_AURII and AuriHeartless then
			if entity.SubType == HeartSubType.HEART_DOUBLEPACK and not entity:IsShopItem() then
                    AuriiSoulCollect = AuriiSoulCollect + 2 
                    entity:GetSprite():Play("Collect", true)
					entity:Die()
					sfx:Play(SoundEffect.SOUND_BOSS2_BUBBLES, 1, 0, false)
				return false

			elseif entity.SubType == HeartSubType.HEART_FULL and not entity:IsShopItem() 
			or entity.SubType == HeartSubType.HEART_SCARED and not entity:IsShopItem() 
            or entity.SubType == HeartSubType.HEART_ROTTEN and not entity:IsShopItem() 

			then
			        AuriiSoulCollect = AuriiSoulCollect + 1
                    entity:GetSprite():Play("Collect", true)
					entity:Die()
					sfx:Play(SoundEffect.SOUND_BOSS2_BUBBLES, 1, 0, false)
				return false
			elseif entity.SubType == HeartSubType.HEART_HALF and not entity:IsShopItem() 

			 then
			 		AuriiSoulCollect = AuriiSoulCollect + 0.5
					entity:GetSprite():Play("Collect", true)
					entity:Die()
					sfx:Play(SoundEffect.SOUND_BOSS2_BUBBLES, 1, 0, false)
				return false
			end
		end
	end

end
Auriz:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, Auriz.CollectHearts, PickupVariant.PICKUP_HEART)

local  DepressedAuri = { 
    DAMAGE = 0,
    SPEED = -0.7,
	TEARS = -4,
    SHOTSPEED = -0.2,
    TEARHEIGHT = 0,
    TEARFALLINGSPEED = 0,
    LUCK = -3,
    FLYING = true,                                 
    TEARFLAG = 0,
    TEARCOLOR = Color(1.0, 1.0, 1.0, 1.0, 0, 0, 0)
}

function DepressedAuri:onCache(player, cacheFlag)
    if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Depressed Auri") then
     if cacheFlag == CacheFlag.CACHE_FLYING and DepressedAuri.FLYING then
            player.CanFly = true
        end
	 if cacheFlag == CacheFlag.CACHE_SPEED then
            player.MoveSpeed = player.MoveSpeed + DepressedAuri.SPEED
        end
	 if cacheFlag == CacheFlag.CACHE_LUCK then
            player.Luck = player.Luck + DepressedAuri.LUCK
        end
     if cacheFlag == CacheFlag.CACHE_FIREDELAY  then
            player.MaxFireDelay = player.MaxFireDelay - DepressedAuri.TEARS

        end
	end
end

Auriz:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, DepressedAuri.onCache)

function HangGirlCard()
	for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Depressed Auri") then
	player:UseCard(Card.CARD_REVERSE_HANGED_MAN, UseFlag.USE_NOANNOUNCER)
  end
end
end
Auriz:AddCallback(ModCallbacks.MC_USE_CARD, HangGirlCard, Card.CARD_HANGED_MAN)

local DpcAuri = {
DAMAGE = -0.5,
SPEED = 0.4,
SHOTSPEED = 0.1,
TEARFALLINGSPEED = 0
}

function Milcahuniquecrown()
    local player = Isaac.GetPlayer(0)
    if
        player:HasCollectible(CollectibleType.COLLECTIBLE_DARK_PRINCES_CROWN) and
        player:GetCollectibleNum(CollectibleType.COLLECTIBLE_DARK_PRINCES_CROWN) == 2 and
        player:GetPlayerType() == Isaac.GetPlayerTypeByName("Milcah")
     then
        player:RemoveCollectible(CollectibleType.COLLECTIBLE_DARK_PRINCES_CROWN)
        player:AddCollectible(COLLECTIBLE_DARK_PRINCESS_CROWN)
        player:AnimateCollectible(COLLECTIBLE_DARK_PRINCESS_CROWN, "UseItem", "Idle")
        sfx:Play(SoundEffect.SOUND_DEVILROOM_DEAL, 1, 0, false, 1)
        game:GetHUD():ShowItemText("Dark Princess's Crown", "Sacrifice is power")
    end
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Milcah") and
	    player:HasCollectible(Birthright) 
		 and player:GetHearts() == 2
		 and player:GetBlackHearts() == 0
		 and player:GetSoulHearts() == 0
		 and player:GetBoneHearts() == 0 
	     and player:HasCollectible(COLLECTIBLE_DYING) and not DyingActive 
	or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Milcah") and
	    player:HasCollectible(Birthright) 
		 and player:GetHearts() == 0
		 and player:GetBlackHearts() == 1 
		 and player:GetSoulHearts() == 2 
		 and player:GetBoneHearts() == 0 
	     and player:HasCollectible(COLLECTIBLE_DYING) and not DyingActive
	or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Milcah") and
	    player:HasCollectible(Birthright) 
		 and player:GetHearts() == 0
		 and player:GetBlackHearts() == 0
		 and player:GetSoulHearts() == 2
		 and player:GetBoneHearts() == 0 
	     and player:HasCollectible(COLLECTIBLE_DYING) and not DyingActive
	or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Milcah") and
	    player:HasCollectible(Birthright) 
		 and player:GetHearts() == 0
		 and player:GetBlackHearts() == 0
		 and player:GetSoulHearts() == 0
		 and player:GetBoneHearts() == 2
	     and player:HasCollectible(COLLECTIBLE_DYING) and not DyingActive then
	    DyingActive = true
		sfx:Play(SoundEffect.SOUND_BERSERK_START, 1, 0, false, 1.5)
		sfx:Play(SoundEffect.SOUND_ISAAC_ROAR, 1.9, 0, false, 1)
	    game:ShakeScreen(19)

		player:UseActiveItem(COLLECTIBLE_A_RERERE)

	end
end

Auriz:AddCallback(ModCallbacks.MC_POST_UPDATE, Milcahuniquecrown)

function DpcAuri:onCache(player, cacheFlag)
    if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Milcah") then
	    if cacheFlag == CacheFlag.CACHE_DAMAGE then
            player.Damage = player.Damage + DpcAuri.DAMAGE
        end
		if cacheFlag == CacheFlag.CACHE_SHOTSPEED then
            player.ShotSpeed = player.ShotSpeed + DpcAuri.SHOTSPEED
        end

		if cacheFlag == CacheFlag.CACHE_FIREDELAY  then
		  if player:HasCollectible(442) and player:GetHearts() == 2 then

			 player.MaxFireDelay = fromTears(toTears(player.MaxFireDelay) + 0.5) 

          end
		end

		if cacheFlag == CacheFlag.CACHE_FIREDELAY then
		  if player:GetHearts() ~= 2 then

			player.MaxFireDelay = fromTears(toTears(player.MaxFireDelay) / 2) 
          end
		end

		if cacheFlag == CacheFlag.CACHE_SPEED then
            player.MoveSpeed = player.MoveSpeed + DpcAuri.SPEED
        end
    end
end

Auriz:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, DpcAuri.onCache)

function DpcAurihair() 
	for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
    if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Milcah") and player:GetHearts() == 2 and not Dpcauhair then
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/dpc_auri_hair_glow.anm2"))
	player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/dpc_auri_hair.anm2"))
    Dpcauhair = true
	elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Milcah") and player:GetHearts() ~= 2 and Dpcauhair then
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/dpc_auri_hair.anm2"))
	player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/dpc_auri_hair_glow.anm2"))
	Dpcauhair = false
	end
  end
end

  Auriz:AddCallback(ModCallbacks.MC_POST_UPDATE, DpcAurihair)

function Auriz:onTear(tear)
    if tear.SpawnerEntity:ToPlayer() ~= nil then
        for i = 1, Game():GetNumPlayers() do
            local player = Isaac.GetPlayer(i - 1)
            local player = tear.SpawnerEntity:ToPlayer()
            if player:HasCollectible(442) and player:GetHearts() == 2 and player:GetPlayerType() == Isaac.GetPlayerTypeByName("Milcah") 

			then
                local data = tear:GetData()
                if
                    tear.Variant ~= TearVariant.TOOTH and tear.Variant ~= TearVariant.RAZOR and
					    tear.Variant ~= TearVariant.EGG and
                        tear.Variant ~= TearVariant.NEEDLE and
                        tear.Variant ~= TearVariant.BLACK_TOOTH and

                        tear.Variant ~= TearVariant.BOOGER and
                        tear.Variant ~= TearVariant.FIST and
                        tear.Variant ~= TearVariant.SPORE
                 then
                    if tear.Variant ~= TearVariant.DIAMOND then
                        tear:ChangeVariant(TearVariant.DIAMOND)
                    end
                    if
                        tear.TearFlags ~= TearFlags.TEAR_HOMING and
                            tear.TearFlags ~= TearFlags.TEAR_FREEZE and
                            tear.TearFlags ~= TearFlags.TEAR_BURN and
                            tear.TearFlags ~= TearFlags.TEAR_MYSTERIOUS_LIQUID_CREEP and
							tear.TearFlags ~= TearFlags.TEAR_POISON
                     then
                        local color = Color(1, 1, 1, 1, 0, 0, 0)
                        color:SetColorize(1.1, 0, 0, 1)
                        tear:SetColor(color, 0, 0, true, false)
                    end
                end
            end
        end
    end

	if tear.SpawnerEntity:ToPlayer() ~= nil then
        for i = 1, Game():GetNumPlayers() do
            local player = Isaac.GetPlayer(i - 1)
            local player = tear.SpawnerEntity:ToPlayer()
            if DyingActive 

			and player:GetPlayerType() == Isaac.GetPlayerTypeByName("Milcah Tainted") then
                local data = tear:GetData()
                if
                    tear.Variant ~= TearVariant.TOOTH and tear.Variant ~= TearVariant.RAZOR and
					    tear.Variant ~= TearVariant.EGG and
                        tear.Variant ~= TearVariant.NEEDLE and
                        tear.Variant ~= TearVariant.BLACK_TOOTH and

                        tear.Variant ~= TearVariant.BOOGER and
                        tear.Variant ~= TearVariant.FIST and
                        tear.Variant ~= TearVariant.SPORE
                 then
                    if tear.Variant ~= TearVariant.DIAMOND then
                        tear:ChangeVariant(TearVariant.DIAMOND)
                    end
                    if
                        tear.TearFlags ~= TearFlags.TEAR_HOMING and
                            tear.TearFlags ~= TearFlags.TEAR_FREEZE and
                            tear.TearFlags ~= TearFlags.TEAR_BURN and
                            tear.TearFlags ~= TearFlags.TEAR_MYSTERIOUS_LIQUID_CREEP and
							tear.TearFlags ~= TearFlags.TEAR_POISON
                     then
                        local color = Color(0, 0, 0, 1, 0, 0, 0)
                        color:SetColorize(1, 1, 1, 1)
                        tear:SetColor(color, 0, 0, true, false)
                    end
                end
            end
        end
    end

	    if tear.SpawnerEntity:ToPlayer() ~= nil then
        for i = 1, Game():GetNumPlayers() do
            local player = Isaac.GetPlayer(i - 1)
            local player = tear.SpawnerEntity:ToPlayer()
            if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Auri") then
                local data = tear:GetData()
                if
                    tear.Variant ~= TearVariant.TOOTH and tear.Variant ~= TearVariant.RAZOR and
					    tear.Variant ~= TearVariant.EGG and
                        tear.Variant ~= TearVariant.NEEDLE and
                        tear.Variant ~= TearVariant.BLACK_TOOTH and

                        tear.Variant ~= TearVariant.BOOGER and
                        tear.Variant ~= TearVariant.FIST and
                        tear.Variant ~= TearVariant.SPORE
                 then
                    if tear.Variant ~= TearVariant.DIAMOND then
                        tear:ChangeVariant(TearVariant.DIAMOND)
                    end
                    if
                        tear.TearFlags ~= TearFlags.TEAR_HOMING and
                            tear.TearFlags ~= TearFlags.TEAR_FREEZE and
                            tear.TearFlags ~= TearFlags.TEAR_BURN and
                            tear.TearFlags ~= TearFlags.TEAR_MYSTERIOUS_LIQUID_CREEP and
							tear.TearFlags ~= TearFlags.TEAR_POISON
                     then
                        local color = Color(1, 1, 1, 1, 0, 0, 0)
                        color:SetColorize(0.50, 0, 1, 1)
                        tear:SetColor(color, 0, 0, true, false)
                    end
                end
            end
        end
    end

	if tear.SpawnerEntity:ToPlayer() ~= nil then
        for i = 1, Game():GetNumPlayers() do
            local player = Isaac.GetPlayer(i - 1)
            local player = tear.SpawnerEntity:ToPlayer()
			local dyingalltear = math.random(48)

            if DyingActive then
			if dyingalltear == 45
			or dyingalltear == 43
			or dyingalltear == 44
			or dyingalltear == 40
			or dyingalltear == 38
			or dyingalltear == 37
			or dyingalltear == 9
			or dyingalltear == 4
			or dyingalltear == 46
           then
			return end
                local data = tear:GetData()
                    if tear.Variant ~= TearVariant.DIAMOND then
                        tear:ChangeVariant(dyingalltear)
                    end
            end
        end
    end

end
Auriz:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, Auriz.onTear)

COLLECTIBLE_DARK_PRINCESS_CROWN = Isaac.GetItemIdByName("Dark Princess's Crown")

function RottenCrown(player, flags) 

 for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)

		if player:HasCollectible(COLLECTIBLE_DARK_PRINCESS_CROWN) then

		player:AddCacheFlags(CacheFlag.CACHE_RANGE | CacheFlag.CACHE_FIREDELAY | CacheFlag.CACHE_SHOTSPEED)
	    player:EvaluateItems()
        end

    end
end
Auriz:AddCallback(ModCallbacks.MC_POST_UPDATE, RottenCrown)

 COLLECTIBLE_LITTLE_AURI = Isaac.GetItemIdByName("Little Auri")
 littleauri_familiar = Isaac.GetEntityVariantByName("Little Auri")

local Bigfrickingfriend = Isaac.GetItemIdByName("BFFS!") 

local king_baby = Isaac.GetItemIdByName("King Baby")
local altar = Isaac.GetItemIdByName("Sacrificial Altar")
local red_marked = Isaac.GetItemIdByName("Marked")

DIRECTION_FLOAT_ANIMATION = {
	[Direction.NO_DIRECTION] = "FloatDown", 
	[Direction.LEFT] = "FloatLeft",
	[Direction.UP] = "FloatDown",
	[Direction.RIGHT] = "FloatRight",
	[Direction.DOWN] = "FloatDown"
}

DIRECTION_SHOOT_ANIMATION = {
	[Direction.NO_DIRECTION] = "FloatShootDown",
	[Direction.LEFT] = "FloatShootLeft",
	[Direction.UP] = "FloatShootUp",
	[Direction.RIGHT] = "FloatShootRight",
	[Direction.DOWN] = "FloatShootDown"
}

DIRECTION_VECTOR = {
	[Direction.LEFT] = Vector(-1, 0),
	[Direction.UP] = Vector(0, -1),
	[Direction.RIGHT] = Vector(1, 0),
	[Direction.DOWN] = Vector(0, 1)
}

function Auriz:init(littleauri)
	littleauri.IsFollower = true
	littleauri:AddToFollowers()
	littleauri.FireCooldown = 3
	local sprite = littleauri:GetSprite()
	sprite:Play("IdleDown")
end

function Auriz:update(littleauri)
	local player = littleauri.Player
	local move_dir = player:GetMovementDirection()
	local sprite = littleauri:GetSprite()
	local player_fire_direction = player:GetFireDirection()

	if player_fire_direction == Direction.NO_DIRECTION then
		sprite:Play(DIRECTION_FLOAT_ANIMATION[move_dir], false)
	else
		local animDirection = player_fire_direction
		local tear_vector = DIRECTION_VECTOR[player_fire_direction]:Normalized()

		if (player:HasCollectible(king_baby)) then
			local enemy = Auriz:closestEnemy(littleauri.Position)
			if enemy ~= nil then
				tear_vector = (enemy.Position - littleauri.Position):Normalized()
				animDirection = Auriz:vectorToDirection(tear_vector)
			end
		end

        if player:HasCollectible(CollectibleType.COLLECTIBLE_MARKED) and #Isaac.FindByType(1000, EffectVariant.TARGET, -1, false, true) > 0 then
				tear_vector = (Isaac.FindByType(1000, EffectVariant.TARGET, -1, false, true)[1].Position - littleauri.Position):Normalized()
				sprite:Play("Shoot")
			end

		if littleauri.FireCooldown <= 0 then
			local entity = littleauri:FireProjectile(tear_vector)
			tear = entity:ToTear()
			tear:ChangeVariant(TearVariant.DIAMOND)
			tear.Scale = 0.7
			tear.CollisionDamage = 5.4

			if player:HasTrinket(141) then 
				littleauri.FireCooldown = 9
			else
				littleauri.FireCooldown = 18
			end

			if (player:HasCollectible(Bigfrickingfriend)) then 
				tear.CollisionDamage = tear.CollisionDamage * 2
			end

			if player:HasTrinket(127) then 
			tear.TearFlags = TearFlags.TEAR_HOMING
			tear.Color = Color(0.4, 0.15, 0.38, 1, 0.27843, 0, 0.4549) 
			end

			if math.random(0,9) == 9 then
			tear.Color = Color(1, 0, 1, 1, 0.196, 0, 0)
			tear.TearFlags = TearFlags.TEAR_CHARM
			end

		end

		sprite:Play(DIRECTION_SHOOT_ANIMATION[animDirection], false)
	end

	littleauri.FireCooldown = littleauri.FireCooldown - 1
	littleauri:FollowParent()

end

function Auriz:on_cache(player, cacheFlag)
    if cacheFlag == CacheFlag.CACHE_FAMILIARS then
		local boxUses = player:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_BOX_OF_FRIENDS)
		local numItem = player:GetCollectibleNum(COLLECTIBLE_LITTLE_AURI)
		local numFamiliars = (numItem > 0 and (numItem + boxUses) or 0)

		player:CheckFamiliar(littleauri_familiar, numFamiliars, player:GetCollectibleRNG(COLLECTIBLE_LITTLE_AURI), Isaac.GetItemConfig():GetCollectible(COLLECTIBLE_LITTLE_AURI))
	end
end

function Auriz:on_tear_collision(tear, collider, low)
	if tear.SpawnerVariant == littleauri_familiar and collider:IsVulnerableEnemy() and not EntityRef(collider).IsCharmed then
		local littleauri = tear.SpawnerEntity:ToFamiliar()
		local player = littleauri.Player
	end
end

function Auriz:on_sacrifice(_, __, player)
	if player:HasCollectible(COLLECTIBLE_LITTLE_AURI) then
		player:RemoveCollectible(COLLECTIBLE_LITTLE_AURI)
	end
end

function Auriz:closestEnemy(pos)
	local entities = Isaac.GetRoomEntities()
	local closestEnt = nil
	local closestDist = 2^32

	for i = 1, #entities do
		if entities[i]:IsEnemy() and entities[i]:IsVulnerableEnemy()then
			local dist = (entities[i].Position - pos):LengthSquared()
			if dist < closestDist then
				closestDist = dist
				closestEnt = entities[i]
			end
		end
	end

	return closestEnt
end

function Auriz:vectorToDirection(v)
	local angle = v:GetAngleDegrees()

	if (angle < 45 and angle >= -45) then
		return Direction.RIGHT
	elseif (angle < -45 and angle >= -135) then
		return Direction.UP
	elseif (angle > 45 and angle <= 135) then
		return Direction.DOWN
	end

	return Direction.LEFT
end

Auriz:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Auriz.on_cache)
Auriz:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, Auriz.init, littleauri_familiar)
Auriz:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Auriz.update, littleauri_familiar)

COLLECTIBLE_PRINCESS_BABY = Isaac.GetItemIdByName("Princess Baby")
little_dpcauri_familiar = Isaac.GetEntityVariantByName("Princess Baby")

function Auriz:init(littledpcauri)
	littledpcauri.IsFollower = true
	littledpcauri:AddToFollowers()
	littledpcauri.FireCooldown = 3
	local sprite = littledpcauri:GetSprite()
	sprite:Play("IdleDown")
end

function Auriz:update(littledpcauri)
	local player = littledpcauri.Player
	local move_dir = player:GetMovementDirection()
	local sprite = littledpcauri:GetSprite()
	local player_fire_direction = player:GetFireDirection()

	if player_fire_direction == Direction.NO_DIRECTION then
		sprite:Play(DIRECTION_FLOAT_ANIMATION[move_dir], false)
	else
		local animDirection = player_fire_direction
		local tear_vector = DIRECTION_VECTOR[player_fire_direction]:Normalized()

		if (player:HasCollectible(king_baby)) then
			local enemy = Auriz:closestEnemy(littledpcauri.Position)
			if enemy ~= nil then
				tear_vector = (enemy.Position - littledpcauri.Position):Normalized()
				animDirection = Auriz:vectorToDirection(tear_vector)

			end

		end

        if player:HasCollectible(CollectibleType.COLLECTIBLE_MARKED) and #Isaac.FindByType(1000, EffectVariant.TARGET, -1, false, true) > 0 then
				tear_vector = (Isaac.FindByType(1000, EffectVariant.TARGET, -1, false, true)[1].Position - littledpcauri.Position):Normalized()
				sprite:Play("Shoot")
			end

		if littledpcauri.FireCooldown <= 0 then
			local entity = littledpcauri:FireProjectile(tear_vector)
			tear = entity:ToTear()
			tear:ChangeVariant(TearVariant.DIAMOND)
			tear.Scale = 0.7
			tear.CollisionDamage = 3
			 local color = Color(1, 1, 1, 1, 0, 0, 0)
                        color:SetColorize(1.1, 0, 0, 1)
                        tear:SetColor(color, 0, 0, true, false)

			if player:HasTrinket(141) and not (player:HasCollectible(king_baby)) then 
				littledpcauri.FireCooldown = 7
				elseif (player:HasCollectible(king_baby)) and not player:HasTrinket(141) then
			   littledpcauri.FireCooldown = 9
			   elseif (player:HasCollectible(king_baby)) and player:HasTrinket(141) then
			   littledpcauri.FireCooldown = 5
			else
				littledpcauri.FireCooldown = 12
			end

			if (player:HasCollectible(Bigfrickingfriend)) then 
				tear.CollisionDamage = tear.CollisionDamage * 2
			end

			if player:HasTrinket(127) then 
			tear.TearFlags = TearFlags.TEAR_HOMING
			tear.Color = Color(0.4, 0.15, 0.38, 1, 0.27843, 0, 0.4549) 
			end

			if math.random(0,9) == 9 then
			tear.Color = Color(1, 1, 0.455, 1, 0.169, 0.145, 0)
			tear.TearFlags = TearFlags.TEAR_FEAR
			end

		end

		sprite:Play(DIRECTION_SHOOT_ANIMATION[animDirection], false)
	end

	littledpcauri.FireCooldown = littledpcauri.FireCooldown - 1
	littledpcauri:FollowParent()
end

function Auriz:on_cache(player, cacheFlag)
    if cacheFlag == CacheFlag.CACHE_FAMILIARS then
		local boxUses = player:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_BOX_OF_FRIENDS)
		local numItem = player:GetCollectibleNum(COLLECTIBLE_PRINCESS_BABY)
		local numFamiliars = (numItem > 0 and (numItem + boxUses) or 0)

		player:CheckFamiliar(little_dpcauri_familiar, numFamiliars, player:GetCollectibleRNG(COLLECTIBLE_PRINCESS_BABY), Isaac.GetItemConfig():GetCollectible(COLLECTIBLE_PRINCESS_BABY))
	end
end

function Auriz:on_tear_collision(tear, collider, low)
	if tear.SpawnerVariant == little_dpcauri_familiar and collider:IsVulnerableEnemy() and not EntityRef(collider).IsCharmed then
		local littledpcauri = tear.SpawnerEntity:ToFamiliar()
		local player = littledpcauri.Player
	end
end

function Auriz:on_sacrifice(_, __, player)
	if player:HasCollectible(COLLECTIBLE_PRINCESS_BABY) then
		player:RemoveCollectible(COLLECTIBLE_PRINCESS_BABY)
	end
end

Auriz:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Auriz.on_cache) 
Auriz:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, Auriz.init, little_dpcauri_familiar)
Auriz:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Auriz.update, little_dpcauri_familiar)

COLLECTIBLE_LITTLE_PYROMANCER = Isaac.GetItemIdByName("Little Pyromancer")
little_pyromancer_familiar = Isaac.GetEntityVariantByName("Little Pyromancer")

function Auriz:init(littlepyromancer)
	littlepyromancer.IsFollower = true
	littlepyromancer:AddToFollowers()
	littlepyromancer.FireCooldown = 3
	local sprite = littlepyromancer:GetSprite()
	sprite:Play("IdleDown")
end

function Auriz:update(littlepyromancer)
	local player = littlepyromancer.Player
	local move_dir = player:GetMovementDirection()
	local sprite = littlepyromancer:GetSprite()
	local player_fire_direction = player:GetFireDirection()

	if player_fire_direction == Direction.NO_DIRECTION then
		sprite:Play(DIRECTION_FLOAT_ANIMATION[move_dir], false)
	else
		local animDirection = player_fire_direction
		local tear_vector = DIRECTION_VECTOR[player_fire_direction]:Normalized()

		if (player:HasCollectible(king_baby)) then
			local enemy = Auriz:closestEnemy(littlepyromancer.Position)
			if enemy ~= nil then
				tear_vector = (enemy.Position - littlepyromancer.Position):Normalized()
				animDirection = Auriz:vectorToDirection(tear_vector)

			end

		end

        if player:HasCollectible(CollectibleType.COLLECTIBLE_MARKED) and #Isaac.FindByType(1000, EffectVariant.TARGET, -1, false, true) > 0 then
				tear_vector = (Isaac.FindByType(1000, EffectVariant.TARGET, -1, false, true)[1].Position - littlepyromancer.Position):Normalized()
				sprite:Play("Shoot")
			end

		if littlepyromancer.FireCooldown <= 0 then
			local entity = littlepyromancer:FireProjectile(tear_vector)
			tear = entity:ToTear()
			tear:ChangeVariant(TearVariant.FIRE)
			tear.TearFlags = TearFlags.TEAR_BURN 

			tear.Scale = 0 
			tear.CollisionDamage = 3.5
			sfx:Play(SoundEffect.SOUND_BEAST_FIRE_RING,0.4,0,false,1.2)  
			 local color = Color(1, 1, 1, 1, 0, 0, 0)
                        color:SetColorize(5, 0.8, 0.1, 1)
                        tear:SetColor(color, 0, 0, true, false)

			if player:HasTrinket(141) then 
				littlepyromancer.FireCooldown = 12
			else
				littlepyromancer.FireCooldown = 24
			end

			if (player:HasCollectible(Bigfrickingfriend)) then 
				tear.CollisionDamage = tear.CollisionDamage * 2
				tear.TearFlags = TearFlags.TEAR_HYDROBOUNCE | TearFlags.TEAR_BURN
			end

			if player:HasTrinket(127) and not (player:HasCollectible(Bigfrickingfriend)) then 
			tear.TearFlags = TearFlags.TEAR_HOMING | TearFlags.TEAR_BURN
			tear.Color = Color(0.4, 0.15, 0.38, 1, 0.27843, 0, 0.4549) 
			elseif player:HasTrinket(127) and (player:HasCollectible(Bigfrickingfriend)) then 
			tear.TearFlags = TearFlags.TEAR_HOMING | TearFlags.TEAR_HYDROBOUNCE | TearFlags.TEAR_BURN
			tear.Color = Color(3, 0.15, 0.38, 1, 0.27843, 0, 0.4549)
			end

		end

		sprite:Play(DIRECTION_SHOOT_ANIMATION[animDirection], false)
	end

	littlepyromancer.FireCooldown = littlepyromancer.FireCooldown - 1
	littlepyromancer:FollowParent()
end

function Auriz:on_cache(player, cacheFlag)
    if cacheFlag == CacheFlag.CACHE_FAMILIARS then
		local boxUses = player:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_BOX_OF_FRIENDS)
		local numItem = player:GetCollectibleNum(COLLECTIBLE_LITTLE_PYROMANCER)
		local numFamiliars = (numItem > 0 and (numItem + boxUses) or 0)

		player:CheckFamiliar(little_pyromancer_familiar, numFamiliars, player:GetCollectibleRNG(COLLECTIBLE_LITTLE_PYROMANCER), Isaac.GetItemConfig():GetCollectible(COLLECTIBLE_LITTLE_PYROMANCER))
	end
end

function Auriz:on_tear_collision(tear, collider, low)
	if tear.SpawnerVariant == little_pyromancer_familiar and collider:IsVulnerableEnemy() and not EntityRef(collider).IsCharmed then
		local littlepyromancer = tear.SpawnerEntity:ToFamiliar()
		local player = littlepyromancer.Player
	end
end

function Auriz:on_sacrifice(_, __, player)
	if player:HasCollectible(COLLECTIBLE_LITTLE_PYROMANCER) then
		player:RemoveCollectible(COLLECTIBLE_LITTLE_PYROMANCER)
	end
end

Auriz:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Auriz.on_cache) 
Auriz:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, Auriz.init, little_pyromancer_familiar)
Auriz:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Auriz.update, little_pyromancer_familiar)

COLLECTIBLE_LIL_NAAMAH = Isaac.GetItemIdByName("Lil Naamah")
little_naamah_familiar = Isaac.GetEntityVariantByName("Lil Naamah")

function Auriz:init(littlenaamah)
	littlenaamah.IsFollower = true
	littlenaamah:AddToFollowers()
	littlenaamah.FireCooldown = 100
	local sprite = littlenaamah:GetSprite()
	sprite:Play("IdleDown")
end

function Auriz:update(littlenaamah)
	local player = littlenaamah.Player
	local move_dir = player:GetMovementDirection()
	local sprite = littlenaamah:GetSprite()
	local player_fire_direction = player:GetFireDirection()

	if player_fire_direction == Direction.NO_DIRECTION then
		sprite:Play(DIRECTION_FLOAT_ANIMATION[move_dir], false)
	else
		local animDirection = player_fire_direction
		local tear_vector = DIRECTION_VECTOR[player_fire_direction]:Normalized()

		if (player:HasCollectible(king_baby)) then
			local enemy = Auriz:closestEnemy(littlenaamah.Position)
			if enemy ~= nil then
				tear_vector = (enemy.Position - littlenaamah.Position):Normalized()
				animDirection = Auriz:vectorToDirection(tear_vector)

			end

		end

        if player:HasCollectible(CollectibleType.COLLECTIBLE_MARKED) and #Isaac.FindByType(1000, EffectVariant.TARGET, -1, false, true) > 0 then
				tear_vector = (Isaac.FindByType(1000, EffectVariant.TARGET, -1, false, true)[1].Position - littlenaamah.Position):Normalized()
				sprite:Play("Shoot")
			end

		if littlenaamah.FireCooldown <= 0 then
			local entity = littlenaamah:FireProjectile(tear_vector)
			tear = entity:ToTear()

			tear.TearFlags = tear.TearFlags | TearFlags.TEAR_WIGGLE | TearFlags.TEAR_CHARM | TearFlags.TEAR_SPECTRAL | TearFlags.TEAR_HOMING
			tear.Scale = 0.7
			tear.CollisionDamage = 3.5
			 local color = Color(1, 1, 1, 1, 0, 0, 0)
                        color:SetColorize(1.2, 0.2, 0.9, 1)
                        tear:SetColor(color, 0, 0, true, false)
	                    sfx:Play(SoundEffect.SOUND_KISS_LIPS1,0.5,0,false,1.2)
				if player:HasTrinket(141) then 
				littlenaamah.FireCooldown = 45
			else
				littlenaamah.FireCooldown = 90
			end

			if (player:HasCollectible(Bigfrickingfriend)) then 
				tear.CollisionDamage = tear.CollisionDamage * 2
			end

			if (player:HasCollectible(Bigfrickingfriend)) then 
				tear.CollisionDamage = tear.CollisionDamage * 2
			end

			if player:HasTrinket(127) then 
			tear.TearFlags = tear.TearFlags | TearFlags.TEAR_WIGGLE | TearFlags.TEAR_CHARM | TearFlags.TEAR_SPECTRAL | TearFlags.TEAR_HOMING
			tear.Color = Color(0.4, 0.15, 0.38, 1, 0.27843, 0, 0.4549) 
			end

		end

		sprite:Play(DIRECTION_SHOOT_ANIMATION[animDirection], false)
	end

	littlenaamah.FireCooldown = littlenaamah.FireCooldown - 1
	littlenaamah:FollowParent()
end

function Auriz:on_cache(player, cacheFlag)
    if cacheFlag == CacheFlag.CACHE_FAMILIARS then
		local boxUses = player:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_BOX_OF_FRIENDS)
		local numItem = player:GetCollectibleNum(COLLECTIBLE_LIL_NAAMAH)
		local numFamiliars = (numItem > 0 and (numItem + boxUses) or 0)

		player:CheckFamiliar(little_naamah_familiar, numFamiliars, player:GetCollectibleRNG(COLLECTIBLE_LIL_NAAMAH), Isaac.GetItemConfig():GetCollectible(COLLECTIBLE_LIL_NAAMAH))
	end
end

function Auriz:on_tear_collision(tear, collider, low)
	if tear.SpawnerVariant == little_naamah_familiar and collider:IsVulnerableEnemy() and not EntityRef(collider).IsCharmed then
		local littlenaamah = tear.SpawnerEntity:ToFamiliar()
		local player = littlenaamah.Player
	end
end

function Auriz:on_sacrifice(_, __, player)
	if player:HasCollectible(COLLECTIBLE_LIL_NAAMAH) then
		player:RemoveCollectible(COLLECTIBLE_LIL_NAAMAH)
	end
end

Auriz:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Auriz.on_cache) 
Auriz:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, Auriz.init, little_naamah_familiar)
Auriz:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Auriz.update, little_naamah_familiar)

local Achievements = {}

PlayerType.PLAYER_AURI = Isaac.GetPlayerTypeByName("Auri")
PlayerType.PLAYER_TAINTED_AURII = Isaac.GetPlayerTypeByName("Aurii", true)

PlayerType.PLAYER_DARK_AURI = Isaac.GetPlayerTypeByName("Dark Auri")
PlayerType.PLAYER_TAINTED_DARK_AURI = Isaac.GetPlayerTypeByName("Dark Corrupted Auri", true)

PlayerType.PLAYER_MAGE_AURI = Isaac.GetPlayerTypeByName("Mage Auri")
PlayerType.PLAYER_NECROMANTRESS_AURI = Isaac.GetPlayerTypeByName("Dark Mage Auri", true)

PlayerType.PLAYER_DEPRESSED_AURI = Isaac.GetPlayerTypeByName("Depressed Auri")
PlayerType.PLAYER_CURSED_AURI = Isaac.GetPlayerTypeByName("Cursed Auri", true)

PlayerType.PLAYER_ROTTEN_AURI = Isaac.GetPlayerTypeByName("Famish")
PlayerType.PLAYER_ZOMBIE_AURI = Isaac.GetPlayerTypeByName("Zombie Auri", true)

PlayerType.PLAYER_DARK_PRINCESS_AURI = Isaac.GetPlayerTypeByName("Milcah")
PlayerType.PLAYER_QUEEN_AURI = Isaac.GetPlayerTypeByName("Queen Auri", true)

PlayerType.PLAYER_DEMONIC_AURI = Isaac.GetPlayerTypeByName("Naamah")
PlayerType.PLAYER_WIP_AURI = Isaac.GetPlayerTypeByName("Demonic Auri WIP", true)

PlayerType.PLAYER_ASCEND_AURI = Isaac.GetPlayerTypeByName("Azrael")
PlayerType.PLAYER_FALLEN_AURI = Isaac.GetPlayerTypeByName("Fallen Auri", true)

PlayerType.PLAYER_DELILAH = Isaac.GetPlayerTypeByName("Delilah")
PlayerType.PLAYER_TAINTED_DELILAH = Isaac.GetPlayerTypeByName("Delilah", true)

PlayerType.PLAYER_GLITCH_AURI = Isaac.GetPlayerTypeByName("Glitch Auri")
PlayerType.PLAYER_ERROR_AURI = Isaac.GetPlayerTypeByName("Error Auri", true)

PlayerType.PLAYER_AURIMP = Isaac.GetPlayerTypeByName("Aurimp")
PlayerType.PLAYER_TAINTED_AURIMP = Isaac.GetPlayerTypeByName("Aurimp", true)

PlayerType.PLAYER_DEBORAH = Isaac.GetPlayerTypeByName("Deborah")
PlayerType.PLAYER_TAINTED_DEBORAH = Isaac.GetPlayerTypeByName("Deborah", true)

PlayerType.PLAYER_SOULBOUND_AURI = Isaac.GetPlayerTypeByName("Soulbound Auri")
PlayerType.PLAYER_SPIRIT_SHACKLES_AURI = Isaac.GetPlayerTypeByName("Soul Shackles Auri", true)

PlayerType.PLAYER_WIPP_AURI = Isaac.GetPlayerTypeByName("Genocide Auri?")
PlayerType.PLAYER_WIPPP_AURI = Isaac.GetPlayerTypeByName("Genocide Auri", true)

AuriAchievements = {

  Isaac = false,
  nulltest = false,

  BlueBaby = false,
  Unlock_Calmmind = false,

  Satan = false,
  Unlock_LittleAuri = false,

  Lamb = false,
  UnlockDarkAuri = false,

  Hush = false,
  Unlock_Auricrown = false,

  MegaSatan = false,
  null = false,

  Delirium = false,
  Unlock_Princessbox = false,

  Mother = false, 
  Unlock_Aurihairclip = false,

  Beast = false,
  Unlock_Thememories = false,

  BossRush = false,
  Unlock_GoldenCrown = false,

  Greed = false,
  Unlock_Morphpenny = false,

  FullCompletion = false,
  notuseyet = false,

  Auriiunlockhome = false,
  AuriHoldLock_Unlock = false,

  Isaac_ii = false,
  null = false,

  BlueBaby_ii = false,
  null = false,

  Satan_ii = false,
  null = false,

  Lamb_ii = false,
  null = false,

  Hush_ii = false,
  null = false,

  MegaSatan_ii = false,
  null = false,

  Delirium_ii = false,
  Unlockglitchcrown = false,

  Mother_ii = false,
  null = false,

  Beast_ii = false,
  null = false,

  BossRush_ii = false,
  null = false,

  Greed_ii = false,
  null = false,

  FullCompletion_ii = false,
  null = false,

  Isaac_AuriDs = false,
  UnlockNullandholdDGHinMainslot = false,

  BlueBaby_AuriDs = false,
  null = false,

  Satan_AuriDs = false,
  null = false,

  Lamb_AuriDs = false,
  null = false,

  Hush_AuriDs = false,
  null = false,

  MegaSatan_AuriDs = false,
  null = false,

  Delirium_AuriDs = false,
  UnlockPocketDarkHour = false, 
  null = false,

  Mother_AuriDs = false,
  null = false,

  Beast_AuriDs = false,
  null = false,

  BossRush_AuriDs = false,
  null = false,

  Greed_AuriDs = false,
  null = false,

  FullCompletion_AuriDs = false,

  Isaac_TaintedAuriDs = false,
  null = false,

  BlueBaby_TaintedAuriDs = false,
  null = false,

  Satan_TaintedAuriDs = false,
  null = false,

  Lamb_TaintedAuriDs = false,
  null = false,

  Hush_TaintedAuriDs = false,
  null = false,

  MegaSatan_TaintedAuriDs = false,
  null = false,

  Delirium_TaintedAuriDs = false,
  null = false,

  Mother_TaintedAuriDs = false,
  null = false,

  Beast_TaintedAuriDs = false,
  null = false,

  BossRush_TaintedAuriDs = false,
  null = false,

  Greed_TaintedAuriDs = false,
  null = false,

  FullCompletion_TaintedAuriDs = false,
  null = false,

  Isaac_MageAuri = false,
  Unlock_Enchantbook = false,

  BlueBaby_MageAuri = false,
  null = false,

  Satan_MageAuri = false,
  null = false,

  Lamb_MageAuri = false,
  null = false,

  Hush_MageAuri = false,
  Unlock_Magehat = false,

  MegaSatan_MageAuri = false,
  Satanmarks_mage = false,

  Delirium_MageAuri = false,
  null = false,

  Mother_MageAuri = false, 
  Unlock_Firebook = false,

  Beast_MageAuri = false,
  Unlock_Firebookpage = false,

  BossRush_MageAuri = false,
  Unlock_Magerobe = false,

  Greed_MageAuri = false,
  Unlock_Enchantpenny = false,

  FullCompletion_MageAuri = false,
  null = false,

  Unlock_HoldCauldron = false,

  Isaac_NecroAuri = false,
  null = false,

  BlueBaby_NecroAuri = false,
  null = false,

  Satan_NecroAuri = false,
  null = false,

  Lamb_NecroAuri = false,
  null = false,

  Hush_NecroAuri = false,
  null = false,

  MegaSatan_NecroAuri = false,
  null = false,

  Delirium_NecroAuri = false,
  null = false,

  Mother_NecroAuri = false,
  null = false,

  Beast_NecroAuri = false,
  null = false,

  Greed_NecroAuri = false,
  null = false,

  BossRush_NecroAuri = false,
  null = false,

  FullCompletion_NecroAuri = false,
  null = false,

  Isaac_DepressedAuri = false,
  null = false,

  BlueBaby_DepressedAuri = false,
  null = false,

  Satan_DepressedAuri = false,
  null = false,

  Lamb_DepressedAuri = false,
  null = false,

  Hush_DepressedAuri = false,
  null = false,

  MegaSatan_DepressedAuri = false,
  null = false,

  Delirium_DepressedAuri = false,
  null = false,

  Mother_DepressedAuri = false,
  null = false,

  Beast_DepressedAuri = false,
  null = false,

  Greed_DepressedAuri = false,
  null = false,

  BossRush_DepressedAuri = false,
  null = false,

  FullCompletion_DepressedAuri = false,
  null = false,

  Isaac_CursedAuri = false,
  null = false,

  BlueBaby_CursedAuri = false,
  null = false,

  Satan_CursedAuri = false,
  null = false,

  Lamb_CursedAuri = false,
  null = false,

  Hush_CursedAuri = false,
  null = false,

  MegaSatan_CursedAuri = false,
  null = false,

  Delirium_CursedAuri = false,
  null = false,

  Mother_CursedAuri = false,
  null = false,

  Beast_CursedAuri = false,
  null = false,

  Greed_CursedAuri = false,
  null = false,

  BossRush_CursedAuri = false,
  null = false,

  FullCompletion_CursedAuri = false,
  null = false,

  Isaac_DpcAuri = false,
  Unlock_BloodyHourGlass = false,

  BlueBaby_DpcAuri = false,
  null = false,

  Satan_DpcAuri = false,
  null = false,

  Lamb_DpcAuri = false,
  null = false,

  Hush_DpcAuri = false,
  null = false,

  MegaSatan_DpcAuri = false,
  null = false,

  Delirium_DpcAuri = false,
  null = false,

  Mother_DpcAuri = false,
  null = false,

  Beast_DpcAuri = false,
  null = false,

  Greed_DpcAuri = false,
  null = false,

  BossRush_DpcAuri = false,
  null = false,

  FullCompletion_DpcAuri = false,
  null = false,

  Isaac_QueenAuri = false,
  null = false,

  BlueBaby_QueenAuri = false,
  null = false,

  Satan_QueenAuri = false,
  null = false,

  Lamb_QueenAuri = false,
  null = false,

  Hush_QueenAuri = false,
  null = false,

  MegaSatan_QueenAuri = false,
  null = false,

  Delirium_QueenAuri = false,
  null = false,

  Mother_QueenAuri = false,
  null = false,

  Beast_QueenAuri = false,
  null = false,

  Greed_QueenAuri = false,
  null = false,

  BossRush_QueenAuri = false,
  null = false,

  FullCompletion_QueenAuri = false,
  null = false,

  Isaac_Azrael = false,
  null = false,

  BlueBaby_Azrael = false,
  null = false,

  Satan_Azrael = false,
  null = false,

  Lamb_Azrael = false,
  null = false,

  Hush_Azrael = false,
  null = false,

  MegaSatan_Azrael = false,
  null = false,

  Delirium_Azrael = false,
  null = false,

  Mother_Azrael = false,
  null = false,

  Beast_Azrael = false,
  null = false,

  Greed_Azrael = false,
  null = false,

  BossRush_Azrael = false,
  null = false,

  FullCompletion_Azrael = false,
  null = false,

  Isaac_FallenAzrael = false,
  null = false,

  BlueBaby_FallenAzrael = false,
  null = false,

  Satan_FallenAzrael = false,
  null = false,

  Lamb_FallenAzrael = false,
  null = false,

  Hush_FallenAzrael = false,
  null = false,

  MegaSatan_FallenAzrael = false,
  null = false,

  Delirium_FallenAzrael = false,
  null = false,

  Mother_FallenAzrael = false,
  null = false,

  Beast_FallenAzrael = false,
  null = false,

  Greed_FallenAzrael = false,
  null = false,

  BossRush_FallenAzrael = false,
  null = false,

  FullCompletion_FallenAzrael = false,
  null = false,

  Isaac_Naamah = false,
  null = false,

  BlueBaby_Naamah = false,
  null = false,

  Satan_Naamah = false,
  null = false,

  Lamb_Naamah = false,
  null = false,

  Hush_Naamah = false,
  null = false,

  MegaSatan_Naamah = false,
  null = false,

  Delirium_Naamah = false,
  null = false,

  Mother_Naamah = false,
  null = false,

  Beast_Naamah = false,
  null = false,

  Greed_Naamah = false,
  null = false,

  BossRush_Naamah = false,
  null = false,

  FullCompletion_Naamah = false,
  null = false,

  Isaac_SuccuNaamah = false,
  null = false,

  BlueBaby_SuccuNaamah = false,
  null = false,

  Satan_SuccuNaamah = false,
  null = false,

  Lamb_SuccuNaamah = false,
  null = false,

  Hush_SuccuNaamah = false,
  null = false,

  MegaSatan_SuccuNaamah = false,
  null = false,

  Delirium_SuccuNaamah = false,
  null = false,

  Mother_SuccuNaamah = false,
  null = false,

  Beast_SuccuNaamah = false,
  null = false,

  Greed_SuccuNaamah = false,
  null = false,

  BossRush_SuccuNaamah = false,
  null = false,

  FullCompletion_SuccuNaamah = false,
  null = false,

  Isaac_Glitch = false,
  null = false,

  BlueBaby_Glitch = false,
  null = false,

  Satan_Glitch = false,
  null = false,

  Lamb_Glitch = false,
  null = false,

  Hush_Glitch = false,
  null = false,

  MegaSatan_Glitch = false,
  null = false,

  Delirium_Glitch = false,
  null = false,

  Mother_Glitch = false,
  null = false,

  Beast_Glitch = false,
  null = false,

  Greed_Glitch = false,
  null = false,

  BossRush_Glitch = false,
  null = false,

  FullCompletion_Glitch = false,
  null = false,

  Isaac_ErrorAuri = false,
  null = false,

  BlueBaby_ErrorAuri = false,
  null = false,

  Satan_ErrorAuri = false,
  null = false,

  Lamb_ErrorAuri = false,
  null = false,

  Hush_ErrorAuri = false,
  null = false,

  MegaSatan_ErrorAuri = false,
  null = false,

  Delirium_ErrorAuri = false,
  null = false,

  Mother_ErrorAuri = false,
  null = false,

  Beast_ErrorAuri = false,
  null = false,

  Greed_ErrorAuri = false,
  null = false,

  BossRush_ErrorAuri = false,
  null = false,

  FullCompletion_ErrorAuri = false,
  null = false,

  Isaac_ = false,
  null = false,

  BlueBaby_ = false,
  null = false,

  Satan_ = false,
  null = false,

  Lamb_ = false,
  null = false,

  Hush_ = false,
  null = false,

  MegaSatan_ = false,
  null = false,

  Delirium_ = false,
  null = false,

  Mother_ = false,
  null = false,

  Beast_ = false,
  null = false,

  Greed_ = false,
  null = false,

  BossRush_ = false,
  null = false,

  FullCompletion_ = false,
  null = false,

  Isaac_ = false,
  null = false,

  BlueBaby_ = false,
  null = false,

  Satan_ = false,
  null = false,

  Lamb_ = false,
  null = false,

  Hush_ = false,
  null = false,

  MegaSatan_ = false,
  null = false,

  Delirium_ = false,
  null = false,

  Mother_ = false,
  null = false,

  Beast_ = false,
  null = false,

  Greed_ = false,
  null = false,

  BossRush_ = false,
  null = false,

  FullCompletion_ = false,
  null = false,

  Isaac_Rotten = false,
  null = false,

  BlueBaby_Rotten = false,
  null = false,

  Satan_Rotten = false,
  null = false,

  Lamb_Rotten = false,
  null = false,

  Hush_Rotten = false,
  null = false,

  MegaSatan_Rotten = false,
  null = false,

  Delirium_Rotten = false,
  null = false,

  Mother_Rotten = false,
  null = false,

  Beast_Rotten = false,
  null = false,

  Greed_Rotten = false,
  null = false,

  BossRush_Rotten = false,
  null = false,

  FullCompletion_Rotten = false,
  null = false,

  Isaac_Zombie = false,
  null = false,

  BlueBaby_Zombie = false,
  null = false,

  Satan_Zombie = false,
  null = false,

  Lamb_Zombie = false,
  null = false,

  Hush_Zombie = false,
  null = false,

  MegaSatan_Zombie = false,
  null = false,

  Delirium_Zombie = false,
  null = false,

  Mother_Zombie = false,
  null = false,

  Beast_Zombie = false,
  null = false,

  Greed_Zombie = false,
  null = false,

  BossRush_Zombie = false,
  null = false,

  FullCompletion_Zombie = false,
  null = false,

  UnlockAuri = false,
  UnlockDarkAuri = false,
  UnlockMilcah = false,
  UnlockMage = false,
  UnlockHangGirl = false,
  UnlockNaamah = false,
  UnlockAzrael = false,

  JustHasCorruptedHeart = false, 
  JustHasCorruptedHeart_Beth = false,
  JustHasCorruptedHeart_Keeper = false,
  JustHasCorruptedHeart_Forgotten = false,
  JustHasCorruptedHeart_Jacob = false,
  JustHasCorruptedHeart_Esau = false,

  HasTrashbag1 = false,
  HasTrashbag2 = false,

  EnchantedBookLuck = 0,
  CalmmindDmg = 0,
  witchsoupluck = 30,
  HorCoffeeboost = 2,
  Candy = 0,
  Enchantpennystack = 0,
  H_Coffee = 0,
  V_accine = 0,
  Y_meat = 0,
  Gp_ears = 0
}

local function UseGwhg()
	PlayerUseGwHourglass = true

	 local table = json.decode(Auriz:LoadData())
            LoadData(table.AuriAchievements)
				PlayerUseGwHourglass = false   
end

Auriz:AddCallback(ModCallbacks.MC_USE_ITEM, UseGwhg, CollectibleType.COLLECTIBLE_GLOWING_HOUR_GLASS)

function Glowinghourfix()  
    if PlayerUseGwHourglass then
        if Auriz:HasData() then
            local table = json.decode(Auriz:LoadData())
            LoadData(table.AuriAchievements)
				PlayerUseGwHourglass = false   
        end
    end
end

local MAX_ACHIEVEMENT_FRAMES = 50

local achievementFrames = 0
local achievementSprite = Sprite()
achievementSprite:Load("gfx/ui/achievement/customAchievements.anm2", true)

function LoadData(table)
  if table == nil then

  else
    AuriAchievements = table
  end
end

function SaveData()
  return AuriAchievements
end

function DisplayAchievement()
  achievementSprite:LoadGraphics()
  achievementSprite:Play("Appear", true)
  achievementFrames = MAX_ACHIEVEMENT_FRAMES
end

function ShowUnlock()
  if AuriAchievements.Isaac and not AuriAchievements.Unlockhourglass then
    AuriAchievements.Unlockhourglass = true 
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_999_aurihourglass.png")
    DisplayAchievement()

	elseif AuriAchievements.BlueBaby and not AuriAchievements.Unlock_Calmmind then
    AuriAchievements.Unlock_Calmmind = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_auri_calmheart.png")
    DisplayAchievement()

	elseif AuriAchievements.Satan and not AuriAchievements.Unlock_LittleAuri then
    AuriAchievements.Unlock_LittleAuri = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_little_auri.png")
    DisplayAchievement()

	elseif AuriAchievements.Lamb and not AuriAchievements.UnlockDarkAuri then
    AuriAchievements.UnlockDarkAuri = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Hush and not AuriAchievements.Unlock_Auricrown then
    AuriAchievements.Unlock_Auricrown = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_auri's_crown.png")
    DisplayAchievement()

	elseif AuriAchievements.MegaSatan and not AuriAchievements.UnlockDarkAuri then
    AuriAchievements.UnlockDarkAuri = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")

	elseif AuriAchievements.Delirium and not AuriAchievements.Unlock_Princessbox then
    AuriAchievements.Unlock_Princessbox = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_princessbox.png")
    DisplayAchievement()

	elseif AuriAchievements.Mother and not AuriAchievements.Unlock_Aurihairclip then
    AuriAchievements.Unlock_Aurihairclip = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_auri's_hairclip.png")
    DisplayAchievement()

	elseif AuriAchievements.Beast and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")

	elseif AuriAchievements.BossRush and not AuriAchievements.Unlock_GoldenCrown then 
	AuriAchievements.Unlock_GoldenCrown = true
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_auri_goldencrown.png")
    DisplayAchievement()

	elseif AuriAchievements.Isaac_ii and not AuriAchievements.Unlocktest then
    AuriAchievements.Unlocktest = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")

	elseif AuriAchievements.BlueBaby_ii and not AuriAchievements.Unlocktesttwo then
    AuriAchievements.Unlocktesttwo = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")

	elseif AuriAchievements.Hush_ii and not AuriAchievements.Unlocksomthing then
    AuriAchievements.Unlocksomthing = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")

	elseif AuriAchievements.Lamb_ii and not AuriAchievements.Unlocksomthing then
    AuriAchievements.Unlocksomthing = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")

	elseif AuriAchievements.Satan_ii and not AuriAchievements.Unlocksomthing then
    AuriAchievements.Unlocksomthing = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")

	elseif AuriAchievements.MegaSatan_ii and not AuriAchievements.Unlocksomthing then
    AuriAchievements.Unlocksomthing = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")

	elseif AuriAchievements.Delirium_ii and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")

	elseif AuriAchievements.Mother_ii and not AuriAchievements.Unlocksomthing then
    AuriAchievements.Unlocksomthing = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")

	elseif AuriAchievements.Beast_ii and not AuriAchievements.Unlocksomthing then
    AuriAchievements.Unlocksomthing = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")

	elseif AuriAchievements.BossRush_ii and not AuriAchievements.Unlocksomthing3 then 
	AuriAchievements.Unlocksomthing3 = true
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")

	elseif AuriAchievements.Greed_ii and not AuriAchievements.Unlocksomthing2 then
	AuriAchievements.Unlocksomthing2 = true
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")

	elseif AuriAchievements.Isaac_AuriDs and not AuriAchievements.UnlockNullandholdDGHinMainslot then
    AuriAchievements.UnlockNullandholdDGHinMainslot = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_set_dark_hourglass_isaac.png")
    DisplayAchievement()

	elseif AuriAchievements.BlueBaby_AuriDs and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Satan_AuriDs and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Lamb_AuriDs and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")

	elseif AuriAchievements.Hush_AuriDs and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.MegaSatan_AuriDs and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")

	elseif AuriAchievements.Delirium_AuriDs and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Mother_AuriDs and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Beast_AuriDs and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")

	elseif AuriAchievements.BossRush_AuriDs and not AuriAchievements.null then
	AuriAchievements.null = true
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Greed_AuriDs and not AuriAchievements.null then
	AuriAchievements.null = true
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Isaac_TaintedAuriDs and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.BlueBaby_TaintedAuriDs and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Satan_TaintedAuriDs and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Lamb_TaintedAuriDs and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Hush_TaintedAuriDs and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.MegaSatan_TaintedAuriDs and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Delirium_TaintedAuriDs and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Mother_TaintedAuriDs and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Beast_TaintedAuriDs and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.BossRush_TaintedAuriDs and not AuriAchievements.null then
	AuriAchievements.null = true
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Greed_TaintedAuriDs and not AuriAchievements.null then
	AuriAchievements.null = true
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Isaac_MageAuri and not AuriAchievements.Unlock_Enchantbook then
    AuriAchievements.Unlock_Enchantbook = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_bookofenchant.png")
    DisplayAchievement()

	elseif AuriAchievements.BlueBaby_MageAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Satan_MageAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Lamb_MageAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Hush_MageAuri and not AuriAchievements.Unlock_Magehat then
    AuriAchievements.Unlock_Magehat = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_magehat.png")
    DisplayAchievement()

	elseif AuriAchievements.MegaSatan_MageAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Delirium_MageAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Mother_MageAuri and not AuriAchievements.Unlock_Firebook then
    AuriAchievements.Unlock_Firebook = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_firemagicbook.png")
    DisplayAchievement()

	elseif AuriAchievements.Beast_MageAuri and not AuriAchievements.Unlock_Firebookpage then
    AuriAchievements.Unlock_Firebookpage = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_firebookpage.png")
    DisplayAchievement()

	elseif AuriAchievements.BossRush_MageAuri and not AuriAchievements.Unlock_Magerobe then
	AuriAchievements.Unlock_Magerobe = true
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_magerobe.png")
    DisplayAchievement()

	elseif AuriAchievements.Greed_MageAuri and not AuriAchievements.Unlock_Enchantpenny then
	AuriAchievements.Unlock_Enchantpenny = true
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_enchantpenny.png")
    DisplayAchievement()

	elseif AuriAchievements.Isaac_NecroAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.BlueBaby_NecroAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Satan_NecroAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Lamb_NecroAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Hush_NecroAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.MegaSatan_NecroAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Delirium_NecroAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Mother_NecroAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Beast_NecroAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.BossRush_NecroAuri and not AuriAchievements.null then
	AuriAchievements.null = true
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Greed_NecroAuri and not AuriAchievements.null then
	AuriAchievements.null = true
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Isaac_DepressedAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.BlueBaby_DepressedAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Satan_DepressedAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Lamb_DepressedAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Hush_DepressedAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.MegaSatan_DepressedAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Delirium_DepressedAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Mother_DepressedAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Beast_DepressedAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Greed_DepressedAuri and not AuriAchievements.null then
	AuriAchievements.null = true
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.BossRush_DepressedAuri and not AuriAchievements.null then
	AuriAchievements.null = true
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Isaac_CursedAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.BlueBaby_CursedAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Satan_CursedAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Lamb_CursedAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Hush_CursedAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.MegaSatan_CursedAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Delirium_CursedAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Mother_CursedAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Beast_CursedAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Greed_CursedAuri and not AuriAchievements.null then
	AuriAchievements.null = true
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.BossRush_CursedAuri and not AuriAchievements.null then
	AuriAchievements.null = true
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Isaac_DpcAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.BlueBaby_DpcAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Satan_DpcAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Lamb_DpcAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Hush_DpcAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.MegaSatan_DpcAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Delirium_DpcAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Mother_DpcAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Beast_DpcAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Greed_DpcAuri and not AuriAchievements.null then
	AuriAchievements.null = true
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.BossRush_DpcAuri and not AuriAchievements.null then
	AuriAchievements.null = true
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Isaac_QueenAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.BlueBaby_QueenAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Satan_QueenAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Lamb_QueenAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Hush_QueenAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.MegaSatan_QueenAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Delirium_QueenAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Mother_QueenAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Beast_QueenAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Greed_QueenAuri and not AuriAchievements.null then
	AuriAchievements.null = true
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.BossRush_QueenAuri and not AuriAchievements.null then
	AuriAchievements.null = true
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Isaac_Azrael and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.BlueBaby_Azrael and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Satan_Azrael and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Lamb_Azrael and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Hush_Azrael and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.MegaSatan_Azrael and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Delirium_Azrael and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Mother_Azrael and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Beast_Azrael and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Greed_Azrael and not AuriAchievements.null then
	AuriAchievements.null = true
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.BossRush_Azrael and not AuriAchievements.null then
	AuriAchievements.null = true
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Isaac_FallenAzrael and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.BlueBaby_FallenAzrael and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Satan_FallenAzrael and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Lamb_FallenAzrael and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Hush_FallenAzrael and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.MegaSatan_FallenAzrael and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Delirium_FallenAzrael and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Mother_FallenAzrael and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Beast_FallenAzrael and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Greed_FallenAzrael and not AuriAchievements.null then
	AuriAchievements.null = true
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.BossRush_FallenAzrael and not AuriAchievements.null then
	AuriAchievements.null = true
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Isaac_Naamah and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.BlueBaby_Naamah and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Satan_Naamah and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Lamb_Naamah and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Hush_Naamah and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.MegaSatan_Naamah and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Delirium_Naamah and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Mother_Naamah and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Beast_Naamah and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Greed_Naamah and not AuriAchievements.null then
	AuriAchievements.null = true
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.BossRush_Naamah and not AuriAchievements.null then
	AuriAchievements.null = true
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Isaac_Glitch and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.BlueBaby_Glitch and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Satan_Glitch and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Lamb_Glitch and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Hush_Glitch and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.MegaSatan_Glitch and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Delirium_Glitch and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Mother_Glitch and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Beast_Glitch and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Greed_Glitch and not AuriAchievements.null then
	AuriAchievements.null = true
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.BossRush_Glitch and not AuriAchievements.null then
	AuriAchievements.null = true
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Isaac_ErrorAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.BlueBaby_ErrorAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Satan_ErrorAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Lamb_ErrorAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Hush_ErrorAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.MegaSatan_ErrorAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Delirium_ErrorAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Mother_ErrorAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Beast_ErrorAuri and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Greed_ErrorAuri and not AuriAchievements.null then
	AuriAchievements.null = true
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.BossRush_ErrorAuri and not AuriAchievements.null then
	AuriAchievements.null = true
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Isaac_Rotten and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.BlueBaby_Rotten and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Satan_Rotten and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Lamb_Rotten and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Hush_Rotten and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.MegaSatan_Rotten and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Delirium_Rotten and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Mother_Rotten and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Beast_Rotten and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Greed_Rotten and not AuriAchievements.null then
	AuriAchievements.null = true
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.BossRush_Rotten and not AuriAchievements.null then
	AuriAchievements.null = true
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Isaac_Zombie and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.BlueBaby_Zombie and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Satan_Zombie and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Lamb_Zombie and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Hush_Zombie and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.MegaSatan_Zombie and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Delirium_Zombie and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Mother_Zombie and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Beast_Zombie and not AuriAchievements.null then
    AuriAchievements.null = true
    achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.Greed_Zombie and not AuriAchievements.null then
	AuriAchievements.null = true
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

	elseif AuriAchievements.BossRush_Zombie and not AuriAchievements.null then
	AuriAchievements.null = true
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
    DisplayAchievement()

  end
end

function IsaacAchievement(npc)
    local player = Isaac.GetPlayer(0)
    local stage = Game():GetLevel():GetStage()
	if game:GetVictoryLap() > 0 then return end

    if player:GetPlayerType() == PlayerType.PLAYER_AURI then

        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE5 and not AuriAchievements.Isaac and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.Isaac = true

            ShowUnlock()
			Auriz:AuriSaveData() 
        end

        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE6 and not AuriAchievements.BlueBaby and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.BlueBaby = true
            ShowUnlock()Auriz:AuriSaveData()
        end
    end

    if player:GetPlayerType() == PlayerType.PLAYER_TAINTED_AURII then
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE5 and not AuriAchievements.Isaac_ii and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.Isaac_ii = true
            ShowUnlock()Auriz:AuriSaveData()
        end
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE6 and not AuriAchievements.BlueBaby_ii and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.BlueBaby_ii = true
            ShowUnlock()Auriz:AuriSaveData()
        end
    end

    if player:GetPlayerType() == PlayerType.PLAYER_DARK_AURI then
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE5 and not AuriAchievements.Isaac_AuriDs and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.Isaac_AuriDs = true
            ShowUnlock()Auriz:AuriSaveData()
        end
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE6 and not AuriAchievements.BlueBaby_AuriDs and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.BlueBaby_AuriDs = true
            ShowUnlock()Auriz:AuriSaveData()
        end
    end

    if player:GetPlayerType() == PlayerType.PLAYER_TAINTED_DARK_AURI then
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE5 and not AuriAchievements.Isaac_TaintedAuriDs and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.Isaac_TaintedAuriDs = true
            ShowUnlock()Auriz:AuriSaveData()
        end
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE6 and not AuriAchievements.BlueBaby_TaintedAuriDs and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.BlueBaby_TaintedAuriDs = true
            ShowUnlock()Auriz:AuriSaveData()
        end
    end

    if player:GetPlayerType() == PlayerType.PLAYER_MAGE_AURI then
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE5 and not AuriAchievements.Isaac_MageAuri and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.Isaac_MageAuri = true
            ShowUnlock()Auriz:AuriSaveData()
        end
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE6 and not AuriAchievements.BlueBaby_MageAuri and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.BlueBaby_MageAuri = true
            ShowUnlock()Auriz:AuriSaveData()
        end
    end

    if player:GetPlayerType() == PlayerType.PLAYER_NECROMANTRESS_AURI then
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE5 and not AuriAchievements.Isaac_NecroAuri and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.Isaac_NecroAuri = true
            ShowUnlock()Auriz:AuriSaveData()
        end
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE6 and not AuriAchievements.BlueBaby_NecroAuri and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.BlueBaby_NecroAuri = true
            ShowUnlock()Auriz:AuriSaveData()
        end
    end

    if player:GetPlayerType() == PlayerType.PLAYER_DEPRESSED_AURI then
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE5 and not AuriAchievements.Isaac_DepressedAuri and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.Isaac_DepressedAuri = true
            ShowUnlock()Auriz:AuriSaveData()
        end
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE6 and not AuriAchievements.BlueBaby_DepressedAuri and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.BlueBaby_DepressedAuri = true
            ShowUnlock()Auriz:AuriSaveData()
        end
    end

    if player:GetPlayerType() == PlayerType.PLAYER_CURSED_AURI then
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE5 and not AuriAchievements.Isaac_CursedAuri and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.Isaac_CursedAuri = true
            ShowUnlock()Auriz:AuriSaveData()
        end
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE6 and not AuriAchievements.BlueBaby_CursedAuri and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.BlueBaby_CursedAuri = true
            ShowUnlock()Auriz:AuriSaveData()
        end
    end

    if player:GetPlayerType() == PlayerType.PLAYER_DARK_PRINCESS_AURI then
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE5 and not AuriAchievements.Isaac_DpcAuri and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.Isaac_DpcAuri = true
            ShowUnlock()Auriz:AuriSaveData()
        end

        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE6 and not AuriAchievements.BlueBaby_DpcAuri and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.BlueBaby_DpcAuri = true
            ShowUnlock()Auriz:AuriSaveData()
        end
    end
    if player:GetPlayerType() == PlayerType.PLAYER_QUEEN_AURI then
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE5 and not AuriAchievements.Isaac_QueenAuri and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.Isaac_QueenAuri = true
            ShowUnlock()Auriz:AuriSaveData()
        end
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE6 and not AuriAchievements.BlueBaby_QueenAuri and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.BlueBaby_QueenAuri = true
            ShowUnlock()Auriz:AuriSaveData()
        end
    end

    if player:GetPlayerType() == PlayerType.PLAYER_ASCEND_AURI then
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE5 and not AuriAchievements.Isaac_Azrael and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.Isaac_Azrael = true
            ShowUnlock()Auriz:AuriSaveData()
        end
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE6 and not AuriAchievements.BlueBaby_Azrael and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.BlueBaby_Azrael = true
            ShowUnlock()Auriz:AuriSaveData()
        end
    end

    if player:GetPlayerType() == PlayerType.PLAYER_FALLEN_AURI then
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE5 and not AuriAchievements.Isaac_FallenAzrael and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.Isaac_FallenAzrael = true
            ShowUnlock()Auriz:AuriSaveData()
        end
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE6 and not AuriAchievements.BlueBaby_FallenAzrael and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.BlueBaby_FallenAzrael = true
            ShowUnlock()Auriz:AuriSaveData()
        end
    end

    if player:GetPlayerType() == PlayerType.PLAYER_DEMONIC_AURI then
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE5 and not AuriAchievements.Isaac_Naamah and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.Isaac_Naamah = true
            ShowUnlock()Auriz:AuriSaveData()
        end
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE6 and not AuriAchievements.BlueBaby_Naamah and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.BlueBaby_Naamah = true
            ShowUnlock()Auriz:AuriSaveData()
        end
    end

    if player:GetPlayerType() == PlayerType.PLAYER_WIP_AURI then
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE5 and not AuriAchievements.Isaac_SuccuNaamah and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.Isaac_SuccuNaamah = true
            ShowUnlock()Auriz:AuriSaveData()
        end
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE6 and not AuriAchievements.BlueBaby_SuccuNaamah and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.BlueBaby_SuccuNaamah = true
            ShowUnlock()Auriz:AuriSaveData()
        end
    end

    if player:GetPlayerType() == PlayerType.PLAYER_GLITCH_AURI then
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE5 and not AuriAchievements.Isaac_Glitch and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.Isaac_Glitch = true
            ShowUnlock()Auriz:AuriSaveData()
        end
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE6 and not AuriAchievements.BlueBaby_Glitch and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.BlueBaby_Glitch = true
            ShowUnlock()Auriz:AuriSaveData()
        end
    end

    if player:GetPlayerType() == PlayerType.PLAYER_ERROR_AURI then
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE5 and not AuriAchievements.Isaac_ErrorAuri and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.Isaac_ErrorAuri = true
            ShowUnlock()Auriz:AuriSaveData()
        end
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE6 and not AuriAchievements.BlueBaby_ErrorAuri and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.BlueBaby_ErrorAuri = true
            ShowUnlock()Auriz:AuriSaveData()
        end
    end

    if player:GetPlayerType() == PlayerType.PLAYER_SOULBOUND_AURI then
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE5 and not AuriAchievements.Isaac_ii and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.Isaac_ii = true
            ShowUnlock()Auriz:AuriSaveData()
        end
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE6 and not AuriAchievements.BlueBaby_ii and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.BlueBaby_ii = true
            ShowUnlock()Auriz:AuriSaveData()
        end
    end

    if player:GetPlayerType() == PlayerType.PLAYER_SPIRIT_SHACKLES_AURI then
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE5 and not AuriAchievements.Isaac_ii and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.Isaac_ii = true
            ShowUnlock()Auriz:AuriSaveData()
        end
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE6 and not AuriAchievements.BlueBaby_ii and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.BlueBaby_ii = true
            ShowUnlock()Auriz:AuriSaveData()
        end
    end

    if player:GetPlayerType() == PlayerType.PLAYER_ROTTEN_AURI then
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE5 and not AuriAchievements.Isaac_Rotten and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.Isaac_Rotten = true
            ShowUnlock()Auriz:AuriSaveData()
        end
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE6 and not AuriAchievements.BlueBaby_Rotten and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.BlueBaby_Rotten = true
            ShowUnlock()Auriz:AuriSaveData()
        end
    end

    if player:GetPlayerType() == PlayerType.PLAYER_ZOMBIE_AURI then
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE5 and not AuriAchievements.Isaac_Zombie and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.Isaac_Zombie = true
            ShowUnlock()Auriz:AuriSaveData()
        end
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE6 and not AuriAchievements.BlueBaby_Zombie and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.BlueBaby_Zombie = true
            ShowUnlock()Auriz:AuriSaveData()
        end
    end

    if player:GetPlayerType() == PlayerType.PLAYER_WIPP_AURI then
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE5 and not AuriAchievements.Isaac_ii and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.Isaac_ii = true
            ShowUnlock()Auriz:AuriSaveData()
        end
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE6 and not AuriAchievements.BlueBaby_ii and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.BlueBaby_ii = true
            ShowUnlock()Auriz:AuriSaveData()
        end
    end

    if player:GetPlayerType() == PlayerType.PLAYER_WIPPP_AURI then
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE5 and not AuriAchievements.Isaac_ii and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.Isaac_ii = true
            ShowUnlock()
        end
        if
            EntityType.ENTITY_ISAAC and stage == LevelStage.STAGE6 and not AuriAchievements.BlueBaby_ii and
                game.Difficulty == Difficulty.DIFFICULTY_HARD
         then
            AuriAchievements.BlueBaby_ii = true
            ShowUnlock()Auriz:AuriSaveData()
        end
    end
end

function SatanAchievement(npc)
  local stage = Game():GetLevel():GetStage()
  local player = Isaac.GetPlayer(0)

 if game:GetVictoryLap() > 0 then return end
 if game.Difficulty == Difficulty.DIFFICULTY_HARD 

 then 
    if player:GetPlayerType() == PlayerType.PLAYER_AURI and EntityType.ENTITY_SATAN 
      and stage == LevelStage.STAGE5 and not AuriAchievements.Satan then
      AuriAchievements.Satan = true
      ShowUnlock()Auriz:AuriSaveData()
    end
    if player:GetPlayerType() == PlayerType.PLAYER_TAINTED_AURII and EntityType.ENTITY_SATAN 
       and stage == LevelStage.STAGE5 and not AuriAchievements.Satan_ii then
       AuriAchievements.Satan_ii = true
       ShowUnlock()Auriz:AuriSaveData()
    end

    if player:GetPlayerType() == PlayerType.PLAYER_DARK_AURI and EntityType.ENTITY_SATAN 
      and stage == LevelStage.STAGE5 and not AuriAchievements.Satan_AuriDs then
      AuriAchievements.Satan_AuriDs = true
      ShowUnlock()Auriz:AuriSaveData()
    end
    if player:GetPlayerType() == PlayerType.PLAYER_TAINTED_DARK_AURI and EntityType.ENTITY_SATAN 
       and stage == LevelStage.STAGE5 and not AuriAchievements.Satan_TaintedAuriDs then
       AuriAchievements.Satan_TaintedAuriDs = true
       ShowUnlock()Auriz:AuriSaveData()
    end

    if player:GetPlayerType() == PlayerType.PLAYER_MAGE_AURI and EntityType.ENTITY_SATAN 
       and stage == LevelStage.STAGE5 and not AuriAchievements.Satan_MageAuri then
       AuriAchievements.Satan_MageAuri = true
       ShowUnlock()Auriz:AuriSaveData()
    end
	if player:GetPlayerType() == PlayerType.PLAYER_NECROMANTRESS_AURI and EntityType.ENTITY_SATAN 
       and stage == LevelStage.STAGE5 and not AuriAchievements.Satan_NecroAuri then
       AuriAchievements.Satan_NecroAuri = true
       ShowUnlock()Auriz:AuriSaveData()
	end

    if player:GetPlayerType() == PlayerType.PLAYER_DEPRESSED_AURI and EntityType.ENTITY_SATAN 
       and stage == LevelStage.STAGE5 and not AuriAchievements.Satan_DepressedAuri then
       AuriAchievements.Satan_DepressedAuri = true
       ShowUnlock()Auriz:AuriSaveData()
    end
	if player:GetPlayerType() == PlayerType.PLAYER_CURSED_AURI and EntityType.ENTITY_SATAN 
       and stage == LevelStage.STAGE5 and not AuriAchievements.Satan_CursedAuri then
       AuriAchievements.Satan_CursedAuri = true
       ShowUnlock()Auriz:AuriSaveData()
	end

    if player:GetPlayerType() == PlayerType.PLAYER_DARK_PRINCESS_AURI and EntityType.ENTITY_SATAN 
       and stage == LevelStage.STAGE5 and not AuriAchievements.Satan_DpcAuri then
       AuriAchievements.Satan_DpcAuri = true
       ShowUnlock()Auriz:AuriSaveData()
    end
	if player:GetPlayerType() == PlayerType.PLAYER_QUEEN_AURI and EntityType.ENTITY_SATAN 
       and stage == LevelStage.STAGE5 and not AuriAchievements.Satan_QueenAuri then
       AuriAchievements.Satan_QueenAuri = true
       ShowUnlock()Auriz:AuriSaveData()
	end

    if player:GetPlayerType() == PlayerType.PLAYER_ASCEND_AURI and EntityType.ENTITY_SATAN 
       and stage == LevelStage.STAGE5 and not AuriAchievements.Satan_Azrael then
       AuriAchievements.Satan_Azrael = true
       ShowUnlock()Auriz:AuriSaveData()
    end
	if player:GetPlayerType() == PlayerType.PLAYER_FALLEN_AURI and EntityType.ENTITY_SATAN 
       and stage == LevelStage.STAGE5 and not AuriAchievements.Satan_FallenAzrael then
       AuriAchievements.Satan_FallenAzrael = true
       ShowUnlock()Auriz:AuriSaveData()
	end

    if player:GetPlayerType() == PlayerType.PLAYER_DEMONIC_AURI and EntityType.ENTITY_SATAN 
       and stage == LevelStage.STAGE5 and not AuriAchievements.Satan_Naamah then
       AuriAchievements.Satan_Naamah = true
       ShowUnlock()Auriz:AuriSaveData()
    end
	if player:GetPlayerType() == PlayerType.PLAYER_WIP_AURI and EntityType.ENTITY_SATAN 
       and stage == LevelStage.STAGE5 and not AuriAchievements.Satan_SuccuNaamah then
       AuriAchievements.Satan_SuccuNaamah = true
       ShowUnlock()Auriz:AuriSaveData()
	end

    if player:GetPlayerType() == PlayerType.PLAYER_GLITCH_AURI and EntityType.ENTITY_SATAN 
       and stage == LevelStage.STAGE5 and not AuriAchievements.Satan_Glitch then
       AuriAchievements.Satan_Glitch = true
       ShowUnlock()Auriz:AuriSaveData()
    end
	if player:GetPlayerType() == PlayerType.PLAYER_ERROR_AURI and EntityType.ENTITY_SATAN 
       and stage == LevelStage.STAGE5 and not AuriAchievements.Satan_ErrorAuri then
       AuriAchievements.Satan_ErrorAuri = true
       ShowUnlock()Auriz:AuriSaveData()
	end

    if player:GetPlayerType() == PlayerType.PLAYER_SOULBOUND_AURI and EntityType.ENTITY_SATAN 
       and stage == LevelStage.STAGE5 and not AuriAchievements.Satan_ then
       AuriAchievements.Satan_ = true
       ShowUnlock()Auriz:AuriSaveData()
    end
	if player:GetPlayerType() == PlayerType.PLAYER_SPIRIT_SHACKLES_AURI and EntityType.ENTITY_SATAN 
       and stage == LevelStage.STAGE5 and not AuriAchievements.Satan_ then
       AuriAchievements.Satan_ = true
       ShowUnlock()Auriz:AuriSaveData()
	end

    if player:GetPlayerType() == PlayerType.PLAYER_ROTTEN_AURI and EntityType.ENTITY_SATAN 
       and stage == LevelStage.STAGE5 and not AuriAchievements.Satan_Rotten then
       AuriAchievements.Satan_Rotten = true
       ShowUnlock()Auriz:AuriSaveData()
    end
	if player:GetPlayerType() == PlayerType.PLAYER_ZOMBIE_AURI and EntityType.ENTITY_SATAN 
       and stage == LevelStage.STAGE5 and not AuriAchievements.Satan_Zombie then
       AuriAchievements.Satan_Zombie = true
       ShowUnlock()Auriz:AuriSaveData()
	end

    if player:GetPlayerType() == PlayerType.PLAYER_WIPP_AURI and EntityType.ENTITY_SATAN 
       and stage == LevelStage.STAGE5 and not AuriAchievements.Satan_ then
       AuriAchievements.Satan_ = true
       ShowUnlock()Auriz:AuriSaveData()
    end
	if player:GetPlayerType() == PlayerType.PLAYER_WIPPP_AURI and EntityType.ENTITY_SATAN 
       and stage == LevelStage.STAGE5 and not AuriAchievements.Satan_ then
       AuriAchievements.Satan_ = true
       ShowUnlock()Auriz:AuriSaveData()
	end

  end
end

function LambAchievement(npc) 
  local stage = Game():GetLevel():GetStage()
  local player = Isaac.GetPlayer(0)
 if game:GetVictoryLap() > 0 then return end
 if game.Difficulty == Difficulty.DIFFICULTY_HARD then
  if EntityType.ENTITY_THE_LAMB and player:GetPlayerType() == PlayerType.PLAYER_AURI and stage == LevelStage.STAGE6 and not AuriAchievements.Lamb then
    AuriAchievements.Lamb = true
    ShowUnlock()Auriz:AuriSaveData()
  end
  if EntityType.ENTITY_THE_LAMB and player:GetPlayerType() == PlayerType.PLAYER_TAINTED_AURII and stage == LevelStage.STAGE6 and not AuriAchievements.Lamb_ii then
    AuriAchievements.Lamb_ii = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  if EntityType.ENTITY_THE_LAMB and player:GetPlayerType() == PlayerType.PLAYER_DARK_AURI and stage == LevelStage.STAGE6 and not AuriAchievements.Lamb_AuriDs then
    AuriAchievements.Lamb_AuriDs = true
    ShowUnlock()Auriz:AuriSaveData()
  end
  if EntityType.ENTITY_THE_LAMB and player:GetPlayerType() == PlayerType.PLAYER_TAINTED_DARK_AURI and stage == LevelStage.STAGE6 and not AuriAchievements.Lamb_TaintedAuriDs then
    AuriAchievements.Lamb_TaintedAuriDs = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  if EntityType.ENTITY_THE_LAMB and player:GetPlayerType() == PlayerType.PLAYER_MAGE_AURI and stage == LevelStage.STAGE6 and not AuriAchievements.Lamb_MageAuri then
    AuriAchievements.Lamb_MageAuri = true
    ShowUnlock()Auriz:AuriSaveData()
  end
  if EntityType.ENTITY_THE_LAMB and player:GetPlayerType() == PlayerType.PLAYER_NECROMANTRESS_AURI and stage == LevelStage.STAGE6 and not AuriAchievements.Lamb_NecroAuri then
    AuriAchievements.Lamb_NecroAuri = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  if EntityType.ENTITY_THE_LAMB and player:GetPlayerType() == PlayerType.PLAYER_DEPRESSED_AURI and stage == LevelStage.STAGE6 and not AuriAchievements.Lamb_DepressedAuri then
    AuriAchievements.Lamb_DepressedAuri = true
    ShowUnlock()Auriz:AuriSaveData()
  end
  if EntityType.ENTITY_THE_LAMB and player:GetPlayerType() == PlayerType.PLAYER_CURSED_AURI and stage == LevelStage.STAGE6 and not AuriAchievements.Lamb_CursedAuri then
    AuriAchievements.Lamb_CursedAuri = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  if EntityType.ENTITY_THE_LAMB and player:GetPlayerType() == PlayerType.PLAYER_DARK_PRINCESS_AURI and stage == LevelStage.STAGE6 and not AuriAchievements.Lamb_DpcAuri then
    AuriAchievements.Lamb_DpcAuri = true
    ShowUnlock()Auriz:AuriSaveData()
  end
  if EntityType.ENTITY_THE_LAMB and player:GetPlayerType() == PlayerType.PLAYER_QUEEN_AURI and stage == LevelStage.STAGE6 and not AuriAchievements.Lamb_QueenAuri then
    AuriAchievements.Lamb_QueenAuri = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  if EntityType.ENTITY_THE_LAMB and player:GetPlayerType() == PlayerType.PLAYER_ASCEND_AURI and stage == LevelStage.STAGE6 and not AuriAchievements.Lamb_Azrael then
    AuriAchievements.Lamb_Azrael = true
    ShowUnlock()Auriz:AuriSaveData()
  end
  if EntityType.ENTITY_THE_LAMB and player:GetPlayerType() == PlayerType.PLAYER_FALLEN_AURI and stage == LevelStage.STAGE6 and not AuriAchievements.Lamb_FallenAzrael then
    AuriAchievements.Lamb_FallenAzrael = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  if EntityType.ENTITY_THE_LAMB and player:GetPlayerType() == PlayerType.PLAYER_DEMONIC_AURI and stage == LevelStage.STAGE6 and not AuriAchievements.Lamb_Naamah then
    AuriAchievements.Lamb_Naamah = true
    ShowUnlock()Auriz:AuriSaveData()
  end
  if EntityType.ENTITY_THE_LAMB and player:GetPlayerType() == PlayerType.PLAYER_WIP_AURI and stage == LevelStage.STAGE6 and not AuriAchievements.Lamb_SuccuNaamah then
    AuriAchievements.Lamb_SuccuNaamah = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  if EntityType.ENTITY_THE_LAMB and player:GetPlayerType() == PlayerType.PLAYER_GLITCH_AURI and stage == LevelStage.STAGE6 and not AuriAchievements.Lamb_Glitch then
    AuriAchievements.Lamb_Glitch = true
    ShowUnlock()Auriz:AuriSaveData()
  end
  if EntityType.ENTITY_THE_LAMB and player:GetPlayerType() == PlayerType.PLAYER_ERROR_AURI and stage == LevelStage.STAGE6 and not AuriAchievements.Lamb_ErrorAuri then
    AuriAchievements.Lamb_ErrorAuri = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  if EntityType.ENTITY_THE_LAMB and player:GetPlayerType() == PlayerType.PLAYER_SOULBOUND_AURI and stage == LevelStage.STAGE6 and not AuriAchievements.Lamb_ then
    AuriAchievements.Lamb_ = true
    ShowUnlock()Auriz:AuriSaveData()
  end
  if EntityType.ENTITY_THE_LAMB and player:GetPlayerType() == PlayerType.PLAYER_SPIRIT_SHACKLES_AURI and stage == LevelStage.STAGE6 and not AuriAchievements.Lamb_ then
    AuriAchievements.Lamb_ = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  if EntityType.ENTITY_THE_LAMB and player:GetPlayerType() == PlayerType.PLAYER_ROTTEN_AURI and stage == LevelStage.STAGE6 and not AuriAchievements.Lamb_Rotten then
    AuriAchievements.Lamb_Rotten = true
    ShowUnlock()Auriz:AuriSaveData()
  end
  if EntityType.ENTITY_THE_LAMB and player:GetPlayerType() == PlayerType.PLAYER_ZOMBIE_AURI and stage == LevelStage.STAGE6 and not AuriAchievements.Lamb_Zombie then
    AuriAchievements.Lamb_Zombie = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  if EntityType.ENTITY_THE_LAMB and player:GetPlayerType() == PlayerType.PLAYER_WIPP_AURI and stage == LevelStage.STAGE6 and not AuriAchievements.Lamb_ then
    AuriAchievements.Lamb_ = true
    ShowUnlock()Auriz:AuriSaveData()
  end
  if EntityType.ENTITY_THE_LAMB and player:GetPlayerType() == PlayerType.PLAYER_WIPPP_AURI and stage == LevelStage.STAGE6 and not AuriAchievements.Lamb_ then
    AuriAchievements.Lamb_ = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  end
end

function HushAchievement(npc) 
  local player = Isaac.GetPlayer(0)
  if game:GetVictoryLap() > 0 then return end
  if game.Difficulty == Difficulty.DIFFICULTY_HARD then
  if player:GetPlayerType() == PlayerType.PLAYER_AURI and not AuriAchievements.Hush then
    AuriAchievements.Hush = true
    ShowUnlock()Auriz:AuriSaveData()
  end
  if player:GetPlayerType() == PlayerType.PLAYER_TAINTED_AURII and not AuriAchievements.Hush_ii then
    AuriAchievements.Hush_ii = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  if player:GetPlayerType() == PlayerType.PLAYER_DARK_AURI and not AuriAchievements.Hush_AuriDs then
    AuriAchievements.Hush_AuriDs = true
    ShowUnlock()Auriz:AuriSaveData()
  end
  if player:GetPlayerType() == PlayerType.PLAYER_TAINTED_DARK_AURI and not AuriAchievements.Hush_TaintedAuriDs then
    AuriAchievements.Hush_TaintedAuriDs = true
    ShowUnlock()Auriz:AuriSaveData()
  end

   if player:GetPlayerType() == PlayerType.PLAYER_MAGE_AURI and not AuriAchievements.Hush_MageAuri then
    AuriAchievements.Hush_MageAuri = true
    ShowUnlock()Auriz:AuriSaveData()
  end
   if player:GetPlayerType() == PlayerType.PLAYER_NECROMANTRESS_AURI and not AuriAchievements.Hush_NecroAuri then
    AuriAchievements.Hush_NecroAuri = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  if player:GetPlayerType() == PlayerType.PLAYER_DEPRESSED_AURI and not AuriAchievements.Hush_DepressedAuri then
    AuriAchievements.Hush_DepressedAuri = true
    ShowUnlock()Auriz:AuriSaveData()
  end
  if player:GetPlayerType() == PlayerType.PLAYER_CURSED_AURI and not AuriAchievements.Hush_CursedAuri then
    AuriAchievements.Hush_CursedAuri = true
    ShowUnlock()Auriz:AuriSaveData()
  end

   if player:GetPlayerType() == PlayerType.PLAYER_DARK_PRINCESS_AURI and not AuriAchievements.Hush_DpcAuri then
    AuriAchievements.Hush_DpcAuri = true
    ShowUnlock()Auriz:AuriSaveData()
  end
  if player:GetPlayerType() == PlayerType.PLAYER_QUEEN_AURI and not AuriAchievements.Hush_QueenAuri then
    AuriAchievements.Hush_QueenAuri = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  if player:GetPlayerType() == PlayerType.PLAYER_ASCEND_AURI and not AuriAchievements.Hush_Azrael then
    AuriAchievements.Hush_Azrael = true
    ShowUnlock()Auriz:AuriSaveData()
  end
  if player:GetPlayerType() == PlayerType.PLAYER_FALLEN_AURI and not AuriAchievements.Hush_FallenAzrael then
    AuriAchievements.Hush_FallenAzrael = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  if player:GetPlayerType() == PlayerType.PLAYER_DEMONIC_AURI and not AuriAchievements.Hush_Naamah then
    AuriAchievements.Hush_Naamah = true
    ShowUnlock()Auriz:AuriSaveData()
  end
  if player:GetPlayerType() == PlayerType.PLAYER_WIP_AURI and not AuriAchievements.Hush_SuccuNaamah then
    AuriAchievements.Hush_SuccuNaamah = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  if player:GetPlayerType() == PlayerType.PLAYER_GLITCH_AURI and not AuriAchievements.Hush_Glitch then
    AuriAchievements.Hush_Glitch = true
    ShowUnlock()Auriz:AuriSaveData()
  end
  if player:GetPlayerType() == PlayerType.PLAYER_ERROR_AURI and not AuriAchievements.Hush_ErrorAuri then
    AuriAchievements.Hush_ErrorAuri = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  if player:GetPlayerType() == PlayerType.PLAYER_SOULBOUND_AURI and not AuriAchievements.Hush then
    AuriAchievements.Hush = true
    ShowUnlock()Auriz:AuriSaveData()
  end
  if player:GetPlayerType() == PlayerType.PLAYER_SPIRIT_SHACKLES_AURI and not AuriAchievements.Hush_ii then
    AuriAchievements.Hush_ii = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  if player:GetPlayerType() == PlayerType.PLAYER_ROTTEN_AURI and not AuriAchievements.Hush_Rotten then
    AuriAchievements.Hush_Rotten = true
    ShowUnlock()Auriz:AuriSaveData()
  end
  if player:GetPlayerType() == PlayerType.PLAYER_ZOMBIE_AURI and not AuriAchievements.Hush_Zombie then
    AuriAchievements.Hush_Zombie = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  if player:GetPlayerType() == PlayerType.PLAYER_WIPP_AURI and not AuriAchievements.Hush then
    AuriAchievements.Hush = true
    ShowUnlock()Auriz:AuriSaveData()
  end
  if player:GetPlayerType() == PlayerType.PLAYER_WIPPP_AURI and not AuriAchievements.Hush_ii then
    AuriAchievements.Hush_ii = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  end
end

function MegaSatanAchievement(npc)
  local player = Isaac.GetPlayer(0)
  if game:GetVictoryLap() > 0 then return end
  if game.Difficulty == Difficulty.DIFFICULTY_HARD then
  if EntityType.ENTITY_MEGA_SATAN_2 and player:GetPlayerType() == PlayerType.PLAYER_AURI and not AuriAchievements.MegaSatan then
    AuriAchievements.MegaSatan = true
    ShowUnlock()Auriz:AuriSaveData()
  end
  if EntityType.ENTITY_MEGA_SATAN_2 and player:GetPlayerType() == PlayerType.PLAYER_TAINTED_AURII and not AuriAchievements.MegaSatan_ii then
    AuriAchievements.MegaSatan_ii = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  if EntityType.ENTITY_MEGA_SATAN_2 and player:GetPlayerType() == PlayerType.PLAYER_DARK_AURI and not AuriAchievements.MegaSatan_AuriDs then
    AuriAchievements.MegaSatan_AuriDs = true
    ShowUnlock()Auriz:AuriSaveData()
  end
  if EntityType.ENTITY_MEGA_SATAN_2 and player:GetPlayerType() == PlayerType.PLAYER_TAINTED_DARK_AURI and not AuriAchievements.MegaSatan_TaintedAuriDs then
    AuriAchievements.MegaSatan_TaintedAuriDs = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  if EntityType.ENTITY_MEGA_SATAN_2 and player:GetPlayerType() == PlayerType.PLAYER_MAGE_AURI and not AuriAchievements.MegaSatan_MageAuri then
    AuriAchievements.MegaSatan_MageAuri = true
    ShowUnlock()Auriz:AuriSaveData()
  end
  if EntityType.ENTITY_MEGA_SATAN_2 and player:GetPlayerType() == PlayerType.PLAYER_NECROMANTRESS_AURI and not AuriAchievements.MegaSatan_NecroAuri then
    AuriAchievements.MegaSatan_NecroAuri = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  if EntityType.ENTITY_MEGA_SATAN_2 and player:GetPlayerType() == PlayerType.PLAYER_DEPRESSED_AURI and not AuriAchievements.MegaSatan_DepressedAuri then
    AuriAchievements.MegaSatan_DepressedAuri = true
    ShowUnlock()Auriz:AuriSaveData()
  end
  if EntityType.ENTITY_MEGA_SATAN_2 and player:GetPlayerType() == PlayerType.PLAYER_CURSED_AURI and not AuriAchievements.MegaSatan_CursedAuri then
    AuriAchievements.MegaSatan_CursedAuri = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  if EntityType.ENTITY_MEGA_SATAN_2 and player:GetPlayerType() == PlayerType.PLAYER_DARK_PRINCESS_AURI and not AuriAchievements.MegaSatan_DpcAuri then
    AuriAchievements.MegaSatan_DpcAuri = true
    ShowUnlock()Auriz:AuriSaveData()
  end
  if EntityType.ENTITY_MEGA_SATAN_2 and player:GetPlayerType() == PlayerType.PLAYER_QUEEN_AURI and not AuriAchievements.MegaSatan_QueenAuri then
    AuriAchievements.MegaSatan_QueenAuri = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  if EntityType.ENTITY_MEGA_SATAN_2 and player:GetPlayerType() == PlayerType.PLAYER_ASCEND_AURI and not AuriAchievements.MegaSatan_Azrael then
    AuriAchievements.MegaSatan_Azrael = true
    ShowUnlock()Auriz:AuriSaveData()
  end
  if EntityType.ENTITY_MEGA_SATAN_2 and player:GetPlayerType() == PlayerType.PLAYER_FALLEN_AURI and not AuriAchievements.MegaSatan_FallenAzrael then
    AuriAchievements.MegaSatan_FallenAzrael = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  if EntityType.ENTITY_MEGA_SATAN_2 and player:GetPlayerType() == PlayerType.PLAYER_DEMONIC_AURI and not AuriAchievements.MegaSatan_Naamah then
    AuriAchievements.MegaSatan_Naamah = true
    ShowUnlock()Auriz:AuriSaveData()
  end
  if EntityType.ENTITY_MEGA_SATAN_2 and player:GetPlayerType() == PlayerType.PLAYER_WIP_AURI and not AuriAchievements.MegaSatan_SuccuNaamah then
    AuriAchievements.MegaSatan_SuccuNaamah = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  if EntityType.ENTITY_MEGA_SATAN_2 and player:GetPlayerType() == PlayerType.PLAYER_GLITCH_AURI and not AuriAchievements.MegaSatan_Glitch then
    AuriAchievements.MegaSatan_Glitch = true
    ShowUnlock()Auriz:AuriSaveData()
  end
  if EntityType.ENTITY_MEGA_SATAN_2 and player:GetPlayerType() == PlayerType.PLAYER_ERROR_AURI and not AuriAchievements.MegaSatan_ErrorAuri then
    AuriAchievements.MegaSatan_ErrorAuri = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  if EntityType.ENTITY_MEGA_SATAN_2 and player:GetPlayerType() == PlayerType.PLAYER_SOULBOUND_AURI and not AuriAchievements.MegaSatan then
    AuriAchievements.MegaSatan = true
    ShowUnlock()Auriz:AuriSaveData()
  end
  if EntityType.ENTITY_MEGA_SATAN_2 and player:GetPlayerType() == PlayerType.PLAYER_SPIRIT_SHACKLES_AURI and not AuriAchievements.MegaSatan_ii then
    AuriAchievements.MegaSatan_ii = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  if EntityType.ENTITY_MEGA_SATAN_2 and player:GetPlayerType() == PlayerType.PLAYER_ROTTEN_AURI and not AuriAchievements.MegaSatan_Rotten then
    AuriAchievements.MegaSatan_Rotten = true
    ShowUnlock()Auriz:AuriSaveData()
  end
  if EntityType.ENTITY_MEGA_SATAN_2 and player:GetPlayerType() == PlayerType.PLAYER_ZOMBIE_AURI and not AuriAchievements.MegaSatan_Zombie then
    AuriAchievements.MegaSatan_Zombie = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  if EntityType.ENTITY_MEGA_SATAN_2 and player:GetPlayerType() == PlayerType.PLAYER_WIPP_AURI and not AuriAchievements.MegaSatan then
    AuriAchievements.MegaSatan = true
    ShowUnlock()Auriz:AuriSaveData()
  end
  if EntityType.ENTITY_MEGA_SATAN_2 and player:GetPlayerType() == PlayerType.PLAYER_WIPPP_AURI and not AuriAchievements.MegaSatan_ii then
    AuriAchievements.MegaSatan_ii = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  end
end

function DeliriumAchievement(npc)
  local player = Isaac.GetPlayer(0)
  if game:GetVictoryLap() > 0 then return end
  if game.Difficulty == Difficulty.DIFFICULTY_HARD then
  if EntityType.ENTITY_DELIRIUM and player:GetPlayerType() == PlayerType.PLAYER_AURI and not AuriAchievements.Delirium  then
    AuriAchievements.Delirium = true
    ShowUnlock()Auriz:AuriSaveData()
  end  
  if EntityType.ENTITY_DELIRIUM and player:GetPlayerType() == PlayerType.PLAYER_TAINTED_AURII and not AuriAchievements.Delirium_ii then
    AuriAchievements.Delirium_ii = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  if EntityType.ENTITY_DELIRIUM and player:GetPlayerType() == PlayerType.PLAYER_DARK_AURI and not AuriAchievements.Delirium_AuriDs  then
    AuriAchievements.Delirium_AuriDs = true
    ShowUnlock()Auriz:AuriSaveData()
  end
  if EntityType.ENTITY_DELIRIUM and player:GetPlayerType() == PlayerType.PLAYER_TAINTED_DARK_AURI and not AuriAchievements.Delirium_TaintedAuriDs then
    AuriAchievements.Delirium_TaintedAuriDs = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  if EntityType.ENTITY_DELIRIUM and player:GetPlayerType() == PlayerType.PLAYER_MAGE_AURI and not AuriAchievements.Delirium_MageAuri then
    AuriAchievements.Delirium_MageAuri = true
    ShowUnlock()Auriz:AuriSaveData()
  end  
  if EntityType.ENTITY_DELIRIUM and player:GetPlayerType() == PlayerType.PLAYER_NECROMANTRESS_AURI and not AuriAchievements.Delirium_NecroAuri then
    AuriAchievements.Delirium_NecroAuri = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  if EntityType.ENTITY_DELIRIUM and player:GetPlayerType() == PlayerType.PLAYER_DEPRESSED_AURI and not AuriAchievements.Delirium_DepressedAuri then
    AuriAchievements.Delirium_DepressedAuri = true
    ShowUnlock()Auriz:AuriSaveData()
  end  
  if EntityType.ENTITY_DELIRIUM and player:GetPlayerType() == PlayerType.PLAYER_CURSED_AURI and not AuriAchievements.Delirium_CursedAuri then
    AuriAchievements.Delirium_CursedAuri = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  if EntityType.ENTITY_DELIRIUM and player:GetPlayerType() == PlayerType.PLAYER_DARK_PRINCESS_AURI and not AuriAchievements.Delirium_DpcAuri  then
    AuriAchievements.Delirium_DpcAuri = true
    ShowUnlock()Auriz:AuriSaveData()
  end  
  if EntityType.ENTITY_DELIRIUM and player:GetPlayerType() == PlayerType.PLAYER_QUEEN_AURI and not AuriAchievements.Delirium_QueenAuri then
    AuriAchievements.Delirium_QueenAuri = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  if EntityType.ENTITY_DELIRIUM and player:GetPlayerType() == PlayerType.PLAYER_ASCEND_AURI and not AuriAchievements.Delirium_Azrael  then
    AuriAchievements.Delirium_Azrael = true
    ShowUnlock()Auriz:AuriSaveData()
  end  
  if EntityType.ENTITY_DELIRIUM and player:GetPlayerType() == PlayerType.PLAYER_FALLEN_AURI and not AuriAchievements.Delirium_FallenAzrael then
    AuriAchievements.Delirium_FallenAzrael = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  if EntityType.ENTITY_DELIRIUM and player:GetPlayerType() == PlayerType.PLAYER_DEMONIC_AURI and not AuriAchievements.Delirium_Naamah  then
    AuriAchievements.Delirium_Naamah = true
    ShowUnlock()Auriz:AuriSaveData()
  end  
  if EntityType.ENTITY_DELIRIUM and player:GetPlayerType() == PlayerType.PLAYER_WIP_AURI and not AuriAchievements.Delirium_SuccuNaamah then
    AuriAchievements.Delirium_SuccuNaamah = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  if EntityType.ENTITY_DELIRIUM and player:GetPlayerType() == PlayerType.PLAYER_GLITCH_AURI and not AuriAchievements.Delirium_Glitch  then
    AuriAchievements.Delirium_Glitch = true
    ShowUnlock()Auriz:AuriSaveData()
  end  
  if EntityType.ENTITY_DELIRIUM and player:GetPlayerType() == PlayerType.PLAYER_ERROR_AURI and not AuriAchievements.Delirium_ErrorAuri then
    AuriAchievements.Delirium_ErrorAuri = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  if EntityType.ENTITY_DELIRIUM and player:GetPlayerType() == PlayerType.PLAYER_SOULBOUND_AURI and not AuriAchievements.Delirium  then
    AuriAchievements.Delirium = true
    ShowUnlock()Auriz:AuriSaveData()
  end  
  if EntityType.ENTITY_DELIRIUM and player:GetPlayerType() == PlayerType.PLAYER_SPIRIT_SHACKLES_AURI and not AuriAchievements.Delirium_ii then
    AuriAchievements.Delirium_ii = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  if EntityType.ENTITY_DELIRIUM and player:GetPlayerType() == PlayerType.PLAYER_ROTTEN_AURI and not AuriAchievements.Delirium_Rotten  then
    AuriAchievements.Delirium_Rotten = true
    ShowUnlock()Auriz:AuriSaveData()
  end  
  if EntityType.ENTITY_DELIRIUM and player:GetPlayerType() == PlayerType.PLAYER_ZOMBIE_AURI and not AuriAchievements.Delirium_Zombie then
    AuriAchievements.Delirium_Zombie = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  if EntityType.ENTITY_DELIRIUM and player:GetPlayerType() == PlayerType.PLAYER_WIPP_AURI and not AuriAchievements.Delirium  then
    AuriAchievements.Delirium = true
    ShowUnlock()Auriz:AuriSaveData()
  end  
  if EntityType.ENTITY_DELIRIUM and player:GetPlayerType() == PlayerType.PLAYER_WIPPP_AURI and not AuriAchievements.Delirium_ii then
    AuriAchievements.Delirium_ii = true
    ShowUnlock()Auriz:AuriSaveData()
  end

  end
end

function Auriz:BeastMarks(npc) 
		local room = game:GetRoom()
	    local player = Isaac.GetPlayer(0)
		if game:GetVictoryLap() > 0 then return end
		if game.Difficulty == Difficulty.DIFFICULTY_HARD then

		if not AuriAchievements.Beast and player:GetPlayerType() == PlayerType.PLAYER_AURI and npc.Variant == 0 then
			AuriAchievements.Beast = true
            ShowUnlock()Auriz:AuriSaveData()
		end
		if not AuriAchievements.AuriHoldLock_Unlock and player:GetCollectibleCount() <= 5 and player:GetPlayerType() == PlayerType.PLAYER_AURI and npc.Variant == 0 then
			AuriAchievements.AuriHoldLock_Unlock = true
            ShowUnlock()Auriz:AuriSaveData()
		end
		if not AuriAchievements.Beast_ii and player:GetPlayerType() == PlayerType.PLAYER_TAINTED_AURII and npc.Variant == 0 then
			AuriAchievements.Beast_ii = true
            ShowUnlock()Auriz:AuriSaveData()
		end

		if not AuriAchievements.Beast_AuriDs and player:GetPlayerType() == PlayerType.PLAYER_DARK_AURI and npc.Variant == 0 then
			AuriAchievements.Beast_AuriDs = true
            ShowUnlock()Auriz:AuriSaveData()
		end
		if not AuriAchievements.Beast_TaintedAuriDs and player:GetPlayerType() == PlayerType.PLAYER_TAINTED_DARK_AURI and npc.Variant == 0 then
			AuriAchievements.Beast_TaintedAuriDs = true
            ShowUnlock()Auriz:AuriSaveData()
		end

		if not AuriAchievements.Beast_MageAuri and player:GetPlayerType() == PlayerType.PLAYER_MAGE_AURI and npc.Variant == 0 then
			AuriAchievements.Beast_MageAuri = true
            ShowUnlock()Auriz:AuriSaveData()
	    end
		if not AuriAchievements.Beast_NecroAuri and player:GetPlayerType() == PlayerType.PLAYER_NECROMANTRESS_AURI and npc.Variant == 0 then
			AuriAchievements.Beast_NecroAuri = true
            ShowUnlock()Auriz:AuriSaveData()
	    end

		if not AuriAchievements.Beast_DepressedAuri and player:GetPlayerType() == PlayerType.PLAYER_DEPRESSED_AURI and npc.Variant == 0 then
			AuriAchievements.Beast_DepressedAuri = true
            ShowUnlock()Auriz:AuriSaveData()
		end
		if not AuriAchievements.Beast_CursedAuri and player:GetPlayerType() == PlayerType.PLAYER_CURSED_AURI and npc.Variant == 0 then
			AuriAchievements.Beast_CursedAuri = true
            ShowUnlock()Auriz:AuriSaveData()
		end

		if not AuriAchievements.Beast_DpcAuri and player:GetPlayerType() == PlayerType.PLAYER_DARK_PRINCESS_AURI and npc.Variant == 0 then
			AuriAchievements.Beast_DpcAuri = true
            ShowUnlock()Auriz:AuriSaveData()
		end
		if not AuriAchievements.Beast_QueenAuri and player:GetPlayerType() == PlayerType.PLAYER_QUEEN_AURI and npc.Variant == 0 then
			AuriAchievements.Beast_QueenAuri = true
            ShowUnlock()Auriz:AuriSaveData()
		end

		if not AuriAchievements.Beast_Azrael and player:GetPlayerType() == PlayerType.PLAYER_ASCEND_AURI and npc.Variant == 0 then
			AuriAchievements.Beast_Azrael = true
            ShowUnlock()Auriz:AuriSaveData()
		end
		if not AuriAchievements.Beast_FallenAzrael and player:GetPlayerType() == PlayerType.PLAYER_FALLEN_AURI and npc.Variant == 0 then
			AuriAchievements.Beast_FallenAzrael = true
            ShowUnlock()Auriz:AuriSaveData()
		end

		if not AuriAchievements.Beast_Naamah and player:GetPlayerType() == PlayerType.PLAYER_DEMONIC_AURI and npc.Variant == 0 then
			AuriAchievements.Beast_Naamah = true
            ShowUnlock()Auriz:AuriSaveData()
		end
		if not AuriAchievements.Beast_SuccuNaamah and player:GetPlayerType() == PlayerType.PLAYER_WIP_AURI and npc.Variant == 0 then
			AuriAchievements.Beast_SuccuNaamah = true
            ShowUnlock()Auriz:AuriSaveData()
		end

		if not AuriAchievements.Beast_Glitch and player:GetPlayerType() == PlayerType.PLAYER_GLITCH_AURI and npc.Variant == 0 then
			AuriAchievements.Beast_Glitch = true
            ShowUnlock()Auriz:AuriSaveData()
		end
		if not AuriAchievements.Beast_ErrorAuri and player:GetPlayerType() == PlayerType.PLAYER_ERROR_AURI and npc.Variant == 0 then
			AuriAchievements.Beast_ErrorAuri = true
            ShowUnlock()Auriz:AuriSaveData()
		end

		if not AuriAchievements.Beast_ and player:GetPlayerType() == PlayerType.PLAYER_SOULBOUND_AURI and npc.Variant == 0 then
			AuriAchievements.Beast_ = true
            ShowUnlock()Auriz:AuriSaveData()
		end
		if not AuriAchievements.Beast_ and player:GetPlayerType() == PlayerType.PLAYER_SPIRIT_SHACKLES_AURI and npc.Variant == 0 then
			AuriAchievements.Beast_ = true
            ShowUnlock()Auriz:AuriSaveData()
		end

		if not AuriAchievements.Beast_Rotten and player:GetPlayerType() == PlayerType.PLAYER_ROTTEN_AURI and npc.Variant == 0 then
			AuriAchievements.Beast_Rotten = true
            ShowUnlock()Auriz:AuriSaveData()
		end
		if not AuriAchievements.Beast_Zombie and player:GetPlayerType() == PlayerType.PLAYER_ZOMBIE_AURI and npc.Variant == 0 then
			AuriAchievements.Beast_Zombie = true
            ShowUnlock()Auriz:AuriSaveData()
		end

			if not AuriAchievements.Beast_ and player:GetPlayerType() == PlayerType.PLAYER_WIPP_AURI and npc.Variant == 0 then
			AuriAchievements.Beast_ = true
            ShowUnlock()Auriz:AuriSaveData()
		end
			if not AuriAchievements.Beast_ and player:GetPlayerType() == PlayerType.PLAYER_WIPPP_AURI and npc.Variant == 0 then
			AuriAchievements.Beast_ = true
            ShowUnlock()Auriz:AuriSaveData()
		end

    end
end

function Auriz:MotherAchievements()
	local room = game:GetRoom()
    local player = Isaac.GetPlayer(0)
	if game:GetVictoryLap() > 0 then return end

	for _, entity in pairs(Isaac.GetRoomEntities()) do
	if game.Difficulty == Difficulty.DIFFICULTY_HARD then

	if game:GetLevel():GetStage() == LevelStage.STAGE4_2 and entity.Type == 5 and entity.Variant == 340 then
		if player:GetPlayerType() == PlayerType.PLAYER_AURI and not AuriAchievements.Mother then
			AuriAchievements.Mother = true
				ShowUnlock()Auriz:AuriSaveData()
			end
		end
	if game:GetLevel():GetStage() == LevelStage.STAGE4_2 and entity.Type == 5 and entity.Variant == 340 then
		if player:GetPlayerType() == PlayerType.PLAYER_TAINTED_AURII and not AuriAchievements.Mother_ii then
			AuriAchievements.Mother_ii = true
				ShowUnlock()Auriz:AuriSaveData()
			end
		end		

   	if game:GetLevel():GetStage() == LevelStage.STAGE4_2 and entity.Type == 5 and entity.Variant == 340 then
		if player:GetPlayerType() == PlayerType.PLAYER_DARK_AURI and not AuriAchievements.Mother_AuriDs then
			AuriAchievements.Mother_AuriDs = true
				ShowUnlock()Auriz:AuriSaveData()
			end
		end
	if game:GetLevel():GetStage() == LevelStage.STAGE4_2 and entity.Type == 5 and entity.Variant == 340 then
		if player:GetPlayerType() == PlayerType.PLAYER_TAINTED_DARK_AURI and not AuriAchievements.Mother_TaintedAuriDs then
			AuriAchievements.Mother_TaintedAuriDs = true
				ShowUnlock()Auriz:AuriSaveData()
			end
		end

   	if game:GetLevel():GetStage() == LevelStage.STAGE4_2 and entity.Type == 5 and entity.Variant == 340 then
		if player:GetPlayerType() == PlayerType.PLAYER_MAGE_AURI and not AuriAchievements.Mother_MageAuri then
			AuriAchievements.Mother_MageAuri = true
				ShowUnlock()Auriz:AuriSaveData()
			end
		end
	if game:GetLevel():GetStage() == LevelStage.STAGE4_2 and entity.Type == 5 and entity.Variant == 340 then
		if player:GetPlayerType() == PlayerType.PLAYER_NECROMANTRESS_AURI and not AuriAchievements.Mother_NecroAuri then
			AuriAchievements.Mother_NecroAuri = true
				ShowUnlock()Auriz:AuriSaveData()
			end
		end

   	if game:GetLevel():GetStage() == LevelStage.STAGE4_2 and entity.Type == 5 and entity.Variant == 340 then
		if player:GetPlayerType() == PlayerType.PLAYER_DEPRESSED_AURI and not AuriAchievements.Mother_DepressedAuri then
			AuriAchievements.Mother_DepressedAuri = true
				ShowUnlock()Auriz:AuriSaveData()
			end
		end
	if game:GetLevel():GetStage() == LevelStage.STAGE4_2 and entity.Type == 5 and entity.Variant == 340 then
		if player:GetPlayerType() == PlayerType.PLAYER_CURSED_AURI and not AuriAchievements.Mother_CursedAuri then
			AuriAchievements.Mother_CursedAuri = true
				ShowUnlock()Auriz:AuriSaveData()
			end
		end

   	if game:GetLevel():GetStage() == LevelStage.STAGE4_2 and entity.Type == 5 and entity.Variant == 340 then
		if player:GetPlayerType() == PlayerType.PLAYER_DARK_PRINCESS_AURI and not AuriAchievements.Mother_DpcAuri then
			AuriAchievements.Mother_DpcAuri = true
				ShowUnlock()Auriz:AuriSaveData()
			end
		end
	if game:GetLevel():GetStage() == LevelStage.STAGE4_2 and entity.Type == 5 and entity.Variant == 340 then
		if player:GetPlayerType() == PlayerType.PLAYER_QUEEN_AURI and not AuriAchievements.Mother_QueenAuri then
			AuriAchievements.Mother_QueenAuri = true
				ShowUnlock()Auriz:AuriSaveData()
			end
		end

   	if game:GetLevel():GetStage() == LevelStage.STAGE4_2 and entity.Type == 5 and entity.Variant == 340 then
		if player:GetPlayerType() == PlayerType.PLAYER_ASCEND_AURI and not AuriAchievements.Mother_Azrael then
			AuriAchievements.Mother_Azrael = true
				ShowUnlock()Auriz:AuriSaveData()
			end
		end
	if game:GetLevel():GetStage() == LevelStage.STAGE4_2 and entity.Type == 5 and entity.Variant == 340 then
		if player:GetPlayerType() == PlayerType.PLAYER_FALLEN_AURI and not AuriAchievements.Mother_FallenAzrael then
			AuriAchievements.Mother_FallenAzrael = true
				ShowUnlock()Auriz:AuriSaveData()
			end
		end

   	if game:GetLevel():GetStage() == LevelStage.STAGE4_2 and entity.Type == 5 and entity.Variant == 340 then
		if player:GetPlayerType() == PlayerType.PLAYER_DEMONIC_AURI and not AuriAchievements.Mother_Naamah then
			AuriAchievements.Mother_Naamah = true
				ShowUnlock()Auriz:AuriSaveData()
			end
		end
	if game:GetLevel():GetStage() == LevelStage.STAGE4_2 and entity.Type == 5 and entity.Variant == 340 then
		if player:GetPlayerType() == PlayerType.PLAYER_WIP_AURI and not AuriAchievements.Mother_SuccuNaamah then
			AuriAchievements.Mother_SuccuNaamah = true
				ShowUnlock()Auriz:AuriSaveData()
			end
		end

   	if game:GetLevel():GetStage() == LevelStage.STAGE4_2 and entity.Type == 5 and entity.Variant == 340 then
		if player:GetPlayerType() == PlayerType.PLAYER_GLITCH_AURI and not AuriAchievements.Mother_Glitch then
			AuriAchievements.Mother_Glitch = true
				ShowUnlock()Auriz:AuriSaveData()
			end
		end
	if game:GetLevel():GetStage() == LevelStage.STAGE4_2 and entity.Type == 5 and entity.Variant == 340 then
		if player:GetPlayerType() == PlayerType.PLAYER_ERROR_AURI and not AuriAchievements.Mother_ErrorAuri then
			AuriAchievements.Mother_ErrorAuri = true
				ShowUnlock()Auriz:AuriSaveData()
			end
		end

   	if game:GetLevel():GetStage() == LevelStage.STAGE4_2 and entity.Type == 5 and entity.Variant == 340 then
		if player:GetPlayerType() == PlayerType.PLAYER_SOULBOUND_AURI and not AuriAchievements.Mother_ then
			AuriAchievements.Mother_ = true
				ShowUnlock()Auriz:AuriSaveData()
			end
		end
	if game:GetLevel():GetStage() == LevelStage.STAGE4_2 and entity.Type == 5 and entity.Variant == 340 then
		if player:GetPlayerType() == PlayerType.PLAYER_SPIRIT_SHACKLES_AURI and not AuriAchievements.Mother_ then
			AuriAchievements.Mother_ = true
				ShowUnlock()Auriz:AuriSaveData()
			end
		end

   	if game:GetLevel():GetStage() == LevelStage.STAGE4_2 and entity.Type == 5 and entity.Variant == 340 then
		if player:GetPlayerType() == PlayerType.PLAYER_ROTTEN_AURI and not AuriAchievements.Mother_Rotten then
			AuriAchievements.Mother_Rotten = true
				ShowUnlock()Auriz:AuriSaveData()
			end
		end
	if game:GetLevel():GetStage() == LevelStage.STAGE4_2 and entity.Type == 5 and entity.Variant == 340 then
		if player:GetPlayerType() == PlayerType.PLAYER_ZOMBIE_AURI and not AuriAchievements.Mother_Zombie then
			AuriAchievements.Mother_Zombie = true
				ShowUnlock()Auriz:AuriSaveData()
			end
		end

   end

	end
end

function Auriz:BossRushMarks()
	local room = game:GetRoom()
   local player = game:GetPlayer(0)
   if game:GetVictoryLap() > 0 then return end
   if game.Difficulty == Difficulty.DIFFICULTY_HARD then

	if not AuriAchievements.BossRush and Game():GetStateFlag(GameStateFlag.STATE_BOSSRUSH_DONE) and player:GetPlayerType() == PlayerType.PLAYER_AURI then
		   AuriAchievements.BossRush = true
	       ShowUnlock()Auriz:AuriSaveData() 
	end
	if not AuriAchievements.BossRush_ii and Game():GetStateFlag(GameStateFlag.STATE_BOSSRUSH_DONE) and player:GetPlayerType() == PlayerType.PLAYER_TAINTED_AURII then
		   AuriAchievements.BossRush_ii = true
	       ShowUnlock()Auriz:AuriSaveData() 
	end

	if not AuriAchievements.BossRush_AuriDs and Game():GetStateFlag(GameStateFlag.STATE_BOSSRUSH_DONE) and player:GetPlayerType() == PlayerType.PLAYER_DARK_AURI then
		   AuriAchievements.BossRush_AuriDs = true
	       ShowUnlock()Auriz:AuriSaveData() 
	end
	if not AuriAchievements.BossRush_TaintedAuriDs and Game():GetStateFlag(GameStateFlag.STATE_BOSSRUSH_DONE) and player:GetPlayerType() == PlayerType.PLAYER_TAINTED_DARK_AURI then
		   AuriAchievements.BossRush_TaintedAuriDs = true
	       ShowUnlock()Auriz:AuriSaveData() 
	end

	if not AuriAchievements.BossRush_MageAuri and Game():GetStateFlag(GameStateFlag.STATE_BOSSRUSH_DONE) and player:GetPlayerType() == PlayerType.PLAYER_MAGE_AURI then
		   AuriAchievements.BossRush_MageAuri = true
	       ShowUnlock()Auriz:AuriSaveData() 
	end
	if not AuriAchievements.BossRush_NecroAuri and Game():GetStateFlag(GameStateFlag.STATE_BOSSRUSH_DONE) and player:GetPlayerType() == PlayerType.PLAYER_NECROMANTRESS_AURI then
		   AuriAchievements.BossRush_NecroAuri = true
	       ShowUnlock()Auriz:AuriSaveData() 
	end

	if not AuriAchievements.BossRush_DepressedAuri and Game():GetStateFlag(GameStateFlag.STATE_BOSSRUSH_DONE) and player:GetPlayerType() == PlayerType.PLAYER_DEPRESSED_AURI then
		   AuriAchievements.BossRush_DepressedAuri = true
	       ShowUnlock()Auriz:AuriSaveData() 
	end
	if not AuriAchievements.BossRush_CursedAuri and Game():GetStateFlag(GameStateFlag.STATE_BOSSRUSH_DONE) and player:GetPlayerType() == PlayerType.PLAYER_CURSED_AURI then
		   AuriAchievements.BossRush_CursedAuri = true
	       ShowUnlock()Auriz:AuriSaveData() 
	end

	if not AuriAchievements.BossRush_DpcAuri and Game():GetStateFlag(GameStateFlag.STATE_BOSSRUSH_DONE) and player:GetPlayerType() == PlayerType.PLAYER_DARK_PRINCESS_AURI then
		   AuriAchievements.BossRush_DpcAuri = true
	       ShowUnlock()Auriz:AuriSaveData() 
	end
	if not AuriAchievements.BossRush_QueenAuri and Game():GetStateFlag(GameStateFlag.STATE_BOSSRUSH_DONE) and player:GetPlayerType() == PlayerType.PLAYER_QUEEN_AURI then
		   AuriAchievements.BossRush_QueenAuri = true
	       ShowUnlock()Auriz:AuriSaveData() 
	end

	if not AuriAchievements.BossRush_Azrael and Game():GetStateFlag(GameStateFlag.STATE_BOSSRUSH_DONE) and player:GetPlayerType() == PlayerType.PLAYER_ASCEND_AURI then
		   AuriAchievements.BossRush_Azrael = true
	       ShowUnlock()Auriz:AuriSaveData() 
	end
	if not AuriAchievements.BossRush_FallenAzrael and Game():GetStateFlag(GameStateFlag.STATE_BOSSRUSH_DONE) and player:GetPlayerType() == PlayerType.PLAYER_FALLEN_AURI then
		   AuriAchievements.BossRush_FallenAzrael = true
	       ShowUnlock()Auriz:AuriSaveData() 
	end

	if not AuriAchievements.BossRush_Naamah and Game():GetStateFlag(GameStateFlag.STATE_BOSSRUSH_DONE) and player:GetPlayerType() == PlayerType.PLAYER_DEMONIC_AURI then
		   AuriAchievements.BossRush_Naamah = true
	       ShowUnlock()Auriz:AuriSaveData() 
	end
	if not AuriAchievements.BossRush_SuccuNaamah and Game():GetStateFlag(GameStateFlag.STATE_BOSSRUSH_DONE) and player:GetPlayerType() == PlayerType.PLAYER_WIP_AURI then
		   AuriAchievements.BossRush_SuccuNaamah = true
	       ShowUnlock()Auriz:AuriSaveData() 
	end

	if not AuriAchievements.BossRush_Glitch and Game():GetStateFlag(GameStateFlag.STATE_BOSSRUSH_DONE) and player:GetPlayerType() == PlayerType.PLAYER_GLITCH_AURI then
		   AuriAchievements.BossRush_Glitch = true
	       ShowUnlock()Auriz:AuriSaveData() 
	end
	if not AuriAchievements.BossRush_ErrorAuri and Game():GetStateFlag(GameStateFlag.STATE_BOSSRUSH_DONE) and player:GetPlayerType() == PlayerType.PLAYER_ERROR_AURI then
		   AuriAchievements.BossRush_ErrorAuri = true
	       ShowUnlock()Auriz:AuriSaveData() 
	end

	if not AuriAchievements.BossRush_ and Game():GetStateFlag(GameStateFlag.STATE_BOSSRUSH_DONE) and player:GetPlayerType() == PlayerType.PLAYER_SOULBOUND_AURI then
		   AuriAchievements.BossRush_ = true
	       ShowUnlock()Auriz:AuriSaveData() 
	end
	if not AuriAchievements.BossRush_ and Game():GetStateFlag(GameStateFlag.STATE_BOSSRUSH_DONE) and player:GetPlayerType() == PlayerType.PLAYER_SPIRIT_SHACKLES_AURI then
		   AuriAchievements.BossRush_ = true
	       ShowUnlock()Auriz:AuriSaveData() 
	end

	if not AuriAchievements.BossRush_Rotten and Game():GetStateFlag(GameStateFlag.STATE_BOSSRUSH_DONE) and player:GetPlayerType() == PlayerType.PLAYER_ROTTEN_AURI then
		   AuriAchievements.BossRush_Rotten = true
	       ShowUnlock()Auriz:AuriSaveData() 
	end
	if not AuriAchievements.BossRush_Zombie and Game():GetStateFlag(GameStateFlag.STATE_BOSSRUSH_DONE) and player:GetPlayerType() == PlayerType.PLAYER_ZOMBIE_AURI then
		   AuriAchievements.BossRush_Zombie = true
	       ShowUnlock()Auriz:AuriSaveData() 
	end

	if not AuriAchievements.BossRush_ and Game():GetStateFlag(GameStateFlag.STATE_BOSSRUSH_DONE) and player:GetPlayerType() == PlayerType.PLAYER_WIPP_AURI then
		   AuriAchievements.BossRush_ = true
	       ShowUnlock()Auriz:AuriSaveData() 
	end
	if not AuriAchievements.BossRush_ and Game():GetStateFlag(GameStateFlag.STATE_BOSSRUSH_DONE) and player:GetPlayerType() == PlayerType.PLAYER_WIPPP_AURI then
		   AuriAchievements.BossRush_ = true
	       ShowUnlock()Auriz:AuriSaveData() 
	end

	end
end

function Auriz:GreedierUnlock()
local room = game:GetRoom()
local player = Isaac.GetPlayer(0);
	for _, ent in pairs(Isaac.GetRoomEntities()) do
		if game.Difficulty == Difficulty.DIFFICULTY_GREEDIER and ent.Type == 5 and ent.Variant == 340 
		then
			if player:GetPlayerType() == PlayerType.PLAYER_AURI and not AuriAchievements.Greed then
			   AuriAchievements.Greed = true
			   achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_morphpenny.png")
			   DisplayAchievement()
			end
			if player:GetPlayerType() == PlayerType.PLAYER_TAINTED_AURII and not AuriAchievements.Greed_ii then
			   AuriAchievements.Greed_ii = true
			   achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
			   DisplayAchievement()
			end

			if player:GetPlayerType() == PlayerType.PLAYER_DARK_AURI and not AuriAchievements.Greed_AuriDs then
			   AuriAchievements.Greed_AuriDs = true
			   achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
			   DisplayAchievement()
			end
			if player:GetPlayerType() == PlayerType.PLAYER_TAINTED_DARK_AURI and not AuriAchievements.Greed_TaintedAuriDs then
			   AuriAchievements.Greed_TaintedAuriDs = true
			   achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
			   DisplayAchievement()
			end

			if player:GetPlayerType() == PlayerType.PLAYER_MAGE_AURI and not AuriAchievements.Greed_MageAuri then
			   AuriAchievements.Greed_MageAuri = true
			   achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_enchantpenny.png")
			   DisplayAchievement()
			end
			if player:GetPlayerType() == PlayerType.PLAYER_NECROMANTRESS_AURI and not AuriAchievements.Greed_NecroAuri then
			   AuriAchievements.Greed_NecroAuri = true
			   achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
			   DisplayAchievement()
			end

			if player:GetPlayerType() == PlayerType.PLAYER_DEPRESSED_AURI and not AuriAchievements.Greed_DepressedAuri then
			   AuriAchievements.Greed_DepressedAuri = true
			   achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
			   DisplayAchievement()
			end
			if player:GetPlayerType() == PlayerType.PLAYER_CURSED_AURI and not AuriAchievements.Greed_CursedAuri then
			   AuriAchievements.Greed_CursedAuri = true
			   achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
			   DisplayAchievement()
			end

			if player:GetPlayerType() == PlayerType.PLAYER_DARK_PRINCESS_AURI and not AuriAchievements.Greed_DpcAuri then
			   AuriAchievements.Greed_DpcAuri = true
			   achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
			   DisplayAchievement()
			end
			if player:GetPlayerType() == PlayerType.PLAYER_QUEEN_AURI and not AuriAchievements.Greed_QueenAuri then
			   AuriAchievements.Greed_QueenAuri = true
			   achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
			   DisplayAchievement()
			end

			if player:GetPlayerType() == PlayerType.PLAYER_ASCEND_AURI and not AuriAchievements.Greed_Azrael then
			   AuriAchievements.Greed_Azrael = true
			   achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
			   DisplayAchievement()
			end
			if player:GetPlayerType() == PlayerType.PLAYER_FALLEN_AURI and not AuriAchievements.Greed_FallenAzrael then
			   AuriAchievements.Greed_FallenAzrael = true
			   achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
			   DisplayAchievement()
			end

			if player:GetPlayerType() == PlayerType.PLAYER_DEMONIC_AURI and not AuriAchievements.Greed_Naamah then
			   AuriAchievements.Greed_Naamah = true
			   achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
			   DisplayAchievement()
			end
			if player:GetPlayerType() == PlayerType.PLAYER_WIP_AURI and not AuriAchievements.Greed_SuccuNaamah then
			   AuriAchievements.Greed_SuccuNaamah = true
			   achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
			   DisplayAchievement()
			end

			if player:GetPlayerType() == PlayerType.PLAYER_GLITCH_AURI and not AuriAchievements.Greed_Glitch then
			   AuriAchievements.Greed_Glitch = true
			   achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
			   DisplayAchievement()
			end
			if player:GetPlayerType() == PlayerType.PLAYER_ERROR_AURI and not AuriAchievements.Greed_ErrorAuri then
			   AuriAchievements.Greed_ErrorAuri = true
			   achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
			   DisplayAchievement()
			end

			if player:GetPlayerType() == PlayerType.PLAYER_SOULBOUND_AURI and not AuriAchievements.Greed_ then
			   AuriAchievements.Greed_ = true
			   achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
			   DisplayAchievement()
			end
			if player:GetPlayerType() == PlayerType.PLAYER_SPIRIT_SHACKLES_AURI and not AuriAchievements.Greed_ then
			   AuriAchievements.Greed_ = true
			   achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
			   DisplayAchievement()
			end

			if player:GetPlayerType() == PlayerType.PLAYER_ROTTEN_AURI and not AuriAchievements.Greed_Rotten then
			   AuriAchievements.Greed_Rotten = true
			   achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
			   DisplayAchievement()
			end
			if player:GetPlayerType() == PlayerType.PLAYER_ZOMBIE_AURI and not AuriAchievements.Greed_Zombie then
			   AuriAchievements.Greed_Zombie = true
			   achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
			   DisplayAchievement()
			end

			if player:GetPlayerType() == PlayerType.PLAYER_WIPP_AURI and not AuriAchievements.Greed_ then
			   AuriAchievements.Greed_ = true
			   achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
			   DisplayAchievement()
			end
			if player:GetPlayerType() == PlayerType.PLAYER_WIPPP_AURI and not AuriAchievements.Greed_ then
			   AuriAchievements.Greed_ = true
			   achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/null.png")
			   DisplayAchievement()
			end
		end
	end
end

function UnlockHangGirlz() 
	for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
	if (player:GetName() ~= "Depressed Auri") and player:HasCollectible(469) and not AuriAchievements.UnlockHangGirl then
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_depressed_auri_unlock.png")
    DisplayAchievement()
	AuriAchievements.UnlockHangGirl = true
  end
end
end
function UnlockHangGirl4()
	for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
	if (player:GetName() ~= "Depressed Auri") and player:HasCollectible(469) and player:HasCollectible(20) and not AuriAchievements.UnlockHangGirl then
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_depressed_auri_unlock.png")
    DisplayAchievement()
	AuriAchievements.UnlockHangGirl = true
  end
end
end

function AuriUnlock()
  local player = Isaac.GetPlayer(0)

    if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Auri") and not AuriAchievements.UnlockDarkAuri and not AuriUnlockCheck then
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_locked_darkauri.png")
    DisplayAchievement()
	AuriUnlockCheck = true

	elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Milcah") and not AuriAchievements.UnlockMilcah and not AuriUnlockCheck then
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_locked_dpcauri.png")
    DisplayAchievement()
	AuriUnlockCheck = true

	elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Naamah") and not AuriAchievements.UnlockNaamah and not AuriUnlockCheck then
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_locked_naamah.png")
    DisplayAchievement()
	AuriUnlockCheck = true

	elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and player:HasCollectible(442) and not AuriAchievements.UnlockMilcah
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and player:HasCollectible(442) and not AuriAchievements.UnlockMilcah
	or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Auri") and player:HasCollectible(442) and not AuriAchievements.UnlockMilcah
	or (player:GetName() == "Mage Auri") and player:HasCollectible(442) and not AuriAchievements.UnlockMilcah
	or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Naamah") and player:HasCollectible(442) and not AuriAchievements.UnlockMilcah
	or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Azrael") and player:HasCollectible(442) and not AuriAchievements.UnlockMilcah
	then
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_dpc_Auri_Unlock.png")
    DisplayAchievement()
	AuriAchievements.UnlockMilcah = true

	elseif not AuriAchievements.UnlockAuri and player:HasTrinket(145) and player:GetPlayerType() == PlayerType.PLAYER_ISAAC then
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_999_auri.png")
    DisplayAchievement()
	AuriAchievements.UnlockAuri = true

	elseif not AuriAchievements.UnlockNaamah and player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and player:HasCollectible(CollectibleType.COLLECTIBLE_SUCCUBUS) then
    player:AnimateSad()
	sfx:Stop(SoundEffect.SOUND_THUMBS_DOWN)

    player:RemoveCollectible(CollectibleType.COLLECTIBLE_CROWN_OF_LIGHT)
	player:RemoveCollectible(CollectibleType.COLLECTIBLE_SUCCUBUS)
	player:AddCollectible(699, 0, false) 
	sfx:Play(SoundEffect.SOUND_DEVILROOM_DEAL, 0.5, 0, false, 1)
	sfx:Play(SoundEffect.AURI_GIGGLE, 3.5, 0, false, 1)
    player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/aurihair.anm2"))
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/demonic_auri_hair.anm2"))
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_Naamah_Unlock.png")
	DisplayAchievement()
	AuriAchievements.UnlockNaamah = true

	elseif AuriAchievements.Isaac and AuriAchievements.BlueBaby and AuriAchievements.Satan and AuriAchievements.Lamb and AuriAchievements.Hush and AuriAchievements.MegaSatan and AuriAchievements.Delirium and AuriAchievements.BossRush and AuriAchievements.Greed and AuriAchievements.Beast and AuriAchievements.Mother and not AuriAchievements.UnlockDarkAuri then
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_dark_auri.png")
    DisplayAchievement()
	AuriAchievements.UnlockDarkAuri = true 

	elseif AuriAchievements.Isaac and not AuriAchievements.Unlockhourglass then
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_999_aurihourglass.png")
    DisplayAchievement()
	AuriAchievements.Unlockhourglass = true

	elseif AuriAchievements.Isaac_DpcAuri and not AuriAchievements.Unlock_BloodyHourGlass then
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_hold_bloody_hourglass.png")
    DisplayAchievement()
	AuriAchievements.Unlock_BloodyHourGlass = true

	elseif not AuriAchievements.UnlockMage and Luckypennyformage == 3 then
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_mage_auri_unlock.png")
    DisplayAchievement()
	AuriAchievements.UnlockMage = true

	elseif (player:GetName() == "Mage Auri") and not AuriUnlockCheck and not AuriAchievements.UnlockMage then
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_mage_auri_lock.png")
    DisplayAchievement()
	AuriUnlockCheck = true

	elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Depressed Auri") and not AuriUnlockCheck and not AuriAchievements.UnlockHangGirl then
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_depressed_auri_lock.png")
    DisplayAchievement()
	AuriUnlockCheck = true

	elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Azrael") and not AuriUnlockCheck and not AuriAchievements.UnlockAzrael then
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_locked.png")
    DisplayAchievement()
	AuriUnlockCheck = true

	elseif 
	not AuriAchievements.UnlockAzrael and player:HasPlayerForm(PlayerForm.PLAYERFORM_ANGEL)
	and player:GetPlayerType() == PlayerType.PLAYER_AURI then
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_999_auri.png")
    DisplayAchievement()
	AuriAchievements.UnlockAzrael = true

	elseif (player:GetName() == "Soulbound Auri") and not AuriUnlockCheck then
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_locked.png")
     DisplayAchievement()
	AuriUnlockCheck = true

	elseif (player:GetName() == "Definitely Not Auri") and not AuriUnlockCheck then
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_locked.png")
     DisplayAchievement()
	AuriUnlockCheck = true

	elseif (player:GetName() == "Dark Mage Auri") and not AuriUnlockCheck then
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_locked.png")
     DisplayAchievement()
	AuriUnlockCheck = true

	elseif (player:GetName() == "Cursed Auri") and not AuriUnlockCheck then
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_locked.png")
    DisplayAchievement()
	AuriUnlockCheck = true

	elseif (player:GetName() == "Soulbound Auri tainted") and not AuriUnlockCheck then
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_locked.png")
     DisplayAchievement()
	AuriUnlockCheck = true

	elseif (player:GetName() == "Zombie Auri") and not AuriUnlockCheck then
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_locked.png")
     DisplayAchievement()
	AuriUnlockCheck = true

	elseif (player:GetName() == "Fallen Auri") and not AuriUnlockCheck then
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_locked.png")
     DisplayAchievement()
	AuriUnlockCheck = true

	elseif (player:GetName() == "Dark Princess Auri Tainted") and not AuriUnlockCheck then
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_locked.png")
    DisplayAchievement()
	AuriUnlockCheck = true

	elseif (player:GetName() == "Definitely Not Auri tainted") and not AuriUnlockCheck then
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_locked.png")
     DisplayAchievement()
	AuriUnlockCheck = true

	elseif (player:GetName() == "Demonic Auri WIP") and not AuriUnlockCheck then
	achievementSprite:ReplaceSpritesheet(2, "gfx/ui/achievement/achievement_locked.png")
     DisplayAchievement()
	AuriUnlockCheck = true
	end

	if not AuriSaveCheck then
if AuriAchievements.Isaac then

end
if AuriAchievements.BlueBaby then
AuriAchievements.Unlock_Calmmind = true
end
if AuriAchievements.Satan then
AuriAchievements.Unlock_LittleAuri = true
end
if AuriAchievements.Lamb then
AuriAchievements.UnlockDarkAuri = true
end
if AuriAchievements.Hush then
AuriAchievements.Unlock_Auricrown = true
end
if AuriAchievements.MegaSatan then

end
if AuriAchievements.Delirium then
AuriAchievements.Unlock_Princessbox = true
end
if AuriAchievements.Mother then
AuriAchievements.Unlock_Aurihairclip = true
end
if AuriAchievements.Beast then
AuriAchievements.Unlock_Thememories = true
end
if AuriAchievements.BossRush then
AuriAchievements.Unlock_GoldenCrown = true
end
if AuriAchievements.Greed then
AuriAchievements.Unlock_Morphpenny = true
end
if AuriAchievements.FullCompletion then

end

if AuriAchievements.BossRush_ii then

end
if AuriAchievements.Isaac_ii then

end
if AuriAchievements.BlueBaby_ii then

end
if AuriAchievements.Satan_ii then

end
if AuriAchievements.Lamb_ii then

end
if AuriAchievements.Hush_ii then

end
if AuriAchievements.MegaSatan_ii then

end
if AuriAchievements.Delirium_ii then
AuriAchievements.Unlockglitchcrown = true
end
if AuriAchievements.Mother_ii then

end
if AuriAchievements.Beast_ii then

end
if AuriAchievements.Greed_ii then

end
if AuriAchievements.FullCompletion_ii then

end

if AuriAchievements.BossRush_AuriDs then

end
if AuriAchievements.Isaac_AuriDs then
AuriAchievements.UnlockNullandholdDGHinMainslot = true
end
if AuriAchievements.BlueBaby_AuriDs then

end
if AuriAchievements.Satan_AuriDs then

end
if AuriAchievements.Lamb_AuriDs then

end
if AuriAchievements.Hush_AuriDs then

end
if AuriAchievements.MegaSatan_AuriDs then

end
if AuriAchievements.Delirium_AuriDs then

end
if AuriAchievements.Mother_AuriDs then

end
if AuriAchievements.Beast_AuriDs then

end
if AuriAchievements.Greed_AuriDs then

end
if AuriAchievements.FullCompletion_AuriDs then

end

if AuriAchievements.BossRush_TaintedAuriDs then

end
if AuriAchievements.Isaac_TaintedAuriDs then

end
if AuriAchievements.BlueBaby_TaintedAuriDs then

end
if AuriAchievements.Satan_TaintedAuriDs then

end
if AuriAchievements.Lamb_TaintedAuriDs then

end
if AuriAchievements.Hush_TaintedAuriDs then

end
if AuriAchievements.MegaSatan_TaintedAuriDs then

end
if AuriAchievements.Delirium_TaintedAuriDs then

end
if AuriAchievements.Mother_TaintedAuriDs then

end
if AuriAchievements.Beast_TaintedAuriDs then

end
if AuriAchievements.Greed_TaintedAuriDs then

end
if AuriAchievements.FullCompletion_TaintedAuriDs then

end

if AuriAchievements.BossRush_MageAuri then
AuriAchievements.Unlock_Magerobe = true
end
if AuriAchievements.Isaac_MageAuri then
AuriAchievements.Unlock_Enchantbook = true
end
if AuriAchievements.BlueBaby_MageAuri then

end
if AuriAchievements.Satan_MageAuri then

end
if AuriAchievements.Lamb_MageAuri then

end
if AuriAchievements.Hush_MageAuri then
AuriAchievements.Unlock_Magehat = true
end
if AuriAchievements.MegaSatan_MageAuri then
AuriAchievements.Satanmarks_mage = true
end
if AuriAchievements.Delirium_MageAuri then

end
if AuriAchievements.Mother_MageAuri then
AuriAchievements.Unlock_Firebook = true
end
if AuriAchievements.Beast_MageAuri then
AuriAchievements.Unlock_Firebookpage = true
end
if AuriAchievements.Greed_MageAuri then
AuriAchievements.Unlock_Enchantpenny = true
end
if AuriAchievements.FullCompletion_MageAuri then

end

print("Auri save updated!")
AuriSaveCheck = true
end

end

function DisplaySprites()
    if achievementFrames > 0 or achievementSprite:IsPlaying("Disappear") then
        achievementSprite:Render(Isaac.WorldToRenderPosition(Vector(320, 300)))
        achievementFrames = achievementFrames - 1
        if AuriUnlockCheck and achievementFrames == 200 then

        end
        if achievementFrames == 0 then
            achievementSprite:Play("Disappear")
        end
    end
end

function UpdateSprites()
  achievementSprite:Update()
end

function Auriz:AuriRenderUpdate(player)
local player = Isaac.GetPlayer(0)
	if player:GetSprite():IsEventTriggered("Glitch") then
	 sfx:Play(SoundEffect.SOUND_STATIC,1,0,false,1)  
	end
	if player:GetSprite():IsEventTriggered("Glitch2") then
	 sfx:Play(SoundEffect.SOUND_EDEN_GLITCH,1,0,false,1.5)  
	end
	if player:GetSprite():IsEventTriggered("Slash") then
	 sfx:Play(SoundEffect.SOUND_TOOTH_AND_NAIL,3,0,false,2) 
	 sfx:Play(SoundEffect.SOUND_DEATH_BURST_SMALL,3,0,false,1)  
	end
	local player = Isaac.GetPlayer(0)
	if player:GetSprite():IsEventTriggered("GSlash") then
	sfx:Play(SoundEffect.SOUND_KNIFE_PULL, 1, 0, false, 1)
	end
end
Auriz:AddCallback(ModCallbacks.MC_POST_UPDATE, Auriz.AuriRenderUpdate)

local logust_hood = Isaac.GetItemIdByName("Knout")  
function AuriRogustHood()
 for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)

	if ROTCG then 
if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and not HasRogustHoodie and player:HasCollectible(logust_hood) 

then
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auri_hair_rogust_hood.anm2"))
	HasRogustHoodie = true

	elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and HasRogustHoodie and not player:HasCollectible(logust_hood) 

then
	HasRogustHoodie = false

  end

  if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and not HasRogustHoodie and player:HasCollectible(logust_hood) then
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auri_hair_rogust_hood_aurii.anm2"))
	HasRogustHoodie = true
	elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and HasRogustHoodie and not player:HasCollectible(logust_hood) then
	HasRogustHoodie = false
	end
  if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Auri") and not HasRogustHoodie and player:HasCollectible(logust_hood) then
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auri_hair_rogust_hood_dark.anm2"))
	HasRogustHoodie = true
	elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Auri") and HasRogustHoodie and not player:HasCollectible(logust_hood) then
	HasRogustHoodie = false
	end
  if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Depressed Auri") and not HasRogustHoodie and player:HasCollectible(logust_hood) then
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auri_hair_rogust_hood_hanggirl.anm2"))
	HasRogustHoodie = true
	elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Depressed Auri") and HasRogustHoodie and not player:HasCollectible(logust_hood) then
	HasRogustHoodie = false
	end
  if (player:GetName() == "Mage Auri") and not HasRogustHoodie and player:HasCollectible(logust_hood) then
	player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/mage_auri_hat_newhair.anm2"))
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auri_hair_rogust_hood_mage.anm2"))
	HasRogustHoodie = true
	elseif (player:GetName() == "Mage Auri") and HasRogustHoodie and not player:HasCollectible(logust_hood) then
	HasRogustHoodie = false
	end
  if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Milcah") and not HasRogustHoodie and player:HasCollectible(logust_hood) then
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auri_hair_rogust_hood_milcah.anm2"))
	HasRogustHoodie = true
	elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Milcah") and HasRogustHoodie and not player:HasCollectible(logust_hood) then
	HasRogustHoodie = false
	end
  if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Naamah") and not HasRogustHoodie and player:HasCollectible(logust_hood) then
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auri_hair_rogust_hood_naamah.anm2"))
	HasRogustHoodie = true
	elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Naamah") and HasRogustHoodie and not player:HasCollectible(logust_hood) then
	HasRogustHoodie = false
	end

  end

end
	for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and not HasMawHair and player:HasCollectible(399) then
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auri_maw_hair.anm2"))
	HasMawHair = true
	elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and HasMawHair and not player:HasCollectible(399) then
	HasMawHair = false
	end
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and not HasMawHair and player:HasCollectible(399) then
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/aurii_maw_hair.anm2"))
	HasMawHair = true
	elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and HasMawHair and not player:HasCollectible(399) then
	HasMawHair = false
	end
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and ShadowAurii and player:HasCollectible(591) and not HasShadowVenus then
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/shadow_auri_head.anm2"))
	HasShadowVenus = true
	elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and not ShadowAurii and not player:HasCollectible(591) and HasShadowVenus then
	HasShadowVenus = false
	end
	if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Naamah") and not HasMawHair and player:HasCollectible(399) then
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/demonic_auri_hair_maw.anm2"))
	HasMawHair = true
	elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Naamah") and HasMawHair and not player:HasCollectible(399) then
	HasMawHair = false
	end
  end

   for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)

if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and not IsGuppyz and player:HasPlayerForm(PlayerForm.PLAYERFORM_GUPPY) then
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auri_hair_guppy.anm2"))
	IsGuppyz = true
	elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") and IsGuppyz and not player:HasPlayerForm(PlayerForm.PLAYERFORM_GUPPY) then
	IsGuppyz = false
  end
  if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and not IsGuppyz and player:HasPlayerForm(PlayerForm.PLAYERFORM_GUPPY) then
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auri_hair_guppy_aurii.anm2"))
	IsGuppyz = true
	elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) and IsGuppyz and not player:HasPlayerForm(PlayerForm.PLAYERFORM_GUPPY) then
	IsGuppyz = false
	end
  if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Auri") and not IsGuppyz and player:HasPlayerForm(PlayerForm.PLAYERFORM_GUPPY) then
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auri_hair_guppy_dark.anm2"))
	IsGuppyz = true
	elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Auri") and IsGuppyz and not player:HasPlayerForm(PlayerForm.PLAYERFORM_GUPPY) then
	IsGuppyz = false
	end
  if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Depressed Auri") and not IsGuppyz and player:HasPlayerForm(PlayerForm.PLAYERFORM_GUPPY) then
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auri_hair_guppy_hanggirl.anm2"))
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auri_body_guppy_hanggirl.anm2"))
	IsGuppyz = true
	elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Depressed Auri") and IsGuppyz and not player:HasPlayerForm(PlayerForm.PLAYERFORM_GUPPY) then
	IsGuppyz = false
	end
  if (player:GetName() == "Mage Auri") and not IsGuppyz and player:HasPlayerForm(PlayerForm.PLAYERFORM_GUPPY) then
	player:TryRemoveNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/mage_auri_hat_newhair.anm2"))
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auri_hair_guppy_mage.anm2"))
	IsGuppyz = true
	elseif (player:GetName() == "Mage Auri") and IsGuppyz and not player:HasPlayerForm(PlayerForm.PLAYERFORM_GUPPY) then
	IsGuppyz = false
	end
  if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Milcah") and not IsGuppyz and player:HasPlayerForm(PlayerForm.PLAYERFORM_GUPPY) then
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auri_hair_guppy_dpc.anm2"))
	IsGuppyz = true
	elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Milcah") and IsGuppyz and not player:HasPlayerForm(PlayerForm.PLAYERFORM_GUPPY) then
	IsGuppyz = false
	end
  if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Naamah") and not IsGuppyz and player:HasPlayerForm(PlayerForm.PLAYERFORM_GUPPY) then
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/auri_hair_guppy_naamah.anm2"))
	IsGuppyz = true
	elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Naamah") and IsGuppyz and not player:HasPlayerForm(PlayerForm.PLAYERFORM_GUPPY) then
	IsGuppyz = false
	end

  end

   for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)

if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Auri")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Corrupted Auri", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Milcah")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Queen Auri", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Mage Auri")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Mage Auri", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Depressed Auri")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Cursed Auri", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Soulbound Auri")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Soul Shackles Auri", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Famish")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Zombie Auri", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Azrael")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Fallen Auri", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Glitch Auri")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Error Auri", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Naamah")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Demonic Auri WIP", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Genocide Auri?")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Genocide Auri?", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Future Auri")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Future Auri", true)
then
if  not IsPoopyz and player:HasPlayerForm(PlayerForm.PLAYERFORM_POOP) then
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/vurio_hat.anm2"))
	IsPoopyz = true
	elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Auri")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Corrupted Auri", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Milcah")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Queen Auri", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Mage Auri")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Mage Auri", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Depressed Auri")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Cursed Auri", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Soulbound Auri")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Soul Shackles Auri", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Famish")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Zombie Auri", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Azrael")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Fallen Auri", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Glitch Auri")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Error Auri", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Naamah")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Demonic Auri WIP", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Genocide Auri?")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Genocide Auri?", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Future Auri")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Future Auri", true)
then
	if IsPoopyz and not player:HasPlayerForm(PlayerForm.PLAYERFORM_POOP) then
	IsPoopyz = false
  end
  end
  end
  end

   for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)

if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Auri")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Corrupted Auri", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Milcah")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Queen Auri", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Mage Auri")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Mage Auri", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Depressed Auri")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Cursed Auri", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Soulbound Auri")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Soul Shackles Auri", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Famish")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Zombie Auri", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Azrael")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Fallen Auri", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Glitch Auri")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Error Auri", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Naamah")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Demonic Auri WIP", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Genocide Auri?")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Genocide Auri?", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Future Auri")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Future Auri", true)
then

if not IsFunguyz and player:HasPlayerForm(PlayerForm.PLAYERFORM_MUSHROOM) then
	player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/aurio_hat.anm2"))
	IsFunguyz = true
	elseif player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Auri")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Corrupted Auri", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Milcah")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Queen Auri", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Mage Auri")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Mage Auri", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Depressed Auri")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Cursed Auri", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Soulbound Auri")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Soul Shackles Auri", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Famish")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Zombie Auri", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Azrael")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Fallen Auri", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Glitch Auri")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Error Auri", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Naamah")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Demonic Auri WIP", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Genocide Auri?")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Genocide Auri?", true)
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Future Auri")
    or player:GetPlayerType() == Isaac.GetPlayerTypeByName("Future Auri", true)
then
	if IsFunguyz and not player:HasPlayerForm(PlayerForm.PLAYERFORM_MUSHROOM) then
	IsFunguyz = false
	end
   end
  end
 end

end
Auriz:AddCallback(ModCallbacks.MC_POST_UPDATE, AuriRogustHood)

 local  MageAuri = { 
    DAMAGE = 0,
    SPEED = -0.1,
	TEARS = 0,
    SHOTSPEED = 0,
    TEARHEIGHT = 0,
    TEARFALLINGSPEED = 0,
    LUCK = 0,
    FLYING = false,                                 
    TEARFLAG = 0,
    TEARCOLOR = Color(1.0, 1.0, 1.0, 1.0, 0, 0, 0)
}

	function MageAuri:onCache(player, cacheFlag)
    if player:GetName() == "Mage Auri" then
        if cacheFlag == CacheFlag.CACHE_DAMAGE then
            player.Damage = player.Damage + MageAuri.DAMAGE
        end
		if cacheFlag == CacheFlag.CACHE_DAMAGE then
		  if ShadowAuri or ShaAuri or DeadAuri or RaisenAuri then
			player.Damage = player.Damage + 1.6
		  end
		end
		if cacheFlag == CacheFlag.CACHE_DAMAGE then
		 if BerSerkAuri then
			player.Damage = player.Damage + 9.99
		  end
		end
		if cacheFlag == CacheFlag.CACHE_FIREDELAY  then

        end

        if cacheFlag == CacheFlag.CACHE_SHOTSPEED then
            player.ShotSpeed = player.ShotSpeed + MageAuri.SHOTSPEED
        end

        if cacheFlag == CacheFlag.CACHE_SPEED then
            player.MoveSpeed = player.MoveSpeed + MageAuri.SPEED
        end
        if cacheFlag == CacheFlag.CACHE_LUCK then
            player.Luck = player.Luck + MageAuri.LUCK
        end
        if cacheFlag == CacheFlag.CACHE_FLYING and MageAuri.FLYING then
            player.CanFly = true
        end
        if cacheFlag == CacheFlag.CACHE_TEARFLAG then
            player.TearFlags = player.TearFlags | MageAuri.TEARFLAG
        end
        if cacheFlag == CacheFlag.CACHE_TEARCOLOR then
            player.TearColor = MageAuri.TEARCOLOR
        end

    end
end

Auriz:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, MageAuri.onCache)

local  Naamah = { 
    DAMAGE = 0,
    SPEED = -0.1,
	TEARS = 0,
    SHOTSPEED = -0.1,
    TEARHEIGHT = 0,
	RANGE = -7,
    TEARFALLINGSPEED = 0,
    LUCK = 0,
    FLYING = false,                                 
    TEARFLAG = 0,
    TEARCOLOR = Color(1.0, 1.0, 1.0, 1.0, 0, 0, 0)
}

	function Naamah:onCache(player, cacheFlag)
    if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Naamah") then
        if cacheFlag == CacheFlag.CACHE_DAMAGE then
            player.Damage = player.Damage + Naamah.DAMAGE
        end
		if cacheFlag == CacheFlag.CACHE_FIREDELAY  then

        end

        if cacheFlag == CacheFlag.CACHE_SHOTSPEED then
            player.ShotSpeed = player.ShotSpeed + Naamah.SHOTSPEED
        end
        if cacheFlag == CacheFlag.CACHE_RANGE then
            player.TearHeight = player.TearHeight - Naamah.TEARHEIGHT
            player.TearFallingSpeed = player.TearFallingSpeed + Naamah.TEARFALLINGSPEED
			player.TearRange = player.TearRange + Naamah.RANGE
        end

        if cacheFlag == CacheFlag.CACHE_SPEED then
            player.MoveSpeed = player.MoveSpeed + Naamah.SPEED
        end
        if cacheFlag == CacheFlag.CACHE_LUCK then
            player.Luck = player.Luck + Naamah.LUCK
        end
        if cacheFlag == CacheFlag.CACHE_FLYING and Naamah.FLYING then
            player.CanFly = true
        end
        if cacheFlag == CacheFlag.CACHE_TEARFLAG then
            player.TearFlags = player.TearFlags | Naamah.TEARFLAG
        end
        if cacheFlag == CacheFlag.CACHE_TEARCOLOR then
            player.TearColor = Naamah.TEARCOLOR
        end

    end
end

Auriz:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Naamah.onCache)

COLLECTIBLE_POCKET_BAG = Isaac.GetItemIdByName("Pocket Bag")

PlayerType.PLAYER_NAAMAH = Isaac.GetPlayerTypeByName("Naamah")
function NaamahDemonic(playertype)
local player = Isaac.GetPlayer(0)
	local playertype = Isaac.GetPlayer(0):GetPlayerType()

			if playertype == PlayerType.PLAYER_NAAMAH and player:GetEffects():HasTrinketEffect(TrinketType.TRINKET_AZAZELS_STUMP) and not NaamahJustTransfroms and player:IsExtraAnimationFinished() == true then 

			player:PlayExtraAnimation("Naamahtrans")
			sfx:Play(SoundEffect.SOUND_DEVILROOM_DEAL, 0.8, 0, false, 1)
			sfx:Play(SoundEffect.AURI_GIGGLE, 60, 0, false, 1)
			player:AddControlsCooldown(55)
			NaamahJustTransfroms = true
    end

	if playertype == PlayerType.PLAYER_NAAMAH and not player:GetEffects():HasTrinketEffect(TrinketType.TRINKET_AZAZELS_STUMP) and NaamahJustTransfroms then 

			NaamahJustTransfroms = false
    end

	if Game():GetFrameCount() == 10 then
	     Aurimod_GetStartItem = player:GetActiveItem(0)
		 Aurimod_GetStartTrinket = player:GetTrinket(0)

       player_IsSetPocketActive = false
	   player_IsGulpStartTrinket = false

	end

	if player:HasCollectible(COLLECTIBLE_POCKET_BAG) and player:GetTrinket(0) == Aurimod_GetStartTrinket then
        if player_IsGulpStartTrinket then
            return
        end

        player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER, false, false, true, true)
        sfx:Play(SoundEffect.SOUND_BIRD_FLAP, 2, 0, false, 1)
		player:AnimateCollectible(COLLECTIBLE_POCKET_BAG, "UseItem", "PlayerPickupSparkle")
		player_IsGulpStartTrinket = true

    end

	if player:HasCollectible(COLLECTIBLE_POCKET_BAG) and player:GetActiveItem(0) == Aurimod_GetStartItem then
        if player_IsSetPocketActive then
            return
        end
		 if Aurimod_GetStartItem == 0 then 
            return
        end

        player:RemoveCollectible(Aurimod_GetStartItem)
        player:SetPocketActiveItem(Aurimod_GetStartItem)
        sfx:Play(SoundEffect.SOUND_BIRD_FLAP, 2, 0, false, 1)
		player:AnimateCollectible(COLLECTIBLE_POCKET_BAG, "UseItem", "PlayerPickupSparkle")
		player_IsSetPocketActive = true

    end

end
Auriz:AddCallback(ModCallbacks.MC_POST_UPDATE, NaamahDemonic)

function Auriz:Charmingtears(tear,cacheFlag)
for i = 1, Game():GetNumPlayers() do
    local player = Isaac.GetPlayer(i - 1)
    local NaamahMaxHP = player:GetMaxHearts()
    local HasBirthRight = player:HasCollectible(Birthright)
    if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Naamah") then
        if player:HasCollectible(COLLECTIBLE_SEDUCE) then
            HasSeduce = 5

        end
        if not player:HasCollectible(COLLECTIBLE_SEDUCE) then
            HasSeduce = 0

        end

        if HasBirthRight then
            Hasbirthright = 10

        end
        if not HasBirthRight then
            Hasbirthright = 0

        end
        local sprite = tear:GetSprite()
        local Naamahhearttears = math.random(0, 99) + NaamahMaxHP + HasSeduce + Hasbirthright
        if Naamahhearttears >= 99 then
            sfx:Play(SoundEffect.SOUND_KISS_LIPS1, 1, 0, false, 1.2)
            tear.TearFlags =
                tear.TearFlags | TearFlags.TEAR_WIGGLE | TearFlags.TEAR_CHARM | TearFlags.TEAR_SPECTRAL |
                TearFlags.TEAR_HOMING
            sprite:Load("gfx/000.999_heart tear.anm2", true)
            sprite:LoadGraphics()
            sprite:Play("MoveHori", true)
            sprite:Update()
        end
    end
end

end
Auriz:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, Auriz.Charmingtears)

function Auriz:NaamahKiss(NPC,entity)
  local player = Isaac.GetPlayer(0) 

    local entity = entity:ToPlayer()
    if entity then

      if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Naamah") then

       NPC:AddCharmed(EntityRef(player),99)

    end
  end
end

Auriz:AddCallback(ModCallbacks.MC_PRE_NPC_COLLISION,Auriz.NaamahKiss)

function Auriz:completion_marks()
  local player = game:GetPlayer(0)
   local f = Font() 
   local controller = player.ControllerIndex

   if  player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") then
    if Input.IsButtonPressed(Keyboard.KEY_V, controller) == true then 
    f:Load("font/pftempestasevencondensed.fnt") 

	f:DrawString("Achievements",50,35,KColor(1,1,1,1,0,0,0),0,true)
	if AuriAchievements.Isaac == false then f:DrawString("Beat Isaac = No",50,50,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Isaac == true then f:DrawString("Beat Isaac = Yes",50,50,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.BlueBaby == false then f:DrawString("Beat ??? = No",50,60,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.BlueBaby == true then f:DrawString("Beat ??? = Yes",50,60,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Satan == false then f:DrawString("Beat Satan = No",50,70,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Satan == true then f:DrawString("Beat Satan = Yes",50,70,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.Lamb == false then f:DrawString("Beat Lamb = No",50,80,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Lamb == true then f:DrawString("Beat Lamb = Yes",50,80,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Hush == false then f:DrawString("Beat Hush = No",50,90,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Hush == true then f:DrawString("Beat Hush = Yes",50,90,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.MegaSatan == false then f:DrawString("Beat MegaSatan = No",50,100,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.MegaSatan == true then f:DrawString("Beat MegaSatan = Yes",50,100,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Delirium == false then f:DrawString("Beat Delirium = No",50,110,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Delirium == true then f:DrawString("Beat Delirium = Yes",50,110,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.Mother == false then f:DrawString("Beat Mother = No",50,120,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Mother == true then f:DrawString("Beat Mother = Yes",50,120,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Beast == false then f:DrawString("Beat Beast = No",50,130,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Beast == true then f:DrawString("Beat Beast = Yes",50,130,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.BossRush == false then f:DrawString("Beat BossRush = No",50,140,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.BossRush == true then f:DrawString("Beat BossRush = Yes",50,140,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Greed == false then f:DrawString("Beat Greed = No",50,150,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Greed == true then f:DrawString("Beat Greed = Yes",50,150,KColor(0,250,0,1,0,0,0),0,true) end

  end
    elseif  player:GetPlayerType() == Isaac.GetPlayerTypeByName("Aurii", true) then
    if Input.IsButtonPressed(Keyboard.KEY_V, controller) == true then 
    f:Load("font/pftempestasevencondensed.fnt") 

	f:DrawString("Achievements",50,35,KColor(1,1,1,1,0,0,0),0,true)

	if AuriAchievements.Isaac_ii == false then f:DrawString("Beat Isaac = No",50,50,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Isaac_ii == true then f:DrawString("Beat Isaac = Yes",50,50,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.BlueBaby_ii == false then f:DrawString("Beat ??? = No",50,60,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.BlueBaby_ii == true then f:DrawString("Beat ??? = Yes",50,60,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Satan_ii == false then f:DrawString("Beat Satan = No",50,70,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Satan_ii == true then f:DrawString("Beat Satan = Yes",50,70,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.Lamb_ii == false then f:DrawString("Beat Lamb = No",50,80,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Lamb_ii == true then f:DrawString("Beat Lamb = Yes",50,80,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Hush_ii == false then f:DrawString("Beat Hush = No",50,90,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Hush_ii == true then f:DrawString("Beat Hush = Yes",50,90,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.MegaSatan_ii == false then f:DrawString("Beat MegaSatan = No",50,100,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.MegaSatan_ii == true then f:DrawString("Beat MegaSatan = Yes",50,100,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Delirium_ii == false then f:DrawString("Beat Delirium = No",50,110,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Delirium_ii == true then f:DrawString("Beat Delirium = Yes",50,110,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.Mother_ii == false then f:DrawString("Beat Mother = No",50,120,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Mother_ii == true then f:DrawString("Beat Mother = Yes",50,120,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Beast_ii == false then f:DrawString("Beat Beast = No",50,130,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Beast_ii == true then f:DrawString("Beat Beast = Yes",50,130,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.BossRush_ii == false then f:DrawString("Beat BossRush = No",50,140,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.BossRush_ii == true then f:DrawString("Beat BossRush = Yes",50,140,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Greed_ii == false then f:DrawString("Beat Greed = No",50,150,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Greed_ii == true then f:DrawString("Beat Greed = Yes",50,150,KColor(0,250,0,1,0,0,0),0,true) end
  end
      elseif  player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Auri") then
    if Input.IsButtonPressed(Keyboard.KEY_V, controller) == true then 
    f:Load("font/pftempestasevencondensed.fnt") 

	f:DrawString("Achievements",50,35,KColor(1,1,1,1,0,0,0),0,true)
	if AuriAchievements.Isaac_AuriDs == false then f:DrawString("Beat Isaac = No",50,50,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Isaac_AuriDs == true then f:DrawString("Beat Isaac = Yes",50,50,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.BlueBaby_AuriDs == false then f:DrawString("Beat ??? = No",50,60,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.BlueBaby_AuriDs == true then f:DrawString("Beat ??? = Yes",50,60,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Satan_AuriDs == false then f:DrawString("Beat Satan = No",50,70,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Satan_AuriDs == true then f:DrawString("Beat Satan = Yes",50,70,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.Lamb_AuriDs == false then f:DrawString("Beat Lamb = No",50,80,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Lamb_AuriDs == true then f:DrawString("Beat Lamb = Yes",50,80,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Hush_AuriDs == false then f:DrawString("Beat Hush = No",50,90,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Hush_AuriDs == true then f:DrawString("Beat Hush = Yes",50,90,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.MegaSatan_AuriDs == false then f:DrawString("Beat MegaSatan = No",50,100,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.MegaSatan_AuriDs == true then f:DrawString("Beat MegaSatan = Yes",50,100,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Delirium_AuriDs == false then f:DrawString("Beat Delirium = No",50,110,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Delirium_AuriDs == true then f:DrawString("Beat Delirium = Yes",50,110,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.Mother_AuriDs == false then f:DrawString("Beat Mother = No",50,120,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Mother_AuriDs == true then f:DrawString("Beat Mother = Yes",50,120,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Beast_AuriDs == false then f:DrawString("Beat Beast = No",50,130,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Beast_AuriDs == true then f:DrawString("Beat Beast = Yes",50,130,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.BossRush_AuriDs == false then f:DrawString("Beat BossRush = No",50,140,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.BossRush_AuriDs == true then f:DrawString("Beat BossRush = Yes",50,140,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Greed_AuriDs == false then f:DrawString("Beat Greed = No",50,150,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Greed_AuriDs == true then f:DrawString("Beat Greed = Yes",50,150,KColor(0,250,0,1,0,0,0),0,true) end
  end
     elseif  player:GetPlayerType() == Isaac.GetPlayerTypeByName("Dark Corrupted Auri", true) then
    if Input.IsButtonPressed(Keyboard.KEY_V, controller) == true then 
    f:Load("font/pftempestasevencondensed.fnt") 

	f:DrawString("Achievements",50,35,KColor(1,1,1,1,0,0,0),0,true)
	if AuriAchievements.Isaac_TaintedAuriDs == false then f:DrawString("Beat Isaac = No",50,50,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Isaac_TaintedAuriDs == true then f:DrawString("Beat Isaac = Yes",50,50,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.BlueBaby_TaintedAuriDs == false then f:DrawString("Beat ??? = No",50,60,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.BlueBaby_TaintedAuriDs == true then f:DrawString("Beat ??? = Yes",50,60,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Satan_TaintedAuriDs == false then f:DrawString("Beat Satan = No",50,70,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Satan_TaintedAuriDs == true then f:DrawString("Beat Satan = Yes",50,70,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.Lamb_TaintedAuriDs == false then f:DrawString("Beat Lamb = No",50,80,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Lamb_TaintedAuriDs == true then f:DrawString("Beat Lamb = Yes",50,80,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Hush_TaintedAuriDs == false then f:DrawString("Beat Hush = No",50,90,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Hush_TaintedAuriDs == true then f:DrawString("Beat Hush = Yes",50,90,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.MegaSatan_TaintedAuriDs == false then f:DrawString("Beat MegaSatan = No",50,100,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.MegaSatan_TaintedAuriDs == true then f:DrawString("Beat MegaSatan = Yes",50,100,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Delirium_TaintedAuriDs == false then f:DrawString("Beat Delirium = No",50,110,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Delirium_TaintedAuriDs == true then f:DrawString("Beat Delirium = Yes",50,110,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.Mother_TaintedAuriDs == false then f:DrawString("Beat Mother = No",50,120,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Mother_TaintedAuriDs == true then f:DrawString("Beat Mother = Yes",50,120,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Beast_TaintedAuriDs == false then f:DrawString("Beat Beast = No",50,130,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Beast_TaintedAuriDs == true then f:DrawString("Beat Beast = Yes",50,130,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.BossRush_TaintedAuriDs == false then f:DrawString("Beat BossRush = No",50,140,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.BossRush_TaintedAuriDs == true then f:DrawString("Beat BossRush = Yes",50,140,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Greed_TaintedAuriDs == false then f:DrawString("Beat Greed = No",50,150,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Greed_TaintedAuriDs == true then f:DrawString("Beat Greed = Yes",50,150,KColor(0,250,0,1,0,0,0),0,true) end
  end
       elseif  player:GetPlayerType() == Isaac.GetPlayerTypeByName("Mage Auri") then
    if Input.IsButtonPressed(Keyboard.KEY_V, controller) == true then 
    f:Load("font/pftempestasevencondensed.fnt") 

	f:DrawString("Achievements",50,35,KColor(1,1,1,1,0,0,0),0,true)
	if AuriAchievements.Isaac_MageAuri == false then f:DrawString("Beat Isaac = No",50,50,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Isaac_MageAuri == true then f:DrawString("Beat Isaac = Yes",50,50,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.BlueBaby_MageAuri == false then f:DrawString("Beat ??? = No",50,60,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.BlueBaby_MageAuri == true then f:DrawString("Beat ??? = Yes",50,60,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Satan_MageAuri == false then f:DrawString("Beat Satan = No",50,70,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Satan_MageAuri == true then f:DrawString("Beat Satan = Yes",50,70,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.Lamb_MageAuri == false then f:DrawString("Beat Lamb = No",50,80,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Lamb_MageAuri == true then f:DrawString("Beat Lamb = Yes",50,80,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Hush_MageAuri == false then f:DrawString("Beat Hush = No",50,90,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Hush_MageAuri == true then f:DrawString("Beat Hush = Yes",50,90,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.MegaSatan_MageAuri == false then f:DrawString("Beat MegaSatan = No",50,100,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.MegaSatan_MageAuri == true then f:DrawString("Beat MegaSatan = Yes",50,100,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Delirium_MageAuri == false then f:DrawString("Beat Delirium = No",50,110,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Delirium_MageAuri == true then f:DrawString("Beat Delirium = Yes",50,110,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.Mother_MageAuri == false then f:DrawString("Beat Mother = No",50,120,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Mother_MageAuri == true then f:DrawString("Beat Mother = Yes",50,120,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Beast_MageAuri == false then f:DrawString("Beat Beast = No",50,130,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Beast_MageAuri == true then f:DrawString("Beat Beast = Yes",50,130,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.BossRush_MageAuri == false then f:DrawString("Beat BossRush = No",50,140,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.BossRush_MageAuri == true then f:DrawString("Beat BossRush = Yes",50,140,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Greed_MageAuri == false then f:DrawString("Beat Greed = No",50,150,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Greed_MageAuri == true then f:DrawString("Beat Greed = Yes",50,150,KColor(0,250,0,1,0,0,0),0,true) end
  end
       elseif  player:GetPlayerType() == Isaac.GetPlayerTypeByName("Depressed Auri") then
    if Input.IsButtonPressed(Keyboard.KEY_V, controller) == true then 
    f:Load("font/pftempestasevencondensed.fnt") 

	f:DrawString("Achievements",50,35,KColor(1,1,1,1,0,0,0),0,true)
	if AuriAchievements.Isaac_DepressedAuri == false then f:DrawString("Beat Isaac = No",50,50,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Isaac_DepressedAuri == true then f:DrawString("Beat Isaac = Yes",50,50,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.BlueBaby_DepressedAuri == false then f:DrawString("Beat ??? = No",50,60,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.BlueBaby_DepressedAuri == true then f:DrawString("Beat ??? = Yes",50,60,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Satan_DepressedAuri == false then f:DrawString("Beat Satan = No",50,70,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Satan_DepressedAuri == true then f:DrawString("Beat Satan = Yes",50,70,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.Lamb_DepressedAuri == false then f:DrawString("Beat Lamb = No",50,80,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Lamb_DepressedAuri == true then f:DrawString("Beat Lamb = Yes",50,80,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Hush_DepressedAuri == false then f:DrawString("Beat Hush = No",50,90,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Hush_DepressedAuri == true then f:DrawString("Beat Hush = Yes",50,90,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.MegaSatan_DepressedAuri == false then f:DrawString("Beat MegaSatan = No",50,100,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.MegaSatan_DepressedAuri == true then f:DrawString("Beat MegaSatan = Yes",50,100,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Delirium_DepressedAuri == false then f:DrawString("Beat Delirium = No",50,110,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Delirium_DepressedAuri == true then f:DrawString("Beat Delirium = Yes",50,110,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.Mother_DepressedAuri == false then f:DrawString("Beat Mother = No",50,120,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Mother_DepressedAuri == true then f:DrawString("Beat Mother = Yes",50,120,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Beast_DepressedAuri == false then f:DrawString("Beat Beast = No",50,130,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Beast_DepressedAuri == true then f:DrawString("Beat Beast = Yes",50,130,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.BossRush_DepressedAuri == false then f:DrawString("Beat BossRush = No",50,140,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.BossRush_DepressedAuri == true then f:DrawString("Beat BossRush = Yes",50,140,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Greed_DepressedAuri == false then f:DrawString("Beat Greed = No",50,150,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Greed_DepressedAuri == true then f:DrawString("Beat Greed = Yes",50,150,KColor(0,250,0,1,0,0,0),0,true) end
  end
    elseif  player:GetPlayerType() == Isaac.GetPlayerTypeByName("Milcah") then
    if Input.IsButtonPressed(Keyboard.KEY_V, controller) == true then 
    f:Load("font/pftempestasevencondensed.fnt") 

	f:DrawString("Achievements",50,35,KColor(1,1,1,1,0,0,0),0,true)
	if AuriAchievements.Isaac_DpcAuri == false then f:DrawString("Beat Isaac = No",50,50,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Isaac_DpcAuri == true then f:DrawString("Beat Isaac = Yes",50,50,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.BlueBaby_DpcAuri == false then f:DrawString("Beat ??? = No",50,60,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.BlueBaby_DpcAuri == true then f:DrawString("Beat ??? = Yes",50,60,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Satan_DpcAuri == false then f:DrawString("Beat Satan = No",50,70,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Satan_DpcAuri == true then f:DrawString("Beat Satan = Yes",50,70,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.Lamb_DpcAuri == false then f:DrawString("Beat Lamb = No",50,80,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Lamb_DpcAuri == true then f:DrawString("Beat Lamb = Yes",50,80,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Hush_DpcAuri == false then f:DrawString("Beat Hush = No",50,90,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Hush_DpcAuri == true then f:DrawString("Beat Hush = Yes",50,90,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.MegaSatan_DpcAuri == false then f:DrawString("Beat MegaSatan = No",50,100,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.MegaSatan_DpcAuri == true then f:DrawString("Beat MegaSatan = Yes",50,100,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Delirium_DpcAuri == false then f:DrawString("Beat Delirium = No",50,110,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Delirium_DpcAuri == true then f:DrawString("Beat Delirium = Yes",50,110,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.Mother_DpcAuri == false then f:DrawString("Beat Mother = No",50,120,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Mother_DpcAuri == true then f:DrawString("Beat Mother = Yes",50,120,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Beast_DpcAuri == false then f:DrawString("Beat Beast = No",50,130,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Beast_DpcAuri == true then f:DrawString("Beat Beast = Yes",50,130,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.BossRush_DpcAuri == false then f:DrawString("Beat BossRush = No",50,140,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.BossRush_DpcAuri == true then f:DrawString("Beat BossRush = Yes",50,140,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Greed_DpcAuri == false then f:DrawString("Beat Greed = No",50,150,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Greed_DpcAuri == true then f:DrawString("Beat Greed = Yes",50,150,KColor(0,250,0,1,0,0,0),0,true) end
  end
    elseif  player:GetPlayerType() == Isaac.GetPlayerTypeByName("Azrael") then
    if Input.IsButtonPressed(Keyboard.KEY_V, controller) == true then 
    f:Load("font/pftempestasevencondensed.fnt") 

	f:DrawString("Achievements",50,35,KColor(1,1,1,1,0,0,0),0,true)
	if AuriAchievements.Isaac_Azrael == false then f:DrawString("Beat Isaac = No",50,50,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Isaac_Azrael == true then f:DrawString("Beat Isaac = Yes",50,50,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.BlueBaby_Azrael == false then f:DrawString("Beat ??? = No",50,60,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.BlueBaby_Azrael == true then f:DrawString("Beat ??? = Yes",50,60,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Satan_Azrael == false then f:DrawString("Beat Satan = No",50,70,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Satan_Azrael == true then f:DrawString("Beat Satan = Yes",50,70,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.Lamb_Azrael == false then f:DrawString("Beat Lamb = No",50,80,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Lamb_Azrael == true then f:DrawString("Beat Lamb = Yes",50,80,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Hush_Azrael == false then f:DrawString("Beat Hush = No",50,90,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Hush_Azrael == true then f:DrawString("Beat Hush = Yes",50,90,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.MegaSatan_Azrael == false then f:DrawString("Beat MegaSatan = No",50,100,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.MegaSatan_Azrael == true then f:DrawString("Beat MegaSatan = Yes",50,100,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Delirium_Azrael == false then f:DrawString("Beat Delirium = No",50,110,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Delirium_Azrael == true then f:DrawString("Beat Delirium = Yes",50,110,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.Mother_Azrael == false then f:DrawString("Beat Mother = No",50,120,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Mother_Azrael == true then f:DrawString("Beat Mother = Yes",50,120,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Beast_Azrael == false then f:DrawString("Beat Beast = No",50,130,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Beast_Azrael == true then f:DrawString("Beat Beast = Yes",50,130,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.BossRush_Azrael == false then f:DrawString("Beat BossRush = No",50,140,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.BossRush_Azrael == true then f:DrawString("Beat BossRush = Yes",50,140,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Greed_Azrael == false then f:DrawString("Beat Greed = No",50,150,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Greed_Azrael == true then f:DrawString("Beat Greed = Yes",50,150,KColor(0,250,0,1,0,0,0),0,true) end
  end
 elseif  player:GetPlayerType() == Isaac.GetPlayerTypeByName("Naamah") then
    if Input.IsButtonPressed(Keyboard.KEY_V, controller) == true then 
    f:Load("font/pftempestasevencondensed.fnt") 

	f:DrawString("Achievements",50,35,KColor(1,1,1,1,0,0,0),0,true)
	if AuriAchievements.Isaac_Naamah == false then f:DrawString("Beat Isaac = No",50,50,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Isaac_Naamah == true then f:DrawString("Beat Isaac = Yes",50,50,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.BlueBaby_Naamah == false then f:DrawString("Beat ??? = No",50,60,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.BlueBaby_Naamah == true then f:DrawString("Beat ??? = Yes",50,60,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Satan_Naamah == false then f:DrawString("Beat Satan = No",50,70,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Satan_Naamah == true then f:DrawString("Beat Satan = Yes",50,70,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.Lamb_Naamah == false then f:DrawString("Beat Lamb = No",50,80,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Lamb_Naamah == true then f:DrawString("Beat Lamb = Yes",50,80,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Hush_Naamah == false then f:DrawString("Beat Hush = No",50,90,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Hush_Naamah == true then f:DrawString("Beat Hush = Yes",50,90,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.MegaSatan_Naamah == false then f:DrawString("Beat MegaSatan = No",50,100,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.MegaSatan_Naamah == true then f:DrawString("Beat MegaSatan = Yes",50,100,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Delirium_Naamah == false then f:DrawString("Beat Delirium = No",50,110,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Delirium_Naamah == true then f:DrawString("Beat Delirium = Yes",50,110,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.Mother_Naamah == false then f:DrawString("Beat Mother = No",50,120,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Mother_Naamah == true then f:DrawString("Beat Mother = Yes",50,120,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Beast_Naamah == false then f:DrawString("Beat Beast = No",50,130,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Beast_Naamah == true then f:DrawString("Beat Beast = Yes",50,130,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.BossRush_Naamah == false then f:DrawString("Beat BossRush = No",50,140,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.BossRush_Naamah == true then f:DrawString("Beat BossRush = Yes",50,140,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Greed_Naamah == false then f:DrawString("Beat Greed = No",50,150,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Greed_Naamah == true then f:DrawString("Beat Greed = Yes",50,150,KColor(0,250,0,1,0,0,0),0,true) end
  end
  elseif  player:GetPlayerType() == Isaac.GetPlayerTypeByName("Famish") then
    if Input.IsButtonPressed(Keyboard.KEY_V, controller) == true then 
    f:Load("font/pftempestasevencondensed.fnt") 

	f:DrawString("Achievements",50,35,KColor(1,1,1,1,0,0,0),0,true)
	if AuriAchievements.Isaac_Rotten == false then f:DrawString("Beat Isaac = No",50,50,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Isaac_Rotten == true then f:DrawString("Beat Isaac = Yes",50,50,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.BlueBaby_Rotten == false then f:DrawString("Beat ??? = No",50,60,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.BlueBaby_Rotten == true then f:DrawString("Beat ??? = Yes",50,60,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Satan_Rotten == false then f:DrawString("Beat Satan = No",50,70,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Satan_Rotten == true then f:DrawString("Beat Satan = Yes",50,70,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.Lamb_Rotten == false then f:DrawString("Beat Lamb = No",50,80,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Lamb_Rotten == true then f:DrawString("Beat Lamb = Yes",50,80,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Hush_Rotten == false then f:DrawString("Beat Hush = No",50,90,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Hush_Rotten == true then f:DrawString("Beat Hush = Yes",50,90,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.MegaSatan_Rotten == false then f:DrawString("Beat MegaSatan = No",50,100,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.MegaSatan_Rotten == true then f:DrawString("Beat MegaSatan = Yes",50,100,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Delirium_Rotten == false then f:DrawString("Beat Delirium = No",50,110,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Delirium_Rotten == true then f:DrawString("Beat Delirium = Yes",50,110,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.Mother_Rotten == false then f:DrawString("Beat Mother = No",50,120,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Mother_Rotten == true then f:DrawString("Beat Mother = Yes",50,120,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Beast_Rotten == false then f:DrawString("Beat Beast = No",50,130,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Beast_Rotten == true then f:DrawString("Beat Beast = Yes",50,130,KColor(0,250,0,1,0,0,0),0,true) end
    if AuriAchievements.BossRush_Rotten == false then f:DrawString("Beat BossRush = No",50,140,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.BossRush_Rotten == true then f:DrawString("Beat BossRush = Yes",50,140,KColor(0,250,0,1,0,0,0),0,true) end
	if AuriAchievements.Greed_Rotten == false then f:DrawString("Beat Greed = No",50,150,KColor(255,0,0,1,0,0,0),0,true) end
    if AuriAchievements.Greed_Rotten == true then f:DrawString("Beat Greed = Yes",50,150,KColor(0,250,0,1,0,0,0),0,true) end
  end

  end

end

function completion_marks_na() 
  local player = Isaac.GetPlayer(0)
    if player:GetPlayerType() == Isaac.GetPlayerTypeByName("Auri") then
	Auri_Marks_Check = true
    end
end

COLLECTIBLE_MAGE_STAFF = Isaac.GetItemIdByName("Mage Staff")

AuriiSoulCollect = 0

function toTears(fireDelay)
  return 30 / (fireDelay + 1)
end
function fromTears(tears)
  return math.max((30 / tears) - 1, -0.99)
end
function Auriz:onCache(player, flags)
	local room = game:GetRoom()
        if flags == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage + CorruptHeart
		end

		if flags == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage + Darkpennystack
		end

		if flags == CacheFlag.CACHE_DAMAGE then
		   if player:HasCollectible(COLLECTIBLE_CALM_MIND) then
	          player.Damage = player.Damage + AuriAchievements.CalmmindDmg
	       end
	   end

	    if flags == CacheFlag.CACHE_LUCK then
            player.Luck = player.Luck + AuriAchievements.Enchantpennystack
        end

		if player:HasCollectible(COLLECTIBLE_MAGE_HAT) then
		if flags == CacheFlag.CACHE_LUCK then 

            player.Luck = player.Luck + 5 *
			player:GetCollectibleNum(COLLECTIBLE_MAGE_HAT)
        end
		end

	     if player:HasCollectible(COLLECTIBLE_MAGE_ROBE) then
        if flags == CacheFlag.CACHE_LUCK then 
		player.Luck = player.Luck + 1 *
		player:GetCollectibleNum(COLLECTIBLE_MAGE_ROBE)
		end
		end

		  if player:HasCollectible(COLLECTIBLE_MAGE_ROBE) then

		if flags == CacheFlag.CACHE_DAMAGE then 
		player.Damage = player.Damage + player.Luck / 2
		end
    end

	    if (flags == CacheFlag.CACHE_FIREDELAY) then

			player.MaxFireDelay = fromTears(toTears(player.MaxFireDelay) + BloodyHour)
			end 
       if flags == CacheFlag.CACHE_SPEED then
            player.MoveSpeed = player.MoveSpeed + BloodyHaste 

    end 

	if flags == CacheFlag.CACHE_DAMAGE then
		if player:HasCollectible(COLLECTIBLE_DYING) and DyingActive then
	   player.Damage = player.Damage * 1.5 + 3
	   end
	   end

	 if (flags == CacheFlag.CACHE_FIREDELAY) then 
	    if player:HasCollectible(COLLECTIBLE_DYING) and DyingActive and (player:GetName() ~= "Milcah") then

			player.MaxFireDelay = fromTears(toTears(player.MaxFireDelay) * 1.5)
	end
	end

	 if (flags == CacheFlag.CACHE_FIREDELAY) then 
	    if player:HasCollectible(COLLECTIBLE_DYING) and DyingActive and player:GetPlayerType() == Isaac.GetPlayerTypeByName("Milcah") then

			player.MaxFireDelay = fromTears(toTears(player.MaxFireDelay) * 2.5)
			player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_PACT, true)
	end
	end

	if (flags == CacheFlag.CACHE_SPEED) then 
	    if player:HasCollectible(COLLECTIBLE_DYING) and DyingActive and player:GetPlayerType() == Isaac.GetPlayerTypeByName("Milcah") 
		or player:HasCollectible(COLLECTIBLE_DYING) and DyingActive and (player:GetName() == "Queen Auri")
		then
			player.MoveSpeed = player.MoveSpeed + 0.9
	end
	end 

	if player:HasTrinket(TrinketType.TRINKET_GLOWING_ORB) then
        if flags == CacheFlag.CACHE_LUCK then 
		player.Luck = player.Luck + 3 * player:GetTrinketMultiplier(TrinketType.TRINKET_GLOWING_ORB)
		end
	end

	if player:HasCollectible(COLLECTIBLE_WITCHS_BROOM) then
		if flags == CacheFlag.CACHE_LUCK then 
            player.Luck = player.Luck + 3 *
			player:GetCollectibleNum(COLLECTIBLE_WITCHS_BROOM)
        end
	end

	if player:HasCollectible(COLLECTIBLE_WITCHS_BROOM) then
		if flags == CacheFlag.CACHE_SPEED then 
            player.MoveSpeed = player.MoveSpeed + 0.1 *
			player:GetCollectibleNum(COLLECTIBLE_WITCHS_BROOM)
        end
	end

	if player:HasCollectible(COLLECTIBLE_WITCHS_BROOM) then
		 if flags == CacheFlag.CACHE_FLYING then
            player.CanFly = true
        end
	end

	if Aurimodcartridgeboost then
	    if flags == CacheFlag.CACHE_SPEED then
            player.MoveSpeed = player.MoveSpeed + 0.5 * player:GetTrinketMultiplier(TrinketType.TRINKET_MODED_CARTRIDGE)
        end
	end

	if flags == CacheFlag.CACHE_RANGE then
	if player:HasCollectible(COLLECTIBLE_DARK_PRINCESS_CROWN) then
			player.TearRange = player.TearRange + 60
	   end
	end
	if flags == CacheFlag.CACHE_FIREDELAY then
	if player:HasCollectible(COLLECTIBLE_DARK_PRINCESS_CROWN) then
			player.MaxFireDelay = fromTears(toTears(player.MaxFireDelay) + 2) 
	   end
	end
	if flags == CacheFlag.CACHE_SHOTSPEED then
	if player:HasCollectible(COLLECTIBLE_DARK_PRINCESS_CROWN) then
			player.ShotSpeed = player.ShotSpeed + 0.20
	   end
	end

	if flags == CacheFlag.CACHE_LUCK then
		player.Luck = player.Luck + AuriiSoulCollect
		player.Luck = player.Luck + AuriAchievements.EnchantedBookLuck 
    end

	if player:HasCollectible(COLLECTIBLE_MAGE_STAFF) then
		if flags & CacheFlag.CACHE_LUCK ~= 0 then 
            player.Luck = player.Luck * 2 *
			player:GetCollectibleNum(COLLECTIBLE_MAGE_STAFF)
        end
	end

	if flags & CacheFlag.CACHE_DAMAGE ~= 0 then
	    if player:HasCollectible(COLLECTIBLE_MAGE_STAFF) then
	       player.Damage = player.Damage + 0.5 *
			player:GetCollectibleNum(COLLECTIBLE_MAGE_STAFF)
	    end
	end

	if player:HasCollectible(COLLECTIBLE_MAGE_STAFF) then
	    if flags & CacheFlag.CACHE_SHOTSPEED ~= 0 then
            player.ShotSpeed = player.ShotSpeed - 0.2 *
			player:GetCollectibleNum(COLLECTIBLE_MAGE_STAFF)
        end
	end

	if (flags & CacheFlag.CACHE_FIREDELAY) ~= 0 then 
	    if player:HasCollectible(COLLECTIBLE_MAGE_STAFF) then

		   player.MaxFireDelay = fromTears(toTears(player.MaxFireDelay) + 0.2 
		   * player:GetCollectibleNum(COLLECTIBLE_MAGE_STAFF) )
	    end
	end

	if flags & CacheFlag.CACHE_RANGE ~= 0 then
	    if player:HasCollectible(COLLECTIBLE_MAGE_STAFF) then
		   player.TearRange = player.TearRange + 50 *
			player:GetCollectibleNum(COLLECTIBLE_MAGE_STAFF)
	    end
	end

	if player:HasCollectible(COLLECTIBLE_WITCHS_SOUP) then
		if flags == CacheFlag.CACHE_LUCK then 

            player.Luck = player.Luck + AuriAchievements.witchsoupluck *
			player:GetCollectibleNum(COLLECTIBLE_WITCHS_SOUP)
        end
	end  

end

Auriz:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Auriz.onCache)

include("aurimod.aurimod_eid")