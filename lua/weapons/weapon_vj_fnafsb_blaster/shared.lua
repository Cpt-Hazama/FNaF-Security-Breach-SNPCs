if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base 						= "weapon_vj_base"
SWEP.PrintName					= "Faz-Blaster"
SWEP.Author 					= "Cpt. Hazama"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose					= "This weapon is made for Players and NPCs"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "Five Nights At Freddy's"
	-- Client Settings ---------------------------------------------------------------------------------------------------------------------------------------------
if CLIENT then
	SWEP.Slot						= 1 -- Which weapon slot you want your SWEP to be in? (1 2 3 4 5 6) 
	SWEP.SlotPos					= 1 -- Which part of that slot do you want the SWEP to be in? (1 2 3 4 5 6)
	SWEP.SwayScale 					= 2 -- Default is 1, The scale of the viewmodel sway
	SWEP.UseHands					= true
	SWEP.ViewModelFOV				= 40
end
	-- NPC Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.NPC_NextPrimaryFire 		= 0.9 -- Next time it can use primary fires
	-- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.ViewModel					= "models/cpthazama/fnaf_sb/weapons/c_fazblaster.mdl"
SWEP.WorldModel					= "models/cpthazama/fnaf_sb/weapons/w_fazblaster.mdl"
SWEP.HoldType 					= "pistol"
SWEP.Spawnable					= true
SWEP.AdminSpawnable				= false
	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Damage				= 0.1 -- Damage
SWEP.Primary.Force				= 1 -- Force applied on the object the bullet hits
SWEP.Primary.ClipSize			= 5 -- Max amount of bullets per clip
SWEP.Primary.Recoil				= 1 -- How much recoil does the player get?
SWEP.Primary.Delay				= 0.2 -- Time until it can shoot again
SWEP.Primary.Automatic			= false -- Is it automatic?
SWEP.Primary.Tracer				= 0 -- Is it automatic?
-- SWEP.Primary.TracerName			= "VJ_FNaF_Laser" -- Is it automatic?
SWEP.Primary.Ammo				= "CombineHeavyCannon" -- Ammo type
SWEP.Primary.Sounds				= {
	"cpthazama/fnafsb/weapons/sfx_fazerblast_shot_player_01.wav",
	"cpthazama/fnafsb/weapons/sfx_fazerblast_shot_player_02.wav",
	"cpthazama/fnafsb/weapons/sfx_fazerblast_shot_player_03.wav",
	"cpthazama/fnafsb/weapons/sfx_fazerblast_shot_player_04.wav",
	"cpthazama/fnafsb/weapons/sfx_fazerblast_shot_player_05.wav",
	"cpthazama/fnafsb/weapons/sfx_fazerblast_shot_player_06.wav",
}
-- SWEP.Primary.DisableBulletCode	= true -- The bullet won't spawn, this can be used when creating a projectile-based weapon
SWEP.PrimaryEffects_MuzzleAttachment = 1
SWEP.PrimaryEffects_SpawnShells = false
	-- Deployment Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.DelayOnDeploy 				= 0.6 -- Time until it can shoot again after deploying the weapon
	-- Idle Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.HasIdleAnimation			= true -- Does it have a idle animation?
SWEP.AnimTbl_Idle				= {ACT_VM_IDLE}
SWEP.NextIdle_Deploy			= 0.5 -- How much time until it plays the idle animation after the weapon gets deployed
SWEP.NextIdle_PrimaryAttack		= 0.5 -- How much time until it plays the idle animation after attacking(Primary)

SWEP.WorldModel_UseCustomPosition = true -- Should the gun use custom position? This can be used to fix guns that are in the crotch
SWEP.WorldModel_CustomPositionAngle = Vector(0,0,180)
SWEP.WorldModel_CustomPositionOrigin = Vector(-1,2,0.5)
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.ChargeT = 0
SWEP.PrimaryPitch = 100
SWEP.BlasterDamage = 10
SWEP.BlasterChargeDelay = 15
SWEP.CanDamage = false
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:PreDrawViewModel(vm, weapon, ply)
	vm:SetSkin(0)
	self:SetSkin(0)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:SetLight(b)
	if CLIENT then return end
	local owner = self:GetOwner()
	if !owner:IsPlayer() then return end
	if b then
		if IsValid(self.Light) then return end
		local envLight = ents.Create("env_projectedtexture")
		envLight:SetLocalPos(owner:EyePos())
		envLight:SetLocalAngles(owner:EyeAngles())
		envLight:SetKeyValue("lightcolor","255 0 0")
		envLight:SetKeyValue("lightfov","60")
		envLight:SetKeyValue("farz","200")
		envLight:SetKeyValue("nearz","10")
		envLight:SetKeyValue("shadowquality","1")
		envLight:SetKeyValue("brightnessscale","0.25")
		envLight:Input("SpotlightTexture",NULL,NULL,"effects/flashlight001")
		envLight:SetOwner(owner)
		-- envLight:SetParent(owner)
		envLight:Spawn()
		-- envLight:Fire("setparentattachment","anim_attachment_RH")
		self:DeleteOnRemove(envLight)

		local hookName = "VJ_FNaF_Light_" .. self:EntIndex()
		hook.Add("Think",hookName,function()
			if !IsValid(self) or !IsValid(envLight) then
				hook.Remove("Think",hookName)
				return
			end
			-- if envLight.DoRemove then
			-- 	envLight:Remove()
			-- 	hook.Remove("Think",hookName)
			-- 	return
			-- end
			local FT = FrameTime() *35
			-- local pos = LerpVector(FT,envLight:GetPos(),owner:GetShootPos() +owner:GetAimVector() *40 +Vector(0,0,-10))
			-- local ang = LerpAngle(FT,envLight:GetAngles(),owner:EyeAngles())
			local aimPos = owner:GetShootPos()
			aimPos.y = aimPos.y -10
			aimPos.z = aimPos.z -6
			local pos = aimPos +owner:GetAimVector() *20
			local ang = owner:EyeAngles()
			envLight:SetPos(pos)
			envLight:SetAngles(ang)
		end)
		-- hook.Add("OnPlayerPhysicsPickup",hookName,function(ply)
		-- 	if !IsValid(self) or !IsValid(envLight) then
		-- 		hook.Remove("OnPlayerPhysicsPickup",hookName)
		-- 		return
		-- 	end
		-- 	envLight.DoRemove = true
		-- 	SafeRemoveEntity(envLight)
		-- 	SafeRemoveEntity(ply:GetActiveWeapon().Light)
		-- end)

		self.Light = envLight
	else
		SafeRemoveEntity(self.Light)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnDeploy()
	self:SetLight(true)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnRemove()
	self:SetLight(false)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnInitialize()
	if self.OnInit then self:OnInit() end
	timer.Simple(0.1,function()
		if IsValid(self) && IsValid(self.Owner) then
			self.Owner:SetNW2Bool("VJ_FNaF_ViewMode",false)
		end
	end)
	timer.Simple(0.1,function() -- Minag mikani modelner tske, yete ooresh model-e, serpe as zenke
		if IsValid(self) && IsValid(self:GetOwner()) then
			local owner = self:GetOwner()
			if owner.VJ_FNaF_StaffBot then
				self.WorldModel_CustomPositionBone = "R_Wrist2_jnt"
				self.WorldModel_CustomPositionAngle = Vector(7, 170, 180)
				self.WorldModel_CustomPositionOrigin = Vector(-1, 5, 0)
				self.CanDamage = true
			end
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:NPCAbleToShoot()
	local owner = self:GetOwner()
	if IsValid(owner) && owner:IsNPC() then
		local ene = owner:GetEnemy()
		if (owner.IsVJBaseSNPC_Human && IsValid(ene) && owner:IsAbleToShootWeapon(true, true) == false) or (self.NPC_StandingOnly == true && owner:IsMoving()) then
			return false
		end
		if owner:GetActivity() != nil && ((owner.IsVJBaseSNPC_Human == true && owner.DoingWeaponAttack == true && (/*(owner.CurrentWeaponAnimation == owner:GetSequenceActivity(owner:GetSequence())) or*/ (owner.CurrentWeaponAnimation == owner:GetActivity()) or (owner:GetActivity() == owner:TranslateToWeaponAnim(owner.CurrentWeaponAnimation)) or (!owner.DoingWeaponAttack_Standing))) or (!owner.IsVJBaseSNPC_Human)) then
			-- For VJ Humans only, ammo check
			if owner.IsVJBaseSNPC_Human && owner.AllowWeaponReloading == true && self:Clip1() <= 0 then -- No ammo!
				if owner.VJ_IsBeingControlled == true then owner.VJ_TheController:PrintMessage(HUD_PRINTCENTER, "Press R to reload!") end
				if self.IsMeleeWeapon == false && self.HasDryFireSound == true && CurTime() > self.NextNPCDrySoundT then
					local sdtbl = VJ_PICK(self.DryFireSound)
					if sdtbl != false then owner:EmitSound(sdtbl, 80, math.random(self.DryFireSoundPitch.a, self.DryFireSoundPitch.b)) end
					if self.NPC_NextPrimaryFire != false then
						self.NextNPCDrySoundT = CurTime() + self.NPC_NextPrimaryFire
					end
				end
				return false
			end
			if IsValid(ene) && ((!owner.VJ_IsBeingControlled) or (owner.VJ_IsBeingControlled && owner.VJ_TheController:KeyDown(IN_ATTACK2))) && !owner:IsBusy() then
				return true
			end
		end
	end
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnPrimaryAttack_BulletCallback(attacker,tr,dmginfo)
	local muzzleattach = self.PrimaryEffects_MuzzleAttachment
	if isnumber(muzzleattach) == false then muzzleattach = self:LookupAttachment(muzzleattach) end
	local vjeffectmuz = EffectData()
	vjeffectmuz:SetOrigin(tr.HitPos)
	vjeffectmuz:SetEntity(self)
	vjeffectmuz:SetStart(self.Owner:GetShootPos())
	vjeffectmuz:SetNormal(self.Owner:GetAimVector())
	vjeffectmuz:SetAttachment(muzzleattach)
	util.Effect("VJ_FNaF_Laser",vjeffectmuz)

	dmginfo:SetDamage(self.CanDamage && self.Owner:VJ_GetDifficultyValue(self.BlasterDamage) or 0)
	dmginfo:SetDamageForce(Vector(0,0,0))

	local ent = tr.Entity
	if self.CanDamage then
		self.Owner:RestartGesture(ACT_GESTURE_RANGE_ATTACK1)
		return
	end
	if ent.VJ_FNaF_CanBeStunned then
		if SERVER then
			ent:VJ_FNaF_Stun(attacker)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnPrimaryAttack_AfterShoot()
	sound.Play(VJ_PICK(self.Primary.Sounds), self.Owner:GetPos(), 80, self.PrimaryPitch, 1)
	self.ChargeT = CurTime() +self.BlasterChargeDelay
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:ChangeFireRate()
	local int = 0.9
	local diff = GetConVar("vj_npc_difficulty"):GetInt()
	if diff == -3 then
		int = int *4
	elseif diff == -2 then
		int = int *2.75
	elseif diff == -1 then
		int = int *2
	elseif diff == 0 then -- Normal
		int = int
	elseif diff == 1 then
		int = int *0.9
	elseif diff == 2 then
		int = int *0.7
	elseif diff == 3 then
		int = int *0.6
	elseif diff == 4 then
		int = int *0.45
	elseif diff == 5 then
		int = int *0.3
	elseif diff == 6 then
		int = int *0.1
	end
	self.NPC_NextPrimaryFire = int
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnThink()
	self:SetSkin(0)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnThink()
	local owner = self:GetOwner()
	self:OnThink()
	if CLIENT then
		-- if owner:IsPlayer() then
		-- 	local dlight = DynamicLight(owner:EntIndex() )
		-- 	if (dlight) then
		-- 		dlight.pos = owner:GetShootPos()
		-- 		dlight.dir = owner:GetAimVector()
		-- 		dlight.innerangle = 1
		-- 		dlight.outerangle = 70
		-- 		dlight.r = 255
		-- 		dlight.g = 0
		-- 		dlight.b = 0
		-- 		dlight.brightness = 2
		-- 		dlight.Decay = 1000
		-- 		dlight.Size = 256
		-- 		dlight.DieTime = CurTime() + 1
		-- 	end
		-- end
		return
	end
	if owner:IsNPC() then
		self:ChangeFireRate()
	end
	if self.CanDamage or (owner:IsPlayer() && owner:HasGodMode()) then
		self:SetClip1(self.Primary.ClipSize)
	end
	if IsValid(owner) && owner:IsPlayer() then
		local clip1 = self:Clip1()
		if CurTime() > self.ChargeT && clip1 < self.Primary.ClipSize then
			self:SetClip1(clip1 +1)
			if SERVER then
				VJ_EmitSound(self,self:Clip1() == self.Primary.ClipSize && "cpthazama/fnafsb/weapons/sfx_fazerblaster_recharge_fullyCharged.wav" or "cpthazama/fnafsb/weapons/sfx_fazerblaster_recharge_singleBar.wav")
			end
			self.ChargeT = CurTime() +1
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnPrimaryAttackEffects()
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnHolster(newWep)
	self:SetLight(false)
	self.Owner:SetNW2Bool("VJ_FNaF_ViewMode",false)
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:Reload()
	if !IsFNaFGamemode() then return end

	self.NextReload = self.NextReload or 0
	if CurTime() < self.NextReload then return end

	self.Owner:SetNW2Bool("VJ_FNaF_ViewMode",!self.Owner:GetNW2Bool("VJ_FNaF_ViewMode"))
	self.NextReload = CurTime() +0.25
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CalcView(ply,pos,ang,fov)
	if !IsFNaFGamemode() then return pos, ang, fov end
	if ply != self.Owner then return pos, ang, fov end

	if self.Owner:GetNW2Bool("VJ_FNaF_ViewMode") == true then
		local att = ply:LookupAttachment("eyes")
		local startPos = att > 0 && ply:GetAttachment(att).Pos or ply:EyePos()
		local tr = util.TraceLine({
			start = startPos,
			endpos = startPos +ply:GetAimVector() *-60 +ply:GetRight() *30,
			filter = ply
		})
		pos = tr.HitPos +tr.HitNormal *4
		return pos, ang, fov
	end

	local realspeed = ply:GetVelocity():Length2D() /ply:GetRunSpeed()
	local bobspeed = math.Clamp(realspeed *1.1, 0, 1)
	local speed = math.Clamp(ply:GetVelocity():Length2DSqr() /ply:GetRunSpeed(), 0.25, 1)
	local bob_x = math.sin((CurTime() *6) *speed *1.25) *speed *bobspeed
	ang[3] = bob_x *1.35

	return pos, ang, fov
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CalcViewModelView(vm, OldEyePos, OldEyeAng, EyePos, EyeAng) -- Credits to Rex for the sway code, he did a really good job on it. Used without permission but he loves Daddy so I'm sure he won't mind ;)
	local EyePos, EyeAng = self:GetViewModelPosition(OldEyePos, OldEyeAng)
	local ply = self:GetOwner()
	local EyePos = OldEyePos
	local EyeAng = OldEyeAng

	local realspeed = ply:GetVelocity():Length2D() /ply:GetRunSpeed()
	local speed = math.Clamp(ply:GetVelocity():Length2DSqr() /ply:GetRunSpeed(), 0.25, 1)

	local bob_x_val = CurTime()*8
	local bob_y_val = CurTime()*16
	
	local bob_x = math.sin(bob_x_val*0.15)*0.1
	local bob_y = math.sin(bob_y_val*0.15)*0.05
	EyePos = EyePos + EyeAng:Right()*bob_x
	EyePos = EyePos + EyeAng:Up()*bob_y
	EyeAng:RotateAroundAxis(EyeAng:Forward(), 5 *bob_x)
	
	local speed_mul = 3
	if self:GetOwner():IsOnGround() && realspeed > 0.1 then
		local bobspeed = math.Clamp(realspeed*1.1, 0, 1)
		local bob_x = math.sin(bob_x_val*1*speed) *0.1 *bobspeed
		local bob_y = math.cos(bob_y_val*1*speed) *0.125 *bobspeed
		EyePos = EyePos + EyeAng:Right()*bob_x*speed_mul *0.65
		EyePos = EyePos + EyeAng:Up() *bob_y *speed_mul *1.5
	end

	if FrameTime() < 0.04 then
		if !self.SwayPos then self.SwayPos = Vector() end
		local vel = ply:GetVelocity()
		vel.x = math.Clamp(vel.x/1000, -0.5, 0.5)
		vel.y = math.Clamp(vel.y/1000, -0.5, 0.5)
		vel.z = math.Clamp(vel.z/750, -1, 0.5)
		
		self.SwayPos = LerpVector(FrameTime()*25, self.SwayPos, -vel)
		EyePos = EyePos + self.SwayPos
	end

	local EyePos, EyeAng = self:GetViewModelPosition(EyePos, EyeAng)
	return EyePos, EyeAng
end