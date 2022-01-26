AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2022 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/fnaf_sb/chica_shattered.mdl"}
ENT.StartHealth = 500

ENT.VJ_NPC_Class = {"CLASS_FNAF_ANIMATRONIC","CLASS_FNAF_BURNTRAP"}

ENT.VJC_Data = {
	CameraMode = 1, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
	ThirdP_Offset = Vector(0, 30, -40), -- The offset for the controller when the camera is in third person
	FirstP_Bone = "HeadMiddle_Jiggle_jnt", -- If left empty, the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(8, 0, 0), -- The offset for the controller when the camera is in first person
	FirstP_ShrinkBone = false, -- Should the bone shrink? Useful if the bone is obscuring the player's view
	FirstP_UseBoneAng = true, -- Should the camera's angle be affected by the bone's angle?
	FirstP_BoneAngAdjust = 0, -- How much should the camera's angle be rotated by? (Useful for weird bone angles, this is the roll angle)
}

ENT.Bleeds = false

ENT.HullType = HULL_HUMAN

ENT.HasMeleeAttack = true
ENT.MeleeAttackDistance = 40
ENT.MeleeAttackDamageDistance = 110
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1}
-- ENT.MeleeAttackAnimationDecreaseLengthAmount = 3
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

ENT.SoundTbl_FootStepAdd = {
	"cpthazama/fnafsb/chica/fx/fly_chica_shattered_add_01.wav",
	"cpthazama/fnafsb/chica/fx/fly_chica_shattered_add_02.wav",
	"cpthazama/fnafsb/chica/fx/fly_chica_shattered_add_03.wav",
	"cpthazama/fnafsb/chica/fx/fly_chica_shattered_add_04.wav",
	"cpthazama/fnafsb/chica/fx/fly_chica_shattered_add_05.wav",
	"cpthazama/fnafsb/chica/fx/fly_chica_shattered_add_06.wav"
}
ENT.SoundTbl_FootStep = {
	"cpthazama/fnafsb/chica/fx/fly_chica_run_01.wav",
	"cpthazama/fnafsb/chica/fx/fly_chica_run_02.wav",
	"cpthazama/fnafsb/chica/fx/fly_chica_run_03.wav",
	"cpthazama/fnafsb/chica/fx/fly_chica_run_04.wav",
	"cpthazama/fnafsb/chica/fx/fly_chica_run_05.wav",
	"cpthazama/fnafsb/chica/fx/fly_chica_run_06.wav",
	"cpthazama/fnafsb/chica/fx/fly_chica_run_07.wav",
	"cpthazama/fnafsb/chica/fx/fly_chica_run_08.wav",
	"cpthazama/fnafsb/chica/fx/fly_chica_run_09.wav",
	"cpthazama/fnafsb/chica/fx/fly_chica_run_10.wav",
	"cpthazama/fnafsb/chica/fx/fly_chica_run_11.wav",
	"cpthazama/fnafsb/chica/fx/fly_chica_run_12.wav"
}
ENT.SoundTbl_Idle = {
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_low_01.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_low_02.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_low_03.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_low_04.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_low_05.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_low_06.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_low_07.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_low_08.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_low_09.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_low_10.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_low_11.ogg"
}
ENT.SoundTbl_CombatIdle = {
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_01.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_02.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_03.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_04.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_05.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_06.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_07.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_08.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_09.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_10.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_11.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_12.ogg"
}
ENT.SoundTbl_Investigate = {
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_low_01.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_low_02.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_low_03.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_low_04.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_low_05.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_low_06.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_low_07.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_low_08.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_low_09.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_low_10.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_low_11.ogg"
}
ENT.SoundTbl_LostEnemy = {
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_low_01.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_low_02.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_low_03.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_low_04.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_low_05.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_low_06.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_low_07.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_low_08.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_low_09.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_low_10.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_low_11.ogg"
}
ENT.SoundTbl_Alert = {
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_01.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_02.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_03.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_04.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_05.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_06.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_07.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_08.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_09.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_10.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_11.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_12.ogg"
}
ENT.SoundTbl_Pain = {
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_01.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_02.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_03.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_04.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_05.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_06.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_07.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_08.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_09.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_10.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_11.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_12.ogg"
}
ENT.SoundTbl_Death = {
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_01.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_02.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_03.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_04.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_05.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_06.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_07.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_08.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_09.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_10.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_11.ogg",
	"cpthazama/fnafsb/chica/broken/sfx_chica_shattered_vox_high_12.ogg"
}

local nwName = "VJ_FNaF_ChicaShattered_Controller"
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
	self.InAttack = false

	self:SetCollisionBounds(Vector(13,13,80),Vector(-13,-13,0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnShocked()
	VJ_CreateSound(self,self.SoundTbl_Pain)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "step" then
		VJ_EmitSound(self,self.SoundTbl_FootStep,75,math.random(90,110))
		VJ_EmitSound(self,self.SoundTbl_FootStepAdd,75,math.random(90,110))
		local servo = math.random(1,14)
		VJ_EmitSound(self,"cpthazama/fnafsb/chica/fx/sfx_chica_servo_short_" .. (servo < 10 && ("0" .. servo) or servo) .. ".wav",80,math.random(90,110))
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert(ent)
	self:VJ_FNAF_Stinger(ent)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_AfterChecks(hitEnt, isProp)
	if isProp then
		return true
	end
	self:VJ_FNAF_Attack(hitEnt,VJ_GetSequenceDuration(self,ACT_MELEE_ATTACK1),2,nil,"cpthazama/fnafsb/sfx_jumpScare_shattered_chica.wav")
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