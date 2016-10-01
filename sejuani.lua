if GetObjectName(myHero) ~= "Sejuani" then return end

require('OpenPredict')

print("SejuaniNation // By:Vikk")

local SejuaniMenu = Menu("SejuaniMenu", "SejuaniMenu")

SejuaniMenu:Menu("Combo", "Combo")
SejuaniMenu.Combo:Boolean("useQ", "Use Q", true)
SejuaniMenu.Combo:Boolean("useW", "Use W", true)
SejuaniMenu.Combo:Boolean("useE", "Use E", true)
SejuaniMenu.Combo:Boolean("useR", "Use R", true)

--Spells
local SejuaniQ = { range = 650}
lucal SejuaniE = { range = 1000}
local SejuaniR = { range = 1175, speed = 1350}

--Start
OnTick(function(myHero)
    if not IsDead(myHero) then
        local target = GetCurrentTarget()

        --Combo
        if IOW:Mode() == "Combo" then
            --E
            if SejuaniMenu.Combo.useQ:Value(), GetRange(myHero) + GetHitBox(target)) then
                CastSpell(_Q)
            end

            if SejuaniMenu.Combo.useW:Value(), GetRange(myHero) + GetHitBox(target)) then
                CastSpell(_W)
            end

            if SejuaniMenu.Combo.useE:Value(), GetRange(myHero) + GetHitBox(target)) then
                CastSpell(_E)
            end

            if SejuaniMenu.Combo.useR:Value(), GetRange(myHero) + GetHitBox(target)) then
                CastSpell(_R)
            end 
        end
    end
end)

SejuaniMenu:SubMenu("s", "Skin Changer")
  skinMeta = {["Sejuani"] = {"Classic", "Sabretusk", "Darkrider", "Traditional", "Bear Cavalry", "Poro Rider", "Beast Hunter"}}
  SejuaniMenu.s:DropDown('skin', myHero.charName.. " Skins", 1, skinMeta[myHero.charName],function(model)
        HeroSkinChanger(myHero, model - 1) print(skinMeta[myHero.charName][model] .." ".. myHero.charName .. " Loaded!") 
    end,
true)