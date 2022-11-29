function veriKaydet(oyuncu)
    local account = getPlayerAccount(oyuncu)
    if not isGuestAccount(account) then
        local silahlar = silahCek(oyuncu)
        local genel = genelVeri(oyuncu)
        local para = getPlayerMoney(oyuncu)
        setAccountData(account, "silah:veri", silahlar)
        setAccountData(account, "genel:veri", genel)
        setAccountData(account, "money", para)
    end
end

addEventHandler("onPlayerQuit", root, function()
    veriKaydet(source)
end)

setTimer(function()
    for i, oyuncu in pairs(getElementsByType("player")) do
        veriKaydet(oyuncu)
    end
end, 10000, 0)


function veriCek(oyuncu)
    local account = getPlayerAccount(oyuncu)
    if not isGuestAccount(account) then
        local silahlar = silahVeriCek(oyuncu)
        for i, v in pairs(silahlar) do
            giveWeapon(oyuncu, v.silah, v.mermi)
        end

        local genel = unpack(genelVeriCek(oyuncu))
        setElementHealth(oyuncu, genel.can)
        setPedArmor(oyuncu, genel.armor)
        setElementModel(oyuncu, genel.skin)
        setElementInterior(oyuncu, genel.interior)
        setElementDimension(oyuncu, genel.dimension)
        if genel.team ~= false then
            setPlayerTeam(oyuncu, getTeamFromName(genel.team))
        end
        setElementPosition(oyuncu, unpack(genel.pozisyon))
        setElementRotation(oyuncu, unpack(genel.rotasyon))

        local para = getAccountData(account, "money")
        setPlayerMoney(oyuncu, tonumber(para))

    end
end

addEventHandler("onPlayerLogin", root, function()
    veriCek(source)
end)

addEventHandler("onPlayerWasted", root, function()
    local weapons = convertWeaponsToJSON(source) 
    setElementData(source,"tempWeapons",weapons) 
	local statsBody = convertStatsBodyToJSON(source)
	setElementData(source, "tempStatsBody", statsBody)
	local statsWeapon = convertStatsWeaponToJSON(source)
	setElementData(source, "tempStatsWeapon", statsWeapon)
    local skin = getElementModel(source)
    setElementData(source, "tempSkin", skin)
end)

addEventHandler("onPlayerSpawn", root, function()
    local skin = getElementData(source, "tempSkin")
    if skin then
        setElementModel(source, skin)
    end
	local statsWeapon = getElementData(source, "tempStatsWeapon")
	if statsWeapon then
		giveStatsWeaponFromJSON(source, statsWeapon)
	end
	local statsBody = getElementData(source, "tempStatsBody")
	if statsBody then
		giveStatsBodyFromJSON(source, statsBody)
	end
	local silah = getElementData(source, "tempWeapons")
	if silah then 
    	giveWeaponsFromJSON(source, silah) 
    end 
end)