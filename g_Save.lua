function silahCek(oyuncu)
    local tablo = {}

    for i = 1, 12 do
        local silah = getPedWeapon(oyuncu, i)
        local mermi = getPedTotalAmmo(oyuncu, i)
        table.insert(tablo, {silah = silah, mermi = mermi})
    end

    return toJSON(tablo)
end

function silahVeriCek(oyuncu)
    local account = getPlayerAccount(oyuncu)
    local silahlar = getAccountData(account, "silah:veri") or toJSON({})
    
    return fromJSON(silahlar)
end

function genelVeri(oyuncu)
    local tablo = {}
	local can = getElementHealth(oyuncu)
	local armor = getPedArmor(oyuncu)
	local skin = getElementModel(oyuncu)
	local interior = getElementInterior(oyuncu)
	local dimension = getElementDimension(oyuncu)
    local team = getPlayerTeam(oyuncu)
    if team ~= false then
        team = getTeamName(team)
    end
	local x, y, z = getElementPosition(oyuncu)
	local xr, xy, xz = getElementRotation(oyuncu) 

    table.insert(tablo, {
        can = can,
        armor = armor,
        skin = skin,
        interior = interior,
        dimension = dimension,
        team = team,
        pozisyon = {x, y, z},
        rotasyon = {xr, xy, xz}
    })

    return toJSON(tablo)
end

function genelVeriCek(oyuncu)
    local account = getPlayerAccount(oyuncu)
    local genelVeriler = getAccountData(account, "genel:veri") or toJSON({{
        can = 100,
        armor = 0,
        skin = 0,
        interior = 0,
        dimension = 0,
        team = false,
        pozisyon = {2551.75537, 1968.13647, 10.82031},
        rotasyon = {0, 0, 178.2751159668}
    }})
    
    return fromJSON(genelVeriler)
end


function convertStatsWeaponToJSON(player) 
    local statsWeaponTable = {} 
    for i = 69, 79 do 
        local stat = getPedStat(player, i)
        statsWeaponTable[i] = stat 
    end 
    return toJSON(statsWeaponTable) 
end 

function giveStatsWeaponFromJSON(player, stat) 
    if (stat and stat ~= "") then 
        for stat, deger in pairs(fromJSON(stat)) do 
            if (stat and deger) then 
                setPedStat(player, tonumber(stat), tonumber(deger)) 
            end 
        end 
    end 
end 

function convertStatsBodyToJSON(player) 
    local statsBodyTable = {} 
    for i = 21, 25 do 
        local stat = getPedStat(player, i)
        statsBodyTable[i] = stat 
    end 
    return toJSON(statsBodyTable) 
end 

function giveStatsBodyFromJSON(player, stat) 
    if (stat and stat ~= "") then 
        for stat, deger in pairs(fromJSON(stat)) do 
            if (stat and deger) then 
                setPedStat(player, tonumber(stat), tonumber(deger)) 
            end 
        end 
    end 
end 

  
function convertWeaponsToJSON(player) 
    local weaponSlots = 12 
    local weaponsTable = {} 
    for slot=1, weaponSlots do 
        local weapon = getPedWeapon( player, slot ) 
        local ammo = getPedTotalAmmo( player, slot ) 
        if (weapon > 0 and ammo > 0) then 
            weaponsTable[weapon] = ammo 
        end 
    end 
    return toJSON(weaponsTable) 
end 
  
function giveWeaponsFromJSON(player, weapons) 
    if (weapons and weapons ~= "") then 
        for weapon, ammo in pairs(fromJSON(weapons)) do 
            if (weapon and ammo) then 
                giveWeapon(player, tonumber(weapon), tonumber(ammo)) 
            end 
        end 
    end 
end 