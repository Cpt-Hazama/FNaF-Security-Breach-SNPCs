ENT.Base 			= "npc_vj_creature_base"
ENT.Type 			= "ai"
ENT.PrintName 		= ""
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose 		= "Spawn it and fight with it!"
ENT.Instructions 	= "Click on the spawnicon to spawn it."
ENT.Category		= ""

include("vj_base/addons/fnaf_music.lua")

function ENT:SetupDataTables()
	self:NetworkVar("Int",0,"Mouth")
end

if CLIENT then
    function ENT:CustomOnDraw()
        self.Mouth = Lerp(FrameTime() *30,self.Mouth or 0,self:GetMouth())
        self:ManipulateBoneAngles(self:LookupBone("Jaw_jnt"),Angle(self.Mouth *0.2,0,0))
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
if CLIENT then
	net.Receive("VJ_FNAF_BurnTrap_Damage",function(len)
		local self = net.ReadEntity()
		local ent = net.ReadEntity()
		local hookName = "VJ_FNAF_BurnTrap_Damage_" .. ent:EntIndex()

        if LocalPlayer() != ent then return end
        
        ent.VJ_FNaF_HackScreenT = CurTime() +2
        ent.VJ_FNaF_HackScreenSND = ent.VJ_FNaF_HackScreenSND or CreateSound(ent,"player/heartbeat1.wav")
        ent.VJ_FNaF_HackScreenSND:Play()
        ent.VJ_FNaF_HackScreenSND2 = ent.VJ_FNaF_HackScreenSND2 or CreateSound(ent,"cpthazama/fnafsb/burntrap/fx/sfx_burntrap_hackFreddy_lp.wav")
        ent.VJ_FNaF_HackScreenSND2:Play()

        -- surface.PlaySound("cpthazama/fnafsb/burntrap/fx/sfx_burntrap_hackFreddy_activate_0" .. math.random(1,3) .. ".wav")

        hook.Add("RenderScreenspaceEffects",hookName,function()
            if LocalPlayer() != ent then return end
            if !IsValid(ent) or IsValid(ent) && (CurTime() > ent.VJ_FNaF_HackScreenT) then
                if IsValid(ent) then ent.VJ_FNaF_HackScreenSND:Stop() end
                if IsValid(ent) then ent.VJ_FNaF_HackScreenSND2:Stop() end
                surface.PlaySound("cpthazama/fnafsb/burntrap/fx/sfx_burntrap_hackFreddy_complete_end.wav")
                hook.Remove("RenderScreenspaceEffects",hookName)
                return
            end
            local tab = {
                ["$pp_colour_addr"] = 0.7,
                ["$pp_colour_addg"] = 0,
                ["$pp_colour_addb"] = 1,
                ["$pp_colour_brightness"] = -0.4,
                ["$pp_colour_contrast"] = 5,
                ["$pp_colour_colour"] = 0.6,
                ["$pp_colour_mulr"] = 0,
                ["$pp_colour_mulg"] = 0,
                ["$pp_colour_mulb"] = 0
            }
            DrawColorModify(tab)
            DrawMaterialOverlay("effects/gas_overlay",0.25)
        end)
	end)
end

if CLIENT then
    local hookAnim = "Burntrap"
    local eyeMat = Material("hud/fnaf/char/HUD_Purple.png")

	net.Receive("VJ_FNaF_" .. hookAnim .. "_Controller",function(len,pl)
		local delete = net.ReadBool()
		local ent = net.ReadEntity()
		local class = net.ReadString()
		local ply = net.ReadEntity()
		local cent = net.ReadEntity()

		if !IsValid(ent) then delete = true end

        local hookName = "VJ_FNaF_" .. hookAnim .. "_HUD_" .. ent:EntIndex()

        if !delete then
            hook.Add("RenderScreenspaceEffects",hookName,function()
                if !IsValid(ent) then
                    hook.Remove("RenderScreenspaceEffects",hookName)
                    return
                end
                surface.SetDrawColor(255,255,255)
                surface.SetMaterial(eyeMat)
                surface.DrawTexturedRect(0,0,ScrW(),ScrH() *0.65)
            end)
		else
            hook.Remove("RenderScreenspaceEffects",hookName)
        end
    end)
end