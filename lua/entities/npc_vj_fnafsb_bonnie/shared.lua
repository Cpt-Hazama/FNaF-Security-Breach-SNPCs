ENT.Base 			= "npc_vj_creature_base"
ENT.Type 			= "ai"
ENT.PrintName 		= ""
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose 		= "Spawn it and fight with it!"
ENT.Instructions 	= "Click on the spawnicon to spawn it."
ENT.Category		= ""

include("vj_base/addons/fnaf_music.lua")

ENT.VJ_FNaF_CanBeStunned = true
ENT.VJ_FNaF_CanBeAlertSummoned = true

if CLIENT then
	net.Receive("VJ_FNaF_Bonnie_Controller",function(len,pl)
		local delete = net.ReadBool()
		local ent = net.ReadEntity()
		local class = net.ReadString()
		local ply = net.ReadEntity()
		local cent = net.ReadEntity()

		if !IsValid(ent) then delete = true end

        local hookName = "VJ_FNaF_Bonnie_HUD_" .. ent:EntIndex()

        if !delete then
            hook.Add("RenderScreenspaceEffects",hookName,function()
                if !IsValid(ent) then
                    hook.Remove("RenderScreenspaceEffects",hookName)
                    return
                end
                surface.SetDrawColor(255,255,255)
                surface.SetMaterial(Material("hud/fnaf/char/HUD_Bonnie.png"))
                surface.DrawTexturedRect(0,0,ScrW(),ScrH() *0.65)
            end)
		else
            hook.Remove("RenderScreenspaceEffects",hookName)
        end
    end)
end