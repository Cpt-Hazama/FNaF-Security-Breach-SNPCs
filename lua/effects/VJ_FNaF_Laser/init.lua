EFFECT.Mat = Material("effects/laser1")

function EFFECT:Init(data)
	self.Initialized = false
	self.Position = data:GetStart()
	self.EndPos = data:GetOrigin()
	self.WeaponEnt = data:GetEntity()
	if !IsValid(self.WeaponEnt) then self.DieTime = 0 return end
	self.Player = self.WeaponEnt:GetOwner()
	self.Attachment = data:GetAttachment()
	self.TexCoord = math.Rand(0,20) /3

	local muzEnt = ((self.Player != LocalPlayer()) or self.Player:ShouldDrawLocalPlayer()) && self.WeaponEnt or self.WeaponEnt

	self.StartPos = self.Position
	if IsValid(self.Player) && self.Player:IsPlayer() && !self.Player:ShouldDrawLocalPlayer() && IsValid(self.Player:GetViewModel()) then
		ent = self.Player:GetViewModel()
		self.StartPos = ent:GetAttachment(ent:LookupAttachment("muzzle")).Pos
	else
		self.StartPos = self.WeaponEnt:GetAttachment(self.WeaponEnt:LookupAttachment("muzzle")).Pos
	end
	self:SetRenderBoundsWS(self.StartPos,self.EndPos)

	self.Dir = (self.EndPos -self.StartPos):GetNormalized()
	self.Dist = self.StartPos:Distance(self.EndPos)
	self.Alpha = 255
	self.FlashA = 255

	self.DieTime = CurTime() +(self.Dir:Length() +100) /10000

	local Emitter = ParticleEmitter(self.StartPos)
	for i = 1,2 do
		local size = math.random(15,18)
		local particle = Emitter:Add("particle/particle_glow_02",self.StartPos)
		particle:SetVelocity(self.Dir:Angle():Forward() *500)
		particle:SetDieTime(math.Rand(0.045,0.065))
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(size)
		particle:SetEndSize(3)
		particle:SetColor(255,0,0)
		particle:SetAirResistance(160)
	end
	Emitter:Finish()

	util.Decal("fadingscorch", self.EndPos +self.Dir:GetNormalized(), self.EndPos -self.Dir:GetNormalized())

	local Emitter = ParticleEmitter(self.EndPos)
	for i = 1,math.random(5,15) do
		local particle = Emitter:Add("effects/spark",self.EndPos)
		particle:SetVelocity(VectorRand() *math.Rand(100,350))
		particle:SetDieTime(math.Rand(0.25,0.8))
		particle:SetStartAlpha(200)
		particle:SetEndAlpha(0)
		particle:SetStartSize(1)
		particle:SetEndSize(3)
		particle:SetRoll(math.random(0,360))
		particle:SetGravity(Vector(math.random(-300,300),math.random(-300,300),math.random(-300,-700)))
		particle:SetCollide(true)
		particle:SetBounce(0.9)
		particle:SetAirResistance(120)
		particle:SetStartLength(0)
		particle:SetEndLength(0.1)
		particle:SetVelocityScale(true)
		particle:SetCollide(true)
		particle:SetColor(255,0,0)
	end
	for i = 1,2 do
		local size = math.random(10,12)
		local particle = Emitter:Add("particle/particle_glow_04",self.EndPos)
		particle:SetVelocity(VectorRand() *math.Rand(50,100))
		particle:SetDieTime(math.Rand(0.08,0.1))
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(size)
		particle:SetEndSize(0)
		particle:SetColor(255,0,0)
		particle:SetAirResistance(160)
	end
	Emitter:Finish()

	self.Initialized = true
end

function EFFECT:Think()
	if self.FlashA then
		self.FlashA = self.FlashA -2050 *FrameTime()
		if (self.FlashA < 0) then self.FlashA = 0 end
	end
	if self.Alpha then
		self.Alpha = self.Alpha -1650 *FrameTime()
		if (self.Alpha < 0) then return false end
	end

	return true
end

function EFFECT:Render()
	if !self.StartPos or !self.EndPos then return end
	self.Length = (self.StartPos -self.EndPos):Length()
	local texcoord = self.TexCoord
	render.SetMaterial(self.Mat)
	render.DrawBeam(
		self.StartPos,
		self.EndPos,
		20, -- Width
		texcoord,
		texcoord +self.Length /256,
		Color(255,0,0,math.Clamp(self.Alpha,0,255))
	)
end