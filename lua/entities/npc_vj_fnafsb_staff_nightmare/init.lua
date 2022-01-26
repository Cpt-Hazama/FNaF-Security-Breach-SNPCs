AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2022 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/fnaf_sb/staff_nightmare.mdl"}

ENT.StaffType = 3
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInit()
	for i = 1,2 do
		local att = i == 2 && "eyeR" or "eyeL"
		local eyeGlow = ents.Create("env_sprite")
		eyeGlow:SetKeyValue("model","sprites/cpthazama/fnafsb/eye_flare2.vmt")
		eyeGlow:SetKeyValue("scale","0.01")
		eyeGlow:SetKeyValue("rendermode","9")
		eyeGlow:SetKeyValue("rendercolor","255 255 255")
		eyeGlow:SetKeyValue("spawnflags","1")
		eyeGlow:SetParent(self)
		eyeGlow:Fire("SetParentAttachment",att,0)
		eyeGlow:Spawn()
		eyeGlow:Activate()
		self:DeleteOnRemove(eyeGlow)

		local stWidth = 2
		local edWidth = 0
		local time = 0.1
		local resolution = 1 /(10 +1) *0.5
		util.SpriteTrail(self,i +2,Color(255,255,255,240),false,stWidth,edWidth,time,resolution,"VJ_Base/sprites/vj_trial1.vmt")
	end
end