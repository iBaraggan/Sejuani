if GetObjectName(myHero) ~= "MonkeyKing" then return end

function AutoUpdate(data)
    if tonumber(data) > tonumber(ver) then
        PrintChat("New version found! " .. data)
        PrintChat("Downloading update, please wait...")
        DownloadFileAsync("https://raw.githubusercontent.com/iBaraggan/Sejuani/master/wukong.lua", SCRIPT_PATH .. "Wukong.lua", function() PrintChat("Update Complete, please 2x F6!") return end)
    else
        PrintChat("No updates found!")
    end
end

require('OpenPredict')

print("SejuaniTopper // By:ekkekk")

local WukongMenu = Menu("Macaco", "Macaco")

  WukongMenu:Menu("Combo", "Combo")
  WukongMenu.Combo:Boolean("useQ", "Use Q", true)
  WukongMenu.Combo:Boolean("useE", "Use E", true)
  WukongMenu.Combo:Boolean("useR", "Use R", true)
  WukongMenu.Combo:Boolean("useHydra", "Use Ravenous Hydra", true)
  WukongMenu.Combo:Boolean("useTiamat", "Use Tiamat", true)
  WukongMenu.Combo:Boolean("useTitanic", "Use Titanic Hydra", true)

OnTick(function()

    if IOW:Mode() == "Combo" then

    if WukongMenu.Combo.EQW:Value() then
      
      if WukongMenu.Combo.E:Value() and Ready(_E) and ValidTarget(target, ERange) then
        CastTargetSpell(target, _E)
      end

      if WukongMenu.Combo.Q:Value() and Ready(_Q) and ValidTarget(target, QRange) then
        CastSpell(_Q)
        if ValidTarget(target, QRange) then
          AttackUnit(target)
        end
      end

      if WukongMenu.Combo.W:Value() and Ready(_W) and ValidTarget(target, WRange) then
        CastSpell(_W)
      end
    end

    
    if WukongMenu.Combo.EWQ:Value() then
      
      if WukongMenu.Combo.E:Value() and Ready(_E) and ValidTarget(target, ERange) then
        CastTargetSpell(target, _E)
      end

      if WukongMenu.Combo.W:Value() and Ready(_W) and ValidTarget(target, WRange) then
        CastSpell(_W)
      end

      if WukongMenu.Combo.Q:Value() and Ready(_Q) and ValidTarget(target, QRange) then
        CastSpell(_Q)
        if ValidTarget(target, QRange) then
          AttackUnit(target)
        end
      end
    end

    if WukongMenu.Combo.R:Value() and Ready(_R) and ValidTarget(target, RRange) then
      CastSpell(_R)
    end

  end
  
WukongMenu:SubMenu("SkinChanger", "SkinChanger")
  skinMeta = {["WukongMenu"] = {"Classic", "Volcanic", "General", "Jade Dragon", "Underworld", "Radiant"}}
  WukongMenu.SkinChanger:DropDown('skin', myHero.charName.. " Skins", 1, skinMeta[myHero.charName],function(model)
        HeroSkinChanger(myHero, model - 1) print(skinMeta[myHero.charName][model] .." ".. myHero.charName .. " Loaded!") 
    end,
true)
  print("Wukong feito por mim")
