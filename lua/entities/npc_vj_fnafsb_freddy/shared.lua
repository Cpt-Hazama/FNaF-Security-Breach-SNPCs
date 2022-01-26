ENT.Base 			= "npc_vj_creature_base"
ENT.Type 			= "ai"
ENT.PrintName 		= ""
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose 		= "Spawn it and fight with it!"
ENT.Instructions 	= "Click on the spawnicon to spawn it."
ENT.Category		= ""

ENT.VJ_FNaF_CanBeStunned = true
ENT.VJ_FNaF_IsFreddy = true

function ENT:SetupDataTables()
	self:NetworkVar("Int",0,"Mouth")
end

if CLIENT then
    function ENT:Initialize()
        local hookName = "VJ_FNAF_FreddyHack_" .. self:EntIndex()
        local lerp_e_hp = 0
        local lastHP = 0
        local aDist = 0
        
        self.LastChangeT = 0
        hook.Add("HUDPaint",hookName,function()
            if !IsValid(self) then
                hook.Remove("HUDPaint",hookName)
                return
            end

            if GetConVar("vj_fnaf_hack_hud"):GetInt() == 0 then return end

            if CurTime() > self.LastChangeT then
                aDist = Lerp(5 *FrameTime(),aDist,0)
            else
                aDist = Lerp(5 *FrameTime(),aDist,1 -math.Clamp((LocalPlayer():GetPos():Distance(self:GetPos()) /600),0,1))
            end
            local len = 200
            local height = 60
            local bColor = Color(35,35,35,230 *aDist)

            local hp = self:GetNW2Int("HackLevel") or 0
            if lastHP != hp then
                lastHP = hp
                self.LastChangeT = CurTime() +3
            end
            local hpMax = 30
            local perHP = hp /hpMax
            lerp_e_hp = Lerp(5 *FrameTime(), lerp_e_hp, hp)
            local perHPB = lerp_e_hp /hpMax

            local offset = 150
            local entPos = (self:EyePos()):ToScreen()
            local boxX = entPos.x -offset -35
            local boxY = entPos.y -offset -35
            draw.RoundedBox(1,boxX,boxY,len,height,bColor)

            local posX = boxX +5
            local posY = boxY +5
            local nlen = len -10
            local height = 20
            local f = math.Clamp(nlen *perHPB,0,nlen)
            local alpha = 255

            draw.RoundedBox(1, posX, posY, nlen, height, Color(0, 0, 0, 150 *aDist))
            draw.RoundedBox(1, posX, posY, f, height, Color(183,0,255, alpha *aDist))

            local hackLevel = self:GetNW2Int("HackLevel")
            local text = "Hack Level " .. (tostring(hackLevel) .. "/30")
            draw.SimpleText(text,"TargetID",boxX +5,boxY +30,Color(183,0,255,255 *aDist))
        end)
    end

    function ENT:CustomOnDraw()
        self.Mouth = Lerp(FrameTime() *30,self.Mouth or 0,self:GetMouth())
        self:ManipulateBoneAngles(self:LookupBone("Jaw_jnt"),Angle(self.Mouth *0.2,0,0))
    end
end

if SERVER then
    net.Receive("VJ_FNaF_GetLightness",function()
        local ent = net.ReadEntity()
        local lum = net.ReadFloat(32)

        if IsValid(ent) then
            ent.DetectedLightness = lum
        end
    end)
end

if CLIENT then
    function ENT:Think()
        local lum = math.Clamp((render.GetLightColor(self:GetPos() +self:OBBCenter()) *Vector(255,255,255)):Length(),0,255)
        net.Start("VJ_FNaF_GetLightness")
            net.WriteEntity(self)
            net.WriteFloat(lum,32)
        net.SendToServer()
    end
end

if CLIENT then
    local hookAnim = "Freddy"
    local eyeMat = Material("hud/fnaf/char/HUD_Freddy.png")
    local eyeMat2 = Material("hud/fnaf/char/HUD_Roxy.png")

	net.Receive("VJ_FNaF_" .. hookAnim .. "_Controller",function(len,pl)
		local delete = net.ReadBool()
		local ent = net.ReadEntity()
		local class = net.ReadString()
		local ply = net.ReadEntity()
		local cent = net.ReadEntity()

		if !IsValid(ent) then delete = true end

        local hookName = "VJ_FNaF_" .. hookAnim .. "_HUD_" .. ent:EntIndex()

        if !delete then
            ply.FNaF_FreddyViewLoop = CreateSound(ply,"cpthazama/fnafsb/freddy/fx/sfx_freddy_int_amb_lp_mech_0" .. math.random(1,3) .. ".wav")
            ply.FNaF_FreddyViewScreenLoop = CreateSound(ply,"cpthazama/fnafsb/freddy/fx/sfx_freddy_int_amb_lp_screen_0" .. math.random(1,3) .. ".wav")
            ply.FNaF_FreddyViewLoopT = 0

            ply.FNaF_FreddyViewScreenLoop:Play()
            ply.FNaF_FreddyViewScreenLoop:ChangeVolume(0.6)

            hook.Add("Think",hookName,function()
                if !IsValid(ent) then
                    hook.Remove("Think",hookName)
                    return
                end
                if CurTime() > ply.FNaF_FreddyViewLoopT then
                    local snd = "cpthazama/fnafsb/freddy/fx/sfx_freddy_int_amb_lp_mech_0" .. math.random(1,3) .. ".wav"
                    ply.FNaF_FreddyViewLoop:Stop()
                    ply.FNaF_FreddyViewLoop = CreateSound(ply,snd)
                    ply.FNaF_FreddyViewLoop:Play()
                    ply.FNaF_FreddyViewLoop:ChangeVolume(0.35)
                    ply.FNaF_FreddyViewLoopT = CurTime() +SoundDuration(snd)
                end
            end)

			hook.Add("PreDrawHalos",hookName,function()
                if !IsValid(ent) then
                    hook.Remove("PreDrawHalos",hookName)
                    return
                end

                if GetConVar("vj_fnaf_freddyeyes"):GetInt() == 0 then return end

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
                surface.SetMaterial(GetConVar("vj_fnaf_freddyeyes"):GetInt() == 0 && eyeMat or eyeMat2)
                surface.DrawTexturedRect(0,0,ScrW(),ScrH() *0.65)
            end)
		else
            hook.Remove("Think",hookName)
            hook.Remove("RenderScreenspaceEffects",hookName)
            hook.Remove("PreDrawHalos",hookName)
            if ply.FNaF_FreddyViewLoopT then ply.FNaF_FreddyViewLoopT = 0 end
            if ply.FNaF_FreddyViewScreenLoop then ply.FNaF_FreddyViewScreenLoop:Stop() end
            if ply.FNaF_FreddyViewLoop then ply.FNaF_FreddyViewLoop:Stop() end
        end
    end)
end