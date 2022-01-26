ENT.Base 			= "npc_vj_creature_base"
ENT.Type 			= "ai"
ENT.PrintName 		= ""
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose 		= "Spawn it and fight with it!"
ENT.Instructions 	= "Click on the spawnicon to spawn it."
ENT.Category		= ""
---------------------------------------------------------------------------------------------------------------------------------------------
if CLIENT then
    ---------------------------------------------------------------------------------------------------------------------------------------------
    function ENT:Initialize()
        local function GetVannys()
            local vannys = {}
            for _,v in pairs(ents.FindByClass("npc_vj_fnafsb_vanny")) do
                if IsValid(v) then
                    table.insert(vannys,v)
                end
            end
            return vannys
        end

        local hookName = "VJ_FNaF_VannyMusic"
        hook.Add("Think",hookName,function()
            local vannys = GetVannys()
            local ply = LocalPlayer()
            if #vannys <= 0 then
                ply.VJ_FNaF_Vanny_Threshold = 0
                hook.Remove("Think",hookName)
                return
            end
            local vanny = NULL
            local closestDist = 999999999
            for _,v in pairs(vannys) do
                local dist = v:GetPos():Distance(ply:GetPos())
                if dist < closestDist then
                    vanny = v
                    closestDist = dist
                end
            end
            if !IsValid(vanny) then ply.VJ_FNaF_Vanny_Threshold = 0 return end
            local FT = FrameTime() *3
            local dist = ply:GetPos():Distance(vanny:GetPos())
            local enemy = vanny:GetNW2Entity("Enemy")

            hook.Add("RenderScreenspaceEffects",hookName,function()
                if !IsValid(ply) or (IsValid(ply) && (ply:Health() <= 0)) or !IsValid(vanny) then
                    hook.Remove("RenderScreenspaceEffects",hookName)
                    return
                end

                ply.VJ_FNaF_Vanny_Threshold = ply.VJ_FNaF_Vanny_Threshold or 0
                local threshold = ply.VJ_FNaF_Vanny_Threshold or 0
                if !ply:Alive() or (ply.IsControlingNPC && ply.VJCE_NPC == vanny) then return end
                if threshold == 0 then return end
                local tab = {
                    ["$pp_colour_addr"] = 0.4,
                    ["$pp_colour_addg"] = 0.1,
                    ["$pp_colour_addb"] = 0,
                    ["$pp_colour_brightness"] = -0.4,
                    ["$pp_colour_contrast"] = 2,
                    ["$pp_colour_colour"] = 0.6,
                    ["$pp_colour_mulr"] = 0,
                    ["$pp_colour_mulg"] = 0,
                    ["$pp_colour_mulb"] = 0
                }
                tab["$pp_colour_addr"] = 0.4 *(threshold *0.5)
                tab["$pp_colour_addg"] = 0.375 *(threshold *0.5)
                tab["$pp_colour_mulr"] = 0.5 *threshold
                tab["$pp_colour_contrast"] = 2 *threshold
                DrawColorModify(tab)
                DrawMotionBlur(0.1,0.3 *threshold,0.01)
                DrawBloom(-0.2 *threshold,1.5 *threshold,4 *threshold,4 *threshold,threshold,threshold,tab["$pp_colour_addr"] *0.2,0,0)
                DrawMaterialOverlay("effects/invuln_overlay_red2",-threshold *10)
                local visThreshold = 1 -(dist /2000)
                surface.SetDrawColor(255,102,0,visThreshold *255)
                surface.SetMaterial(Material("hud/fnaf/static_vanny"))
                surface.DrawTexturedRect(0,0,ScrW() *(visThreshold *20),ScrH() *(visThreshold *20))
            end)

            ply.VJ_FNaF_Vanny_Threshold = ply.VJ_FNaF_Vanny_Threshold or 0
            ply.VJ_FNaF_Vanny_MusicT = ply.VJ_FNaF_Vanny_MusicT or 0
            ply.VJ_FNaF_Vanny_Chase = ply.VJ_FNaF_Vanny_Chase or CreateSound(ply, "cpthazama/fnafsb/vanessa/fx_vanny/Vanny_Chase_Layer2.wav")
            ply.VJ_FNaF_Vanny_BassLow = ply.VJ_FNaF_Vanny_BassLow or CreateSound(ply, "cpthazama/fnafsb/vanessa/fx_vanny/Vanny_Encounter_Bass_LO.wav")
            ply.VJ_FNaF_Vanny_Bass = ply.VJ_FNaF_Vanny_Bass or CreateSound(ply, "cpthazama/fnafsb/vanessa/fx_vanny/Vanny_Encounter_Bass.wav")
            ply.VJ_FNaF_Vanny_Percussion = ply.VJ_FNaF_Vanny_Percussion or CreateSound(ply, "cpthazama/fnafsb/vanessa/fx_vanny/Vanny_Encounter_Percussion.wav")

            if dist <= 2000 && GetConVarNumber("ai_ignoreplayers") == 0 && !(ply.IsControlingNPC && ply.VJCE_NPC == vanny) then
                local extraAdd = math.random(12,20)
                if dist > 1200 then
                    ply.VJ_FNaF_Vanny_BassLow:Play()
                    ply.VJ_FNaF_Vanny_Bass:Stop()
                    ply.VJ_FNaF_Vanny_Threshold = Lerp(FT,ply.VJ_FNaF_Vanny_Threshold,1)
                else
                    ply.VJ_FNaF_Vanny_BassLow:Stop()
                    ply.VJ_FNaF_Vanny_Bass:Play()
                    extraAdd = math.random(8,14)
                end
                if dist < 800 then
                    ply.VJ_FNaF_Vanny_Percussion:Play()
                    ply.VJ_FNaF_Vanny_Threshold = Lerp(FT,ply.VJ_FNaF_Vanny_Threshold,2)
                    extraAdd = math.random(6,12)
                else
                    ply.VJ_FNaF_Vanny_Percussion:Stop()
                end
                if dist < 600 && enemy == ply then
                    ply.VJ_FNaF_Vanny_Chase:Play()
                    ply.VJ_FNaF_Vanny_Threshold = Lerp(FT,ply.VJ_FNaF_Vanny_Threshold,3)
                    extraAdd = math.random(4,8)
                else
                    ply.VJ_FNaF_Vanny_Chase:Stop()
                end
                if CurTime() > ply.VJ_FNaF_Vanny_MusicT then
                    local snd = "cpthazama/fnafsb/vanessa/fx_vanny/Vanny_MusicBox_0"..math.random(1,8)..".wav"
                    surface.PlaySound(snd)
                    ply.VJ_FNaF_Vanny_MusicT = CurTime() +SoundDuration(snd) +extraAdd
                end
            else
                vanny:StopSounds(ply)
                ply.VJ_FNaF_Vanny_Threshold = 0
            end
        end)
    end
    ---------------------------------------------------------------------------------------------------------------------------------------------
    function ENT:StopSounds(ply)
        if ply.VJ_FNaF_Vanny_Chase then ply.VJ_FNaF_Vanny_Chase:Stop() end
        if ply.VJ_FNaF_Vanny_BassLow then ply.VJ_FNaF_Vanny_BassLow:Stop() end
        if ply.VJ_FNaF_Vanny_Bass then ply.VJ_FNaF_Vanny_Bass:Stop() end
        if ply.VJ_FNaF_Vanny_Percussion then ply.VJ_FNaF_Vanny_Percussion:Stop() end
    end
    ---------------------------------------------------------------------------------------------------------------------------------------------
    function ENT:OnRemove()
        local canStop = true
        for _,v in pairs(ents.FindByClass(self:GetClass())) do
            if IsValid(v) && v != self then
                canStop = false
                break
            end
        end
        if canStop then
            for _,ply in pairs(player.GetAll()) do
                self:StopSounds(ply)
            end
        end
    end
end