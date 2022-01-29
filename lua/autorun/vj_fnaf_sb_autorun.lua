/*--------------------------------------------------
	=============== Autorun File ===============
	*** Copyright (c) 2012-2021 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
------------------ Addon Information ------------------
local Name = "FNaF Security Breach"
local PublicAddonName = Name .. " SNPCs"
local AddonName = Name
local AddonType = "SNPC"
local AutorunFile = "autorun/vj_fnaf_sb_autorun.lua"
-------------------------------------------------------
local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua","GAME")
if VJExists == true then
	include('autorun/vj_controls.lua')

	if SERVER then
		resource.AddWorkshop("2725341611") -- Pack #1
		resource.AddWorkshop("2725348397") -- Pack #2
		resource.AddWorkshop("2725352362") -- Pack #3
	end

	local mdlDir = "models/cpthazama/fnaf_sb/"
	for _,v in pairs(file.Find(mdlDir .. "*.mdl","GAME")) do
		util.PrecacheModel(mdlDir .. v)
	end
	for _,v in pairs(file.Find(mdlDir .. "/custom/*.mdl","GAME")) do
		util.PrecacheModel(mdlDir .. v)
	end

	local re1 = file.Exists("lua/autorun/vj_fnaf_sb_1.lua","GAME")
	local re2 = file.Exists("lua/autorun/vj_fnaf_sb_2.lua","GAME")
	local re3 = file.Exists("lua/autorun/vj_fnaf_sb_3.lua","GAME")
	local allowNPCs = true
	if re1 == false or re2 == false or re3 == false then
		if SERVER then
			timer.Create("FNAFSBMissing",5,0,function()
				if game.SinglePlayer() then
					Entity(1):ChatPrint("[FNaF SB SNPCs] - Missing resources detected! Either you didn't download the required addons, disabled the required addons, or they failed to download/install. Please verify that you have the required addons installed and enabled to prevent this message from appearing!")
				end
				print("[FNaF SB SNPCs] - Missing resources detected! Either you didn't download the required addons, disabled the required addons, or they failed to download/install. Please verify that you have the required addons installed and enabled to prevent this message from appearing!")
			end)
		end
		allowNPCs = false
	end

	if allowNPCs == false then return end

	VJ_FNAF_COREINSTALLED = true

	local vCat = Name
	VJ.AddCategoryInfo(vCat,{Icon = "vj_icons/fnafsb.png"})

	// Main Cast
	VJ.AddNPC("Glamrock Freddy","npc_vj_fnafsb_freddy",vCat)
	VJ.AddNPC("Glamrock Freddy (Hacked)","npc_vj_fnafsb_freddy_purple",vCat)
	VJ.AddNPC("Glamrock Chica","npc_vj_fnafsb_chica",vCat)
	VJ.AddNPC("Roxanne Wolf","npc_vj_fnafsb_roxy",vCat)
	VJ.AddNPC("Montgomery Gator","npc_vj_fnafsb_monty",vCat)
	
	// Main Cast (Shattered)
	VJ.AddNPC("Glamrock Chica (Shattered)","npc_vj_fnafsb_chica_shattered",vCat)
	VJ.AddNPC("Roxanne Wolf (Shattered)","npc_vj_fnafsb_roxy_shattered",vCat)
	VJ.AddNPC("Montgomery Gator (Shattered)","npc_vj_fnafsb_monty_shattered",vCat)
	
	// Main Cast (Skins) (https://www.nexusmods.com/fnafsecuritybreach/mods/13) (w/ Permission from StoreBrand_Mods and SB_HoneyLoops)
	VJ.AddNPC("Glamrock Freddy (Classic)","npc_vj_fnafsb_freddy_classic",vCat)
	VJ.AddNPC("Glamrock Chica (Classic)","npc_vj_fnafsb_chica_classic",vCat)
	VJ.AddNPC("Roxanne Wolf (Classic)","npc_vj_fnafsb_roxy_classic",vCat)
	VJ.AddNPC("Montgomery Gator (Classic)","npc_vj_fnafsb_monty_classic",vCat)
	
	// Main Cast (Custom) (https://www.nexusmods.com/fnafsecuritybreach/mods/15) (w/ Permission from kauamelo25)
	VJ.AddNPC("Glamrock Bonnie","npc_vj_fnafsb_bonnie",vCat)

	// STAFF Bots
	VJ.AddNPC("S.T.A.F.F. Bot","npc_vj_fnafsb_staff",vCat)
	VJ.AddNPC("S.T.A.F.F. Security Bot","npc_vj_fnafsb_staff_security",vCat)
	VJ.AddNPC("S.T.A.F.F. Security Bot (Withered)","npc_vj_fnafsb_staff_security_withered",vCat)
	VJ.AddNPC("S.T.A.F.F. Map Bot","npc_vj_fnafsb_staff_map",vCat)
	VJ.AddNPC("S.T.A.F.F. Alien Bot","npc_vj_fnafsb_staff_alien",vCat)
	VJ.AddNPC("S.T.A.F.F. Nightmarionne Bot","npc_vj_fnafsb_staff_nightmare",vCat)

	// Enemies
	VJ.AddNPC("Vanessa A.","npc_vj_fnafsb_vanessa",vCat)
	VJ.AddNPC("Vanny","npc_vj_fnafsb_vanny",vCat)
	VJ.AddNPC("Little Music Man (Withered)","npc_vj_fnafsb_lmm",vCat)
	VJ.AddNPC("Moondrop","npc_vj_fnafsb_moondrop",vCat)
	VJ.AddNPC("Sundrop","npc_vj_fnafsb_moondrop_sun",vCat)
	VJ.AddNPC("Endo-Skeleton","npc_vj_fnafsb_endo",vCat)
	VJ.AddNPC("DJ Music Man","npc_vj_fnafsb_djmm",vCat)
	VJ.AddNPC("The Blob","npc_vj_fnafsb_blob",vCat)
	VJ.AddNPC("Burntrap","npc_vj_fnafsb_burntrap",vCat)

	// Custom
	VJ.AddNPC("Blob-Skeleton","npc_vj_fnafsb_endo_blob",vCat)

	--// ConVars \\--

	VJ.AddConVar("vj_fnaf_freddyeyes",0)
	VJ.AddConVar("vj_fnaf_teleportdistance",2000)
	VJ.AddConVar("vj_fnaf_witherspawn",1)
	VJ.AddConVar("vj_fnaf_witherspawnrand1",25)
	VJ.AddConVar("vj_fnaf_witherspawnrand2",45)
	VJ.AddClientConVar("vj_fnaf_tension",0,"Enable standard tension music")
	VJ.AddClientConVar("vj_fnaf_tension_fx",0,"Enable standard tension effects")
	VJ.AddClientConVar("vj_fnaf_tension_vol",80,"Enable standard tension effects")
	VJ.AddClientConVar("vj_fnaf_hack_hud",1,"Enable Freddy's Hack HUD")
	VJ.AddClientConVar("vj_fnaf_cam_pic",0,"Enable Faz-Cam saving pictures")

	VJ_SoundDuration = function(sndfile)
		if !sndfile then return 0 end
		local duration = SoundDuration(sndfile)
		if duration == nil then return 0 end

		local isOGG = string.find(sndfile,".ogg")
		local isMP3 = string.find(sndfile,".mp3")
		if isOGG then
			duration = duration *1.5
		elseif isMP3 then
			duration = duration *2
		end

		return duration
	end

	if SERVER then
		util.AddNetworkString("VJ_FNaF_DeathScreen")
		util.AddNetworkString("VJ_FNaF_DeathScreen_End")
		util.AddNetworkString("VJ_FNaF_FreddyScreen")
		util.AddNetworkString("VJ_FNaF_GetLightness")
		util.AddNetworkString("VJ_FNaF_Stinger")

		function VJ_ControllerTest(ply,ent)
			if IsValid(ply) && IsValid(ent) then
				local cont = ents.Create("obj_vj_npccontroller")
				cont.VJCE_Player = ply
				cont:SetControlledNPC(ent)
				cont:Spawn()
				cont:StartControlling()
			end
		end

		local NPC = FindMetaTable("NPC")

		function NPC:VJ_FNaF_MouthCode()
			self.NextMouthT = self.NextMouthT or 0
			if self.NextMouthT > CurTime() then
				self:SetMouth(math.random(20,90))
			else
				if self:GetMouth() != 0 then
					self:SetMouth(0)
				end
			end
		end

		function NPC:VJ_FNaF_InViewCone(ent,fov,entB)
			if ent:GetClass() == "obj_vj_bullseye" then return false end
			local me = entB or self
			local vec = me:GetPos() -ent:GetPos()
			-- local vec = (me:GetPos() +me:OBBCenter()) -(ent:GetPos() +ent:OBBCenter())
			local len = vec:Length()
			-- local width = me:BoundingRadius() *2
			local width = me:BoundingRadius() *0.5
			local cosi = math.abs(math.cos(math.acos(len /math.sqrt(len *len +width *width)) +fov *(math.pi /180)))
			vec:Normalize()

			return vec:Dot(ent:EyeAngles():Forward()) > cosi
		end

		function NPC:VJ_FNaF_GetViewers()
			local tbl = {}
			local entities = ents.GetAll()
			for _,v in pairs(entities) do
				if (v:IsNPC() && v != self && v:GetClass() != "obj_vj_bullseye") or (v:IsPlayer() && GetConVarNumber("ai_ignoreplayers") == 0 && !v:IsFlagSet(FL_NOTARGET)) then
					if self:DoRelationshipCheck(v) != true then continue end
					if self:Visible(v) && self:VJ_FNaF_InViewCone(v,v:IsPlayer() && v:GetFOV() or 45) then
						table.insert(tbl,v)
					end
				end
			end
			return tbl
		end

		function NPC:VJ_FNaF_CanBeSeen()
			local tbl = self:VJ_FNaF_GetViewers()
			return #tbl > 0
		end

		function VJ_SetClearPos(moveEnt,origin) // Credits to Silverlan
			local mins = moveEnt:OBBMins()
			local maxs = moveEnt:OBBMaxs()
			local pos = origin || moveEnt:GetPos()
			local nearents = ents.FindInBox(pos +mins,pos +maxs)
			maxs.x = maxs.x *2
			maxs.y = maxs.y *2
			local zMax = 0
			local entTgt
			for _,ent in ipairs(nearents) do
				if(ent != moveEnt && ent:GetSolid() != SOLID_NONE && ent:GetSolid() != SOLID_BSP && gamemode.Call("ShouldCollide",moveEnt,ent) != false) then
					local obbMaxs = ent:OBBMaxs()
					if(obbMaxs.z > zMax) then
						zMax = obbMaxs.z
						entTgt = ent
					end
				end
			end
			local tbl_filter = {moveEnt,entTgt}
			local stayaway = zMax > 0
			if(!stayaway) then
				pos.z = pos.z +10
			else
				zMax = zMax +10
			end
			local left = Vector(0,1,0)
			local right = left *-1
			local forward = Vector(1,0,0)
			local back = forward *-1
			local trace_left = util.TraceLine({
				start = pos,
				endpos = pos +left *maxs.y,
				filter = tbl_filter
			})
			local trace_right = util.TraceLine({
				start = pos,
				endpos = pos +right *maxs.y,
				filter = tbl_filter
			})
			if(trace_left.Hit || trace_right.Hit) then
				if(trace_left.Fraction < trace_right.Fraction) then
					pos = pos +right *((trace_right.Fraction -trace_left.Fraction) *maxs.y)
				elseif(trace_right.Fraction < trace_left.Fraction) then
					pos = pos +left *((trace_left.Fraction -trace_right.Fraction) *maxs.y)
				end
			elseif(stayaway) then
				pos = pos +(math.random(1,2) == 1 && left || right) *maxs.y *1.8
				stayaway = false
			end
			local trace_forward = util.TraceLine({
				start = pos,
				endpos = pos +forward *maxs.x,
				filter = tbl_filter
			})
			local trace_backward = util.TraceLine({
				start = pos,
				endpos = pos +back *maxs.x,
				filter = tbl_filter
			})
			if(trace_forward.Hit || trace_backward.Hit) then
				if(trace_forward.Fraction < trace_backward.Fraction) then
					pos = pos +back *((trace_backward.Fraction -trace_forward.Fraction) *maxs.x)
				elseif(trace_backward.Fraction < trace_forward.Fraction) then
					pos = pos +forward *((trace_forward.Fraction -trace_backward.Fraction) *maxs.x)
				end
			elseif(stayaway) then
				pos = pos +(math.random(1,2) == 1 && forward || back) *maxs.x *1.8
				stayaway = false
			end
			if(stayaway) then -- We can't avoid whatever it is we're stuck in, let's try to spawn on top of it
				local start = entTgt:GetPos()
				start.z = start.z +zMax
				local endpos = start
				endpos.z = endpos.z +maxs.z
				local tr = util.TraceLine({
					start = start,
					endpos = endpos,
					filter = tbl_filter
				})
				if(!tr.Hit || (!tr.HitWorld && gamemode.Call("ShouldCollide",moveEnt,tr.Entity) == false)) then
					pos.z = start.z
					stayaway = false
				else -- Just try to move to whatever direction seems best
					local trTgt = trace_left
					if(trace_right.Fraction < trTgt.Fraction) then trTgt = trace_right end
					if(trace_forward.Fraction < trTgt.Fraction) then trTgt = trace_forward end
					if(trace_backward.Fraction < trTgt.Fraction) then trTgt = trace_backward end
					pos = pos +trTgt.Normal *maxs.x
				end
			end
			moveEnt:SetPos(pos)
		end

		function NPC:VJ_FNaF_Stun(ent)
			if !self.VJ_FNaF_CanBeStunned then
				return
			end
			if self.InAttack then
				return
			end
			if self.IsShocked then
				if self.VJ_FNaF_StaffBot then
					self:TakeDamage(self:GetMaxHealth() *0.25,ent,ent)
				end
				return
			end
			self:StopAllCommonSounds()
			self.NextIdleSoundT = CurTime() +math.Rand(self.NextSoundTime_Idle.a, self.NextSoundTime_Idle.b) *1.5
			self:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
			self.IsShocked = true
			if self.OnShocked then
				self:OnShocked()
			end
			self:SetEnemy(NULL)
			self:VJ_ACT_PLAYACTIVITY("vjseq_shock_in",true,false,false,0,{OnFinish=function(interrupted,anim)
				if interrupted then return end
				self:VJ_ACT_PLAYACTIVITY("vjseq_shock",true,false,false,0,{OnFinish=function(interrupted,anim)
					if interrupted then return end
					if self.OnEndShock then
						self:OnEndShock()
					end
					self:SetEnemy(NULL)
					self:VJ_ACT_PLAYACTIVITY("vjseq_shock_out",true,false,false,0,{OnFinish=function(interrupted,anim)
						if interrupted then return end
						self:SetState()
						self.IsShocked = false
						if self.OnShockEnded then
							self:OnShockEnded()
						end
					end})
				end})
			end})
		end

		function NPC:VJ_FNAF_Stinger(ent,snd)
			if !ent:IsPlayer() then return end
			net.Start("VJ_FNaF_Stinger")
				net.WriteEntity(ent)
				if snd then net.WriteString(snd) end
			net.Send(ent)
		end

		local str1111 = "1111"
		local str1 = "1"
		local string_sub = string.sub
		function VJ_FNaF_CheckAllFourSides(entCheck, checkDist, returnPos, sides)
			checkDist = checkDist or 200
			sides = sides or str1111
			local result = returnPos == true and {} or {Forward=false, Backward=false, Right=false, Left=false}
			local i = 0
			local myPos = entCheck:GetPos()
			local myPosCentered = entCheck:GetPos() + entCheck:OBBCenter()
			local positions = {
				string_sub(sides, 1, 1) == str1 and entCheck:GetForward() or 0, 
				string_sub(sides, 2, 2) == str1 and -entCheck:GetForward() or 0,
				string_sub(sides, 3, 3) == str1 and entCheck:GetRight() or 0,
				string_sub(sides, 4, 4) == str1 and -entCheck:GetRight() or 0
			}
			for _, v in pairs(positions) do
				i = i + 1
				if v == 0 then continue end -- If 0 then we have the tag to skip this!
				local tr = util.TraceLine({
					start = myPosCentered,
					endpos = myPosCentered +v *checkDist,
					filter = entCheck
				})
				local hitPos = tr.HitPos +tr.HitNormal *22
				local dist = entCheck:GetPos():Distance(hitPos)
				if (dist <= checkDist && dist > checkDist *0.25) or !tr.Hit then
					if returnPos == true then
						if !tr.Hit then
							hitPos = myPosCentered +v *checkDist
						end
						hitPos.z = myPos.z
						result[#result + 1] = hitPos
					elseif i == 1 then
						result.Forward = true
					elseif i == 2 then
						result.Backward = true
					elseif i == 3 then
						result.Right = true
					elseif i == 4 then
						result.Left = true
					end
				end
			end
			return result
		end

		function VJ_FNAF_BringFreddy(ent)
			if !IsValid(ent) then return end
			local animatronic = false
			for _,v in RandomPairs(ents.GetAll()) do
				if v:IsNPC() && v.VJ_FNaF_IsFreddy && !IsValid(v:GetEnemy()) && !v:Visible(ent) && v:DoRelationshipCheck(ent) != true && !IsValid(v.Gregory) && v:GetPos():Distance(ent:GetPos()) > 600 then
					animatronic = v
					break
				end
			end

			if animatronic then
				local moveCheck = VJ_PICK(VJ_FNaF_CheckAllFourSides(ent, 1000, true, "0111"))
				-- local tr = util.TraceHull({
				-- 	start = ent:GetPos(),
				-- 	endpos = ent:GetPos() +ent:GetForward() *-500,
				-- 	filter = {ent,self},
				-- 	mins = ent:OBBMins(),
				-- 	maxs = ent:OBBMaxs(),
				-- 	mask = MASK_SHOT_HULL
				-- })
				-- if tr.HitPos:Distance(ent:GetPos()) > 80 then
				if moveCheck then
					animatronic:SetPos(moveCheck)
					animatronic:SetAngles(Angle(0,(ent:GetPos() -animatronic:GetPos()):Angle().y,0))
					animatronic:SetTarget(ent)
					animatronic:VJ_TASK_GOTO_TARGET("TASK_RUN_PATH")
				else
					animatronic = NULL
				end
			end

			return IsValid(animatronic)
		end

		function NPC:VJ_FNAF_BringAlertedAllies(dist,ent) -- Dist is obsolete
			if !IsValid(ent) then return end
			local dist = GetConVar("vj_fnaf_teleportdistance"):GetInt()
			local animatronic = false
			for _,v in RandomPairs(ents.FindInSphere(self:GetPos(),dist)) do
				if v:IsNPC() && v != self && v.VJ_FNaF_CanBeAlertSummoned && !IsValid(v:GetEnemy()) && !v:Visible(ent) && self:DoRelationshipCheck(v) != true then
					animatronic = v
					break
				end
			end

			if animatronic then
				VJ_CreateSound(ent,"cpthazama/fnafsb/stinger.wav")
				local tr = util.TraceHull({
					start = ent:GetPos(),
					endpos = ent:GetPos() +ent:GetForward() *-500,
					filter = {ent,self},
					mins = ent:OBBMins(),
					maxs = ent:OBBMaxs(),
					mask = MASK_SHOT_HULL
				})
				if tr.HitPos:Distance(ent:GetPos()) > 150 then
					animatronic:SetPos(tr.HitPos +tr.HitNormal *8)
					animatronic:SetAngles(Angle(0,(self:GetPos() -animatronic:GetPos()):Angle().y,0))
				end
			end
		end

		function NPC:VJ_FNAF_Jumpscare(hitEnt,time,threshold,offset,snd)
			if !IsValid(hitEnt) then
				return false
			end
			if self.InAttack then
				return false
			end
			if hitEnt.VJ_FNaF_KillTime && hitEnt.VJ_FNaF_KillTime > CurTime() then
				return false
			end
			if hitEnt:IsNPC() then
				self.InAttack = true
				hitEnt.VJ_FNaF_KillTime = CurTime() +(time or 2)
				local hookName = "VJ_FNaF_DeathScreen_" .. hitEnt:EntIndex()
				hook.Add("Think",hookName,function()
					if !IsValid(hitEnt) or IsValid(hitEnt) && (hitEnt:Health() <= 0) or !IsValid(self) then
						if !IsValid(self) && IsValid(hitEnt) && hitEnt:IsPlayer() then
							hitEnt:DrawViewModel(true)
						elseif IsValid(self) then
							self.InAttack = false
						end
						hook.Remove("Think",hookName)
						return
					end
					if CurTime() > hitEnt.VJ_FNaF_KillTime then
						self.InAttack = false
						hook.Remove("Think",hookName)
						return
					else
						hitEnt:SetEnemy(NULL)
						hitEnt:TaskComplete()
						hitEnt:StopMoving()
						hitEnt:ClearSchedule()
						hitEnt:ClearGoal()
						if hitEnt.IsVJBaseSNPC then
							hitEnt:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
						end
						hitEnt:SetPos(self.JumpscareOffset && self:JumpscareOffset(hitEnt) or self:GetPos() +self:GetForward() *35)
						hitEnt:SetAngles(Angle(0,(self:GetPos() -hitEnt:GetPos()):Angle().y,0))
					end
				end)
				VJ_EmitSound(self,snd or "cpthazama/fnafsb/jumpscare.wav",90)
			elseif hitEnt:IsPlayer() then
				self.InAttack = true
				net.Start("VJ_FNaF_FreddyScreen")
					net.WriteEntity(hitEnt)
					net.WriteEntity(self)
					net.WriteInt(time or 2,32)
				net.Send(hitEnt)
				-- net.Start("VJ_FNaF_DeathScreen")
				-- 	net.WriteEntity(hitEnt)
				-- 	net.WriteEntity(self)
				-- 	net.WriteInt(offset or -6,32)
				-- 	net.WriteInt(threshold or 1,32)
				-- 	net.WriteString(snd or "cpthazama/fnafsb/jumpscare.wav")
				-- net.Send(hitEnt)
				hitEnt.VJ_FNaF_KillTime = CurTime() +(time or 2)
				local hookName = "VJ_FNaF_DeathScreen_" .. hitEnt:EntIndex()
				hook.Add("Think",hookName,function()
					if !IsValid(hitEnt) or IsValid(hitEnt) && (!hitEnt:Alive() or hitEnt:Health() <= 0 or CurTime() > hitEnt.VJ_FNaF_KillTime) or !IsValid(self) then
						if IsValid(hitEnt) then
							hitEnt:Freeze(false)
							hitEnt:DrawViewModel(true)
							hitEnt:RemoveFlags(FL_NOTARGET)
						end
						if IsValid(self) then
							self.InAttack = false
							if IsValid(hitEnt) then
								hitEnt:Freeze(false)
								hitEnt:DrawViewModel(true)
								hitEnt:RemoveFlags(FL_NOTARGET)
							end
						end
						hook.Remove("Think",hookName)
						return
					end
					if CurTime() > hitEnt.VJ_FNaF_KillTime then
						hitEnt:Freeze(false)
						hitEnt:DrawViewModel(true)
						hitEnt:RemoveFlags(FL_NOTARGET)
						self.InAttack = false
						hook.Remove("Think",hookName)
						return
					else
						hitEnt:Freeze(true)
						hitEnt:AddFlags(FL_NOTARGET)
						hitEnt:DrawViewModel(false)
						hitEnt:SetPos(self.JumpscareOffset && self:JumpscareOffset(hitEnt) or self:GetPos() +self:GetForward() *35)
						hitEnt:SetAngles(Angle(0,(self:GetPos() -hitEnt:GetPos()):Angle().y,0))
					end
				end)
				VJ_EmitSound(self,snd or "cpthazama/fnafsb/jumpscare.wav",90)
			end
		end

		function NPC:VJ_FNAF_Attack(hitEnt,time,threshold,offset,snd,blob)
			if !IsValid(hitEnt) then
				return false
			end
			if self.InAttack then
				return false
			end
			if hitEnt.VJ_FNaF_KillTime && hitEnt.VJ_FNaF_KillTime > CurTime() then
				return false
			end
			if hitEnt:IsNPC() then
				self.InAttack = true
				hitEnt.VJ_FNaF_KillTime = CurTime() +(time or 2)
				local hookName = "VJ_FNaF_DeathScreen_" .. hitEnt:EntIndex()
				hook.Add("Think",hookName,function()
					if !IsValid(hitEnt) or IsValid(hitEnt) && (hitEnt:Health() <= 0) or !IsValid(self) then
						if !IsValid(self) && IsValid(hitEnt) then
							hitEnt:SetHealth(0)
							hitEnt:TakeDamage(999999999,hitEnt,hitEnt)
						elseif IsValid(self) then
							self.InAttack = false
						end
						hook.Remove("Think",hookName)
						return
					end
					if CurTime() > hitEnt.VJ_FNaF_KillTime then
						hitEnt:SetHealth(0)
						local dmginfo = DamageInfo()
						dmginfo:SetDamage(self:VJ_GetDifficultyValue(hitEnt:GetMaxHealth()))
						dmginfo:SetDamageType(bit.bor(DMG_DIRECT,DMG_SLASH))
						dmginfo:SetDamageForce(self:GetForward() *((dmginfo:GetDamage() +100) *70))
						dmginfo:SetInflictor(self)
						dmginfo:SetAttacker(self)
						hitEnt:TakeDamageInfo(dmginfo,self)
						self.InAttack = false
						hook.Remove("Think",hookName)
						return
					else
						hitEnt:SetEnemy(NULL)
						hitEnt:TaskComplete()
						hitEnt:StopMoving()
						hitEnt:ClearSchedule()
						hitEnt:ClearGoal()
						if hitEnt.IsVJBaseSNPC then
							hitEnt:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
						end
						SafeRemoveEntity(hitEnt:GetActiveWeapon())
						if !blob then
							hitEnt:SetPos(self.JumpscareOffset && self:JumpscareOffset(hitEnt) or self:GetPos() +self:GetForward() *35)
						end
					end
				end)
				VJ_EmitSound(self,snd or "cpthazama/fnafsb/jumpscare.wav",90)
			elseif hitEnt:IsPlayer() then
				self.InAttack = true
				net.Start("VJ_FNaF_DeathScreen")
					net.WriteEntity(hitEnt)
					net.WriteEntity(self)
					net.WriteInt(offset or -6,32)
					net.WriteInt(threshold or 1,32)
					net.WriteString(snd or "cpthazama/fnafsb/jumpscare.wav")
				net.Send(hitEnt)
				hitEnt.VJ_FNaF_KillTime = CurTime() +(time or 2)
				local hookName = "VJ_FNaF_DeathScreen_" .. hitEnt:EntIndex()
				hook.Add("Think",hookName,function()
					if !IsValid(hitEnt) or IsValid(hitEnt) && (!hitEnt:Alive() or hitEnt:Health() <= 0) or !IsValid(self) then
						if !IsValid(self) && IsValid(hitEnt) then
							hitEnt:Freeze(false)
							hitEnt:DrawViewModel(true)
							hitEnt:Kill()
						elseif IsValid(self) then
							self.InAttack = false
							if IsValid(hitEnt) then
								hitEnt:Freeze(false)
								hitEnt:DrawViewModel(true)
							end
						end
						hook.Remove("Think",hookName)
						return
					end
					if CurTime() > hitEnt.VJ_FNaF_KillTime then
						hitEnt:SetHealth(0)
						local dmginfo = DamageInfo()
						dmginfo:SetDamage(self:VJ_GetDifficultyValue(hitEnt:Health()))
						dmginfo:SetDamageType(bit.bor(DMG_DIRECT,DMG_SLASH))
						dmginfo:SetDamageForce(self:GetForward() *((dmginfo:GetDamage() +100) *70))
						dmginfo:SetInflictor(self)
						dmginfo:SetAttacker(self)
						hitEnt:TakeDamageInfo(dmginfo,self)
						hitEnt:Freeze(false)
						hitEnt:DrawViewModel(true)
						self.InAttack = false
						hook.Remove("Think",hookName)
						return
					else
						hitEnt:Freeze(true)
						hitEnt:DrawViewModel(false)
						hitEnt:StripWeapons()
						if !blob then
							hitEnt:SetPos(self.JumpscareOffset && self:JumpscareOffset(hitEnt) or self:GetPos() +self:GetForward() *35)
						end
					end
				end)
				VJ_EmitSound(self,snd or "cpthazama/fnafsb/jumpscare.wav",90)
			end
		end
	end

	if CLIENT then
		-- hook.Add("CalcView","VJ_FNaF_TensionView",function(ply, pos, ang, fov)
			-- local view = {origin = pos, angles = ang, fov = fov}
			-- if GetConVar("vj_fnaf_tension_fx"):GetInt() == 0 then
			-- 	if ply.VJ_FNaF_TensionSound then ply.VJ_FNaF_TensionSound:Stop() end
			-- 	return view
			-- end
			-- ply.VJ_FNaF_TensionSound = ply.VJ_FNaF_TensionSound or CreateSound(ply,"vj_player/heartbeat.wav")
			-- if IsValid(ply:GetViewEntity()) && ply:GetViewEntity():GetClass() == "gmod_cameraprop" or ply.VJ_FNaF_InJumpscare then
			-- 	ply.VJ_FNaF_TensionSound:Stop()
			-- 	return view
			-- end
			-- local tension = ply.VJ_FNaF_TensionAmount or 0
			-- if tension > 0 then
			-- 	ply.VJ_FNaF_TensionSound:Play()
			-- 	local int = tension /0.55
			-- 	ply.VJ_FNaF_TensionSound:ChangeVolume(int)
			-- 	ply.VJ_FNaF_TensionSound:ChangePitch(math.Clamp(int *180,90,180))
			-- else
			-- 	ply.VJ_FNaF_TensionSound:Stop()
			-- end
			-- view.angles = ang +AngleRand(-tension,tension)
			-- return view
		-- end)

		local customOffsets = {
			["npc_vj_fnafsb_burntrap"] = Vector(0,0,-6),
			["npc_vj_fnafsb_endo"] = Vector(0,0,-6),
			["npc_vj_fnafsb_endo_blob"] = Vector(0,0,-6),
		}

		net.Receive("VJ_FNaF_DeathScreen",function()
			local ply = net.ReadEntity()
			local ent = net.ReadEntity()
			local offset = net.ReadInt(32) or -5
			-- local threshold = net.ReadInt(32) or 1
			local threshold = 0.35
			local snd = net.ReadString() or "cpthazama/fnafsb/jumpscare.wav"
			local hookName = "VJ_FNaF_DeathScreen_" .. ply:EntIndex()
			local class = ent:GetClass()

			surface.PlaySound(snd)

			local ov = ply:GetNW2Entity("VJ_FNaF_Override")
			if IsValid(ov) then
				ent = ov
			end

			hook.Add("CalcView",hookName,function()
				if !IsValid(ply) or IsValid(ply) && (!ply:Alive() or ply:Health() <= 0) or !IsValid(ent) then
					ply.VJ_FNaF_InJumpscare = false
					hook.Remove("CalcView",hookName)
					return
				end
				if IsValid(ply:GetViewEntity()) && ply:GetViewEntity():GetClass() == "gmod_cameraprop" then
					return
				end
				ply.VJ_FNaF_InJumpscare = true
				local view = {}
				local customOffsetData = customOffsets[class] or Vector(0,0,0)
				local pos = ent:GetAttachment(ent:LookupAttachment("jumpscare")).Pos
				if pos:Distance(ent:GetPos()) <= 25 then -- To deal with NPC animations not updating fast enough
					return
					-- pos = ent:GetAttachment(ent:LookupAttachment("eyes")).Pos
					-- view.origin = pos +ent:GetForward() *15
					-- view.angles = (pos -view.origin):Angle()
				else
					view.origin = pos +(ent:GetForward() *customOffsetData.x +ent:GetRight() *customOffsetData.y +ent:GetUp() *customOffsetData.z)
					view.angles = ent:GetAttachment(ent:LookupAttachment("jumpscare")).Ang +Angle(0,0,-90) +AngleRand(-threshold,threshold)
				end
				return view
			end)
		end)

		net.Receive("VJ_FNaF_FreddyScreen",function()
			local ply = net.ReadEntity()
			local ent = net.ReadEntity()
			local time = net.ReadInt(14)
			local isFreddy = ent.VJ_FNaF_IsFreddy
			local hookName = "VJ_FNaF_FreddyScreen_" .. ply:EntIndex()
			
			ply.VJ_FNaF_FreddySceneT = CurTime() +time

			hook.Add("CalcView",hookName,function()
				if !IsValid(ply) or IsValid(ply) && (!ply:Alive() or ply:Health() <= 0 or CurTime() > ply.VJ_FNaF_FreddySceneT) or !IsValid(ent) then
					ply.VJ_FNaF_InJumpscare = false
					hook.Remove("CalcView",hookName)
					return
				end
				if IsValid(ply:GetViewEntity()) && ply:GetViewEntity():GetClass() == "gmod_cameraprop" then
					return
				end
				ply.VJ_FNaF_InJumpscare = true
				local view = {}
				local pos = ent:GetAttachment(ent:LookupAttachment("jumpscare")).Pos
				if pos:Distance(ent:GetPos()) <= 25 then -- To deal with NPC animations not updating fast enough
					return
				else
					view.origin = pos
					view.angles = ent:GetAttachment(ent:LookupAttachment("jumpscare")).Ang +Angle(0,isFreddy && 90 or 0,-90) +(isFreddy && Angle(0,0,0) or AngleRand(-1,1))
				end
				return view
			end)
		end)

		net.Receive("VJ_FNaF_DeathScreen_End",function()
			local ply = net.ReadEntity()
			local hookName = "VJ_FNaF_DeathScreen_End_" .. ply:EntIndex()
			
			ply.VJ_FNaF_DeathScreen_Time = CurTime() +2

			hook.Add("RenderScreenspaceEffects",hookName,function()
				if !IsValid(ply) or IsValid(ply) && (CurTime() > ply.VJ_FNaF_DeathScreen_Time) then
					hook.Remove("RenderScreenspaceEffects",hookName)
					return
				end
				DrawMaterialOverlay("hud/fnaf/static",0)
			end)
		end)

		net.Receive("VJ_FNaF_Stinger",function()
			local ply = net.ReadEntity()
			local snd = net.ReadString()
			if snd == "" or snd == nil or !string.find(snd,"cpthazama") then
				snd = "cpthazama/fnafsb/stinger.wav"
			end

			ply.VJ_FNaF_StingerT = ply.VJ_FNaF_StingerT or 0
			if CurTime() < ply.VJ_FNaF_StingerT then return end

			ply.VJ_FNaF_StingerT = CurTime() +SoundDuration(snd) +1.5

			surface.PlaySound(snd)
		end)

		hook.Add("PopulateToolMenu","VJ_ADDTOMENU_FNAF_SB", function()
			spawnmenu.AddToolMenuOption("DrVrej","SNPC Configures","FNaF Security Breach","FNaF Security Breach","","", function(Panel)				
				Panel:AddControl("Label", {Text = "Client-Side"})
				Panel:AddControl("Checkbox", {Label = "Enable Faz-Cam Saving Pictures", Command = "vj_fnaf_cam_pic"})
				Panel:AddControl("Checkbox", {Label = "Enable Freddy's Hack HUD", Command = "vj_fnaf_hack_hud"})
				Panel:AddControl("Checkbox", {Label = "Enable Tension Music", Command = "vj_fnaf_tension"})
				-- Panel:AddControl("Checkbox", {Label = "Enable Tension Effects", Command = "vj_fnaf_tension_fx"})
				-- Panel:ControlHelp("Note: The Tension Effects Simulates The Player Shaking In Fear.")
				Panel:AddControl("Slider", {Label = "Tension Music Volume Adjustment", min = 1, max = 100, Command = "vj_fnaf_tension_vol"})
				Panel:ControlHelp("Note: The Tension Music Is Dynamic In Both Tracks And Volume, This Slider Only Alters The Intensity Of The Output Volume!")
				Panel:AddControl("Label", {Text = " "})
				if !game.SinglePlayer() && !LocalPlayer():IsAdmin() then
					Panel:AddControl("Label", {Text = "#vjbase.menu.general.admin.not"})
					Panel:AddControl("Label", {Text = "#vjbase.menu.general.admin.only"})
					return
				end
				Panel:AddControl("Label", {Text = "#vjbase.menu.general.admin.only"})
				Panel:AddControl("Button", {Text = "#vjbase.menu.general.reset.everything", Command = "vj_fnaf_witherspawn 1\nvj_fnaf_witherspawnrand1 25\nvj_fnaf_witherspawnrand2 45"})
				
				Panel:AddControl("Label", {Text = "Server-Side"})
				Panel:AddControl("Checkbox", {Label = "Give Freddy Roxy's Eyes", Command = "vj_fnaf_freddyeyes"})
				Panel:AddControl("Slider", {Label = "S.T.A.F.F. Bot Teleport Animatronics Distance", min = 0, max = 32000, Command = "vj_fnaf_teleportdistance"})
				Panel:AddControl("Checkbox", {Label = "Allow Shattered Animatronic Spawning", Command = "vj_fnaf_witherspawn"})
				Panel:ControlHelp("When Enabled, Animatronics With Shattered Variants Will Respawn As The Shattered Version When Left To Rot.")
				Panel:AddControl("Slider", {Label = "Shattered Animatronic Respawn Time Rand #1", min = 5, max = 999, Command = "vj_fnaf_witherspawnrand1"})
				Panel:AddControl("Slider", {Label = "Shattered Animatronic Respawn Time Rand #2", min = 5, max = 999, Command = "vj_fnaf_witherspawnrand2"})
				Panel:ControlHelp("Note: Rand #2 Must Be Higher Than Rand #1!")
			end)
		end)
	end

	function VJ_FNaF_FindHiddenNavArea(trCheck,water)
		local tbl = {}
		if !navmesh then return tbl end
		local function VisToPlayers(area)
			for _,v in pairs(player.GetAll()) do
				if area:IsVisible(v:EyePos()) && v:GetPos():Distance(area:GetCenter()) then
					return true
				end
			end
			return false
		end
		local function TooClose(area)
			for _,v in pairs(player.GetAll()) do
				if v:GetPos():Distance(area:GetCenter()) <= 900 then
					return true
				end
			end
			return false
		end
		local navAreas = navmesh.GetAllNavAreas()
		for _,v in pairs(navAreas) do
			if !IsValid(v) then continue end
			if VisToPlayers(v) then continue end
			if TooClose(v) then continue end
			if water && v:IsUnderwater() then continue end
			for _,vec in pairs(v:GetHidingSpots()) do
				if trCheck then
					local tr = util.TraceHull({
						start = vec,
						endpos = vec +Vector(0,0,82),
						obbmins = Vector(-18,-18,0),
						obbmaxs = Vector(18,18,82)
					})
					if tr.Hit then continue end
				end
				table.insert(tbl,vec)
			end
		end
		return VJ_PICK(tbl)
	end

	game.AddParticles("particles/CHOREO_DOG_V_STRIDER.PCF")

-- !!!!!! DON'T TOUCH ANYTHING BELOW THIS !!!!!! -------------------------------------------------------------------------------------------------------------------------
	AddCSLuaFile(AutorunFile)
	VJ.AddAddonProperty(AddonName,AddonType)
else
	if (CLIENT) then
		chat.AddText(Color(0,200,200),PublicAddonName,
		Color(0,255,0)," was unable to install, you are missing ",
		Color(255,100,0),"VJ Base!")
	end
	timer.Simple(1,function()
		if not VJF then
			if (CLIENT) then
				VJF = vgui.Create("DFrame")
				VJF:SetTitle("ERROR!")
				VJF:SetSize(790,560)
				VJF:SetPos((ScrW()-VJF:GetWide())/2,(ScrH()-VJF:GetTall())/2)
				VJF:MakePopup()
				VJF.Paint = function()
					draw.RoundedBox(8,0,0,VJF:GetWide(),VJF:GetTall(),Color(200,0,0,150))
				end
				
				local VJURL = vgui.Create("DHTML",VJF)
				VJURL:SetPos(VJF:GetWide()*0.005, VJF:GetTall()*0.03)
				VJURL:Dock(FILL)
				VJURL:SetAllowLua(true)
				VJURL:OpenURL("https://sites.google.com/site/vrejgaming/vjbasemissing")
			elseif (SERVER) then
				timer.Create("VJBASEMissing",5,0,function() print("VJ Base is Missing! Download it from the workshop!") end)
			end
		end
	end)
end