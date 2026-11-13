-- OPAH: DESA BATU SUNYI
-- Local/client-side Luau map preview.
-- Jalankan hanya di experience milik sendiri / tempat yang kamu punya izin.
-- Perubahan hanya terlihat di client kamu, tidak tersimpan ke server.

local ok, err = pcall(function()
    local Workspace = game:GetService("Workspace")
    local Lighting = game:GetService("Lighting")

    -- Hapus versi lama jika script dijalankan ulang
    local old = Workspace:FindFirstChild("OpahMap_Client")
    if old then old:Destroy() end

    local map = Instance.new("Folder")
    map.Name = "OpahMap_Client"
    map.Parent = Workspace

    local function makePart(name, size, position, color, material, parent, transparency)
        local p = Instance.new("Part")
        p.Name = name
        p.Size = size
        p.Position = position
        p.Anchored = true
        p.CanCollide = true
        p.TopSurface = Enum.SurfaceType.Smooth
        p.BottomSurface = Enum.SurfaceType.Smooth
        p.Color = color
        p.Material = material or Enum.Material.Wood
        p.Transparency = transparency or 0
        p.Parent = parent or map
        return p
    end

    local function lamp(position, color, brightness, range, parent)
        local bulb = makePart("Lampu", Vector3.new(0.7, 0.7, 0.7), position,
            color, Enum.Material.Neon, parent, 0)
        bulb.CanCollide = false
        local light = Instance.new("PointLight")
        light.Color = color
        light.Brightness = brightness
        light.Range = range
        light.Shadows = true
        light.Parent = bulb
        return bulb
    end

    -- Suasana malam
    Lighting.ClockTime = 0
    Lighting.Brightness = 1
    Lighting.Ambient = Color3.fromRGB(45, 43, 53)
    Lighting.OutdoorAmbient = Color3.fromRGB(22, 22, 31)
    Lighting.FogColor = Color3.fromRGB(35, 34, 43)
    Lighting.FogStart = 25
    Lighting.FogEnd = 180

    local atmosphere = Lighting:FindFirstChild("OpahMapAtmosphere")
    if not atmosphere then
        atmosphere = Instance.new("Atmosphere")
        atmosphere.Name = "OpahMapAtmosphere"
        atmosphere.Parent = Lighting
    end
    atmosphere.Density = 0.32
    atmosphere.Offset = -0.1
    atmosphere.Color = Color3.fromRGB(145, 142, 158)
    atmosphere.Decay = Color3.fromRGB(45, 42, 53)
    atmosphere.Haze = 2

    -- Tanah dan jalan
    makePart("Tanah Desa", Vector3.new(220, 2, 220), Vector3.new(0, -1, 0),
        Color3.fromRGB(55, 46, 38), Enum.Material.Ground)
    makePart("Jalan Desa", Vector3.new(18, 0.2, 200), Vector3.new(0, 0.05, 0),
        Color3.fromRGB(78, 62, 50), Enum.Material.Ground)

    -- Rumah Opah
    local house = Instance.new("Folder")
    house.Name = "Rumah Opah"
    house.Parent = map

    local green = Color3.fromRGB(64, 91, 57)
    local darkGreen = Color3.fromRGB(43, 65, 43)
    local brown = Color3.fromRGB(76, 43, 34)

    makePart("Lantai", Vector3.new(42, 1, 34), Vector3.new(0, 1, 0),
        brown, Enum.Material.WoodPlanks, house)
    makePart("Atap", Vector3.new(44, 2, 36), Vector3.new(0, 18, 0),
        Color3.fromRGB(48, 43, 39), Enum.Material.WoodPlanks, house)

    -- Dinding dengan bukaan pintu depan
    makePart("Dinding Belakang", Vector3.new(42, 16, 1), Vector3.new(0, 9, 17),
        green, Enum.Material.WoodPlanks, house)
    makePart("Dinding Kiri", Vector3.new(1, 16, 34), Vector3.new(-21, 9, 0),
        green, Enum.Material.WoodPlanks, house)
    makePart("Dinding Kanan", Vector3.new(1, 16, 34), Vector3.new(21, 9, 0),
        green, Enum.Material.WoodPlanks, house)
    makePart("Dinding Depan Kiri", Vector3.new(14, 16, 1), Vector3.new(-14, 9, -17),
        green, Enum.Material.WoodPlanks, house)
    makePart("Dinding Depan Kanan", Vector3.new(14, 16, 1), Vector3.new(14, 9, -17),
        green, Enum.Material.WoodPlanks, house)
    makePart("Dinding Atas Pintu", Vector3.new(14, 5, 1), Vector3.new(0, 14.5, -17),
        green, Enum.Material.WoodPlanks, house)

    -- Teras dan tangga
    makePart("Teras", Vector3.new(18, 1, 8), Vector3.new(0, 0.6, -21),
        brown, Enum.Material.WoodPlanks, house)
    makePart("Tangga 1", Vector3.new(12, 1, 3), Vector3.new(0, 0, -26),
        brown, Enum.Material.WoodPlanks, house)
    makePart("Tangga 2", Vector3.new(10, 1, 3), Vector3.new(0, -0.5, -29),
        brown, Enum.Material.WoodPlanks, house)
    makePart("Atap Teras", Vector3.new(20, 1, 9), Vector3.new(0, 11, -22),
        Color3.fromRGB(45, 40, 36), Enum.Material.WoodPlanks, house)

    for _, x in ipairs({-8, 8}) do
        makePart("Tiang Teras", Vector3.new(0.8, 10, 0.8), Vector3.new(x, 5.5, -24),
            darkGreen, Enum.Material.Wood, house)
    end

    -- Sekat kamar dan lorong
    makePart("Sekat Kiri", Vector3.new(1, 15, 20), Vector3.new(-7, 8.5, 7),
        darkGreen, Enum.Material.WoodPlanks, house)
    makePart("Sekat Belakang", Vector3.new(14, 15, 1), Vector3.new(0, 8.5, 4),
        darkGreen, Enum.Material.WoodPlanks, house)
    makePart("Sekat Kanan", Vector3.new(1, 15, 12), Vector3.new(8, 8.5, 11),
        darkGreen, Enum.Material.WoodPlanks, house)
    makePart("Karpet Lorong", Vector3.new(9, 0.12, 24), Vector3.new(0, 1.57, 1),
        Color3.fromRGB(83, 18, 23), Enum.Material.Fabric, house)

    -- Furnitur sederhana
    makePart("Lemari", Vector3.new(5, 8, 3), Vector3.new(-15, 5, 9),
        Color3.fromRGB(91, 53, 36), Enum.Material.Wood, house)
    makePart("Pintu Lemari", Vector3.new(4.5, 7, 0.2), Vector3.new(-15, 5, 7.35),
        Color3.fromRGB(119, 76, 48), Enum.Material.Wood, house)
    makePart("Meja", Vector3.new(5, 3, 3), Vector3.new(14, 2.5, 11),
        Color3.fromRGB(117, 75, 45), Enum.Material.Wood, house)
    makePart("Kasur", Vector3.new(8, 2, 12), Vector3.new(12, 2, -7),
        Color3.fromRGB(91, 28, 34), Enum.Material.Fabric, house)
    makePart("Bantal", Vector3.new(5, 0.6, 3), Vector3.new(12, 3.2, -11),
        Color3.fromRGB(190, 177, 151), Enum.Material.Fabric, house)

    -- Jendela merah
    for _, x in ipairs({-14, 14}) do
        local window = makePart("Jendela", Vector3.new(5, 4, 0.25),
            Vector3.new(x, 10, -17.6), Color3.fromRGB(150, 35, 28),
            Enum.Material.Neon, house, 0.25)
        window.CanCollide = false
    end

    -- Lampu dalam dan luar rumah
    for _, pos in ipairs({
        Vector3.new(0, 14, -8),
        Vector3.new(0, 14, 10),
        Vector3.new(-14, 14, 8),
        Vector3.new(14, 14, -8)
    }) do
        lamp(pos, Color3.fromRGB(255, 185, 112), 0.8, 18, house)
    end
    lamp(Vector3.new(-7, 10, -23), Color3.fromRGB(255, 172, 91), 1.4, 25, map)
    lamp(Vector3.new(7, 10, -23), Color3.fromRGB(255, 172, 91), 1.4, 25, map)

    -- Pohon desa
    local function tree(x, z, scale)
        makePart("Batang Pohon", Vector3.new(2*scale, 10*scale, 2*scale),
            Vector3.new(x, 5*scale, z), Color3.fromRGB(67, 46, 33),
            Enum.Material.Wood, map)
        for i = 1, 3 do
            local leaves = makePart("Daun Pohon", Vector3.new((10-i)*scale, 5*scale, (10-i)*scale),
                Vector3.new(x, (10+i*2)*scale, z), Color3.fromRGB(26, 48, 30),
                Enum.Material.Grass, map)
            leaves.Shape = Enum.PartType.Ball
        end
    end

    local treePositions = {
        {-36, -34, 1.2}, {36, -30, 1.1}, {-43, 15, 1.3},
        {43, 24, 1.2}, {-30, 48, 1}, {30, 52, 1.1},
        {-53, -5, 1.2}, {53, -10, 1.2}
    }
    for _, v in ipairs(treePositions) do
        tree(v[1], v[2], v[3])
    end

    -- NPC Opah dekorasi sederhana (belum memiliki AI mengejar)
    local npc = Instance.new("Model")
    npc.Name = "Opah - NPC Dekorasi"
    npc.Parent = map

    local function npcPart(name, size, position, color, shape)
        local p = Instance.new("Part")
        p.Name = name
        p.Size = size
        p.Position = position
        p.Anchored = true
        p.CanCollide = false
        p.Color = color
        p.Material = Enum.Material.SmoothPlastic
        if shape then p.Shape = shape end
        p.Parent = npc
        return p
    end

    npcPart("Badan", Vector3.new(2, 3, 1), Vector3.new(10, 2.5, -36),
        Color3.fromRGB(194, 157, 177))
    npcPart("Kepala", Vector3.new(1.5, 1.5, 1.5), Vector3.new(10, 4.7, -36),
        Color3.fromRGB(220, 185, 148), Enum.PartType.Ball)
    npcPart("Rambut", Vector3.new(1.7, 0.5, 1.7), Vector3.new(10, 5.4, -36),
        Color3.fromRGB(220, 220, 210), Enum.PartType.Ball)
    npcPart("Kaki Kiri", Vector3.new(0.7, 2, 0.8), Vector3.new(9.4, 0.5, -36),
        Color3.fromRGB(80, 45, 40))
    npcPart("Kaki Kanan", Vector3.new(0.7, 2, 0.8), Vector3.new(10.6, 0.5, -36),
        Color3.fromRGB(80, 45, 40))

    -- Titik spawn untuk menandai area; tidak memindahkan karakter otomatis
    local marker = makePart("Penanda Spawn", Vector3.new(5, 0.2, 5),
        Vector3.new(0, 0.2, -48), Color3.fromRGB(80, 80, 80),
        Enum.Material.SmoothPlastic, map, 0.5)
    marker.CanCollide = false

    print("OpahMap_Client berhasil dibuat. Ini hanya terlihat di client kamu.")
end)

if not ok then
    warn("OpahMap gagal dibuat: " .. tostring(err))
end
