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
	net.Receive("VJ_FNaF_Roxy_Controller",function(len,pl)
		local delete = net.ReadBool()
		local ent = net.ReadEntity()
		local class = net.ReadString()
		local ply = net.ReadEntity()
		local cent = net.ReadEntity()

		if !IsValid(ent) then delete = true end

        local hookName = "VJ_FNaF_Roxy_HUD_" .. ent:EntIndex()
        local hookPDH = "VJ_FNaF_Roxy_PreDrawHalos_" .. ent:EntIndex()

        if !delete then
            ply.FNaF_RoxyViewLoop = CreateSound(ply,"cpthazama/fnafsb/common/sfx_roxyEyes_hud_lp.wav")
            ply.FNaF_RoxyViewLoop:Play()
            ply.FNaF_RoxyViewLoop:ChangeVolume(0.4)

			hook.Add("PreDrawHalos",hookPDH,function()
                if !IsValid(ent) then
                    hook.Remove("PreDrawHalos",hookPDH)
                    return
                end

				local tbEnemies = {}
                local col = Color(212,0,255)
				for _,v in pairs(ents.GetAll()) do
                    if v == ent then continue end
                    if (v:IsNPC() && v:GetClass() != "obj_vj_bullseye" or v:IsPlayer()) && !v:IsFlagSet(FL_NOTARGET) then
                        table.insert(tbEnemies,v)
                    end
				end
				halo.Add(tbEnemies,col,4,4,3,true,true)
			end)

            hook.Add("RenderScreenspaceEffects",hookName,function()
                if !IsValid(ent) then
                    hook.Remove("RenderScreenspaceEffects",hookName)
                    return
                end
                surface.SetDrawColor(255,255,255)
                surface.SetMaterial(Material("hud/fnaf/char/HUD_Roxy.png"))
                surface.DrawTexturedRect(0,0,ScrW(),ScrH() *0.65)

                -- if ply.VJC_Camera_Mode == 2 then
                --     local start = ply:GetPos() +ply:EyeAngles():Forward() *800
                --     local bone = ent:LookupBone("Head_Jnt")
                --     ent:ManipulateBoneAngles(bone,(start -ent:GetBonePosition(bone)):Angle())
                -- end
            end)
		else
            hook.Remove("PreDrawHalos",hookPDH)
            hook.Remove("RenderScreenspaceEffects",hookName)
            -- if ent then ent:ManipulateBoneAngles(ent:LookupBone("Head_Jnt"),Angle(0,0,0)) end
            if ply then ply.FNaF_RoxyViewLoop:Stop() end
        end
    end)
end