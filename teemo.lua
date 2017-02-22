if GetObjectName(myHero) ~= "Teemo" then return end

local TeemoMenu = Menu("hiihii eoq", "Teemo")
TeemoMenu:Menu("Combo","Combo")
TeemoMenu.Combo:Boolean("useQ", "Use Q", true)
TeemoMenu.Combo:Boolean("useW", "Use W", true)
TeemoMenu.Combo:Slider("manaQ", "Minimo de mana para usar o Q",  30, 0, 100)
TeemoMenu.Combo:Boolean("useR", "Minimo de mana para usar o R", true)
TeemoMenu.Combo:Slider("manaR", "Mana R",  45, 0, 100)
TeemoMenu.Combo:Slider("minCharg", "Minimo de carga antes de usar", 2 1 3)

TeemoMenu:Menu("Harass", "Harass")
TeemoMenu.Harass:Boolean("useQ", "Use Q", true)
TeemoMenu.Harass:Slider("manaQ", "Minimo de mana para usar o Q",  30, 0, 100)

TeemoMenu:SubMenu('LastHit', 'Last Hit')
TeemoMenu.LastHit:Boolean('useQ', 'Use Q', true)
TeemoMenu.LastHit:Slider('manaQ', 'Minimo de mana para usar o Q', 60, 0, 100)

TeemoMenu:SubMenu('LaneClear', 'Lane Clear')
TeemoMenu.LaneClear:Boolean('useQ', 'Use Q', true)
TeemoMenu.LaneClear:Boolean('useR', 'Use R', true)
TeemoMenu.LaneClear:Slider('manaQ', 'Minimo de mana para usar o Q', 60, 0, 100)
TeemoMenu.LaneClear:Slider('manaR', 'Minimo de mana para usar o R', 60, 0, 100)
TeemoMenu.LaneClear:Slider('minCharg', 'Minimo de carga antes de usar', 2, 1, 3)

TeemoMenu:SubMenu('SkinChanger', 'Skin Changer')
TeemoMenu.SkinChanger:DropDown('skin', localplayer.charName.. " Skins", 1, Skins[localplayer.charName], function(model) HeroSkinChanger(localplayer, model - 1) end, true)

TeemoMenu:SubMenu('Pred', 'HitChance')
TeemoMenu.Pred:Slider('HitChanceR', 'HitChance R', 60, 0, 100)

local teemoR = {delay = 1.25, range = 900, radius = 250, speed = 1200}

if getdmg("Q", unit) >= unit.health then
    thedmg = unit.health - 1
    text = "KILLABLE FROM Q!"
  else
    thedmg = getdmg("Q", unit)
    text = "Damage from Q"
  end

  thedmg = math.round(thedmg)

  function CastR(unit)
	local predictR = GetCircularAOEPrediction(unit, TeemoR)
	if predictR.hitChance >= (K7M.Pred.HitchanceR:Value() * 0.01) then
		CastSkillShot(_R, predictR.castPos)
	end
end

function AutoLvl()
	LvLE = {_E,_Q,_W,_E,_E,_R,_E,_Q,_E,_Q,_R,_Q,_Q,_W,_W,_R,_W,_W}
	LvLQ = {_Q,_E,_W,_Q,_Q,_R,_Q,_E,_Q,_E,_R,_E,_E,_W,_W,_R,_W,_W}

	if K7M.LvL.AutoLvL:Value() and GetLevelPoints(localplayer) > 0 then

		if K7M.LvL.MaxE:Value() and not K7M.LvL.MaxQ:Value() then
			LevelSpell(LvLE[GetLevel(localplayer)-GetLevelPoints(localplayer)+1])
		end

		if K7M.LvL.MaxQ:Value() and not K7M.LvL.MaxE:Value() then
			LevelSpell(LvLQ[GetLevel(localplayer)-GetLevelPoints(localplayer)+1])
		end
	end
end

function LaneClear()
	if Mix:Mode() == "LaneClear" then
		for _, minion in pairs(minionManager.objects) do
			if GetTeam(minion) == MINION_JUNGLE then
				local iCount = GetSpellData(localplayer, _R).ammo
				if K7M.JungleClear.useQ:Value() and Ready(_Q) and ValidTarget(minion, 680) and K7M.JungleClear.manaQ:Value() < GetPercentMP(localplayer) then
					CastTargetSpell(minion, _Q)
				end
				if K7M.JungleClear.useR:Value() and Ready(_R) and ValidTarget(minion, (250+ 150*GetCastLevel(localplayer,_R))) and K7M.JungleClear.chargeR:Value() <= iCount and K7M.JungleClear.manaR:Value() < GetPercentMP(localplayer) then
					CastR(minion)
				end
			end

			if GetTeam(minion) ~= MINION_ALLY then
				if K7M.LaneClear.useQ:Value() and Ready(_Q) and ValidTarget(minion, 680) and K7M.LaneClear.manaQ:Value() < GetPercentMP(localplayer) then
					CastTargetSpell(minion, _Q)
				end
			end
		end
	end
end

function LastHitQ()
	if Mix:Mode() == "LastHit" then
	  	if Ready(_Q) and K7M.LastHit.useQ:Value() then 
	  		if K7M.LastHit.manaQ:Value() <= GetPercentMP(localplayer) then
	  		for _, minion in pairs(minionManager.objects) do
	  			if IsObjectAlive(minion) and GetTeam(minion) ~= MINION_ALLY and GetDistance(minion) <= 680 and GetCurrentHP(minion) < getdmg("Q", minion) then
	  				CastTargetSpell(minion, _Q)
	  			end
	  		end
	  	end
	  end
	end
end

function Harass()
	if Mix:Mode() == "Harass" then
		if K7M.Harass.useQ:Value() and Ready(_Q) and ValidTarget(entitytarget, 680) then
			CastTargetSpell(entitytarget, _Q)
			IOW:ResetAA()
		end
	end
end

function Combo()
	if Mix:Mode() == "Combo" then
		if K7M.Combo.useQ:Value() and Ready(_Q) and ValidTarget(entitytarget, 680) then
			CastTargetSpell(entitytarget, _Q)
			IOW:ResetAA()
		end

		if K7M.Combo.useW:Value() and Ready(_W) and ValidTarget(entitytarget, 710) then
			CastSpell(_W)
		end

		local iCount = GetSpellData(localplayer, _R).ammo

		if K7M.Combo.useR:Value() and Ready(_R) and ValidTarget(entitytarget, (250 + 150 * GetCastLevel(localplayer,_R))) and K7M.Combo.chargeR:Value() <= iCount and K7M.Combo.manaR:Value() <= GetPercentMP(localplayer) then
			CastR(entitytarget)
		end
	end
end

	OnTick(function(localplayer)
		
		Combo()

		Harass()

		LastHitQ()

		LaneClear()

		AutoLvl()