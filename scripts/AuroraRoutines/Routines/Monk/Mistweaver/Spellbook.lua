local NewSpell = Aurora.SpellHandler.NewSpell

Aurora.SpellHandler.PopulateSpellbook({
  spells = {
    -- Heilung & Defensive
    RenewingMist        = NewSpell(115151),
    EnvelopingMist      = NewSpell(124682),
    Vivify              = NewSpell(116670),
    SoothingMist        = NewSpell(115175),
    LifeCocoon          = NewSpell(116849),
    Revival             = NewSpell(115310),
    FortifyingBrew      = NewSpell(115203),
    DiffuseMagic        = NewSpell(122783),
    ExpelHarm           = NewSpell(322101),
    ManaTea             = NewSpell(197908),

    -- Schaden (Fistweaving)
    TigerPalm           = NewSpell(100780),
    BlackoutKick        = NewSpell(100784),
    RisingSunKick       = NewSpell(107428),
    RushingWindKick     = NewSpell(392983),
    CracklingJadeLightning = NewSpell(117952),

    -- Utility & CC
    SpearHandStrike     = NewSpell(116705),
    Paralysis           = NewSpell(115078),
    LegSweep            = NewSpell(119381),
    TigersLust          = NewSpell(116841),
    GrappleWeapon       = NewSpell(233759),
    Transcendence       = NewSpell(101643),
    TranscendenceTransfer = NewSpell(119996),

    -- Major Cooldowns
    ThunderFocusTea     = NewSpell(116680),
    InvokeChiJi         = NewSpell(198664),
    InvokeYuLon         = NewSpell(331644), -- Alternativ-Talent
  },
  auras = {
    TeachingsOfTheMonastery = NewSpell(116645), -- Stapel von Tigerklaue
    RenewingMistHoT         = NewSpell(119611), -- Der HoT-Effekt von Erneuernder Nebel
    RushingWinds            = NewSpell(423197), -- Buff von Rauschender Jadewind
  },
  talents = {
    AncientTeachings    = NewSpell(388974),
    ZenSpheres          = NewSpell(198414),
    Peaceweaver         = NewSpell(205234),
    Eminence            = NewSpell(116096),
  }
}, "MONK", 2, "MistweaverHybrid")
