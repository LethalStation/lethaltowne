/*
*	A Psydon-locked Naledian class based on lore by monkberry and the AP class by the same name.
*/

/datum/advclass/lethal_mage/warscholar
	name = "Naledi Warscholar"
	tutorial = "Heralded by sigils of black-and-gold and their distinct masks, the Naledi Warscholars once prowled the dunes of their homeland, exterminating daemons \
	in exchange for coin, artifacts, or knowledge. As Naledi's economy falters, the Warscholars travel to foreign lands to seek further business."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/lethal_mage/warscholar
	category_tags = list(CTAG_LETHALMAGE)
	cmode_music = 'sound/music/warscholar.ogg'
	traits_applied = list(TRAIT_OUTLANDER)
	classes = list(
		"Hierophant" = "You are a Naledi Hierophant, a magician who studied under cloistered sages, well-versed in all manners of arcyne. You prioritize \
		enhancing your teammates and distracting foes while staying in the backline.",
		"Pontifex" = "You are a Naledi Pontifex, a warrior trained into a hybridized style of movement-controlling magic and hand-to-hand combat. Though your \
		abilities in magical fields are lacking, you are far more dangerous than other magi in a straight fight. You manifest your calm, practiced skill into a \
		killing intent that takes the shape of an arcyne blade.",
		)

/datum/outfit/job/roguetown/lethal_mage/warscholar
	var/detailcolor
	allowed_patrons = list(/datum/patron/old_god)

/datum/outfit/job/roguetown/lethal_mage/warscholar/pre_equip(mob/living/carbon/human/H)
	..()
	var/list/naledicolors = sortList(list(
		"GOLD" = "#C8BE6D",
		"PALE PURPLE" = "#9E93FF",
		"BLUE" = "#A7B4F6",
		"BRICK BROWN" = "#773626",
		"PURPLE" = "#B542AC",
		"GREEN" = "#62a85f",
		"BLUE" = "#A9BFE0",
		"RED" = "#ED6762",
		"ORANGE" = "#EDAF6D",
		"PINK" = "#EDC1D5",
		"MAROON" = "#5F1F34",
		"BLACK" = "#242526"
	))
	// CLASS ARCHETYPES
	H.adjust_blindness(-3)
	detailcolor = input("Choose a color.", "NALEDIAN COLORPLEX") as anything in naledicolors
	detailcolor = naledicolors[detailcolor]
	var/classes = list("Hierophant","Pontifex")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes
	mask = /obj/item/clothing/mask/rogue/lordmask/naledi
	wrists = /obj/item/clothing/neck/roguetown/psicross/naledi
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/flashlight/flare/torch/lantern/decrepit
	shoes = /obj/item/clothing/shoes/roguetown/sandals
	backr = /obj/item/storage/backpack/rogue/satchel/black

	switch(classchoice)
		if("Hierophant")
			H.set_blindness(0)
			to_chat(H, span_warning("You are a Naledi Hierophant, a magician who studied under cloistered sages, well-versed in all manners of arcyne. You prioritize enhancing your teammates and distracting foes while staying in the backline."))
			H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
			H.adjust_skillrank(/datum/skill/craft/alchemy, 3, TRUE)
			H.adjust_skillrank(/datum/skill/magic/arcane, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
			H.grant_language(/datum/language/celestial)
			if(H.age == AGE_OLD)
				H.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
				H.change_stat("speed", -1)
				H.change_stat("intelligence", 1)
				H.change_stat("perception", 1)
				H?.mind.adjust_spellpoints(3)
			H.change_stat("endurance", 1)
			H.change_stat("speed", 1)
			H.change_stat("constitution", -1)
			H.change_stat("perception", 1)
			H.change_stat("intelligence", 3)
			H?.mind.adjust_spellpoints(7)
			ADD_TRAIT(H, TRAIT_MAGEARMOR, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_ARCYNE_T3, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_OUTLANDER, TRAIT_GENERIC)
			if(H.mind)
				H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
				H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/giants_strength)
				H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/longstrider)
				H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/guidance)
				H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/haste)
				H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/fortitude)
				H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/forcewall/greater)
			r_hand = /obj/item/rogueweapon/woodstaff/naledi/tarnished
			head = /obj/item/clothing/head/roguetown/roguehood/hierophant
			cloak = /obj/item/clothing/cloak/hierophant
			armor = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/hierophant
			shirt = /obj/item/clothing/suit/roguetown/shirt/robe/hierophant
			pants = /obj/item/clothing/under/roguetown/trou/leather
			backpack_contents = list(
				/obj/item/rogueweapon/huntingknife/idagger = 1,
				/obj/item/spellbook_unfinished/pre_arcyne = 1,
				/obj/item/rogueweapon/scabbard/sheath = 1
				)

		if("Pontifex")
			H.set_blindness(0)
			to_chat(H, span_warning("You are a Naledi Pontifex, a warrior trained into a hybridized style of movement-controlling magic and hand-to-hand combat. Though your abilities in magical fields are lacking, you are far more dangerous than other magi in a straight fight. You manifest your calm, practiced skill into a killing intent that takes the shape of an arcyne blade."))
			H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
			H.adjust_skillrank(/datum/skill/magic/arcane, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/lockpicking, 3, TRUE)
			H.change_stat("strength", 3)
			H.change_stat("endurance", 1)
			H.change_stat("perception", -1)
			H.change_stat("speed", 2)
			H.grant_language(/datum/language/celestial)
			H.grant_language(/datum/language/thievescant)
			if(H.mind)
				H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
				H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/fetch)
				H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/ensnare)
				H.mind.AddSpell(new/obj/effect/proc_holder/spell/invoked/projectile/repel)
				H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/summonrogueweapon/bladeofpsydon)
				H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/shadowstep)
			ADD_TRAIT(H, TRAIT_CIVILIZEDBARBARIAN, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_ARCYNE_T1, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_OUTLANDER, TRAIT_GENERIC)
			head = /obj/item/clothing/head/roguetown/roguehood/pontifex
			gloves = /obj/item/clothing/gloves/roguetown/angle/pontifex
			head = /obj/item/clothing/head/roguetown/roguehood/pontifex
			armor = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/pontifex
			shirt = /obj/item/clothing/suit/roguetown/shirt/robe/pointfex
			pants = /obj/item/clothing/under/roguetown/trou/leather/pontifex
			backpack_contents = list(
				/obj/item/lockpick = 1,
				/obj/item/rogueweapon/huntingknife = 1,
				/obj/item/rogueweapon/scabbard/sheath = 1
				)

/datum/outfit/job/roguetown/lethal_mage/warscholar/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()

	for(var/obj/item/clothing/V in H.get_equipped_items(FALSE))
		if(V.naledicolor)
			V.color = detailcolor
			V.update_icon()
	H.regenerate_icons()
