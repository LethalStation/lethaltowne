/*
*	The Psydonite rogue. Higher stats due to their unique progression.
*/

/datum/advclass/lethal_rogue/confessor
	name = "Confessor"
	tutorial = "Psydonite hunters, unmatched in the fields of subterfuge and investigation. There is no suspect too powerful to investigate, no room too guarded to \
	infiltrate, and no weakness too hidden to exploit."
	allowed_sexes = list(MALE, FEMALE)
	outfit = /datum/outfit/job/roguetown/lethal_rogue/confessor
	category_tags = list(CTAG_LETHALROGUE)
	cmode_music = ''
	allowed_patrons = list(/datum/patron/old_god)

/datum/outfit/job/roguetown/lethal_rogue/confessor
	allowed_patrons = list(/datum/patron/old_god)

/datum/outfit/job/roguetown/lethal_rogue/confessor/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 5, TRUE)
	H.adjust_skillrank(/datum/skill/misc/stealing, 5, TRUE)
	H.adjust_skillrank(/datum/skill/misc/lockpicking, 5, TRUE)
	H.adjust_skillrank(/datum/skill/misc/tracking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/crossbows, 4, TRUE)
	cloak = /obj/item/clothing/cloak/psydontabard
	wrists = /obj/item/clothing/neck/roguetown/psicross/silver
	gloves = /obj/item/clothing/gloves/roguetown/fingerless_leather
	backr = /obj/item/storage/backpack/rogue/satchel/black
	belt = /obj/item/storage/belt/rogue/leather/knifebelt/black/psydon
	pants = /obj/item/clothing/under/roguetown/trou/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/lowcut
	shoes = /obj/item/clothing/shoes/roguetown/boots
	mask = /obj/item/clothing/mask/rogue/facemask/psydonmask
	head = /obj/item/clothing/head/roguetown/roguehood/psydon
	backpack_contents = list(
		/obj/item/lockpickring/mundane = 1,
		/obj/item/rogueweapon/huntingknife/idagger/silver/psydagger = 1,
		/obj/item/rogueweapon/scabbard/sheath = 1,
		/obj/item/grapplinghook = 1,
		)
	H.change_stat("strength", -1)
	H.change_stat("endurance", 2)
	H.change_stat("perception", 1)
	H.change_stat("speed", 3)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_INQUISITION, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_PERFECT_TRACKER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_OUTLANDER, TRAIT_GENERIC)
	H.grant_language(/datum/language/otavan)
