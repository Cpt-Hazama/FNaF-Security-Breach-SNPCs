ENT.Base 			= "npc_vj_creature_base"
ENT.Type 			= "ai"
ENT.PrintName 		= ""
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose 		= "Spawn it and fight with it!"
ENT.Instructions 	= "Click on the spawnicon to spawn it."
ENT.Category		= ""

include("vj_base/addons/fnaf_music.lua")

if CLIENT then
    local eyeMat2 = Material("hud/fnaf/star_overlay")
    local eyeMat3 = Material("hud/fnaf/star_overlay2")

    function ENT:CustomOnDraw()
        local pos,ang = self:GetBonePosition(11)
        local tr = util.TraceLine({
            start = pos,
            endpos = pos +Vector(0,0,32000),
            filter = self
        })
        local adjustment = tr.HitPos:Distance(pos)
        self:SetPoseParameter("rope",adjustment)
        -- self:ManipulateBonePosition(93,Vector(0,adjustment,0))
        -- self:ManipulateBonePosition(94,Vector(0,-adjustment,0))
    end

    function ENT:OnInit()
        local function GetMoons()
            local moons = {}
            for _,v in pairs(ents.FindByClass("npc_vj_fnafsb_moondrop*")) do
                if IsValid(v) then
                    table.insert(moons,v)
                end
            end
            return moons
        end

        local hookName = "VJ_FNaF_MoonFX"
        hook.Add("Think",hookName,function()
            local moons = GetMoons()
            local ply = LocalPlayer()
            if #moons <= 0 then
                hook.Remove("Think",hookName)
                return
            end
            local moon = NULL
            local closestDist = 999999999
            for _,v in pairs(moons) do
                local dist = v:GetPos():Distance(ply:GetPos())
                if dist < closestDist then
                    moon = v
                    closestDist = dist
                end
            end
            if !IsValid(moon) then ply.VJ_FNaF_Moon_Threshold = 0 return end
            local FT = FrameTime() *3
            local dist = ply:GetPos():Distance(moon:GetPos())
            local isMoon = moon:GetNW2Int("SunMode") == 1

            hook.Add("RenderScreenspaceEffects",hookName,function()
                if !IsValid(ply) or (IsValid(ply) && (ply:Health() <= 0)) or !IsValid(moon) then
                    hook.Remove("RenderScreenspaceEffects",hookName)
                    return
                end

                ply.VJ_FNaF_Moon_Threshold = ply.VJ_FNaF_Moon_Threshold or 0
                ply.VJ_FNaF_Moon_Stinger = ply.VJ_FNaF_Moon_Stinger or 0
                ply.VJ_FNaF_Moon_Last = ply.VJ_FNaF_Moon_Last or NULL
                local threshold = ply.VJ_FNaF_Moon_Threshold or 0
                if !ply:Alive() or (ply.IsControlingNPC && ply.VJCE_NPC == moon) then return end
                if threshold == 0 then return end
                if !isMoon then return end

                local tab = {
                    ["$pp_colour_addr"] = 0,
                    ["$pp_colour_addg"] = 0,
                    ["$pp_colour_addb"] = 0,
                    ["$pp_colour_brightness"] = -0.4,
                    ["$pp_colour_contrast"] = 1,
                    ["$pp_colour_colour"] = 0.6,
                    ["$pp_colour_mulr"] = 0,
                    ["$pp_colour_mulg"] = 0,
                    ["$pp_colour_mulb"] = 0
                }
                tab["$pp_colour_addr"] = 0.3 *threshold
                tab["$pp_colour_addg"] = 0.15 *threshold
                tab["$pp_colour_addb"] = 0.92 *threshold
                tab["$pp_colour_brightness"] = -0.7 *threshold
				DrawColorModify(tab)
                
                surface.SetDrawColor(255,255,255)
                surface.SetMaterial(eyeMat3)
                surface.DrawTexturedRect(0,0,ScrW(),ScrH())
                surface.SetDrawColor(255,255,255)
                surface.SetMaterial(eyeMat2)
                surface.DrawTexturedRect(0,0,ScrW(),ScrH())
            end)

            ply.VJ_FNaF_Moon_Threshold = ply.VJ_FNaF_Moon_Threshold or 0

            if dist <= 5000 && isMoon && GetConVarNumber("ai_ignoreplayers") == 0 && !ply:IsFrozen() && !(ply.IsControlingNPC && ply.VJCE_NPC == moon) then
                ply.VJ_FNaF_Moon_Threshold = Lerp(FT,ply.VJ_FNaF_Moon_Threshold,1 -(dist /5000))
                if CurTime() > (ply.VJ_FNaF_Moon_Stinger or 0) && ply.VJ_FNaF_Moon_Last != moon then
                    ply.VJ_FNaF_Moon_Last = moon
                    surface.PlaySound("cpthazama/fnafsb/sfx_moonman_sting_hourly.wav")
                    ply.VJ_FNaF_Moon_Stinger = CurTime() +30
                end
            else
                ply.VJ_FNaF_Moon_Threshold = 0
            end
        end)
    end
end

if CLIENT then
    local hookAnim = "Moon"
    local eyeMat = Material("hud/fnaf/char/HUD_Generic.png")

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

                local isMoon = ent:GetNW2Int("SunMode") == 1

                local tab = {
                    ["$pp_colour_addr"] = 0,
                    ["$pp_colour_addg"] = 0,
                    ["$pp_colour_addb"] = 0,
                    ["$pp_colour_brightness"] = -0.4,
                    ["$pp_colour_contrast"] = 1,
                    ["$pp_colour_colour"] = 0.6,
                    ["$pp_colour_mulr"] = 0,
                    ["$pp_colour_mulg"] = 0,
                    ["$pp_colour_mulb"] = 0
                }
                tab["$pp_colour_addr"] = isMoon && 0.3 or 1
                tab["$pp_colour_addg"] = isMoon && 0.15 or 0.5
                tab["$pp_colour_addb"] = isMoon && 0.92 or 0
				DrawColorModify(tab)

                if isMoon then
                    surface.SetDrawColor(77,43,226)
                else
                    surface.SetDrawColor(255,187,0)
                end
                surface.SetMaterial(eyeMat)
                surface.DrawTexturedRect(0,0,ScrW(),ScrH() *0.65)
            end)
		else
            hook.Remove("RenderScreenspaceEffects",hookName)
        end
    end)
end