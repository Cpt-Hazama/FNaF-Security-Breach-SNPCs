AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2022 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/fnaf_sb/staff_default.mdl"}
ENT.StartHealth = 100

ENT.VJ_NPC_Class = {"CLASS_FNAF_ANIMATRONIC","CLASS_FNAF_BURNTRAP"}

ENT.VJC_Data = {
	CameraMode = 1, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
	ThirdP_Offset = Vector(0, 30, -40), -- The offset for the controller when the camera is in third person
	FirstP_Bone = "Head_jnt", -- If left empty, the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(8, 0, 0), -- The offset for the controller when the camera is in first person
	FirstP_ShrinkBone = false, -- Should the bone shrink? Useful if the bone is obscuring the player's view
	FirstP_UseBoneAng = true, -- Should the camera's angle be affected by the bone's angle?
	FirstP_BoneAngAdjust = 0, -- How much should the camera's angle be rotated by? (Useful for weird bone angles, this is the roll angle)
}

ENT.Bleeds = false

ENT.HullType = HULL_HUMAN
ENT.PoseParameterLooking_InvertPitch = true

ENT.CallForHelp = false

ENT.NoChaseAfterCertainRange_FarDistance = 600
ENT.NoChaseAfterCertainRange_CloseDistance = 0
ENT.NoChaseAfterCertainRange_Type = "Regular"

ENT.OnPlayerSightDistance = 400
ENT.OnPlayerSightOnlyOnce = false
ENT.FollowPlayer = false

ENT.HasMeleeAttack = false
ENT.MeleeAttackDistance = 40
ENT.MeleeAttackDamageDistance = 110
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1}
ENT.TimeUntilMeleeAttackDamage = 0
ENT.DisableDefaultMeleeAttackDamageCode = true
ENT.StopMeleeAttackAfterFirstHit = true

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

ENT.StaffType = 0

ENT.SoundTbl_Sweep = {
	"cpthazama/fnafsb/bot/sfx_staffBot_mop_swipe_01.wav",
	"cpthazama/fnafsb/bot/sfx_staffBot_mop_swipe_02.wav",
	"cpthazama/fnafsb/bot/sfx_staffBot_mop_swipe_03.wav",
	"cpthazama/fnafsb/bot/sfx_staffBot_mop_swipe_04.wav"
}

local nwName = "VJ_FNaF_StaffBot_Controller"
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
function ENT:SetMapAnimation(set)
	self.MapAnimSet = set && 1 or 0
	if set then
		self.AnimTbl_IdleStand = {ACT_IDLE_STEALTH}
		self.AnimTbl_Walk = {ACT_WALK_STIMULATED}
		self.AnimTbl_Run = {ACT_RUN_STIMULATED}
		self:SetBodygroup(1,1)
		self:SetBodygroup(3,1)
		local snd = self.Gender == 1 && "cpthazama/fnafsb/bot_map/MAPBOT_00001_m.wav" or "cpthazama/fnafsb/bot_map/MAPBOT_00001_f.wav"
		VJ_CreateSound(self,snd)
		self.NextAnnoyingT = CurTime() +SoundDuration(snd) +math.Rand(4,7)
	else
		self.AnimTbl_IdleStand = {ACT_IDLE_RELAXED}
		self.AnimTbl_Walk = {ACT_WALK}
		self.AnimTbl_Run = {ACT_RUN}
		self:SetBodygroup(1,0)
		self:SetBodygroup(3,0)
		VJ_CreateSound(self,self.Gender == 1 && "cpthazama/fnafsb/bot_map/MAPBOT_00004_m.wav" or "cpthazama/fnafsb/bot_map/MAPBOT_00004_f.wav")
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GetSightDirection()
	return self:GetAttachment(self:LookupAttachment("eyes")).Ang:Forward()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPlayerSight(ply)
	if !IsValid(self.TargetPlayer) then
		local dat = self.TargetPlayers[ply]
		if dat && CurTime() < dat then return end
		self.TargetPlayer = ply
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, ply, caller, data)
	if key == "Use" then
		local tPly = self.TargetPlayer
		if IsValid(tPly) && ply:IsPlayer() && ply:Alive() && ply == tPly && self.MapAnimSet == 1 then
			self.TargetPlayer = NULL
			self:SetMapAnimation(false)
			self.TargetPlayers[ply] = CurTime() +math.random(45,60)
		end
	elseif key == "sweep" then
		VJ_EmitSound(self,self.SoundTbl_Sweep)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnShocked()
	if self.StaffType == 0 then
		self:SetBodygroup(1,0)
		self:SetBodygroup(4,0)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnShockEnded()
	if self.StaffType == 0 then
		self:SetBodygroup(1,1)
		self:SetBodygroup(4,1)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert(ply)
	local staffType = self.StaffType
	if staffType == 0 then
		if self.IsShocked then return end
		local tbl = self.SightingsTimes[ply]
		if tbl && CurTime() < tbl then return end
		self.Sightings[ply] = self.Sightings[ply] or 0
		self.Sightings[ply] = self.Sightings[ply] +1
		self:StopAllCommonSounds()
		self.NextIdleSoundT = CurTime() + math.Rand(self.NextSoundTime_Idle.a, self.NextSoundTime_Idle.b)
		local anim = "clean_alert" .. self.Sightings[ply]
		VJ_EmitSound(self,"cpthazama/fnafsb/bot/sfx_staffBot_player_detected_0" .. self.Sightings[ply] .. ".wav")
		local snd = "cpthazama/fnafsb/bot_mop/MOPBOT_0000" .. self.Sightings[ply] .. (self.Gender == 1 && "_m" or "_f") .. ".ogg"
		VJ_CreateSound(self,snd)
		self.SightingsTimes[ply] = CurTime() +VJ_GetSequenceDuration(self,anim) +(SoundDuration(snd) *2) +3
		self:VJ_ACT_PLAYACTIVITY(anim,true,false,true,0,{OnFinish=function(interrupted,anim)
			if interrupted then return end
			if !IsValid(ply) then return end
			self:SetEnemy(NULL)
			self:AddEntityRelationship(ply,D_NU,10)
		end})
		if self.Sightings[ply] == 3 then
			self.Sightings[ply] = 0
			VJ_EmitSound(self,"cpthazama/fnafsb/bot/sfx_staffBot_security_alert_0" .. math.random(1,3) .. ".wav")
			self.CallForHelp = true
			self:VJ_FNAF_BringAlertedAllies(self.CallForHelpDistance,ply)
			self:Allies_CallHelp(self.CallForHelpDistance)
			self.CallForHelp = false
		end
	-- elseif staffType == 1 then
	-- 	self.CallForHelp = true
	-- 	self:VJ_FNAF_BringAlertedAllies(self.CallForHelpDistance,ply)
	-- 	self:Allies_CallHelp(self.CallForHelpDistance)
	-- 	self.CallForHelp = false
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.InAttack = false
	self.TargetPlayer = NULL
	self.NextAnnoyingT = 0
	self.MapAnimSet = 0
	self.Gender = math.random(1,2)

	self:SetCollisionBounds(Vector(13,13,82),Vector(-13,-13,0))

	self.MoveLoopSound = CreateSound(self,"cpthazama/fnafsb/bot/sfx_staffBot_wheels_lp_0" .. math.random(1,3) .. ".wav")
	self.MoveLoopSound:SetSoundLevel(60)

	local gender = self.Gender
	local staffType = self.StaffType
	if staffType == 0 then -- Default
		self.AnimTbl_IdleStand = {ACT_CROUCHIDLE}
		self.AnimTbl_Walk = {ACT_WALK_RELAXED}
		self.AnimTbl_Run = {ACT_RUN_RELAXED}

		self.Behavior = VJ_BEHAVIOR_PASSIVE
		self.SightDistance = 350
		self.InvestigateSoundDistance = 0
		-- self.DisableFindEnemy = true
		self.DisableMakingSelfEnemyToNPCs = true
		self.DisableChasingEnemy = true
		-- self.CallForHelp = true
		self.Sightings = {}
		self.SightingsTimes = {}

		-- self.VJ_FNaF_CanBeStunned = false

		self.SoundTbl_Idle = gender == 1 && {
			"cpthazama/fnafsb/bot_mop/sweeperbot_00001_m.ogg",
			"cpthazama/fnafsb/bot_mop/sweeperbot_00002_m.ogg",
			"cpthazama/fnafsb/bot_mop/sweeperbot_00003_m.ogg",
			"cpthazama/fnafsb/bot_mop/sweeperbot_00004_m.ogg",
			"cpthazama/fnafsb/bot_mop/sweeperbot_00005_m.ogg"
		} or {
			"cpthazama/fnafsb/bot_mop/sweeperbot_00001_f.ogg",
			"cpthazama/fnafsb/bot_mop/sweeperbot_00002_f.ogg",
			"cpthazama/fnafsb/bot_mop/sweeperbot_00003_f.ogg",
			"cpthazama/fnafsb/bot_mop/sweeperbot_00004_f.ogg",
			"cpthazama/fnafsb/bot_mop/sweeperbot_00005_f.ogg"
		}

		self:SetBodygroup(1,1)
		self:SetBodygroup(4,1)
	elseif staffType == 1 then -- Security
		self.AnimTbl_IdleStand = {ACT_IDLE_STIMULATED}
		self.AnimTbl_Walk = {ACT_WALK_AGITATED}
		self.AnimTbl_Run = {ACT_RUN_AGITATED}
		self.HasMeleeAttack = true
		self.SightDistance = 700

		self.PoseParameterLooking_Names = {pitch={"d_aim_pitch"}, yaw={"d_aim_yaw"}, roll={}}

		self.SoundTbl_Idle = gender == 1 && {
			"cpthazama/fnafsb/bot_sentry/sentrybot_00001_m.ogg",
			"cpthazama/fnafsb/bot_sentry/sentrybot_00004_m.ogg",
			"cpthazama/fnafsb/bot_sentry/sentrybot_00005_m.ogg",
			"cpthazama/fnafsb/bot_sentry/sentrybot_00006_m.ogg",
			"cpthazama/fnafsb/bot_sentry/sentrybot_00008_m.ogg",
		} or {
			"cpthazama/fnafsb/bot_sentry/sentrybot_00001_f.ogg",
			"cpthazama/fnafsb/bot_sentry/sentrybot_00004_f.ogg",
			"cpthazama/fnafsb/bot_sentry/sentrybot_00005_f.ogg",
			"cpthazama/fnafsb/bot_sentry/sentrybot_00006_f.ogg",
			"cpthazama/fnafsb/bot_sentry/sentrybot_00008_f.ogg",
		}

		self.SoundTbl_Alert = gender == 1 && {
			"cpthazama/fnafsb/bot_sentry/sentrybot_00002_m.ogg",
			"cpthazama/fnafsb/bot_sentry/sentrybot_00003_m.ogg",
			"cpthazama/fnafsb/bot_sentry/sentrybot_00007_m.ogg",
			"cpthazama/fnafsb/bot_sentry/sentrybot_00009_m.ogg",
			"cpthazama/fnafsb/bot_sentry/sentrybot_00010_m.ogg",
			"cpthazama/fnafsb/bot_sentry/sentrybot_00011_m.ogg",
			"cpthazama/fnafsb/bot_sentry/sentrybot_00012_m.ogg",
			"cpthazama/fnafsb/bot_sentry/sentrybot_00013_m.ogg",
			"cpthazama/fnafsb/bot_sentry/sentrybot_00014_m.ogg",
			"cpthazama/fnafsb/bot_sentry/sentrybot_00016_m.ogg",
			"cpthazama/fnafsb/bot_sentry/sentrybot_00017_m.ogg",
		} or {
			"cpthazama/fnafsb/bot_sentry/sentrybot_00002_f.ogg",
			"cpthazama/fnafsb/bot_sentry/sentrybot_00003_f.ogg",
			"cpthazama/fnafsb/bot_sentry/sentrybot_00007_f.ogg",
			"cpthazama/fnafsb/bot_sentry/sentrybot_00009_f.ogg",
			"cpthazama/fnafsb/bot_sentry/sentrybot_00010_f.ogg",
			"cpthazama/fnafsb/bot_sentry/sentrybot_00011_f.ogg",
			"cpthazama/fnafsb/bot_sentry/sentrybot_00012_f.ogg",
			"cpthazama/fnafsb/bot_sentry/sentrybot_00013_f.ogg",
			"cpthazama/fnafsb/bot_sentry/sentrybot_00014_f.ogg",
			"cpthazama/fnafsb/bot_sentry/sentrybot_00016_f.ogg",
			"cpthazama/fnafsb/bot_sentry/sentrybot_00017_f.ogg",
		}

		self.SoundTbl_CallForHelp = gender == 1 && {
			"cpthazama/fnafsb/bot_sentry/sentrybot_00015_m.ogg",
		} or {
			"cpthazama/fnafsb/bot_sentry/sentrybot_00015_f.ogg",
		}

		local envLight = ents.Create("env_projectedtexture")
		envLight:SetLocalPos(self:GetPos())
		envLight:SetLocalAngles(self:GetAngles())
		envLight:SetKeyValue("lightcolor","255 255 255")
		envLight:SetKeyValue("lightfov","40")
		envLight:SetKeyValue("farz","1000")
		envLight:SetKeyValue("nearz","10")
		envLight:SetKeyValue("shadowquality","1")
		envLight:Input("SpotlightTexture",NULL,NULL,"effects/flashlight001")
		envLight:SetOwner(self)
		envLight:SetParent(self)
		envLight:Spawn()
		envLight:Fire("setparentattachment","flashlight")
		self:DeleteOnRemove(envLight)

		local glow1 = ents.Create("env_sprite")
		glow1:SetKeyValue("model","sprites/light_ignorez.vmt")
		glow1:SetKeyValue("scale","1")
		glow1:SetKeyValue("rendermode","9")
		glow1:SetKeyValue("rendercolor","255 255 255")
		glow1:SetKeyValue("spawnflags","0.1")
		glow1:SetParent(self)
		envLight:SetOwner(self)
		glow1:Fire("SetParentAttachment","flashlight",0)
		glow1:Spawn()
		self:DeleteOnRemove(glow1)

		local glowLight = ents.Create("light_dynamic")
		glowLight:SetKeyValue("brightness","4")
		glowLight:SetKeyValue("distance","30")
		glowLight:SetLocalPos(self:GetPos() +self:OBBCenter())
		glowLight:SetLocalAngles(self:GetAngles())
		glowLight:Fire("Color", "255 255 255")
		glowLight:SetParent(self)
		envLight:SetOwner(self)
		glowLight:Spawn()
		glowLight:Fire("TurnOn","",0)
		glowLight:Fire("SetParentAttachment","flashlight",0)
		self:DeleteOnRemove(glowLight)

		self:SetBodygroup(2,1)
		self:SetBodygroup(5,1)
	elseif staffType == 2 then -- Map
		self.AnimTbl_IdleStand = {ACT_IDLE_RELAXED}
		self.AnimTbl_Walk = {ACT_WALK}
		self.AnimTbl_Run = {ACT_RUN}

		self.PoseParameterLooking_Names = {pitch={"d_aim_pitch"}, yaw={"d_aim_yaw"}, roll={}}

		self.HasOnPlayerSight = true
		self.PlayerFriendly = true
		self.MoveOutOfFriendlyPlayersWay = false
		self.FriendsWithAllPlayerAllies = true
		self.Behavior = VJ_BEHAVIOR_PASSIVE
		self.DisableFindEnemy = true
		self.DisableMakingSelfEnemyToNPCs = true
		self.OnPlayerSightDistance = 1800

		self.TargetPlayers = {}

		local tbl = {}
		tbl[1] = {
			"cpthazama/fnafsb/bot_map/MAPBOT_00002_m.wav",
			"cpthazama/fnafsb/bot_map/MAPBOT_00003_m.wav",
		}
		tbl[2] = {
			"cpthazama/fnafsb/bot_map/MAPBOT_00002_f.wav",
			"cpthazama/fnafsb/bot_map/MAPBOT_00003_f.wav",
		}
		self.SoundTbl_Map = tbl[self.Gender]
	elseif staffType == 3 then -- Killer
		self.AnimTbl_IdleStand = {ACT_IDLE}
		self.AnimTbl_Walk = {ACT_WALK}
		self.AnimTbl_Run = {ACT_RUN}
		self.HasMeleeAttack = true
	elseif staffType == 4 then -- Blaster
		self.AnimTbl_IdleStand = {ACT_IDLE_HURT}
		self.AnimTbl_Walk = {ACT_WALK_STEALTH}
		self.AnimTbl_Run = {ACT_RUN_STEALTH}

		self.NoChaseAfterCertainRange = true

		self.SoundTbl_CombatIdle = gender == 1 && {"cpthazama/fnafsb/bot_alien/alienbot_00008_m.ogg","cpthazama/fnafsb/bot_alien/alienbot_00009_m.ogg","cpthazama/fnafsb/bot_alien/alienbot_00006_d.ogg","cpthazama/fnafsb/bot_alien/alienbot_00003_m.ogg","cpthazama/fnafsb/bot_alien/alienbot_00004_m.ogg"} or {"cpthazama/fnafsb/bot_alien/alienbot_00006_f.ogg","cpthazama/fnafsb/bot_alien/alienbot_00003_f.ogg","cpthazama/fnafsb/bot_alien/alienbot_00004_f.ogg","cpthazama/fnafsb/bot_alien/alienbot_00008_f.ogg","cpthazama/fnafsb/bot_alien/alienbot_00009_f.ogg",}
		self.SoundTbl_Alert = gender == 1 && {"cpthazama/fnafsb/bot_alien/alienbot_00007_m.ogg","cpthazama/fnafsb/bot_alien/alienbot_00005_m.ogg"} or {"cpthazama/fnafsb/bot_alien/alienbot_00007_f.ogg","cpthazama/fnafsb/bot_alien/alienbot_00005_f.ogg"}
		self.SoundTbl_OnKilledEnemy = gender == 1 && {"cpthazama/fnafsb/bot_alien/alienbot_00001_m.ogg"} or {"cpthazama/fnafsb/bot_alien/alienbot_00001_f.ogg"}

		self:Give("weapon_vj_fnafsb_blaster")

		self:SetBodygroup(2,1)
		self:SetBodygroup(5,1)
	end

	if self.OnInit then
		self:OnInit()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local ang_app = math.ApproachAngle
--
function ENT:DoPoseParameterLooking(resetPoses)
	if self.HasPoseParameterLooking == false then return end
	if resetPoses == true && IsValid(self.TargetPlayer) then resetPoses = false end
	resetPoses = resetPoses or false
	//self:GetPoseParameters(true)
	local ent = (self.VJ_IsBeingControlled == true and self.VJ_TheController) or self.TargetPlayer or self:GetEnemy()
	local p_enemy = 0 -- Pitch
	local y_enemy = 0 -- Yaw
	local r_enemy = 0 -- Roll
	if IsValid(ent) && resetPoses == false then
		local enemy_pos = (self.VJ_IsBeingControlled == true and self.VJ_TheControllerBullseye:GetPos()) or ent:GetPos() + ent:OBBCenter()
		local self_ang = self:GetAngles()
		local enemy_ang = (enemy_pos - (self:GetPos() + self:OBBCenter())):Angle()
		p_enemy = math.AngleDifference(enemy_ang.p, self_ang.p)
		if self.PoseParameterLooking_InvertPitch == true then p_enemy = -p_enemy end
		y_enemy = math.AngleDifference(enemy_ang.y, self_ang.y)
		if self.PoseParameterLooking_InvertYaw == true then y_enemy = -y_enemy end
		r_enemy = math.AngleDifference(enemy_ang.z, self_ang.z)
		if self.PoseParameterLooking_InvertRoll == true then r_enemy = -r_enemy end
	elseif self.PoseParameterLooking_CanReset == false then -- Should it reset its pose parameters if there is no enemies?
		return
	end
	
	self:CustomOn_PoseParameterLookingCode(p_enemy, y_enemy, r_enemy)
	
	local names = self.PoseParameterLooking_Names
	for x = 1, #names.pitch do
		self:SetPoseParameter(names.pitch[x], ang_app(self:GetPoseParameter(names.pitch[x]), p_enemy, self.PoseParameterLooking_TurningSpeed))
	end
	for x = 1, #names.yaw do
		self:SetPoseParameter(names.yaw[x], ang_app(self:GetPoseParameter(names.yaw[x]), y_enemy, self.PoseParameterLooking_TurningSpeed))
	end
	for x = 1, #names.roll do
		self:SetPoseParameter(names.roll[x], ang_app(self:GetPoseParameter(names.roll[x]), r_enemy, self.PoseParameterLooking_TurningSpeed))
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GetTurnDifference(pos)
	local ang = (pos -self:GetPos()):Angle()
	local dif = math.AngleDifference(self:GetAngles().y,ang.y)
	return dif
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	local movingFast = self:GetMovementActivity() == ACT_RUN
	self.MoveLoopSound:ChangePitch(movingFast && 115 or 100)
	self.MoveLoopSound:ChangeVolume(movingFast && 1 or 0.6)
	if self:IsMoving() then
		if !self.MoveLoopPlaying then
			self.MoveLoopPlaying = true
			self:PlayMoveLoop()
		end
	else
		self:StopMovementSound()
		self.MoveLoopPlaying = false
	end

	local staffType = self.StaffType
	if staffType == 0 then
		self:SetEnemy(NULL)
		self.Alerted = false
	elseif staffType == 2 then
		local ply = self.TargetPlayer
		local dist = self:VJ_GetNearestPointToEntityDistance(ply)
		self.DisableWandering = IsValid(ply)
		if IsValid(ply) then
			local gender = self.Gender
			if !IsValid(ply) or IsValid(ply) && (ply:Health() <= 0 /*or ply:IsFlagSet(FL_NOTARGET)*/ or (self:GetPos():Distance(ply:GetPos()) > 1000 && !self:Visible(ply))) or GetConVarNumber("ai_ignoreplayers") == 1 then
				self.TargetPlayer = NULL
				self:SetMapAnimation(false)
				self.NextAnnoyingT = CurTime() +math.Rand(10,15)
				return
			end
			if self.MapAnimSet == 0 then
				if self:BusyWithActivity() == false then
					self:SetTarget(ply)
					self:VJ_TASK_GOTO_TARGET("TASK_RUN_PATH")
					if dist < self.MeleeAttackDistance && ply:Visible(self) then
						self:VJ_ACT_PLAYACTIVITY(ACT_MELEE_ATTACK1,true,false,false,0,{OnFinish=function(interrupted,anim)
							-- if interrupted then return end
							if !IsValid(ply) then return end
							self:SetMapAnimation(true)
						end})
						self:VJ_FNAF_Jumpscare(ply,VJ_GetSequenceDuration(self,ACT_MELEE_ATTACK1),2,nil,VJ_PICK({"cpthazama/fnafsb/sfx_mapbot_jumpscare.wav","cpthazama/fnafsb/sfx_mapbot_jumpscare_02.wav"}))
					end
				end
				return
			end
			local vel = ply:GetVelocity()
			local tr = util.TraceLine({
				start = ply:GetPos(),
				endpos = ply:GetPos() +ply:GetForward() *80,
				filter = {self,ply}
			})
			local tPos = tr.HitPos
			local dist = self:GetPos():Distance(tPos)
			-- self:SetAngles(Angle(0,(ply:GetPos() -self:GetPos()):Angle().y,0))
			if CurTime() > self.NextAnnoyingT then
				VJ_CreateSound(self,self.SoundTbl_Map,75)
				self.NextAnnoyingT = CurTime() +math.Rand(6,12)
			end
			if self:IsBusy() == false then
				local tDif = self:GetTurnDifference(ply:GetPos())
				if dist > 35 then
					self:SetLastPosition(tPos)
					local movet = "TASK_RUN_PATH"
					self:VJ_TASK_GOTO_LASTPOS(movet)
				else
					if math.abs(tDif) > 100 then
						self:SetTarget(ply)
						self:VJ_TASK_FACE_X("TASK_FACE_TARGET")
					end
				end
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_AfterChecks(hitEnt, isProp)
	if isProp then
		return true
	end
	if !IsValid(hitEnt) or IsValid(hitEnt) && (hitEnt.VJ_FNaF_KillTime && hitEnt.VJ_FNaF_KillTime > CurTime()) then return false end
	local staffType = self.StaffType
	local animTime = VJ_GetSequenceDuration(self,ACT_MELEE_ATTACK1)
	if staffType == 3 then
		self:VJ_FNAF_Attack(hitEnt,animTime,2,nil,"cpthazama/fnafsb/sfx_jumpScare_sewer.wav")
	else
		self:VJ_FNAF_Jumpscare(hitEnt,animTime,2,nil,staffType == 2 && VJ_PICK({"cpthazama/fnafsb/sfx_mapbot_jumpscare.wav","cpthazama/fnafsb/sfx_mapbot_jumpscare_02.wav"}) or "cpthazama/fnafsb/common/sfx_chica_sting_bathroom_reveal.wav")
		timer.Simple(animTime,function()
			if IsValid(self) && IsValid(hitEnt) then
				self:VJ_ACT_PLAYACTIVITY("halt",true,false,true)
				VJ_CreateSound(self,"cpthazama/fnafsb/bot/sfx_staffBot_security_alert_0" .. math.random(1,3) .. ".wav")
				self:VJ_FNAF_BringAlertedAllies(self.CallForHelpDistance,hitEnt)
				self:Allies_CallHelp(self.CallForHelpDistance)
			end
		end)
	end
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDoKilledEnemy(ent, attacker, inflictor)
	if ent:IsPlayer() && attacker == self && self.HasMeleeAttack == true then
		net.Start("VJ_FNaF_DeathScreen_End")
			net.WriteEntity(ent)
		net.Send(ent)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:PlayMoveLoop()
	self.MoveLoopSound:Stop()
	self.MoveLoopSound:Play()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:StopMovementSound()
	self.MoveLoopSound:Stop()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:PlayMovementSound()
	if self:IsMoving() then
		self.MoveLoopPlaying = true
		self:PlayMoveLoop()
	else
		self.MoveLoopPlaying = false
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_BeforeCorpseSpawned()
	if self.StaffType == 0 then
		self:SetBodygroup(1,0)
		self:SetBodygroup(4,0)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	self.MoveLoopSound:Stop()
end