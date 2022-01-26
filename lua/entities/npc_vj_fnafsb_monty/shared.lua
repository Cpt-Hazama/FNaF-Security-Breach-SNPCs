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
ENT.VJ_FNaF_CamProtection = true
ENT.VJ_FNaF_CanBeAlertSummoned = true

function ENT:SetupDataTables()
	self:NetworkVar("Int",0,"Mouth")
end

if CLIENT then
    function ENT:CustomOnDraw()
        self.Mouth = Lerp(FrameTime() *30,self.Mouth or 0,self:GetMouth())
        self:ManipulateBoneAngles(self:LookupBone("Jaw_jnt"),Angle(self.Mouth *0.2,0,0))
    end
end

if CLIENT then
	net.Receive("VJ_FNaF_Monty_Controller",function(len,pl)
		local delete = net.ReadBool()
		local ent = net.ReadEntity()
		local class = net.ReadString()
		local ply = net.ReadEntity()
		local cent = net.ReadEntity()

		if !IsValid(ent) then delete = true end

        local hookName = "VJ_FNaF_Monty_HUD_" .. ent:EntIndex()

        if !delete then
            hook.Add("RenderScreenspaceEffects",hookName,function()
                if !IsValid(ent) then
                    hook.Remove("RenderScreenspaceEffects",hookName)
                    return
                end
                surface.SetDrawColor(255,255,255)
                surface.SetMaterial(Material("hud/fnaf/char/HUD_Monty.png"))
                surface.DrawTexturedRect(0,0,ScrW(),ScrH() *0.65)
            end)
		else
            hook.Remove("RenderScreenspaceEffects",hookName)
        end
    end)
end