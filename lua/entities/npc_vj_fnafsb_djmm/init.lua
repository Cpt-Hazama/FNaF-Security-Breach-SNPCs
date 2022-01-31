AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2022 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/fnaf_sb/djmm.mdl"}
ENT.StartHealth = 2000
ENT.VJ_IsHugeMonster = true

ENT.VJ_NPC_Class = {"CLASS_FNAF_ANIMATRONIC","CLASS_FNAF_BURNTRAP"}

ENT.VJC_Data = {
	CameraMode = 1, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
	ThirdP_Offset = Vector(0, 30, -40), -- The offset for the controller when the camera is in third person
	FirstP_Bone = "Nose_jnt", -- If left empty, the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(0,0,12), -- The offset for the controller when the camera is in first person
	FirstP_ShrinkBone = false, -- Should the bone shrink? Useful if the bone is obscuring the player's view
	FirstP_CameraBoneAng = 3, -- Should the camera's angle be affected by the bone's angle?
	FirstP_CameraBoneAng_Offset = 0, -- How much should the camera's angle be rotated by? (Useful for weird bone angles, this is the roll angle)
}

ENT.Bleeds = false

ENT.HullType = HULL_HUMAN

ENT.HasMeleeAttack = true
ENT.MeleeAttackDistance = 200
ENT.MeleeAttackDamageDistance = 450
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1}
ENT.TimeUntilMeleeAttackDamage = 0
ENT.DisableDefaultMeleeAttackDamageCode = true
ENT.StopMeleeAttackAfterFirstHit = true

ENT.CallForHelp = false

ENT.HasDeathRagdoll = false
ENT.GibOnDeathDamagesTable = {"All"}

ENT.AttackProps = false
ENT.PushProps = false

ENT.DisableFootStepSoundTimer = true
ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100

ENT.NextSoundTime_Idle = VJ_Set(9, 15)
ENT.NextSoundTime_Investigate = VJ_Set(6, 8)
ENT.NextSoundTime_LostEnemy = VJ_Set(8, 15)
ENT.NextSoundTime_Alert = VJ_Set(7, 15)
ENT.NextSoundTime_OnKilledEnemy = VJ_Set(6, 9)
ENT.NextSoundTime_DamageByPlayer = VJ_Set(5, 8)

ENT.SoundTbl_FootStep = {
	"cpthazama/fnafsb/djmm/fx/fly_djmm_walk_01.wav",
	"cpthazama/fnafsb/djmm/fx/fly_djmm_walk_02.wav",
	"cpthazama/fnafsb/djmm/fx/fly_djmm_walk_03.wav",
	"cpthazama/fnafsb/djmm/fx/fly_djmm_walk_04.wav",
	"cpthazama/fnafsb/djmm/fx/fly_djmm_walk_05.wav",
	"cpthazama/fnafsb/djmm/fx/fly_djmm_walk_06.wav",
	"cpthazama/fnafsb/djmm/fx/fly_djmm_walk_07.wav",
	"cpthazama/fnafsb/djmm/fx/fly_djmm_walk_08.wav",
	"cpthazama/fnafsb/djmm/fx/fly_djmm_walk_09.wav",
	"cpthazama/fnafsb/djmm/fx/fly_djmm_walk_10.wav",
	"cpthazama/fnafsb/djmm/fx/fly_djmm_walk_11.wav",
	"cpthazama/fnafsb/djmm/fx/fly_djmm_walk_12.wav",
	"cpthazama/fnafsb/djmm/fx/fly_djmm_walk_13.wav",
	"cpthazama/fnafsb/djmm/fx/fly_djmm_walk_14.wav",
	"cpthazama/fnafsb/djmm/fx/fly_djmm_walk_15.wav"
}
---------------------------------------------------------------------------------------------------------------------------------------------
-- function ENT:GetSightDirection()
-- 	return self:GetAttachment(self:LookupAttachment("eyes")).Ang:Forward()
-- end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:JumpscareOffset(ent)
	return self:GetPos() +self:GetForward() *300
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.InAttack = false
	self:SetCollisionBounds(Vector(100,100,210),Vector(-100,-100,0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "step" then
		VJ_EmitSound(self,self.SoundTbl_FootStep,90)
		util.ScreenShake(self:GetPos(),16,100,2,1250)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	self:SetNW2Entity("Enemy",self:GetEnemy())
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_AfterChecks(hitEnt, isProp)
	if isProp then
		return true
	end
	self:VJ_FNAF_Attack(hitEnt,VJ_GetSequenceDuration(self,ACT_MELEE_ATTACK1),2,nil,"cpthazama/fnafsb/sfx_jumpScare_DJMM.wav")
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDoKilledEnemy(ent, attacker, inflictor)
	if ent:IsPlayer() && attacker == self then
		net.Start("VJ_FNaF_DeathScreen_End")
			net.WriteEntity(ent)
		net.Send(ent)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomDeathAnimationCode(dmginfo, hitgroup)
	timer.Simple(0.5, function()
		if IsValid(self) then
			util.ScreenShake(self:GetPos(), 100, 200, 1, 3000)
			if self.HasGibDeathParticles == true then ParticleEffect("vj_explosion2", self:GetPos() + self:GetUp()*360 + self:GetRight() *-50, defAngle) end
			local effectdata = EffectData()
			effectdata:SetOrigin(self:GetPos() + self:GetUp()*360 + self:GetRight() *-50) -- the vector of were you want the effect to spawn
			util.Effect("Explosion", effectdata)
		end
	end)
	timer.Simple(2, function()
		if IsValid(self) then
			util.ScreenShake(self:GetPos(), 100, 200, 1, 3000)
			if self.HasGibDeathParticles == true then ParticleEffect("vj_explosion2", self:GetPos() + self:GetUp()*300, defAngle) end
			local effectdata = EffectData()
			effectdata:SetOrigin(self:GetPos() + self:GetUp()*460) -- the vector of were you want the effect to spawn
			util.Effect("Explosion", effectdata)
		end
	end)
	timer.Simple(3.5, function()
		if IsValid(self) then
			util.ScreenShake(self:GetPos(), 100, 200, 1, 3000)
			if self.HasGibDeathParticles == true then ParticleEffect("vj_explosion2", self:GetPos() + self:GetUp()*460, defAngle) end
			local effectdata = EffectData()
			effectdata:SetOrigin(self:GetPos() + self:GetUp()*460) -- the vector of were you want the effect to spawn
			util.Effect("Explosion", effectdata)
		end
	end)
	timer.Simple(5.05, function()
		if IsValid(self) then
			util.ScreenShake(self:GetPos(), 100, 200, 1, 3000)
			if self.HasGibDeathParticles == true then ParticleEffect("vj_explosion2", self:GetBonePosition(self:LookupBone("Bip01 R Clavicle")), defAngle) end
			local effectdata = EffectData()
			effectdata:SetOrigin(self:GetBonePosition(self:LookupBone("Bip01 R Clavicle"))) -- the vector of were you want the effect to spawn
			util.Effect("Explosion", effectdata)
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
local gibMdls = {"models/props_debris/metal_panelchunk01a.mdl","models/props_debris/metal_panelchunk01b.mdl","models/props_debris/metal_panelchunk01d.mdl","models/props_debris/metal_panelchunk01e.mdl","models/props_debris/metal_panelchunk01f.mdl","models/props_debris/metal_panelchunk01g.mdl","models/props_debris/metal_panelchunk02d.mdl","models/props_debris/metal_panelchunk02e.mdl"}
local gibColor = Color(50, 50, 50)
local defVector = Vector(0, 0, 0)
local defAngle = Angle(0, 0, 0)
--
function ENT:SetUpGibesOnDeath(dmginfo, hitgroup)
	for i = 0, self:GetBoneCount() -15 do
		self:CreateGibEntity("prop_physics", gibMdls, {Pos=self:GetBonePosition(i), Vel=self:GetForward()*math.Rand(-200,200) + self:GetRight()*math.Rand(-200,200) + self:GetUp()*math.Rand(350,600)}, function(gib)
			gib:Ignite(math.Rand(20, 30), 0)
			gib:SetColor(gibColor)
		end)
	end
	return true, {DeathAnim=false}
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomGibOnDeathSounds(dmginfo, hitgroup) return false end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnKilled(dmginfo, hitgroup)
	util.BlastDamage(self, self, self:GetPos() + self:GetUp()*360, 200, 40)
	util.BlastDamage(self, self, self:GetPos(), 400, 40)
	util.ScreenShake(self:GetPos(), 100, 200, 1, 3000)
	if self.HasGibDeathParticles == true then
		for i = 0, self:GetBoneCount() -62 do
			if math.random(1,3) == 1 then
				ParticleEffect("vj_explosion2", self:GetBonePosition(i), defAngle)
			end
		end
		local pos = self:GetPos() + self:GetUp()*260
		local effectdata = EffectData()
		effectdata:SetOrigin(pos) -- the vector of were you want the effect to spawn
		util.Effect("Explosion", effectdata)
	end
	self:RunGibOnDeathCode(dmginfo, hitgroup)
end