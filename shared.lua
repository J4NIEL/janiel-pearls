Config = {}
Config.CookRecipes = {
    ['Taco Fish'] = {
        required = {
            {item = 'butter_fish', amount = 1},
            {item = 'tortillas', amount = 1},
            {item = 'lettuce', amount = 1},
            {item = 'taco-tomato', amount = 1},
        },
        reward = 'fish_taco'
    },
    ['Buttered Fish'] = {
        required = {
            {item = 'fish_meat', amount = 1},
            {item = 'butter', amount = 1},
        },
        reward = 'butter_fish'
    },
    ['Fish Burger'] = {
        required = {
            {item = 'butter_fish', amount = 1},
            {item = 'bun', amount = 1},
            {item = 'lettuce', amount = 1},
        },
        reward = 'fish_burger'
    },
    ['Fish Wrap'] = {
        required = {
            {item = 'fish_meat', amount = 1},
            {item = 'slicedonion', amount = 1},
            {item = 'tortillas', amount = 1},
        },
        reward = 'fish_wrap'
    },
    ['Chips'] = {
        required = {
            {item = 'slicedpotato', amount = 1},
            {item = 'butter', amount = 1},
        },
        reward = 'crispy_potato'
    },
    ['Fish Plate'] = {
        required = {
            {item = 'fish_meat', amount = 2},
            {item = 'lettuce', amount = 1},
            {item = 'slicedonion', amount = 1},
        },
        reward = 'fish_plate'
    }
}

--Config.Drinks = {
--    'coke-soda', 'soda', 'fanta'
--}

Config.Items = {
    label = "Shop",
    slots = 9,
    items = {
    [1] = {
        name = "tortillas",
        price = 10,
        amount = 50,
        info = {},
        type = "item",
        slot = 1,
    },
    [2] = {
        name = "lettuce",
        price = 10,
        amount = 50,
        info = {},
        type = "item",
        slot = 2,
    },
    [3] = {
        name = "butter",
        price = 10,
        amount = 50,
        info = {},
        type = "item",
        slot = 3,
    },
    [4] = {
        name = "taco-tomato",
        price = 10,
        amount = 50,
        info = {},
        type = "item",
        slot = 4,
    },
    [5] = {
        name = "carbonated-water",
        price = 10,
        amount = 50,
        info = {},
        type = "item",
        slot = 5,
    },
    [6] = {
        name = "slicedonion",
        price = 10,
        amount = 50,
        info = {},
        type = "item",
        slot = 6,
    },
    [7] = {
        name = "slicedpotato",
        price = 10,
        amount = 50,
        info = {},
        type = "item",
        slot = 7,
    },
    [8] = {
        name = "bun",
        price = 10,
        amount = 50,
        info = {},
        type = "item",
        slot = 8,
    },
    [9] = {
        name = "coke-soda",
        price = 10,
        amount = 50,
        info = {},
        type = "item",
        slot = 9,
    },
    [10] = {
        name = "sprunk",
        price = 10,
        amount = 50,
        info = {},
        type = "item",
        slot = 10,
    },
    [11] = {
        name = "fanta",
        price = 10,
        amount = 50,
        info = {},
        type = "item",
        slot = 11,
    },
    [12] = {
        name = "fish_meat",
        price = 25,
        amount = 50,
        info = {},
        type = "item",
        slot = 12,
    },
    
    
    }
}
