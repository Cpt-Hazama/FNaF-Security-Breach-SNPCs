AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2022 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/fnaf_sb/blob.mdl"}
ENT.StartHealth = 5000
ENT.VJ_IsHugeMonster = true
ENT.MovementType = VJ_MOVETYPE_STATIONARY
ENT.CanTurnWhileStationary = false
ENT.FindEnemy_CanSeeThroughWalls = true

ENT.VJ_NPC_Class = {"CLASS_FNAF_ANIMATRONIC_BLOB"}
-- ENT.VJ_NPC_Class = {"CLASS_FNAF_ANIMATRONIC"}

ENT.VJC_Data = {
	CameraMode = 1, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
	ThirdP_Offset = Vector(0, 30, -40), -- The offset for the controller when the camera is in third person
	FirstP_Bone = "Head5_jnt", -- If left empty, the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(8, -1, -20), -- The offset for the controller when the camera is in first person
	FirstP_ShrinkBone = false, -- Should the bone shrink? Useful if the bone is obscuring the player's view
	FirstP_UseBoneAng = true, -- Should the camera's angle be affected by the bone's angle?
	FirstP_BoneAngAdjust = 180, -- How much should the camera's angle be rotated by? (Useful for weird bone angles, this is the roll angle)
}

ENT.Bleeds = false

ENT.HullType = HULL_HUMAN

ENT.HasMeleeAttack = true
ENT.MeleeAttackDistance = 95
ENT.MeleeAttackDamageDistance = 300
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1}
ENT.MeleeAttackAnimationDecreaseLengthAmount = 0
ENT.TimeUntilMeleeAttackDamage = 0
ENT.DisableDefaultMeleeAttackDamageCode = true
ENT.StopMeleeAttackAfterFirstHit = true

ENT.DeathCorpseEntityClass = "prop_vj_animatable"

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

ENT.EntitiesToNoCollide = {"npc_vj_fnafsb_endo_blob"}

ENT.EndoPositions = {
	[1] = {x=0,y=220,z=0},
	[2] = {x=220,y=0,z=0},
	[3] = {x=-220,y=0,z=0},
	[4] = {x=0,y=-250,z=0}
}

local nwName = "VJ_FNaF_Blob_Controller"
util.AddNetworkString(nwName)
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_Initialize(ply)
	local opt1, opt2, opt3 = self, self:GetClass(), self.VJ_TheControllerEntity
    net.Start(nwName)
		net.WriteBool(false)
		net.WriteEntity(opt1)
		net.WriteString(opt2)
		net.WriteEntity(ply)
		net.WriteEntity(opt3)
    net.Send(ply)

	function self.VJ_TheControllerEntity:CustomOnStopControlling()
		net.Start(nwName)
			net.WriteBool(true)
			net.WriteEntity(opt1)
			net.WriteString(opt2)
			net.WriteEntity(ply)
			net.WriteEntity(opt3)
		net.Send(ply)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GetSightDirection()
	return self:GetAttachment(self:LookupAttachment("eyes")).Ang:Forward()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.Endo1 = NULL
	self.Endo2 = NULL
	self.Endo3 = NULL
	self.Endo4 = NULL
	self.NextEndoT = CurTime() +math.Rand(12,30)
	self.Tentacles = 0
	self.MaxTentacles = 8
	self.NextTentacleT = 0
	self.EndoList = {}

	self:SetCollisionBounds(Vector(140,140,260),Vector(-140,-140,0))
	
	for i = 1,2 do
		local att = i == 2 && "eyeR" or "eyeL"
		local eyeGlow = ents.Create("env_sprite")
		eyeGlow:SetKeyValue("model","vj_base/sprites/vj_glow1.vmt")
		eyeGlow:SetKeyValue("scale","0.05")
		eyeGlow:SetKeyValue("rendermode","9")
		eyeGlow:SetKeyValue("rendercolor","255 0 0")
		eyeGlow:SetKeyValue("spawnflags","1")
		eyeGlow:SetParent(self)
		eyeGlow:Fire("SetParentAttachment",att,0)
		eyeGlow:Spawn()
		eyeGlow:Activate()
		self:DeleteOnRemove(eyeGlow)

		local stWidth = 4
		local edWidth = 0
		local time = 0.175
		local resolution = 1 /(10 +1) *0.5
		util.SpriteTrail(self,i +2,Color(255,0,0,240),false,stWidth,edWidth,time,resolution,"VJ_Base/sprites/vj_trial1.vmt")
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CanMakeMoreEndos()
	return (!IsValid(self.Endo1) or !IsValid(self.Endo2) or !IsValid(self.Endo3) or !IsValid(self.Endo4))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CreateEndo()
	if !self:CanMakeMoreEndos() then return end
	local num = 0
	if !IsValid(self.Endo1) then
		num = 1
	elseif !IsValid(self.Endo2) then
		num = 2
	elseif !IsValid(self.Endo3) then
		num = 3
	elseif !IsValid(self.Endo4) then
		num = 4
	end
	local dat = self.EndoPositions[num]
	local pos = self:GetPos() +self:GetForward() *dat.y +self:GetRight() *dat.x +self:GetUp() *dat.z
	local tr = util.TraceLine({
		start = pos,
		endpos = pos +Vector(0,0,-32600),
		filter = self,
		mask = MASK_SOLID_BRUSHONLY
	})
	pos = tr.HitPos or pos
	local e = ents.Create("npc_vj_fnafsb_endo_blob")
	VJ_SetClearPos(e,pos)
	e:SetAngles(Angle(0,(e:GetPos() -self:GetPos()):Angle().y,0))
	e:Spawn()
	e:SetNoDraw(true)
	e:SetOwner(self)
	e:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
	timer.Simple(0.25,function()
		if IsValid(e) then
			e:SetNoDraw(false)
		end
	end)
	e:VJ_ACT_PLAYACTIVITY(ACT_ROLL_LEFT,true,false,false,0,{OnFinish=function(interrupted,anim)
		e:SetState()
	end})
	table.insert(self.EndoList,e)
	if num == 1 then
		self.Endo1 = e
	elseif num == 2 then
		self.Endo2 = e
	elseif num == 3 then
		self.Endo3 = e
	elseif num == 4 then
		self.Endo4 = e
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CreateTentacle(pos)
	if self.Tentacles >= self.MaxTentacles then return end
	local tr = util.TraceLine({
		start = pos,
		endpos = pos +Vector(0,0,-32000),
		filter = self,
		mask = MASK_SOLID_BRUSHONLY
	})
	pos = tr.HitPos or pos
	local e = ents.Create("prop_vj_animatable")
	e:SetModel("models/cpthazama/fnaf_sb/blob_tentacle.mdl")
	VJ_SetClearPos(e,pos)
	e:SetAngles(Angle(0,math.random(0,360),0))
	e:Spawn()
	e:SetOwner(self)
	e:ResetSequence("in")
	e:EmitSound("physics/concrete/concrete_break2.wav",110,100)
	ParticleEffect("advisor_plat_break",e:GetPos(),e:GetAngles(),e)
	ParticleEffect("strider_impale_ground",e:GetPos(),e:GetAngles(),e)
	timer.Simple(VJ_GetSequenceDuration(e,"in"),function()
		if IsValid(e) then
			e:ResetSequence("idle_search")
		end
	end)
	e.Target = NULL
	e.GoAwayT = CurTime() +math.Rand(7,15)
	self:DeleteOnRemove(e)
	self.Tentacles = self.Tentacles +1
	local hookName = "VJ_FNaF_Tentacle_" .. e:EntIndex()
	hook.Add("Think",hookName,function()
		if !IsValid(e) or !IsValid(self) then
			hook.Remove("Think",hookName)
			if IsValid(self) then
				self.Tentacles = self.Tentacles -1
			end
			return
		end
		local anim = e:GetSequenceName(e:GetSequence())
		local target = e.Target
		if (IsValid(target) or CurTime() > e.GoAwayT) && anim != "out" then
			e:ResetSequence("out")
			timer.Simple(VJ_GetSequenceDuration(e,"out"),function()
				if IsValid(e) then
					e:Remove()
				end
			end)
			if !IsValid(target) then return end
			self:VJ_FNAF_Attack(target,2,2,nil,"cpthazama/fnafsb/burntrap/jumpscare.wav",true)
			local v = ents.Create("prop_vj_animatable")
			v:SetModel("models/cpthazama/fnaf_sb/blob.mdl")
			v:SetPos(target:GetPos())
			v:SetAngles(target:GetAngles())
			v:Spawn()
			v:DrawShadow(false)
			v:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
			target:SetNW2Entity("VJ_FNaF_Override",v)
			v:SetOwner(self)
			v:ResetSequence("jumpscare_ground")
			v:EmitSound("physics/concrete/concrete_break2.wav",110,100)
			ParticleEffect("advisor_plat_break",v:GetPos(),v:GetAngles(),v)
			ParticleEffect("strider_impale_ground",v:GetPos(),v:GetAngles(),v)
			for i = 1,2 do
				local att = i == 2 && "eyeR" or "eyeL"
				local eyeGlow = ents.Create("env_sprite")
				eyeGlow:SetKeyValue("model","vj_base/sprites/vj_glow1.vmt")
				eyeGlow:SetKeyValue("scale","0.05")
				eyeGlow:SetKeyValue("rendermode","9")
				eyeGlow:SetKeyValue("rendercolor","255 0 0")
				eyeGlow:SetKeyValue("spawnflags","1")
				eyeGlow:SetParent(v)
				eyeGlow:Fire("SetParentAttachment",att,0)
				eyeGlow:Spawn()
				eyeGlow:Activate()
				v:DeleteOnRemove(eyeGlow)

				local stWidth = 4
				local edWidth = 0
				local time = 0.175
				local resolution = 1 /(10 +1) *0.5
				util.SpriteTrail(v,i +2,Color(255,0,0,240),false,stWidth,edWidth,time,resolution,"VJ_Base/sprites/vj_trial1.vmt")
			end
			timer.Simple(VJ_GetSequenceDuration(v,"jumpscare_ground"),function()
				if IsValid(v) then
					v:Remove()
				end
			end)
			return
		end
		if anim == "idle_search" && !self.InAttack && !IsValid(target) && anim != "out" && anim != "in" then
			for _,v in pairs(ents.FindInSphere(e:GetPos(),150)) do
				if (v:IsPlayer() && GetConVarNumber("ai_ignoreplayers") == 0 && v:Alive()) or (v:IsNPC() && self:Disposition(v) != D_LI && v != self && v:Health() > 0) then
					if v:IsFlagSet(FL_NOTARGET) then continue end
					local jsTime = v.VJ_FNaF_KillTime or 0
					if jsTime > CurTime() then continue end
					if VJ_HasValue(v.VJ_NPC_Class or {},"CLASS_FNAF_ANIMATRONIC") then continue end
					e.Target = v
					break
				end
			end
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomAttack()
	local ent = self:GetEnemy()
	local anim = self:GetActivity()
	local dist = self.NearestPointToEnemyDistance
	local cont = self.VJ_TheController
	if CurTime() > self.NextTentacleT && dist <= 5000 then
		if (IsValid(cont) && cont:KeyDown(IN_ATTACK2)) or !IsValid(cont) then
			local vec = VectorRand(-250,250)
			vec.z = math.abs(vec.z)
			self:CreateTentacle(ent:GetPos() +vec)
			self.NextTentacleT = CurTime() +math.Rand(1,3)
		end
	end
	if !self:CanMakeMoreEndos() then return end
	if CurTime() > self.NextEndoT && dist <= 4000 then
		self:CreateEndo()
		self.NextEndoT = CurTime() +math.Rand(2,30)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:JumpscareOffset(ent)
	return self:GetPos() +self:GetForward() *150
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_AfterChecks(hitEnt, isProp)
	if isProp then
		return true
	end
	self:VJ_FNAF_Attack(hitEnt,VJ_GetSequenceDuration(self,ACT_MELEE_ATTACK1),2,nil,"cpthazama/fnafsb/burntrap/jumpscare.wav")
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
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,ent)
	undo.ReplaceEntity(self,ent)
	ent:ResetSequence("idle")
	ent:SetCycle(0)
	ent:SetPlaybackRate(0)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	if self:Health() >= self:GetMaxHealth() then
		for _,v in pairs(self.EndoList) do
			if IsValid(v) then
				v:Remove()
			end
		end
	end
end