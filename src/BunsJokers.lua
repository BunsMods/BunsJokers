--- STEAMODDED HEADER
--- MOD_NAME: Bun's Jokers
--- MOD_ID: BunsJokers
--- MOD_AUTHOR: [stealthypony, LoupFakafon]
--- MOD_DESCRIPTION: Adds some Strawbunneh themed jokers into the game! Version 5.0.1r, Build ID: 352E302E31722D72656C
--- BADGE_COLOUR: DC8AD1
--- PRIORITY: -1

----------------------------------------------
------------MOD CODE -------------------------

-- This section here was mostly copied from the 'Jank Jonklers' mod, created by spikeof2010 on GitHub
local function add_joker(joker)

	sendDebugMessage("Creating Joker... " .. joker.name .. " (j_" .. joker.slug .. ")", 'sbj.JokerCreator')
	local joker = SMODS.Joker:new(
		joker.name,
		joker.slug,
		joker.config,
		joker.spritepos,
		joker.locale,
		joker.rarity,
		joker.cost,
		joker.isunlocked,
		joker.isdiscovered,
		joker.blueprintable,
		joker.eternable,
		joker.effect,
		joker.atlas,
		joker.soulpos
		)
	joker:register()
	SMODS.Sprite:new(joker.slug, SMODS.findModByID("BunsJokers").path, joker.slug .. ".png", 71, 95, "asset_atli"):register();
end
-- Okay, back to stuff I actually did write myself (the bulk of the actual code is in the TOML)



function SMODS.INIT.BunsJokers()
	sendDebugMessage("Hello? Is this thing on?", 'sbj')
	init_localization()
	local enable = {
		j_ohhey = true,
		j_bunshouse = true,
		j_thebrigade = true,
		j_monkeyspaw = true,
		j_bundeadjoker = true,
		j_crystallinerabbit = true,
		j_placeholder = true,
		j_peckingorder = true,
		j_twentyfourkarrot = true,
		j_rabbithole = true,
		j_cottontailjoker = true,
		j_sketchbook = true,
		j_technicaldifficulties = true,
		j_hatrabbit = true,
		j_curtaincall = true,
		}
	
	if enable.j_ohhey then
		local ohhey = {
					locale = {
						name = "Oh, Hey!",
						text = {
							"Retrigger all played cards",
							"if played hand contains",
							"a {C:attention}Full House"
							}
						},
					name = "Oh, Hey!",
					slug = "ohhey",
					config = {},
					spritepos = { x = 0, y = 0 },
					rarity = 2,
					cost = 4,
					isunlocked = true,
					isdiscovered = false,
					blueprintable = true,
					eternable = true,
					soulpos = { x = 1, y = 0 }
			}
		add_joker(ohhey)
		function SMODS.Jokers.j_ohhey.calculate(self, context)
			if context.repetition and context.cardarea == G.play then
				if context.scoring_name == "Full House" or context.scoring_name == "Flush House" then
					return {
						message = localize('k_again_ex'),
						repetitions = 1,
						card = self
						}
				end
			end
		end
	end
	
	if enable.j_bunshouse then
		local bunshouse = {
					locale = {
						name = "Bun's House",
						text = {
							"Allows {C:attention}Full Houses{} to be",
							"made with a {C:attention}Two Pair{} and",
							"an additional 5th card",
							"{C:inactive}(ex: {C:attention}2 2 4 4 5{C:inactive})"
							-- old example: 1 1 4 4 8
							}
						},
					name = "Bun's House",
					slug = "bunshouse",
					config = {},
					spritepos = { x = 0, y = 0 },
					rarity = 3,
					cost = 8,
					isunlocked = true,
					isdiscovered = false,
					blueprintable = false,
					eternable = true,
					soulpos = { x = 1, y = 0 }
			}
		add_joker(bunshouse)
	end
	
	if enable.j_thebrigade then
		local thebrigade = {
					locale = {
						name = "The Brigade",
						text = {
							"Each {C:attention}face{} card",
							"held in hand",
							"gives {C:mult}+#1#{} Mult",
							}
						},
					name = "The Brigade",
					slug = "thebrigade",
					config = {
						extra = {
							bonus_mult = 10
							}
						},
					spritepos = { x = 0, y = 0 },
					rarity = 1,
					cost = 5,
					isunlocked = true,
					isdiscovered = false,
					blueprintable = false,
					eternable = true,
					soulpos = { x = 1, y = 0 }
			}
		add_joker(thebrigade)
		function SMODS.Jokers.j_thebrigade.loc_def(card)
			return { 
				card.ability.extra.bonus_mult
				}
		end
	end
	
	if enable.j_monkeyspaw then
		local monkeyspaw = {
					locale = {
						name = "Monkey's Paw",
						text = {
							"Pentuples all {C:attention}listed",
							"{C:green,E:1,S:1.1}probabilities{} for",
							"the next {C:attention}#1#{} rounds",
							"{C:inactive}(ex: {C:green}1 in 6{C:inactive} -> {C:green}5 in 6{C:inactive})"
							}
						},
					name = "Monkey's Paw",
					slug = "monkeyspaw",
					config = {
						extra = {
							rounds = 5
							}
						},
					spritepos = { x = 0, y = 0 },
					rarity = 3,
					cost = 10,
					isunlocked = true,
					isdiscovered = false,
					blueprintable = false,
					eternable = false,
					soulpos = { x = 1, y = 0 }
			}
		add_joker(monkeyspaw)
		function SMODS.Jokers.j_monkeyspaw.loc_def(card)
			return { 
				card.ability.extra.rounds
				}
		end
	end

	-- Bundead Joker's "Saved by" message is not customised due to dynamic text being very difficult to work with
	if enable.j_bundeadjoker then
		local bundeadjoker = {
					locale = {
						name = "Bundead Joker",
						text = {
							"Prevents Death if chips",
							"scored are at least",
							"{C:attention}#1#%{} of required chips",
							"{S:1.1,C:red,E:2}self destructs{}",
							"{s:0.7}percentage changes at end of round"
							}
						},
					name = "Bundead Joker",
					slug = "bundeadjoker",
					config = {
						extra ={
								percentage = 75
							}
						},
					spritepos = { x = 0, y = 0 },
					rarity = 2,
					cost = 6,
					isunlocked = true,
					isdiscovered = false,
					blueprintable = false,
					eternable = false,
					soulpos = { x = 1, y = 0 }
			}
		add_joker(bundeadjoker)
		function SMODS.Jokers.j_bundeadjoker.loc_def(card)
			return { 
				card.ability.extra.percentage
				}
		end
	end
	
	if enable.j_crystallinerabbit then
		local crystallinerabbit = {
					locale = {
						name = "Crystalline Rabbit",
						text = {
							"{C:green}#1# in #2#{} chance to",
							"convert all cards in",
							"hand to glass when a",
							"{C:attention}Glass Card{} is destroyed"
							}
						},
					name = "Crystalline Rabbit",
					slug = "crystallinerabbit",
					config = {
						extra ={
								odds = 3
							}
						},
					spritepos = { x = 0, y = 0 },
					rarity = 3,
					cost = 7,
					isunlocked = true,
					isdiscovered = false,
					blueprintable = false,
					eternable = true,
					soulpos = { x = 1, y = 0 }
			}
		add_joker(crystallinerabbit)
		function SMODS.Jokers.j_crystallinerabbit.loc_def(card)
			return { 
				G.GAME.probabilities.normal,
				card.ability.extra.odds
				}
		end
	end
	
	if enable.j_placeholder then
		local placeholder = {
					locale = {
						name = "Placeholder",
						text = {
							"This Joker gains",
							"{X:mult,C:white} X#1# {} Mult every time",
							"a {C:attention}Spectral{} card is used",
							"{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)"
							},
						unlock = {
							"{E:1,s:1.3}?????"
							}
						},
					name = "Placeholder",
					slug = "placeholder",
					config = {
						extra ={
								mod = 0.5,
								multiplier = 1,
								spectrals = 2
							}
						},
					spritepos = { x = 0, y = 0 },
					rarity = 3,
					cost = 10,
					isunlocked = true,
					isdiscovered = false,
					blueprintable = true,
					eternable = true,
					soulpos = { x = 1, y = 0 }
			}
		add_joker(placeholder)
		function SMODS.Jokers.j_placeholder.loc_def(card)
			return { 
				card.ability.extra.mod,
				card.ability.extra.multiplier
				}
		end
	end
	
	if enable.j_peckingorder then
		local peckingorder = {
					locale = {
						name = "Pecking Order",
						text = {
							"{X:mult,C:white} X#1# {} Mult if all cards",
							"held in hand have",
							"a different {C:attention}rank"
							}
						},
					name = "Pecking Order",
					slug = "peckingorder",
					config = {
						extra = {
							multiplier = 2
						}
					},
					spritepos = { x = 0, y = 0 },
					rarity = 2,
					cost = 7,
					isunlocked = true,
					isdiscovered = false,
					blueprintable = true,
					eternable = true,
					soulpos = { x = 1, y = 0 }
			}
		add_joker(peckingorder)
		function SMODS.Jokers.j_peckingorder.loc_def(card)
			return { 
				card.ability.extra.multiplier
				}
		end
	end
	
	if enable.j_twentyfourkarrot then
		local twentyfourkarrot = {
					locale = {
						name = "24 Karrot",
						text = {
							"Earn {C:money}$#1#{} when",
							"a {C:attention}Gold{} card",
							"is destroyed"
							}
						},
					name = "24 Karrot",
					slug = "twentyfourkarrot",
					config = {
						extra = {
							cash = 7
						}
					},
					spritepos = { x = 0, y = 0 },
					rarity = 2,
					cost = 7,
					isunlocked = true,
					isdiscovered = false,
					blueprintable = false,
					eternable = true,
					soulpos = { x = 1, y = 0 }
			}
		add_joker(twentyfourkarrot)
		function SMODS.Jokers.j_twentyfourkarrot.loc_def(card)
			return { 
				card.ability.extra.cash
				}
		end
	end
	
	if enable.j_rabbithole then
		local rabbithole = {
					locale = {
						name = "Rabbit Hole",
						text = {
							"This Joker gains {C:chips}+#1#{} Chips",
							"per {C:attention}consecutive{} blind",
							"played this run",
							"{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"
							}
						},
					name = "Rabbit Hole",
					slug = "rabbithole",
					config = {
						extra = {
							bonus_chips = { 
								gain = 25,
								amount = 0
								}
						}
					},
					spritepos = { x = 0, y = 0 },
					rarity = 1,
					cost = 5,
					isunlocked = true,
					isdiscovered = false,
					blueprintable = true,
					eternable = true,
					soulpos = { x = 1, y = 0 }
			}
		add_joker(rabbithole)
		function SMODS.Jokers.j_rabbithole.loc_def(card)
			return { 
				card.ability.extra.bonus_chips.gain,
				card.ability.extra.bonus_chips.amount
				}
		end
	end
	
	if enable.j_cottontailjoker then
		local cottontailjoker = {
					locale = {
						name = "Cottontail Joker",
						text = {
							"Adds {C:attention}double{} the level",
							"of the played",
							"{C:attention}poker hand{} to Mult"
							}
						},
					name = "Cottontail Joker",
					slug = "cottontailjoker",
					config = {},
					spritepos = { x = 0, y = 0 },
					rarity = 1,
					cost = 3,
					isunlocked = true,
					isdiscovered = false,
					blueprintable = true,
					eternable = true,
					soulpos = { x = 1, y = 0 }
			}
		add_joker(cottontailjoker)
	end
	
	if enable.j_sketchbook then
		local sketchbook = {
					locale = {
						name = "Sketchbook",
						text = {
							"Copies ability of",
							"a random sold {C:attention}Joker{}",
							"{s:0.8}Joker changes every round{}",
							"{C:inactive}(Currently {C:attention}#1#{C:inactive})",
							}
						},
					name = "Sketchbook",
					slug = "sketchbook",
					config = {
						extra = {
							joker = {
								name = "None",
								slug = "",
								card = nil
							},
							sold_joker_slugs = {},
							},
					},
					spritepos = { x = 0, y = 0 },
					rarity = 3,
					cost = 10,
					isunlocked = true,
					isdiscovered = false,
					blueprintable = false,
					eternable = true,
					soulpos = { x = 1, y = 0 }
			}
		add_joker(sketchbook)
		function SMODS.Jokers.j_sketchbook.loc_def(card)
			return { 
				card.ability.extra.joker.name,
				}
		end
	end
	
	if enable.j_technicaldifficulties then
		local technicaldifficulties = {
					locale = {
						name = "Technical Difficulties",
						text = {
							"{C:green}#1# in #2#{} chance to randomise",
							"the suit and value of a card",
							"when the card is {C:attention}discarded",
							}
						},
					name = "Technical Difficulties",
					slug = "technicaldifficulties",
					config = {
						extra ={
								odds = 2,
								flip = false
							}
						},
					spritepos = { x = 0, y = 0 },
					rarity = 1,
					cost = 5,
					isunlocked = true,
					isdiscovered = false,
					blueprintable = false,
					eternable = true,
					soulpos = { x = 1, y = 0 }
			}
		add_joker(technicaldifficulties)
		function SMODS.Jokers.j_technicaldifficulties.loc_def(card)
			return { 
				G.GAME.probabilities.normal,
				card.ability.extra.odds
				}
		end
	end
	
	if enable.j_hatrabbit then
		local hatrabbit = {
					locale = {
						name = "Hat Rabbit",
						text = {
							"{C:mult}+#1#{} Mult for each {V:1}#2#{}",
							"in your {C:attention}full deck{}",
							"suit changes every round"
							}
						},
					name = "Hat Rabbit",
					slug = "hatrabbit",
					config = {
						extra = {
							bonus_mult = 3,
							bonus_suit = "Hearts"
						},
					},
					spritepos = { x = 0, y = 0 },
					rarity = 2,
					cost = 4,
					isunlocked = true,
					isdiscovered = false,
					blueprintable = false,
					eternable = true,
					soulpos = { x = 1, y = 0 }
			}
		add_joker(hatrabbit)
		function SMODS.Jokers.j_hatrabbit.loc_def(card)
			return { 
				card.ability.extra.bonus_mult,
				localize(card.ability.extra.bonus_suit, 'suits_singular'),
				colours = {G.C.SUITS[card.ability.extra.bonus_suit]}
				}
		end
	end
	
	if enable.j_curtaincall then
		local curtaincall = {
					locale = {
						name = "Curtain Call",
						text = {
							"This Joker gains {X:chips,C:white}X#1#{} Chips",
							"when {C:attention}Boss Blind{} is defeated",
							"{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"
							},
						unlock = {
							"{E:1,s:1.3}?????",
						}
						},
					name = "Curtain Call",
					slug = "curtaincall",
					config = {
						extra = {
							bonus_chips = {
								gain = 1.35,
								amount = 75
								}
							},
						},
					spritepos = { x = 0, y = 0 },
					rarity = 4,
					cost = 20,
					isunlocked = false,
					isdiscovered = false,
					blueprintable = true,
					eternable = true,
					soulpos = { x = 1, y = 0 }
			}
		add_joker(curtaincall)
		function SMODS.Jokers.j_curtaincall.loc_def(card)
			return { 
				card.ability.extra.bonus_chips.gain,
				card.ability.extra.bonus_chips.amount
				}
		end
	end
end
----------------------------------------------
------------MOD CODE END----------------------