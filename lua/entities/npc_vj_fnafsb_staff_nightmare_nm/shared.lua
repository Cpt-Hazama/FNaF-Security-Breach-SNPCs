ENT.Base 			= "npc_vj_creature_base"
ENT.Type 			= "ai"
ENT.PrintName 		= "Nightmarionne"
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose 		= "Spawn it and fight with it!"
ENT.Instructions 	= "Click on the spawnicon to spawn it."
ENT.Category		= ""

if CLIENT then
	local defAng = Angle(0,0,0)
	local mat = Material("effects/cpthazama/fnaf/render_nm")
	local bones = {"Head_jnt","L_Elbow_jnt","R_Elbow_jnt","Spine_jnt","L_Shoulder_jnt","R_Shoulder_jnt"}
	function ENT:CustomOnDraw()
		self.NextTwitchT = self.NextTwitchT or 0
		self.NextTwitchLen = self.NextTwitchLen or 0
		self.NextTwitchReset = self.NextTwitchReset or 0

		if self:GetSequenceName(self:GetSequence()) == "jumpscare" then
			self.NextTwitchReset = true
			for _,v in pairs(bones) do
				local bone = self:LookupBone(v)
				if bone then
					self:ManipulateBoneAngles(bone,defAng)
				end
			end
			return
		end

		if CurTime() > self.NextTwitchT && math.random(1,30) == 1 then
			local t = math.Rand(0.3,2)
			self.NextTwitchT = CurTime() +t
			self.NextTwitchLen = CurTime() +math.Rand(0.1,0.2)
		elseif CurTime() <= self.NextTwitchLen then
			self.NextTwitchReset = false
			for _,v in pairs(bones) do
				local bone = self:LookupBone(v)
				if bone then
					self:ManipulateBoneAngles(bone,AngleRand(-30,30))
				end
			end
		elseif CurTime() > self.NextTwitchLen && !self.NextTwitchReset then
			self.NextTwitchReset = true
			for _,v in pairs(bones) do
				local bone = self:LookupBone(v)
				if bone then
					self:ManipulateBoneAngles(bone,defAng)
				end
			end
		end
	end

	function ENT:Initialize()
		local ind = self:EntIndex()
		hook.Add("RenderScreenspaceEffects", "VJ_FNaF_NM_" .. ind, function()
			if !IsValid(self) then
				hook.Remove("RenderScreenspaceEffects", "VJ_FNaF_NM_" .. ind)
				return
			end
			if !IsValid(self) then return end
			cam.Start3D(EyePos(),EyeAngles())
				if util.IsValidModel(self:GetModel()) then
					render.SetBlend(0.125)
					render.MaterialOverride(mat)
					self:DrawModel()
					render.MaterialOverride(0)
					render.SetBlend(1)
				end
			cam.End3D()
		end)

        local hookName = "VJ_FNaF_NM_FX"
        hook.Add("Think",hookName,function()
            local ply = LocalPlayer()
            if !IsValid(self) then
                hook.Remove("Think",hookName)
                return
            end
            local FT = FrameTime() *6
			local maxDist = 5000
            local dist = ply:GetPos():Distance(self:GetPos())

            hook.Add("RenderScreenspaceEffects",hookName,function()
                if !IsValid(ply) or (IsValid(ply) && (ply:Health() <= 0)) or !IsValid(self) then
                    hook.Remove("RenderScreenspaceEffects",hookName)
                    return
                end

                if !ply:Alive() or ply.IsControlingNPC or dist > maxDist or GetConVar("ai_ignoreplayers"):GetInt() == 1 then return end

				ply.VJ_FNaF_NMShotT = ply.VJ_FNaF_NMShotT or 0
				ply.VJ_FNaF_NMShot = ply.VJ_FNaF_NMShot or 1
				ply.VJ_FNaF_NMShotLen = ply.VJ_FNaF_NMShotLen or 0
				if ply.VJ_FNaF_NMShotA == nil then ply.VJ_FNaF_NMShotA = 0 end
				if dist < maxDist *0.9 then
					if CurTime() > ply.VJ_FNaF_NMShotT && math.random(1,25) == 1 then
						local dur = 1
						if dist > maxDist *0.3 then
							local snd = VJ_PICK({"cpthazama/fnafsb/nm/nm1.mp3","cpthazama/fnafsb/nm/nm2.mp3","cpthazama/fnafsb/nm/nm3.mp3","cpthazama/fnafsb/nm/nm4.mp3","cpthazama/fnafsb/nm/nm5.mp3"})
							surface.PlaySound(snd)
							dur = VJ_SoundDuration(snd) *0.9
						end
						ply.VJ_FNaF_NMShotLen = CurTime() +dur
						ply.VJ_FNaF_NMShotT = CurTime() +dur +math.Rand(7,18)
						ply.VJ_FNaF_NMShot = math.random(1,2)
						local ang = (self:GetPos() -ply:GetPos()):Angle()
						local dif = math.AngleDifference(ply:GetAngles().y,ang.y)
						local w = ScrW()
						local num = 0
						if dif >= 0 then
							num = 0.5 +math.Clamp(dif /90,0,0.5)
						else
							num = 0.5 -math.Clamp(dif /-90,0,1) *0.5
						end
						ply.VJ_FNaF_NM_X = ((w *num)) -(w *0.5)
					end
				end
				if CurTime() < ply.VJ_FNaF_NMShotLen then
					local remaining = CurTime() /ply.VJ_FNaF_NMShotLen
					local a = 220 *remaining
					ply.VJ_FNaF_NMShotA = Lerp(FT,ply.VJ_FNaF_NMShotA,a)
				else
					ply.VJ_FNaF_NMShotA = Lerp(FT,ply.VJ_FNaF_NMShotA,0)
				end
				surface.SetDrawColor(255,255,255,ply.VJ_FNaF_NMShotA or 0)
				surface.SetMaterial(Material("hud/fnaf/nm_shot" .. ply.VJ_FNaF_NMShot .. ".png"))
				surface.DrawTexturedRect(ply.VJ_FNaF_NM_X or 0,0,ScrW(),ScrH())

				if dist <= 2000 then
					surface.SetDrawColor(110,110,110,200 *(1 -(dist/ 2000)))
					surface.SetMaterial(Material("hud/fnaf/static_vanny"))
					surface.DrawTexturedRect(0,0,ScrW(),ScrH())
				end

                local visThreshold = (1 -(dist/ maxDist))
                surface.SetDrawColor(255,255,255,255 *visThreshold)
                surface.SetMaterial(Material("hud/fnaf/nm.png"))
                surface.DrawTexturedRect(0,0,ScrW(),ScrH())
            end)
        end)
	end
end