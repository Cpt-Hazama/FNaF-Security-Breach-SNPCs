/*--------------------------------------------------
	*** Copyright (c) 2012-2022 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
AddCSLuaFile()
if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end

ENT.Base 			= "base_gmodentity"
ENT.Type 			= "anim"
ENT.PrintName 		= "Pizza Box"
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose 		= ""
ENT.Instructions 	= ""
ENT.Category		= "Five Nights At Freddy's"

ENT.Spawnable = true
ENT.AdminOnly = false
---------------------------------------------------------------------------------------------------------------------------------------------
if CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if !SERVER then return end

function ENT:Initialize()
	self:SetModel("models/cpthazama/fnaf_sb/props/pizza_box.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	self.FNaF_Pizza = true
	self.BeenEaten = false
	
	local phys = self:GetPhysicsObject()
	if phys and IsValid(phys) then
		phys:Wake()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Think()
	if self.BeenEaten then return end
	for _,v in pairs(ents.FindInSphere(self:GetPos(),800)) do
		if v:IsNPC() && v.VJ_FNaF_IsChica then
			if !IsValid(v:GetEnemy()) && !v:IsBusy() then
				self.NextIdleSoundT = CurTime() +math.Rand(3,8)
				if !IsValid(v.Pizza) then
					if v:GetPos():Distance(self:GetPos()) < 75 then
						v:EatPizza(self)
						if self:GetBodygroup(0) == 0 then
							self:EmitSound("physics/cardboard/cardboard_box_impact_hard5.wav")
							self:SetBodygroup(0,1)
						end
						return
					end
					if v:Visible(self) && CurTime() > v.NextPizzaSeeT then
						v:StopAllCommonSpeechSounds()
						VJ_CreateSound(v,v.SoundTbl_SeePizza,75)
						v.NextPizzaSeeT = CurTime() +math.random(5,9)
					elseif !v:Visible(self) && CurTime() > v.NextPizzaSmellT then
						v:StopAllCommonSpeechSounds()
						VJ_CreateSound(v,v.SoundTbl_SmellPizza,75)
						v.NextPizzaSmellT = CurTime() +math.random(6,12)
					end
					v:SetTarget(self)
					v:VJ_TASK_GOTO_TARGET(v:Visible(self) && "TASK_RUN_PATH" or "TASK_WALK_PATH")
				end
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:PhysicsCollide(data, physobj)
	if data.Speed < 140 then return end
	self:EmitSound("physics/cardboard/cardboard_box_impact_soft" .. math.random(1,5) .. ".wav")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnTakeDamage(dmginfo)
	self:GetPhysicsObject():AddVelocity(dmginfo:GetDamageForce() *0.1)
end