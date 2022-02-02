ENT.Base 			= "npc_vj_creature_base"
ENT.Type 			= "ai"
ENT.PrintName 		= ""
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
			local t = math.Rand(0.65,3)
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
            if ply.IsControlingNPC && ply.VJCE_NPC.VJ_FNaF_UniqueAnimatronic then return end
            local FT = FrameTime() *6
			local maxDist = 5000
            local dist = ply:GetPos():Distance(self:GetPos())

            hook.Add("RenderScreenspaceEffects",hookName,function()
                if !IsValid(ply) or (IsValid(ply) && (ply:Health() <= 0)) or !IsValid(self) then
                    hook.Remove("RenderScreenspaceEffects",hookName)
                    return
                end

                if !ply:Alive() or (ply.IsControlingNPC && ply.VJCE_NPC == self) or dist > maxDist or GetConVar("ai_ignoreplayers"):GetInt() == 1 then return end

				if dist < maxDist *0.9 then
					ply.VJ_FNaF_NMShotT = ply.VJ_FNaF_NMShotT or 0
					ply.VJ_FNaF_NMShot = ply.VJ_FNaF_NMShot or 1
					ply.VJ_FNaF_NMShotLen = ply.VJ_FNaF_NMShotLen or 0
					if ply.VJ_FNaF_NMShotA == nil then ply.VJ_FNaF_NMShotA = 0 end
					if CurTime() > ply.VJ_FNaF_NMShotT && math.random(1,25) == 1 then
					-- if CurTime() > ply.VJ_FNaF_NMShotT then
						ply.VJ_FNaF_NMShotLen = CurTime() +math.random(2,5)
						-- ply.VJ_FNaF_NMShotT = CurTime() +math.Rand(7,9)
						ply.VJ_FNaF_NMShotT = CurTime() +math.Rand(7,18)
						ply.VJ_FNaF_NMShot = math.random(1,2)
						ply.VJ_FNaF_NM_X = math.random(ScrW() *-0.5,ScrW() *0.5)
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