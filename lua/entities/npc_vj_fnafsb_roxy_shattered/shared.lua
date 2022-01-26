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

if CLIENT then
	net.Receive("VJ_FNaF_Roxy_Shattered_Controller",function(len,pl)
		local delete = net.ReadBool()
		local ent = net.ReadEntity()
		local class = net.ReadString()
		local ply = net.ReadEntity()
		local cent = net.ReadEntity()

		if !IsValid(ent) then delete = true end

        local hookRSE = "VJ_FNaF_ShatteredRoxy_RenderScreenspaceEffects_" .. ent:EntIndex()
        local hookPDH = "VJ_FNaF_ShatteredRoxy_PreDrawHalos_" .. ent:EntIndex()

        if !delete then
			hook.Add("RenderScreenspaceEffects",hookRSE,function()
                if !IsValid(ent) then
                    hook.Remove("RenderScreenspaceEffects",hookRSE)
                    return
                end

				local light = DynamicLight(ent:EntIndex())
				if (light) then
					light.Pos = ent:GetPos() +ent:OBBCenter()
					light.r = 255
					light.g = 255
					light.b = 255
					light.Brightness = 16
					light.Size = 300
					light.NoModel = true
					light.Decay = 0
					light.DieTime = CurTime() +0.05
					light.Style = 0
				end

				local tab = {
					["$pp_colour_addr"] = 0,
					["$pp_colour_addg"] = 0,
					["$pp_colour_addb"] = 0,
					["$pp_colour_brightness"] = -0.6,
					["$pp_colour_contrast"] = 0.1,
					["$pp_colour_colour"] = 0,
					["$pp_colour_mulr"] = 0,
					["$pp_colour_mulg"] = 0,
					["$pp_colour_mulb"] = 0
				}
				DrawColorModify(tab)

                surface.SetDrawColor(255,255,255,80)
                surface.SetMaterial(Material("hud/fnaf/static_vanny"))
                surface.DrawTexturedRect(0,0,ScrW(),ScrH())
			end)

			-- hook.Add("PreDrawHalos",hookPDH,function()
			-- 	local tbEnemies = {}
			-- 	local tbClear = tbClear or {}
			-- 	local lPly = LocalPlayer()
			-- 	if lPly != ply then return end
            --     if !IsValid(ent) then
            --         hook.Remove("PreDrawHalos",hookPDH)
			-- 		for _,v in pairs(tbClear) do
			-- 			if IsValid(v) && v:GetNoDraw() == true then
			-- 				v:SetNoDraw(false)
			-- 			end
			-- 		end
            --         return
            --     end

			-- 	local col = Color(255,255,255,255)
			-- 	for _,v in pairs(ents.GetAll()) do
			-- 		if !v:IsNPC() && !v:IsPlayer() then continue end
			-- 		if v == ent then continue end
			-- 		if v == ply then continue end
			-- 		local invT = v:GetNW2Int("VJ_FNaF_InvestigateT") or 0
			-- 		local shouldBeSeen = !(invT > CurTime())
			-- 		v:SetNoDraw(shouldBeSeen)
			-- 		table.insert(tbClear,v)
			-- 		local wep = v:GetActiveWeapon()
			-- 		if IsValid(wep) then
			-- 			wep:SetNoDraw(shouldBeSeen)
			-- 			table.insert(tbClear,wep)
			-- 			if shouldBeSeen then
			-- 				table.insert(tbEnemies,wep)
			-- 			end
			-- 		end
			-- 		if shouldBeSeen then
			-- 			table.insert(tbEnemies,v)
			-- 		end
			-- 	end
			-- 	halo.Add(tbEnemies,col,4,4,3,true,true)
			-- end)

			hook.Add("PreDrawHalos",hookPDH,function()
				local tbEnemies = {}
				local tbClear = tbClear or {}
				local lPly = LocalPlayer()
				if lPly != ply then return end
                if !IsValid(ent) then
                    hook.Remove("PreDrawHalos",hookPDH)
					-- if lPly != ply then
						-- for _,v in pairs(tbClear) do
							-- if IsValid(v) then
								-- v:SetNoDraw(false)
					-- 		end
					-- 	end
					-- end
                    return
                end

                local col = Color(255,255,255,255)
				for _,v in pairs(ents.GetAll()) do
                    local invT = v:GetNW2Int("VJ_FNaF_InvestigateT",0)
                    if v == ent then continue end
                    -- if v:IsNPC() or v:IsPlayer() then
                        -- v:SetNoDraw(true)
						-- if !VJ_HasValue(tbClear,v) then
						-- 	table.insert(tbClear,v)
						-- end
                    -- end
                    if invT == 0 then continue end
					if CurTime() < invT && !VJ_HasValue(tbEnemies,v) then
                        -- if v:IsNPC() or v:IsPlayer() then
                            -- v:SetNoDraw(false)
                        -- end
                        table.insert(tbEnemies,v)
					end
				end
				halo.Add(tbEnemies,col,5,5,3,true,true)
			end)
		else
            hook.Remove("RenderScreenspaceEffects",hookRSE)
            hook.Remove("PreDrawHalos",hookPDH)
        end
    end)
end