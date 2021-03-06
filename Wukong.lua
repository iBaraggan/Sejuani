if GetObjectName(myHero) ~= "Wukong" then return end

require('OpenPredict')

print("SejuaniTopper // By:ekkekk")

local WukongMenu = Menu("SejuaniTopper", "SejuaniTopper")

  WukongMenu:Menu("Combo", "Combo")
  WukongMenu.Combo:Boolean("useQ", "Use Q", true)
  WukongMenu.Combo:Boolean("useE", "Use E", true)
  WukongMenu.Combo:Boolean("useR", "Use R", true)
  WukongMenu.Combo:Boolean("useHydra", "Use Ravenous Hydra", true)
  WukongMenu.Combo:Boolean("useTiamat", "Use Tiamat", true)
  WukongMenu.Combo:Boolean("useTitanic", "Use Titanic Hydra", true)

OnTick(function()

    if IOW:Mode() == "Combo" then
       
        local target = GetCurrentTarget() 
       
        if ValidTarget(target,GetRange(myHero) + GetHitBox(target)) and CanUseSpell(myHero,_Q) == READY and WukongMenu.Combo.useQ:Value() then
          CastTargetSpell(target,_Q) 
        end
        
        if ValidTarget(target,GetRange(myHero) + GetHitBox(target)) and CanUseSpell(myHero,_W) == READY and WukongMenu.Combo.useW:Value() then
          CastSpell(_W)
        end
        
        if ValidTarget(target,GetRange(myHero) + GetHitBox(target)) and CanUseSpell(myHero,_E) == READY and WukongMenu.Combo.useE:Value() then
          CastTargetSpell(target,_E)
        end
        
        if ValidTarget(target,GetRange(myHero) + GetHitBox(target)) and CanUseSpell(myHero,_R) == READY and WukongMenu.Combo.useR:Value() then
          CastSpell(_R)
        end

         if GetItemSlot(myHero, 3077) > 0 and IsReady(GetItemSlot(myHero, 3077)) and WukongMenu.Combo.useTiamat:Value() then
       CastSpell(GetItemSlot(myHero, 3077))
      end
      if GetItemSlot(myHero, 3074) > 0 and IsReady(GetItemSlot(myHero, 3074)) and WukongMenu.Combo.useHydra:Value() then
       CastSpell(GetItemSlot(myHero, 3074))
      end
    if GetItemSlot(myHero, 3748) > 0 and IsReady(GetItemSlot(myHero, 3748)) and WukongMenu.Combo.useTitanic:Value() then
       CastSpell(GetItemSlot(myHero, 3748))
      end 
    end
end)
  
WukongMenu:SubMenu("SkinChanger", "SkinChanger")
  skinMeta = {["WukongMenu"] = {"Classic", "Volcanic", "General", "Jade Dragon", "Underworld", "Radiant"}}
  WukongMenu.SkinChanger:DropDown('skin', myHero.charName.. " Skins", 1, skinMeta[myHero.charName],function(model)
        HeroSkinChanger(myHero, model - 1) print(skinMeta[myHero.charName][model] .." ".. myHero.charName .. " Loaded!") 
    end,
true)

