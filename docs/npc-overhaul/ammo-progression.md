# Ammunition progression by price per round

Generated with `python3 docs/npc-overhaul/tools/ammo_progression.py --write`.

The cost is the concrete item's `price / ammoAmount`, matching the ammunition base's GetPrice.
Twelve global price bands each have regular and upgraded-load stages, scaled to the contact's tree.
Different prices may share a band. AP and HP at equal prices are parallel upgrades; neither requires the other.
Each vendor's ammunition stages require its preceding stage, so sibling story branches cannot bypass the order.
Regional ungated basic supplies remain available. No box prices, round counts or damage values are changed.

Variants always follow their regular counterpart. Special 12-gauge loads and 14.5 mm variants currently cost
less per round than the regular load; they use the regular load's price band to preserve that upgrade rule.
The legacy ID `45acp41` is .410 bore, a separate cartridge rather than a .45 ACP upgrade.

| Item | Box price | Rounds | Price per round | Regular counterpart | Seller: milestone |
| --- | ---: | ---: | ---: | --- | --- |
| 22lr | 450 | 60 | 7.5000 | 22lr | brass: ungated; old-timer: ungated; quartermaster: ungated; spoor: ungated |
| 22lrap | 450 | 60 | 7.5000 | 22lr | brass: BR02; quartermaster: QM02; spoor: SP02 |
| 22lrhp | 450 | 60 | 7.5000 | 22lr | brass: BR02; quartermaster: QM02; spoor: SP02 |
| 762x25 | 500 | 60 | 8.3333 | 762x25 | brass: BR01; haggler: HG01; quartermaster: QM01 |
| 762x25ap | 500 | 60 | 8.3333 | 762x25 | brass: BR02; quartermaster: QM02 |
| 762x25hp | 500 | 60 | 8.3333 | 762x25 | brass: BR02; quartermaster: QM02 |
| 9x18 | 600 | 60 | 10.0000 | 9x18 | haggler: HG03; brass: ungated; old-timer: ungated; quartermaster: ungated |
| 9x18ap | 600 | 60 | 10.0000 | 9x18 | brass: BR04; quartermaster: QM04 |
| 9x18hp | 600 | 60 | 10.0000 | 9x18 | brass: BR04; quartermaster: QM04 |
| 9x19 | 750 | 60 | 12.5000 | 9x19 | brass: BR03; cleaner: CL03; haggler: HG03; quartermaster: QM03 |
| 9x19ap | 750 | 60 | 12.5000 | 9x19 | brass: BR04; quartermaster: QM04 |
| 9x19hp | 750 | 60 | 12.5000 | 9x19 | brass: BR04; quartermaster: QM04 |
| 9x21 | 750 | 60 | 12.5000 | 9x21 | brass: BR03; quartermaster: QM03 |
| 9x21ap | 750 | 60 | 12.5000 | 9x21 | brass: BR04; quartermaster: QM04 |
| 9x21hp | 750 | 60 | 12.5000 | 9x21 | brass: BR04; quartermaster: QM04 |
| 57x28 | 850 | 60 | 14.1667 | 57x28 | brass: BR05; quartermaster: QM05 |
| 57x28ap | 850 | 60 | 14.1667 | 57x28 | brass: BR06; quartermaster: QM06 |
| 57x28hp | 850 | 60 | 14.1667 | 57x28 | brass: BR06; quartermaster: QM06 |
| 45acp | 950 | 60 | 15.8333 | 45acp | brass: BR05; haggler: HG05; quartermaster: QM05 |
| 45acpap | 950 | 60 | 15.8333 | 45acp | brass: BR06; quartermaster: QM06 |
| 45acphp | 950 | 60 | 15.8333 | 45acp | brass: BR06; quartermaster: QM06 |
| 357magnum | 1000 | 60 | 16.6667 | 357magnum | brass: BR07; quartermaster: QM07 |
| 357magnumap | 1000 | 60 | 16.6667 | 357magnum | brass: BR08; quartermaster: QM08 |
| 357magnumhp | 1000 | 60 | 16.6667 | 357magnum | brass: BR08; quartermaster: QM08 |
| 44magnum | 1000 | 60 | 16.6667 | 44magnum | brass: BR07; quartermaster: QM07 |
| 44magnumap | 1000 | 60 | 16.6667 | 44magnum | brass: BR08; quartermaster: QM08 |
| 44magnumhp | 1000 | 60 | 16.6667 | 44magnum | brass: BR08; quartermaster: QM08 |
| 12gaugedt | 600 | 30 | 20.0000 | 12gauge | brass: BR10; quartermaster: QM10; spoor: SP09 |
| 12gaugesg | 700 | 30 | 23.3333 | 12gauge | brass: BR10; quartermaster: QM10; spoor: SP09 |
| 12gaugemg | 750 | 30 | 25.0000 | 12gauge | brass: BR10; quartermaster: QM10; spoor: SP09 |
| 12gaugetr | 750 | 30 | 25.0000 | 12gauge | brass: BR10; quartermaster: QM10; spoor: SP09 |
| 545x39 | 1500 | 60 | 25.0000 | 545x39 | brass: BR09; haggler: HG09; quartermaster: QM09; boss: ungated |
| 545x39ap | 1500 | 60 | 25.0000 | 545x39 | brass: BR10; quartermaster: QM10 |
| 545x39hp | 1500 | 60 | 25.0000 | 545x39 | brass: BR10; quartermaster: QM10 |
| 12gauge | 800 | 30 | 26.6667 | 12gauge | haggler: HG09; the-original: OR09; brass: ungated; old-timer: ungated; quartermaster: ungated; spoor: ungated |
| 556x45 | 1650 | 60 | 27.5000 | 556x45 | brass: BR11; quartermaster: QM11; boss: ungated |
| 556x45ap | 1650 | 60 | 27.5000 | 556x45 | brass: BR12; quartermaster: QM12 |
| 556x45hp | 1650 | 60 | 27.5000 | 556x45 | brass: BR12; quartermaster: QM12 |
| 762x39 | 1700 | 60 | 28.3333 | 762x39 | brass: BR11; haggler: HG11; quartermaster: QM11 |
| 762x39ap | 1700 | 60 | 28.3333 | 762x39 | brass: BR12; quartermaster: QM12 |
| 762x39hp | 1700 | 60 | 28.3333 | 762x39 | brass: BR12; quartermaster: QM12 |
| 50ae | 1750 | 60 | 29.1667 | 50ae | brass: BR13; quartermaster: QM13 |
| 50aeap | 1750 | 60 | 29.1667 | 50ae | brass: BR14; quartermaster: QM14 |
| 50aehp | 1750 | 60 | 29.1667 | 50ae | brass: BR14; quartermaster: QM14 |
| 45acp41 | 600 | 20 | 30.0000 | 45acp41 | brass: BR13; haggler: HG14; old-timer: OT15; quartermaster: QM13 |
| 9x39 | 1900 | 60 | 31.6667 | 9x39 | boss: BO13; brass: BR15; quartermaster: QM15 |
| 9x39ap | 1900 | 60 | 31.6667 | 9x39 | brass: BR16; quartermaster: QM16 |
| 9x39hp | 1900 | 60 | 31.6667 | 9x39 | brass: BR16; quartermaster: QM16 |
| 762x51 | 1950 | 60 | 32.5000 | 762x51 | brass: BR17; quartermaster: QM17; spoor: SP15 |
| 762x51ap | 1950 | 60 | 32.5000 | 762x51 | brass: BR18; quartermaster: QM18; spoor: SP16 |
| 762x51hp | 1950 | 60 | 32.5000 | 762x51 | brass: BR18; quartermaster: QM18; spoor: SP16 |
| 500magnum | 1000 | 30 | 33.3333 | 500magnum | brass: BR17; quartermaster: QM17 |
| 500magnumap | 1000 | 30 | 33.3333 | 500magnum | brass: BR18; quartermaster: QM18 |
| 500magnumhp | 1000 | 30 | 33.3333 | 500magnum | brass: BR18; quartermaster: QM18 |
| 762x54 | 2100 | 60 | 35.0000 | 762x54 | brass: BR19; old-timer: OT22; quartermaster: QM19; spoor: SP17 |
| 762x54ap | 2100 | 60 | 35.0000 | 762x54 | brass: BR20; quartermaster: QM20; spoor: SP18 |
| 762x54hp | 2100 | 60 | 35.0000 | 762x54 | brass: BR20; quartermaster: QM20; spoor: SP18 |
| 338lapua | 3500 | 60 | 58.3333 | 338lapua | brass: BR19; quartermaster: QM19; spoor: SP17 |
| 338lapuaap | 3500 | 60 | 58.3333 | 338lapua | brass: BR20; quartermaster: QM20; spoor: SP18 |
| 338lapuahp | 3500 | 60 | 58.3333 | 338lapua | brass: BR20; quartermaster: QM20; spoor: SP18 |
| 127x55 | 3500 | 30 | 116.6667 | 127x55 | brass: BR21; quartermaster: QM21 |
| 93x64 | 3500 | 30 | 116.6667 | 93x64 | brass: BR21; quartermaster: QM21 |
| 145x114ap | 8000 | 60 | 133.3333 | 145x114 | brass: BR24; quartermaster: QM24 |
| 145x114hp | 8000 | 60 | 133.3333 | 145x114 | brass: BR24; quartermaster: QM24 |
| 700nitro | 3500 | 16 | 218.7500 | 700nitro | brass: BR21; quartermaster: QM21 |
| 145x114 | 8000 | 30 | 266.6667 | 145x114 | brass: BR23; quartermaster: QM23 |
