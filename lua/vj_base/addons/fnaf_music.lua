ENT.VJ_FNaF_UniqueAnimatronic = true

if CLIENT then
    ---------------------------------------------------------------------------------------------------------------------------------------------
    function ENT:Initialize()
        if self.OnInit then
            self:OnInit()
        end

        local function GetAnimatronics()
            local animatronics = {}
            for _,v in pairs(ents.FindByClass("npc_vj_fnafsb*")) do
                if IsValid(v) && v.VJ_FNaF_UniqueAnimatronic then
                    table.insert(animatronics,v)
                end
            end
            return animatronics
        end

        local hookName = "VJ_FNaF_AnimatronicMusic_" .. self:EntIndex()
        hook.Add("Think",hookName,function()
            local animatronics = GetAnimatronics()
            local ply = LocalPlayer()
            if #animatronics <= 0 then
                ply.VJ_FNaF_Enemy_Threshold = 0
                ply.VJ_FNaF_TensionAmount = 0
                hook.Remove("Think",hookName)
                return
            end
            local animatronic = NULL
            local closestDist = 999999999
            for _,v in pairs(animatronics) do
                local dist = v:GetPos():Distance(ply:GetPos())
                if dist < closestDist then
                    animatronic = v
                    closestDist = dist
                end
            end
            if !IsValid(animatronic) then ply.VJ_FNaF_Enemy_Threshold = 0 return end
            local FT = FrameTime() *3
            local dist = ply:GetPos():Distance(animatronic:GetPos())
            local enemy = animatronic:GetNW2Entity("Enemy")
            local sunMode = animatronic:GetNW2Int("SunMode",-1)
            local sunEnt = animatronic:GetNW2Entity("SunEntity")

            ply.VJ_FNaF_Animatronic_CurrentTensionSet = ply.VJ_FNaF_Animatronic_CurrentTensionSet or math.random(1,3)
            ply.VJ_FNaF_Animatronic_NextSongSwitchT = ply.VJ_FNaF_Animatronic_NextSongSwitchT or 0
            ply.VJ_FNaF_Enemy_Threshold = ply.VJ_FNaF_Enemy_Threshold or 0
            ply.VJ_FNaF_Animatronic_Tension1_1 = ply.VJ_FNaF_Animatronic_Tension1_1 or CreateSound(ply, "cpthazama/fnafsb/FNAF_SB_tension1_int1_lp.wav")
            ply.VJ_FNaF_Animatronic_Tension1_2 = ply.VJ_FNaF_Animatronic_Tension1_2 or CreateSound(ply, "cpthazama/fnafsb/FNAF_SB_tension1_int2_lp.wav")
            ply.VJ_FNaF_Animatronic_Tension1_3 = ply.VJ_FNaF_Animatronic_Tension1_3 or CreateSound(ply, "cpthazama/fnafsb/FNAF_SB_tension1_int3_lp.wav")
            ply.VJ_FNaF_Animatronic_Tension2_1 = ply.VJ_FNaF_Animatronic_Tension2_1 or CreateSound(ply, "cpthazama/fnafsb/FNAF_SB_tension2_int1_lp.wav")
            ply.VJ_FNaF_Animatronic_Tension2_2 = ply.VJ_FNaF_Animatronic_Tension2_2 or CreateSound(ply, "cpthazama/fnafsb/FNAF_SB_tension2_int2_lp.wav")
            ply.VJ_FNaF_Animatronic_Tension2_3 = ply.VJ_FNaF_Animatronic_Tension2_3 or CreateSound(ply, "cpthazama/fnafsb/FNAF_SB_tension2_int3_lp.wav")
            ply.VJ_FNaF_Animatronic_Tension3_1 = ply.VJ_FNaF_Animatronic_Tension3_1 or CreateSound(ply, "cpthazama/fnafsb/FNAF_SB_tension3_int1_lp.wav")
            ply.VJ_FNaF_Animatronic_Tension3_2 = ply.VJ_FNaF_Animatronic_Tension3_2 or CreateSound(ply, "cpthazama/fnafsb/FNAF_SB_tension3_int2_lp.wav")
            ply.VJ_FNaF_Animatronic_Tension3_3 = ply.VJ_FNaF_Animatronic_Tension3_3 or CreateSound(ply, "cpthazama/fnafsb/FNAF_SB_tension3_int3_lp.wav")
            ply.VJ_FNaF_Animatronic_Daycare = ply.VJ_FNaF_Animatronic_Daycare or CreateSound(ply, "cpthazama/fnafsb/daycare.wav")

            if sunMode != nil && sunMode == 0 then
                if sunEnt == ply then
                    ply.VJ_FNaF_Animatronic_Daycare:Play()
                    ply.VJ_FNaF_Animatronic_Daycare:ChangeVolume(1 *(GetConVar("vj_fnaf_tension_vol"):GetInt() *0.01))
                else
                    animatronic:StopSounds(ply)
                end
            else
                if dist <= 2500 && GetConVarNumber("ai_ignoreplayers") == 0 && !ply:IsFrozen() && ply:Alive() && !ply.IsControlingNPC && GetConVar("vj_fnaf_tension"):GetInt() == 1 then
                    local vol = (1 -math.Clamp(dist /2500,0,1))
                    local tension = vol
                    vol = vol *(GetConVar("vj_fnaf_tension_vol"):GetInt() *0.01)
                    ply.VJ_FNaF_Animatronic_Tension1_1:ChangeVolume(vol)
                    ply.VJ_FNaF_Animatronic_Tension1_2:ChangeVolume(vol)
                    ply.VJ_FNaF_Animatronic_Tension1_3:ChangeVolume(vol)
                    ply.VJ_FNaF_Animatronic_Tension2_1:ChangeVolume(vol)
                    ply.VJ_FNaF_Animatronic_Tension2_2:ChangeVolume(vol)
                    ply.VJ_FNaF_Animatronic_Tension2_3:ChangeVolume(vol)
                    ply.VJ_FNaF_Animatronic_Tension3_1:ChangeVolume(vol)
                    ply.VJ_FNaF_Animatronic_Tension3_2:ChangeVolume(vol)
                    ply.VJ_FNaF_Animatronic_Tension3_3:ChangeVolume(vol)
                    if dist > 1000 then
                        animatronic:PlaySound(ply,3)
                         ply.VJ_FNaF_TensionAmount = 0
                        ply.VJ_FNaF_Enemy_Threshold = Lerp(FT,ply.VJ_FNaF_Enemy_Threshold,1)
                    elseif dist <= 1000 && dist > 300 then
                        animatronic:PlaySound(ply,2)
                         ply.VJ_FNaF_TensionAmount = tension *0.185
                        ply.VJ_FNaF_Enemy_Threshold = Lerp(FT,ply.VJ_FNaF_Enemy_Threshold,2)
                    elseif dist <= 300 then
                        animatronic:PlaySound(ply,1)
                        ply.VJ_FNaF_TensionAmount = tension *0.55
                        ply.VJ_FNaF_Enemy_Threshold = Lerp(FT,ply.VJ_FNaF_Enemy_Threshold,3)
                    end
                else
                    animatronic:StopSounds(ply)
                    ply.VJ_FNaF_TensionAmount = 0
                    ply.VJ_FNaF_Enemy_Threshold = 0
                    ply.VJ_FNaF_Animatronic_NextSongSwitchT = 0
                    ply.VJ_FNaF_Animatronic_CurrentTensionSet = math.random(1,3)
                end
            end
        end)
    end
    ---------------------------------------------------------------------------------------------------------------------------------------------
    function ENT:PlaySound(ply,v)
        if CurTime() < ply.VJ_FNaF_Animatronic_NextSongSwitchT then return end
        local set = ply.VJ_FNaF_Animatronic_CurrentTensionSet
        if v == 1 then
            ply.VJ_FNaF_Animatronic_Tension2_1:Stop()
            ply.VJ_FNaF_Animatronic_Tension2_2:Stop()
            ply.VJ_FNaF_Animatronic_Tension2_3:Stop()
            ply.VJ_FNaF_Animatronic_Tension3_1:Stop()
            ply.VJ_FNaF_Animatronic_Tension3_2:Stop()
            ply.VJ_FNaF_Animatronic_Tension3_3:Stop()
            if set == 1 then
                ply.VJ_FNaF_Animatronic_Tension1_1:Play()
                ply.VJ_FNaF_Animatronic_Tension1_2:Stop()
                ply.VJ_FNaF_Animatronic_Tension1_3:Stop()
            elseif set == 2 then
                ply.VJ_FNaF_Animatronic_Tension1_1:Stop()
                ply.VJ_FNaF_Animatronic_Tension1_2:Play()
                ply.VJ_FNaF_Animatronic_Tension1_3:Stop()
            elseif set == 3 then
                ply.VJ_FNaF_Animatronic_Tension1_1:Stop()
                ply.VJ_FNaF_Animatronic_Tension1_2:Stop()
                ply.VJ_FNaF_Animatronic_Tension1_3:Play()
            end
        elseif v == 2 then
            ply.VJ_FNaF_Animatronic_Tension1_1:Stop()
            ply.VJ_FNaF_Animatronic_Tension1_2:Stop()
            ply.VJ_FNaF_Animatronic_Tension1_3:Stop()
            ply.VJ_FNaF_Animatronic_Tension3_1:Stop()
            ply.VJ_FNaF_Animatronic_Tension3_2:Stop()
            ply.VJ_FNaF_Animatronic_Tension3_3:Stop()
            if set == 1 then
                ply.VJ_FNaF_Animatronic_Tension2_1:Play()
                ply.VJ_FNaF_Animatronic_Tension2_2:Stop()
                ply.VJ_FNaF_Animatronic_Tension2_3:Stop()
            elseif set == 2 then
                ply.VJ_FNaF_Animatronic_Tension2_1:Stop()
                ply.VJ_FNaF_Animatronic_Tension2_2:Play()
                ply.VJ_FNaF_Animatronic_Tension2_3:Stop()
            elseif set == 3 then
                ply.VJ_FNaF_Animatronic_Tension2_1:Stop()
                ply.VJ_FNaF_Animatronic_Tension2_2:Stop()
                ply.VJ_FNaF_Animatronic_Tension2_3:Play()
            end
        elseif v == 3 then
            ply.VJ_FNaF_Animatronic_Tension1_1:Stop()
            ply.VJ_FNaF_Animatronic_Tension1_2:Stop()
            ply.VJ_FNaF_Animatronic_Tension1_3:Stop()
            ply.VJ_FNaF_Animatronic_Tension2_1:Stop()
            ply.VJ_FNaF_Animatronic_Tension2_2:Stop()
            ply.VJ_FNaF_Animatronic_Tension2_3:Stop()
            if set == 1 then
                ply.VJ_FNaF_Animatronic_Tension3_1:Play()
                ply.VJ_FNaF_Animatronic_Tension3_2:Stop()
                ply.VJ_FNaF_Animatronic_Tension3_3:Stop()
            elseif set == 2 then
                ply.VJ_FNaF_Animatronic_Tension3_1:Stop()
                ply.VJ_FNaF_Animatronic_Tension3_2:Play()
                ply.VJ_FNaF_Animatronic_Tension3_3:Stop()
            elseif set == 3 then
                ply.VJ_FNaF_Animatronic_Tension3_1:Stop()
                ply.VJ_FNaF_Animatronic_Tension3_2:Stop()
                ply.VJ_FNaF_Animatronic_Tension3_3:Play()
            end
        end
        ply.VJ_FNaF_Animatronic_Daycare:Stop()
        ply.VJ_FNaF_Animatronic_NextSongSwitchT = CurTime() +1.5
    end
    ---------------------------------------------------------------------------------------------------------------------------------------------
    function ENT:StopSounds(ply)
        if ply.VJ_FNaF_Animatronic_Tension1_1 then ply.VJ_FNaF_Animatronic_Tension1_1:Stop() end
        if ply.VJ_FNaF_Animatronic_Tension1_2 then ply.VJ_FNaF_Animatronic_Tension1_2:Stop() end
        if ply.VJ_FNaF_Animatronic_Tension1_3 then ply.VJ_FNaF_Animatronic_Tension1_3:Stop() end

        if ply.VJ_FNaF_Animatronic_Tension2_1 then ply.VJ_FNaF_Animatronic_Tension2_1:Stop() end
        if ply.VJ_FNaF_Animatronic_Tension2_2 then ply.VJ_FNaF_Animatronic_Tension2_2:Stop() end
        if ply.VJ_FNaF_Animatronic_Tension2_3 then ply.VJ_FNaF_Animatronic_Tension2_3:Stop() end

        if ply.VJ_FNaF_Animatronic_Tension3_1 then ply.VJ_FNaF_Animatronic_Tension3_1:Stop() end
        if ply.VJ_FNaF_Animatronic_Tension3_2 then ply.VJ_FNaF_Animatronic_Tension3_2:Stop() end
        if ply.VJ_FNaF_Animatronic_Tension3_3 then ply.VJ_FNaF_Animatronic_Tension3_3:Stop() end

        if ply.VJ_FNaF_Animatronic_Daycare then ply.VJ_FNaF_Animatronic_Daycare:Stop() end
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