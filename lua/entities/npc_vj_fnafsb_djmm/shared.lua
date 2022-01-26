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
        local function GetDJMMs()
            local djmms = {}
            for _,v in pairs(ents.FindByClass("npc_vj_fnafsb_djmm")) do
                if IsValid(v) then
                    table.insert(djmms,v)
                end
            end
            return djmms
        end

        local hookName = "VJ_FNaF_DJMMMusic"
        hook.Add("Think",hookName,function()
            local djmms = GetDJMMs()
            local ply = LocalPlayer()
            if #djmms <= 0 then
                ply.VJ_FNaF_DJMM_Threshold = 0
                hook.Remove("Think",hookName)
                return
            end
            local djmm = NULL
            local closestDist = 999999999
            for _,v in pairs(djmms) do
                local dist = v:GetPos():Distance(ply:GetPos())
                if dist < closestDist then
                    djmm = v
                    closestDist = dist
                end
            end
            if !IsValid(djmm) then ply.VJ_FNaF_DJMM_Threshold = 0 return end
            local FT = FrameTime() *3
            local dist = ply:GetPos():Distance(djmm:GetPos())
            local enemy = djmm:GetNW2Entity("Enemy")

            ply.VJ_FNaF_DJMM_Threshold = ply.VJ_FNaF_DJMM_Threshold or 0
            ply.VJ_FNaF_DJMM_SongChangeT = ply.VJ_FNaF_DJMM_SongChangeT or 0
            ply.VJ_FNaF_DJMM_T1 = ply.VJ_FNaF_DJMM_T1 or CreateSound(ply, "cpthazama/fnafsb/djmm/fx/theme1.wav")
            ply.VJ_FNaF_DJMM_T2 = ply.VJ_FNaF_DJMM_T2 or CreateSound(ply, "cpthazama/fnafsb/djmm/fx/theme2.wav")
            ply.VJ_FNaF_DJMM_T3 = ply.VJ_FNaF_DJMM_T3 or CreateSound(ply, "cpthazama/fnafsb/djmm/fx/theme3.wav")
            ply.VJ_FNaF_DJMM_T4 = ply.VJ_FNaF_DJMM_T4 or CreateSound(ply, "cpthazama/fnafsb/djmm/fx/theme4.wav")
            ply.VJ_FNaF_DJMM_T5 = ply.VJ_FNaF_DJMM_T5 or CreateSound(ply, "cpthazama/fnafsb/djmm/fx/theme5.wav")
            ply.VJ_FNaF_DJMM_T6 = ply.VJ_FNaF_DJMM_T6 or CreateSound(ply, "cpthazama/fnafsb/djmm/fx/theme6.wav")

            if dist <= 10000 && GetConVarNumber("ai_ignoreplayers") == 0 then
                if dist > 6200 then
                    djmm:PlaySound(ply,1)
                    ply.VJ_FNaF_DJMM_Threshold = Lerp(FT,ply.VJ_FNaF_DJMM_Threshold,1)
                elseif dist <= 6200 && dist > 5600 then
                    djmm:PlaySound(ply,2)
                    ply.VJ_FNaF_DJMM_Threshold = Lerp(FT,ply.VJ_FNaF_DJMM_Threshold,2)
                elseif dist <= 5600 && dist > 5000 then
                    djmm:PlaySound(ply,3)
                    ply.VJ_FNaF_DJMM_Threshold = Lerp(FT,ply.VJ_FNaF_DJMM_Threshold,3)
                elseif dist <= 5000 && dist > 4000 then
                    djmm:PlaySound(ply,4)
                    ply.VJ_FNaF_DJMM_Threshold = Lerp(FT,ply.VJ_FNaF_DJMM_Threshold,4)
                elseif dist <= 4000 && dist > 2000 then
                    djmm:PlaySound(ply,5)
                    ply.VJ_FNaF_DJMM_Threshold = Lerp(FT,ply.VJ_FNaF_DJMM_Threshold,5)
                elseif dist <= 2000 then
                    djmm:PlaySound(ply,6)
                    ply.VJ_FNaF_DJMM_Threshold = Lerp(FT,ply.VJ_FNaF_DJMM_Threshold,6)
                end
            else
                djmm:StopSounds(ply)
                ply.VJ_FNaF_DJMM_Threshold = 0
                ply.VJ_FNaF_DJMM_SongChangeT = 0
            end
        end)
    end
    ---------------------------------------------------------------------------------------------------------------------------------------------
    function ENT:PlaySound(ply,v)
        if CurTime() < ply.VJ_FNaF_DJMM_SongChangeT then return end
        if v == 1 then
            ply.VJ_FNaF_DJMM_T1:Play()
            ply.VJ_FNaF_DJMM_T2:Stop()
            ply.VJ_FNaF_DJMM_T3:Stop()
            ply.VJ_FNaF_DJMM_T4:Stop()
            ply.VJ_FNaF_DJMM_T5:Stop()
            ply.VJ_FNaF_DJMM_T6:Stop()
        elseif v == 2 then
            ply.VJ_FNaF_DJMM_T1:Stop()
            ply.VJ_FNaF_DJMM_T2:Play()
            ply.VJ_FNaF_DJMM_T3:Stop()
            ply.VJ_FNaF_DJMM_T4:Stop()
            ply.VJ_FNaF_DJMM_T5:Stop()
            ply.VJ_FNaF_DJMM_T6:Stop()
        elseif v == 3 then
            ply.VJ_FNaF_DJMM_T1:Stop()
            ply.VJ_FNaF_DJMM_T2:Stop()
            ply.VJ_FNaF_DJMM_T3:Play()
            ply.VJ_FNaF_DJMM_T4:Stop()
            ply.VJ_FNaF_DJMM_T5:Stop()
            ply.VJ_FNaF_DJMM_T6:Stop()
        elseif v == 4 then
            ply.VJ_FNaF_DJMM_T1:Stop()
            ply.VJ_FNaF_DJMM_T2:Stop()
            ply.VJ_FNaF_DJMM_T3:Stop()
            ply.VJ_FNaF_DJMM_T4:Play()
            ply.VJ_FNaF_DJMM_T5:Stop()
            ply.VJ_FNaF_DJMM_T6:Stop()
        elseif v == 5 then
            ply.VJ_FNaF_DJMM_T1:Stop()
            ply.VJ_FNaF_DJMM_T2:Stop()
            ply.VJ_FNaF_DJMM_T3:Stop()
            ply.VJ_FNaF_DJMM_T4:Stop()
            ply.VJ_FNaF_DJMM_T5:Play()
            ply.VJ_FNaF_DJMM_T6:Stop()
        elseif v == 6 then
            ply.VJ_FNaF_DJMM_T1:Stop()
            ply.VJ_FNaF_DJMM_T2:Stop()
            ply.VJ_FNaF_DJMM_T3:Stop()
            ply.VJ_FNaF_DJMM_T4:Stop()
            ply.VJ_FNaF_DJMM_T5:Stop()
            ply.VJ_FNaF_DJMM_T6:Play()
        end
        ply.VJ_FNaF_DJMM_SongChangeT = CurTime() +(SoundDuration("cpthazama/fnafsb/djmm/fx/theme" .. v .. ".wav") *0.5) -- Dev note: For some reason, the tracks are double the length of what they really need to be, so dividing by half will always return a perfect drop-off point for the next track to play
    end
    ---------------------------------------------------------------------------------------------------------------------------------------------
    function ENT:StopSounds(ply)
        if ply.VJ_FNaF_DJMM_T1 then ply.VJ_FNaF_DJMM_T1:Stop() end
        if ply.VJ_FNaF_DJMM_T2 then ply.VJ_FNaF_DJMM_T2:Stop() end
        if ply.VJ_FNaF_DJMM_T3 then ply.VJ_FNaF_DJMM_T3:Stop() end
        if ply.VJ_FNaF_DJMM_T4 then ply.VJ_FNaF_DJMM_T4:Stop() end
        if ply.VJ_FNaF_DJMM_T5 then ply.VJ_FNaF_DJMM_T5:Stop() end
        if ply.VJ_FNaF_DJMM_T6 then ply.VJ_FNaF_DJMM_T6:Stop() end
        ply.VJ_FNaF_DJMM_SongChangeT = 0
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