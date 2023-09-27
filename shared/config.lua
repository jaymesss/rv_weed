Config = {}
Config.CoreName = "qb-core"
Config.TargetName = "qb-target"
Config.WeedLabCardItem = 'weed_lab_card'
Config.UnprocessedWeedItem = 'unprocessed_weed'
Config.CleanedWeedItem = 'cleaned_weed'
Config.WeedBaggyItem = 'weed_baggy'
Config.GlovesItem = 'gloves'
Config.ScissorsItem = 'scissors'
Config.PlasticBagsItem = 'plastic_bags'
Config.WeedPerBaggy = 4
Config.Dealer = {
    Ped = {
        Coords = vector4(724.17, -697.23, 27.54, 87.06),
        Model = 'a_m_o_soucent_03'
    },
    Target = {
        Coords = vector3(724.17, -697.23, 28.54),
        Heading = 265,
    },
    Shop = {
        Label = 'Dealer Shop',
        Slots = 40,
        Items = {
            { name = 'plastic_bags', price = 50, amount = 50, type = "item", slot = 1, info = {} },
            { name = 'weed_lab_card', price = 1000, amount = 50, type = "item", slot = 2, info = {} },
        }
    }
}
Config.Lab = {
    Enter = {
        Ped = {
            Coords = vector4(-74.96, -1824.79, 25.94, 228.59),
            Model = 'a_m_o_soucent_03'
        },
        Target = {
            Coords = vector3(-74.86, -1824.84, 26.94),
            Heading = 45,
        },
        Teleport = {
            Coords = vector4(1039.73, -3193.16, -38.17, 232.21)
        }
    },
    Exit = {
        Target = {
            Coords = vector3(1038.74, -3193.93, -38.17),
            Heading = 108
        },
        Teleport = {
            Coords = vector4(-71.27, -1821.55, 26.94, 204.44)
        }
    },
    Supplies = {
        Ped = {
            Coords = vector4(1044.95, -3198.33, -39.16, 92.99),
            Model = 'a_m_y_beach_03'
        },
        Target = {
            Coords = vector3(1044.83, -3198.33, -38.16),
            Heading = 248
        },
        Shop = {
            Label = 'Weed Supplies',
            Slots = 40,
            Items = {
                { name = 'scissors', price = 50, amount = 50, type = "item", slot = 1, info = {} },
                { name = 'gloves', price = 50, amount = 50, type = "item", slot = 2, info = {} },
            }
        }
    },
    CleanWeed = {
        Chair = {
            Coords = vector3(1037.74, -3205.92, -39.17),
            Heading = 276.01
        },
        ChairExit = vector3(1037.55, -3206.92, -39.17),
        Target = {
            Coords = vector3(1038.26, -3205.96, -38.17),
            Heading = 320
        }
    },
    PackageWeed = {
        Chair = {
            Coords = vector3(1033.04, -3206.09, -39.18),
            Heading = 276.01
        },
        ChairExit = vector3(1032.86, -3206.96, -38.18),
        Target = {
            Coords = vector3(1033.84, -3206.0, -37.28),
            Heading = 130
        }
    },
    Plants = {
        Models = {
            716763602,
            469652573,
            -928937343
        },
        PlantCoords = {
            vector3(1049.86, -3205.49, -40.15),
            vector3(1050.04, -3207.2, -40.15),
            vector3(1051.57, -3206.87, -40.15),
            vector3(1051.34, -3205.27, -40.15),
            vector3(1053.04, -3205.57, -40.15),
            vector3(1053.05, -3207.22, -40.15),
            vector3(1053.11, -3200.62, -40.15),
            vector3(1051.53, -3200.7, -40.15),
            vector3(1050.01, -3200.53, -40.15),
            vector3(1050.1, -3199.07, -40.15),
            vector3(1051.53, -3199.35, -40.15),
            vector3(1053.15, -3199.11, -40.15),
            vector3(1052.77, -3197.41, -40.14),
            vector3(1052.77, -3195.93, -40.13),
            vector3(1052.77, -3194.47, -40.13),
            vector3(1051.17, -3197.61, -40.13),
            vector3(1051.17, -3196.03, -40.13),
            vector3(1051.17, -3194.57, -40.13),
            vector3(1049.94, -3194.45, -40.17),
            vector3(1049.94, -3195.97, -40.17),
            vector3(1052.79, -3192.61, -40.04),
            vector3(1052.95, -3191.1, -40.04),
            vector3(1053.0, -3189.48, -40.04),
            vector3(1052.88, -3187.94, -40.04),
            vector3(1051.51, -3188.12, -40.15),
            vector3(1051.56, -3189.57, -40.15),
            vector3(1051.57, -3191.03, -40.15),
            vector3(1051.41, -3192.94, -40.15),
            vector3(1049.92, -3192.61, -40.04),
            vector3(1050.2, -3190.71, -40.04),
            vector3(1050.23, -3189.33, -40.04),
            vector3(1050.14, -3187.77, -40.04),
            vector3(1054.881, -3191.4, -40.15),
            vector3(1056.28, -3191.67, -40.15),
            vector3(1057.87, -3191.53, -40.15),
            vector3(1058.08, -3189.92, -40.15),
            vector3(1057.88, -3188.22, -40.15),
            vector3(1056.35, -3188.57, -40.15),
            vector3(1056.6, -3190.16, -40.15),
            vector3(1054.89, -3189.89, -40.15),
            vector3(1054.87, -3188.24, -40.15),
            vector3(1061.41, -3191.78, -40.15),
            vector3(1062.89, -3192.11, -40.15),
            vector3(1064.41, -3191.75, -40.15),
            vector3(1061.43, -3193.43, -40.15),
            vector3(1061.35, -3194.93, -40.15),
            vector3(1062.82, -3195.21, -40.15),
            vector3(1063.14, -3193.70, -40.15),
            vector3(1064.62, -3193.46, -40.15),
            vector3(1064.57, -3195.07, -40.15),
            vector3(1061.35, -3196.94, -40.15),
            vector3(1061.22, -3198.42, -40.15),
            vector3(1061.52, -3200.15, -40.15),
            vector3(1063.13, -3200.05, -40.15),
            vector3(1062.75, -3198.60, -40.15),
            vector3(1062.86, -3196.87, -40.15),
            vector3(1064.50, -3196.69, -40.15),
            vector3(1064.32, -3198.20, -40.15),
            vector3(1064.81, -3199.69, -40.15),
            vector3(1061.99, -3201.57, -40.15),
            vector3(1061.96, -3203.10, -40.15),
            vector3(1061.97, -3204.68, -40.15),
            vector3(1061.94, -3206.38, -40.15),
            vector3(1063.26, -3206.71, -40.15),
            vector3(1064.80, -3206.44, -40.15),
            vector3(1064.89, -3204.87, -40.15),
            vector3(1063.42, -3205.15, -40.15),
            vector3(1063.41, -3203.34, -40.15),
            vector3(1064.85, -3203.25, -40.15),
            vector3(1064.74, -3201.71, -40.15),
            vector3(1063.36, -3201.69, -40.15),
            vector3(1060.14, -3204.67, -40.15),
            vector3(1058.62, -3204.56, -40.15),
            vector3(1057.04, -3204.48, -40.15),
            vector3(1055.34, -3204.37, -40.15),
            vector3(1054.94, -3205.67, -40.15),
            vector3(1056.50, -3205.87, -40.15),
            vector3(1058.30, -3205.96, -40.15),
            vector3(1059.95, -3206.03, -40.15),
            vector3(1059.86, -3207.41, -40.15),
            vector3(1058.31, -3207.39, -40.15),
            vector3(1056.70, -3207.34, -40.15),
            vector3(1055.13, -3207.22, -40.15),
            vector3(1055.87, -3201.82, -40.15),
            vector3(1057.23, -3202.21, -40.15),
            vector3(1058.64, -3201.87, -40.15),
            vector3(1058.73, -3199.85, -40.15),
            vector3(1057.42, -3200.20, -40.15),
            vector3(1055.89, -3200.44, -40.15),
            vector3(1056.03, -3198.85, -40.15),
            vector3(1056.15, -3197.54, -40.15),
            vector3(1057.42, -3198.38, -40.15),
            vector3(1058.77, -3197.98, -40.15)
        }
    }
}
