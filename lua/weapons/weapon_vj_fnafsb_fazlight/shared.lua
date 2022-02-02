if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base 						= "weapon_vj_base"
SWEP.PrintName					= "Faz-Flashlight"
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
SWEP.ViewModel					= "models/cpthazama/fnaf_sb/weapons/c_flashlight.mdl"
SWEP.WorldModel					= "models/cpthazama/fnaf_sb/weapons/w_flashlight.mdl"
SWEP.HoldType 					= "physgun"
SWEP.Spawnable					= true
SWEP.AdminSpawnable				= false
	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.ClipSize			= 0 -- Max amount of bullets per clip
SWEP.Primary.DisableBulletCode	= true -- The bullet won't spawn, this can be used when creating a projectile-based weapon
SWEP.PrimaryEffects_SpawnShells = false
SWEP.PrimaryEffects_MuzzleFlash = false
SWEP.PrimaryEffects_SpawnDynamicLight = false
	-- Deployment Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.DelayOnDeploy 				= 0.6 -- Time until it can shoot again after deploying the weapon
	-- Idle Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.HasIdleAnimation			= true -- Does it have a idle animation?
SWEP.AnimTbl_Idle				= {ACT_VM_IDLE}
SWEP.NextIdle_Deploy			= 0.5 -- How much time until it plays the idle animation after the weapon gets deployed
SWEP.NextIdle_PrimaryAttack		= 0.5 -- How much time until it plays the idle animation after attacking(Primary)

SWEP.WorldModel_UseCustomPosition = true -- Should the gun use custom position? This can be used to fix guns that are in the crotch
SWEP.WorldModel_CustomPositionAngle = Vector(0,0,-90)
SWEP.WorldModel_CustomPositionOrigin = Vector(-0.5,3,-1.35)
SWEP.WorldModel_CustomPositionBone = "ValveBiped.Bip01_R_Hand"
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.ViewModelAdjust = {
	Pos = {x=0,y=3,z=-2},
	Ang = {r=5,p=0,y=0},
}
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:GetViewModelPosition(pos,ang)
	pos:Add(ang:Right() *(self.ViewModelAdjust.Pos.x))
	pos:Add(ang:Forward() *(self.ViewModelAdjust.Pos.y))
	pos:Add(ang:Up() *(self.ViewModelAdjust.Pos.z))
	ang:RotateAroundAxis(ang:Right(),self.ViewModelAdjust.Ang.r)
	ang:RotateAroundAxis(ang:Forward(),self.ViewModelAdjust.Ang.p)
	ang:RotateAroundAxis(ang:Up(),self.ViewModelAdjust.Ang.y)

	return pos,ang
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnInitialize()
	self.NextBatteryDrain = 0
	self:SetNW2Bool("ViewMode",false)
	if CLIENT then
		local hName = "TP_" .. self.Owner:EntIndex()
		hook.Add("ShouldDrawLocalPlayer",hName,function(ply)
			if !IsValid(self) or IsValid(self) && IsValid(self.Owner) && !self.Owner:IsPlayer() then
				hook.Remove("ShouldDrawLocalPlayer",hName)
				return false
			end
			if !IsFNaFGamemode() then
				return false
			end
			return self:GetNW2Bool("ViewMode")
		end)
	end
	if self.Owner:IsNPC() then
		self:SetFlashlight(true)
		self.WorldModel_CustomPositionAngle = Vector(0,0,-90)
		self.WorldModel_CustomPositionOrigin = Vector(-0.5,3,-1.35)
		self.WorldModel_CustomPositionBone = "ValveBiped.Bip01_R_Hand"
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnDeploy()
	self:SetFlashlight(true)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnHolster(newWep)
	self:SetFlashlight(nil,true)
	self:SetNW2Bool("ViewMode",false)
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnRemove()
	self:SetFlashlight(nil,true)
end	
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:NPCAbleToShoot() return false end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:SetFlashlight(enable,reset)
	if CLIENT then return end
	local ply = self.Owner
	if IsValid(ply) && ply:IsPlayer() then
		if reset then
			ply:AllowFlashlight(true)
			ply:Flashlight(false)
			-- SafeRemoveEntity(self.Glow)
			return
		end
		if enable then
			if ply:Armor() <= 0 then return end
			ply:AllowFlashlight(true)
			ply:Flashlight(true)
			ply:AllowFlashlight(false)

			-- local vm = ply:GetViewModel()
			-- if !IsValid(vm) then return end
			-- local glow1 = ents.Create("env_sprite")
			-- glow1:SetKeyValue("model","sprites/light_ignorez.vmt")
			-- glow1:SetKeyValue("scale","0.4")
			-- glow1:SetKeyValue("rendermode","5")
			-- glow1:SetKeyValue("rendercolor","255 255 255")
			-- glow1:SetKeyValue("spawnflags","0.1")
			-- glow1:SetParent(vm)
			-- glow1:Fire("SetParentAttachment","flashlight",0)
			-- glow1:Spawn()
			-- self:DeleteOnRemove(glow1)
			-- self.Glow = glow1
		else
			ply:AllowFlashlight(true)
			ply:Flashlight(false)
			ply:AllowFlashlight(false)
			-- SafeRemoveEntity(self.Glow)
		end
	else
		if reset then
			SafeRemoveEntity(self.Light1)
			SafeRemoveEntity(self.Light2)
			return
		end
		if enable then
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
			glow1:SetOwner(self)
			glow1:Fire("SetParentAttachment","flashlight",0)
			glow1:Spawn()
			self:DeleteOnRemove(glow1)

			self.Light1 = envLight
			self.Light2 = glow1
		else
			SafeRemoveEntity(self.Light1)
			SafeRemoveEntity(self.Light2)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:PrimaryAttack()
	if self.Owner:IsNPC() then return end
	if (self:GetNextPrimaryFire() > CurTime()) then return end
	local owner = self:GetOwner()

	if owner:IsPlayer() then
		self:SendWeaponAnim(VJ_PICK(self.AnimTbl_PrimaryFire))
		self:SetFlashlight(!owner:FlashlightIsOn())
	end
	self:SetNextPrimaryFire(CurTime() +self.NextIdle_PrimaryAttack +0.1)
	timer.Simple(self.NextIdle_PrimaryAttack, function() if IsValid(self) then self:DoIdleAnimation() end end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnThink()
	if CLIENT then return end
	local ply = self.Owner
	if ply:IsNPC() then
		self:SetClip1(1)
		return
	end
	local isOn = ply:FlashlightIsOn()
	local battery = ply:Armor()

	if battery > ply:GetMaxArmor() then
		ply:SetArmor(ply:GetMaxArmor())
	end

	if isOn then
		-- if IsValid(self.Glow) then
		-- 	self.Glow:SetAngles(ply:EyeAngles())
		-- end
		if battery > 0 then
			if ply:HasGodMode() then return end
			if CurTime() < self.NextBatteryDrain then return end
			ply:SetArmor(battery -1)
			self.NextBatteryDrain = CurTime() +2
		else
			self:SetFlashlight(false)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:SecondaryAttack()
	if (self:GetNextSecondaryFire() > CurTime()) then return end
	if !IsFNaFGamemode() then return end
	local owner = self:GetOwner()
	local tr = owner:GetEyeTrace()
	local ent = tr.Entity
	if IsValid(ent) && ent:GetPos():Distance(owner:GetPos()) <= 60 && !ent:IsNPC() && !ent:IsPlayer() && ent:Health() > 0 then
		owner:ViewPunch(Angle(math.Rand(-2,-4),math.Rand(-1,1),math.Rand(-1,1)))
		ent:TakeDamage(math.random(2,5),owner,owner)
		VJ_CreateSound(owner,"physics/body/body_medium_impact_hard" .. math.random(1,6) .. ".wav",75)
	end

	self:SetNextSecondaryFire(CurTime() +1)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:Reload()
	if !IsFNaFGamemode() then return end

	self.NextReload = self.NextReload or 0
	if CurTime() < self.NextReload then return end

	self:SetNW2Bool("ViewMode",!self:GetNW2Bool("ViewMode"))
	self.NextReload = CurTime() +0.25
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:DrawHUD()
	local ply = self.Owner
	if ply != LocalPlayer() then return end

	local ammo = ply:Armor()
	local maxAmmo = ply:GetMaxArmor()
	local ammoPercent = ammo /maxAmmo
	local smooth = 8
	local posX = 0.435
	local posY = 0.89
	local bX = 325
	local bY = 130
	-- draw.RoundedBox(1,ScrW() *posX,ScrH() *posY,bX,bY,Color(255,102,0,255))
	-- draw.RoundedBox(smooth,ScrW() *posX,ScrH() *posY,bX *ammoPercent,bY,Color(0,225,255,255))

	surface.SetDrawColor(255,153,0)
	surface.SetMaterial(Material("hud/fnaf/BatteryHUD.png"))
	surface.DrawTexturedRect(ScrW() *posX,ScrH() *posY,bX *1.05,bY *1.05)

	-- local m1, m2, m3 = 1.013, 1.1, 1.19
	local mTb = {1.013, 1.1, 1.19}
	for i = 1,3 do
		surface.SetMaterial(Material("hud/fnaf/BatteryHUD_Slot.png"))
		surface.DrawTexturedRect(ScrW() *posX *mTb[i],ScrH() *posY *1.009,bX *0.33,bY *0.83)
	end

	ammoPercent = ammoPercent *100
	local fillSlots = ammoPercent >= 66 && 3 or ammoPercent < 66 && ammoPercent >= 33 && 2 or ammoPercent < 33 && ammoPercent > 0 && 1 or 0
	if fillSlots <= 0 then return end
	surface.SetDrawColor(0,238,255)
	for i = 1, fillSlots do
		surface.SetMaterial(Material("hud/fnaf/BatteryHUD_Fill.png"))
		surface.DrawTexturedRect(ScrW() *posX *mTb[i],ScrH() *posY *1.009,bX *0.33,bY *0.83)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnPrimaryAttackEffects()
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CalcView(ply,pos,ang,fov)
	if !IsFNaFGamemode() then return pos, ang, fov end
	if ply != self.Owner then return pos, ang, fov end

	if self:GetNW2Bool("ViewMode") == true then
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
function SWEP:CalcViewModelView(ViewModel, OldEyePos, OldEyeAng, EyePos, EyeAng) -- Credits to Rex for the sway code, he did a really good job on it. Used without permission but he loves Daddy so I'm sure he won't mind ;)
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
		local bob_x = math.sin(bob_x_val*1*speed)*0.2*bobspeed
		local bob_y = math.cos(bob_y_val*1*speed)*0.1*bobspeed
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