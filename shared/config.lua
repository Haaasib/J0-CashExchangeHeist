J0 = {}

J0.heistCoords = {
    StartLoc = {
        vec = vec3(137.64, -1334.10, 29.20),
        zname = "StartLoc"
    },
    Hack1Lock = {
        vec = vec3(139.76, -1339.85, 30.23),
        zname = "Hack1Lock"
    },
    ThermiteAnim = {
        vec = vec3(137.62, -1334.08, 29.20),
        heading = 129.72
    },
}

J0.trollysInfo = {
    [1] = {coords = vec4(132.04, -1340.37, 29.71, 329.05), type = 'cash'},
    [2] = {coords = vec4(133.83, -1339.79, 29.71, 170.17), type = 'gold'},
    [3] = {coords = vec4(133.70, -1341.37, 29.71, 200.41), type = 'cash'},
    
}

J0.rewardTable = {
    cash = { min = 100, max = 200 },
    gold = { min = 1, max = 2, itemname = "goldbar" }
}

J0.heistCooldown = 60000

J0.cashExchangeDoors = {
    [1] = {coords = vec3(127.4314, -1342.241, 29.83489), heading = 225.81959533691, hash = 254199918},
    [2] = {coords = vec3(134.7591, -1345.698, 29.83489), heading = 316.0, hash = 254199918},
    [3] = {coords = vec3(130.7513, -1338.805, 29.83489), heading = 226.00003051758, hash = 254199918},
}

J0.dispatchInfo = {
    displayCode = "10-09A",
    title = 'Cash Exchange Heist',
    description = "Cash Exchange heist in progress",
    message = "Suspects reported at the LS Cash Exchange",
    sprite = 278,
    scale = 1.0,
    colour = 11,
    blipText = "Cash Exchange Heist",
    dispatchcodename = "j0_cashex"
}


J0.discordLogs = true
J0.discordWebHook = 'https://discord.com/api/webhooks/1249694100664619081/Z26abRL5nf8-jRgME9Seotrq3BwPdt2Qd35Fbm4qqDcst9tfqmP2NerAGAFw5ZMLFB7b'