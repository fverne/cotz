# Ammunition progression by price per round

Generated with `python3 docs/npc-overhaul/tools/ammo_progression.py --write`.

The cost is the concrete item's `price / ammoAmount`, matching the ammunition base's GetPrice.
Eight global regular-load price bands each have regular, HP and AP stages, scaled to the contact's tree.
HP requires regular ammunition. AP additionally requires local HP when available, including equal-price variants.
Each vendor's ammunition stages require its preceding stage, so sibling story branches cannot bypass the order.
The approved plan has no starting sale supplies. No box prices, round counts or damage values are changed.

Variants always follow their regular counterpart. Special 12-gauge loads and 14.5 mm variants currently cost
less per round than the regular load; they use the regular load's price band to preserve that upgrade rule.
The legacy ID `45acp41` is .410 bore, a separate cartridge rather than a .45 ACP upgrade.

| Item | Box price | Rounds | Price per round | Regular counterpart | Seller: milestone |
| --- | ---: | ---: | ---: | --- | --- |
| 22lr | 450 | 60 | 7.5000 | 22lr | beanstalk: BN01; haggler: HG01 |
| 22lrap | 450 | 60 | 7.5000 | 22lr | beanstalk: BN03 |
| 22lrhp | 450 | 60 | 7.5000 | 22lr | beanstalk: BN02 |
| 762x25 | 500 | 60 | 8.3333 | 762x25 | beanstalk: BN01; brass: BR01; haggler: HG01 |
| 762x25ap | 500 | 60 | 8.3333 | 762x25 | beanstalk: BN03; brass: BR03 |
| 762x25hp | 500 | 60 | 8.3333 | 762x25 | beanstalk: BN02; brass: BR02 |
| 9x18 | 600 | 60 | 10.0000 | 9x18 | beanstalk: BN01; brass: BR01; haggler: HG01 |
| 9x18ap | 600 | 60 | 10.0000 | 9x18 | beanstalk: BN03; brass: BR03 |
| 9x18hp | 600 | 60 | 10.0000 | 9x18 | beanstalk: BN02; brass: BR02 |
| 9x19 | 750 | 60 | 12.5000 | 9x19 | beanstalk: BN04; brass: BR04; haggler: HG04 |
| 9x19ap | 750 | 60 | 12.5000 | 9x19 | beanstalk: BN06; brass: BR06 |
| 9x19hp | 750 | 60 | 12.5000 | 9x19 | beanstalk: BN05; brass: BR05 |
| 9x21 | 750 | 60 | 12.5000 | 9x21 | beanstalk: BN04; brass: BR04 |
| 9x21ap | 750 | 60 | 12.5000 | 9x21 | beanstalk: BN06; brass: BR06 |
| 9x21hp | 750 | 60 | 12.5000 | 9x21 | beanstalk: BN05; brass: BR05 |
| 57x28 | 850 | 60 | 14.1667 | 57x28 | beanstalk: BN04; brass: BR04 |
| 57x28ap | 850 | 60 | 14.1667 | 57x28 | beanstalk: BN06; brass: BR06 |
| 57x28hp | 850 | 60 | 14.1667 | 57x28 | beanstalk: BN05; brass: BR05 |
| 45acp | 950 | 60 | 15.8333 | 45acp | beanstalk: BN04; brass: BR04; haggler: HG04 |
| 45acpap | 950 | 60 | 15.8333 | 45acp | beanstalk: BN06; brass: BR06 |
| 45acphp | 950 | 60 | 15.8333 | 45acp | beanstalk: BN05; brass: BR05 |
| 357magnum | 1000 | 60 | 16.6667 | 357magnum | beanstalk: BN07; haggler: HG07 |
| 357magnumap | 1000 | 60 | 16.6667 | 357magnum | beanstalk: BN09 |
| 357magnumhp | 1000 | 60 | 16.6667 | 357magnum | beanstalk: BN08 |
| 44magnum | 1000 | 60 | 16.6667 | 44magnum | beanstalk: BN07; brass: BR07; haggler: HG07 |
| 44magnumap | 1000 | 60 | 16.6667 | 44magnum | beanstalk: BN09; brass: BR09 |
| 44magnumhp | 1000 | 60 | 16.6667 | 44magnum | beanstalk: BN08; brass: BR08 |
| 12gaugedt | 600 | 30 | 20.0000 | 12gauge | spoor: SP02 |
| 12gaugesg | 700 | 30 | 23.3333 | 12gauge | spoor: SP02 |
| 12gaugemg | 750 | 30 | 25.0000 | 12gauge | spoor: SP02 |
| 12gaugetr | 750 | 30 | 25.0000 | 12gauge | spoor: SP02 |
| 545x39 | 1500 | 60 | 25.0000 | 545x39 | beanstalk: BN07; brass: BR07; intern: IN01; quartermaster: QM01 |
| 545x39ap | 1500 | 60 | 25.0000 | 545x39 | beanstalk: BN09; brass: BR09; intern: IN03 |
| 545x39hp | 1500 | 60 | 25.0000 | 545x39 | beanstalk: BN08; brass: BR08; intern: IN02 |
| 12gauge | 800 | 30 | 26.6667 | 12gauge | spoor: SP01 |
| 556x45 | 1650 | 60 | 27.5000 | 556x45 | beanstalk: BN10; haggler: HG10; intern: IN04; quartermaster: QM04 |
| 556x45ap | 1650 | 60 | 27.5000 | 556x45 | beanstalk: BN12; intern: IN06 |
| 556x45hp | 1650 | 60 | 27.5000 | 556x45 | beanstalk: BN11; intern: IN05 |
| 762x39 | 1700 | 60 | 28.3333 | 762x39 | beanstalk: BN10; brass: BR10; haggler: HG10; intern: IN04; quartermaster: QM04 |
| 762x39ap | 1700 | 60 | 28.3333 | 762x39 | beanstalk: BN12; brass: BR12; intern: IN06 |
| 762x39hp | 1700 | 60 | 28.3333 | 762x39 | beanstalk: BN11; brass: BR11; intern: IN05 |
| 50ae | 1750 | 60 | 29.1667 | 50ae | beanstalk: BN13; brass: BR13 |
| 50aeap | 1750 | 60 | 29.1667 | 50ae | beanstalk: BN15; brass: BR15 |
| 50aehp | 1750 | 60 | 29.1667 | 50ae | beanstalk: BN14; brass: BR14 |
| 45acp41 | 600 | 20 | 30.0000 | 45acp41 | haggler: HG14; spoor: SP03 |
| 9x39 | 1900 | 60 | 31.6667 | 9x39 | beanstalk: BN13; intern: IN07; quartermaster: QM07 |
| 9x39ap | 1900 | 60 | 31.6667 | 9x39 | beanstalk: BN15; intern: IN09 |
| 9x39hp | 1900 | 60 | 31.6667 | 9x39 | beanstalk: BN14; intern: IN08 |
| 762x51 | 1950 | 60 | 32.5000 | 762x51 | beanstalk: BN16; haggler: HG17; intern: IN10; quartermaster: QM10 |
| 762x51ap | 1950 | 60 | 32.5000 | 762x51 | beanstalk: BN18; intern: IN12 |
| 762x51hp | 1950 | 60 | 32.5000 | 762x51 | beanstalk: BN17; intern: IN11 |
| 500magnum | 1000 | 30 | 33.3333 | 500magnum | beanstalk: BN16; haggler: HG17 |
| 500magnumap | 1000 | 30 | 33.3333 | 500magnum | beanstalk: BN18 |
| 500magnumhp | 1000 | 30 | 33.3333 | 500magnum | beanstalk: BN17 |
| 762x54 | 2100 | 60 | 35.0000 | 762x54 | beanstalk: BN19; brass: BR19; haggler: HG20; intern: IN13; quartermaster: QM13 |
| 762x54ap | 2100 | 60 | 35.0000 | 762x54 | beanstalk: BN21; brass: BR21; intern: IN15 |
| 762x54hp | 2100 | 60 | 35.0000 | 762x54 | beanstalk: BN20; brass: BR20; intern: IN14 |
| 338lapua | 3500 | 60 | 58.3333 | 338lapua | beanstalk: BN19; intern: IN13; quartermaster: QM13 |
| 338lapuaap | 3500 | 60 | 58.3333 | 338lapua | beanstalk: BN21; intern: IN15 |
| 338lapuahp | 3500 | 60 | 58.3333 | 338lapua | beanstalk: BN20; intern: IN14 |
| 127x55 | 3500 | 30 | 116.6667 | 127x55 | beanstalk: BN19 |
| 93x64 | 3500 | 30 | 116.6667 | 93x64 | beanstalk: BN19 |
| 145x114ap | 8000 | 60 | 133.3333 | 145x114 |  |
| 145x114hp | 8000 | 60 | 133.3333 | 145x114 |  |
| 700nitro | 3500 | 16 | 218.7500 | 700nitro |  |
| 145x114 | 8000 | 30 | 266.6667 | 145x114 |  |
