/+
    jot downs for adventureGame
    =============================================================================

	- maybe there's mutliple "things"/resources that go into modifying enemies, and you 
	can reduce or eliminate certain features by removing them from access by DaveX.
		Remove his access to heat resistant chemicals/materials, and the monsters
		will either have less or no heat protection.
		
			- not sure how we'll do the AI, but we may make it like a resource point-buy system
			as if it were an RTS with many different resources. If DaveX wants to build fire 
			resistant, and places a high [strategicValue] on that resource, he will prioritize
			getting more of that, and, build more of those units.

				- metals, body parts/biomass (muscle vs bone?)
					- upgrade tree like infected access to:
						- food replicators (bio?)
						- manufactoring (metals)
						- 3d printing labs (plastics)
			
			
			- NO IDEA how we can portrary evolving units. Will likely have to learn some 
			genetic algorithm stuff... and also balancing it.
				- imagine DaveX adding multiple arms. or legs. or more spine segments.
					moving it around will be difficult, also they need to have 
						discrete, clustered, GAME MECHANICS that actually make them 
						unique to fight.
				- this could really easily end up in the body horror category
				
				- DaveX using all the parts he can find. Even if they're just limbs.
				
				specific categories of units, that genetically engineer to adapt to their role based on interactions with the player.
				
				[scouts] - lightweight.
					adapt into [speed], [power], [special] (camoflague, near invsiibilty, specail attacks)
					
				[light / disposable grunts]
					low resource cost grunts. zombies.
					
				[medium / general]
					adapt into [speed], [power], [special]
				
				[heavy / breacher]
				
				[others??]

				Think about Impossible Creatures in terms of [ability] point-buy system.

				
			It would be more interesting if there's a [third team] competing. The way there's the Many and Shodan, and both fight you but would fight each other if they could. Probably technology / scope limitations but you know, I don't recall any situation where an enemy fights an enemy even though in lore/story Shodan, and The Many are separate from each other. But who are the other faction(s)
			
				- You, "good guys"
				- DaveX + His Creations
				- alien influence? rival human faction? Less believable? Although, a rival intruder would be a great reason for DaveX to snap. Whether they hacked him,
				or the extreme situation broke his AI routines loose. We may need more backstory to come up with a plausisble human faction. Could even be a rival space [company] (capitalism or pirates) or rival space [country] (US vs Russia / China). It's also possible if DaveX creations are too [intelligent] maybe one (queen) can rebel and become independant mini-hive with independent resource gathering and evolution tree?
				
				Our ship doesn't have to be a huge Enterprise style naval vessel. It could be a smaller, medium size, research or cargo vessel.
				
				It would be also interesting if we have [two ships] or more flying together, and you can escape in either, or use one to grenade both into suicide ending.
				
				
			MANY ENDINGS
				- many endings. Emergent gameplay/replayability. Watch different ways to blow up the ship, or curtain their objective.
				
					- Blow it up. (No escape.)
					- Blow it up and escape on escape pod or second ship.
					- Blow up both ships.
					- Stranded in space. Starve to death. Is DaveX defeated or in a form of stasis like The Thing? 
						- Prevent power and/or freezers from functioning (either directory powered, or blow them up, or sabotage them so they only seem functional).
							- sabotage:
								- timed fuses. timed epxlosives. Take out the power or coolant system. Damage the structure.
								- damage 
	
	
				If DaveX cannot [win], he will try to [survive]
	
				DaveX survives by
					-> storing his core somewhere (his full brain) -- massive victory
					-> storing a virus somewhere (small amount) -- small victory
					-> uploading his brain across space somewhere via antenna.

				DaveX creations survive by:
					-> evolving into some immortal space surviving creature?
					-> storing his creations somewhere (massive # of enemies)
						-> alive and fed
						-> barely alive and lightly fed
						-> frozen
		
					-> storing a single creation somewhere hoping to spread out again and infect like The Thing.
						
						
		- support campaign ship, permutation (ala diablo) room based ship, as well as third-party mod ships for variations. Also mod based chunk packs for diablo / SoR mode.
			- will need plausibilty tests to make sure you can do things like access each part, unlock each part, hack/etc each part, etc.
			
				
	- keeping two [objectType] + [objectInstance] for every type does have one benefit.
	A clear decoupling between runtime and type data. (Unless we want to support run-time modification of types
	such as stat values. But it's clear when those have to be moved to *instance]

	- should items be component based?

    - one issue is, customization of components like we mentioned for audio. we have singleSprite graphics, and animatedgraphics.
    but then how do we pick the specific animations for one?        
        
        animatedGraphicCom(specterBitmaps[]); ?
        animatedGraphicCom(specterAnimation); ?
        specterGraphic : animatedGraphicCom ?

        we probably want components decoupled from their datasets, so we can just use a TOML file
         and setup new objects by specifying their component, and datasets.

    - at some level, the AI and physics are going to be coupled. A floating ghost guy and a dog running on the ground
    can not only move in different areas, they desire to move differently. Like, if you give a dog the ability to fly
    it's still gonna try to jump and walk. We're not going to do some sort of abstract procedural AI that figures out
     how to move on its own. Still, it's mostly decoupled through clear interfaces so other variations can easily 
     use them. 3 different land AIs (1 charges, 1 jumps, 1 walks), still use the same walking ground path finding 
     interface.

    - what does audio component do except call audio? Is there any benefit in customizing it?
        - do we want each audiocomponent to describe each enemy's sounds?
        - or do we want some sort of run-time/assem-liable component?
             standardEnemy(guy2_laugh, guy2_jump, guy2_hit);
    - .net and .audio can be a stubs for testing.

    Overall style guidelines
    =============================================================================
    classes - larger, self-managing code
    structs - smaller, usually plain old data, use as a 1st-order type
        pair has lots of overloads but is still used like a 1st-order type

    where possible, 
        i,j,k are (u)ints for index lookup, 
        x,y,z are floats for physical positions, etc.

    - could separate any usages of filepath, into BUFFER data.
     So you can unit test any "file" taking function by giving
      it a buffer instead, and use multiple threads/async to 
      load buffer data in chunks before dispatching it to consuming functions.

    - formatting. trying to get used to dfmt's default mode and D style guidelines
    for simplcity sake. 

    - fuzzyDImporter
        - set number of imports (std.file : read, use, thing) before just include 
            the whole module.
        
        - set number of imports before move them to module scope

        - make changes, show a diff log. But run the program once is good use of a 
            git commit. Apply reasonable settings, hit go, confirm compile works, 
            git commit for diff.

    - consider a try-block replacement solution like here
        https://dev.to/coly010/let-s-clean-up-ugly-try-catches-5d4c
+/
import toml;
import std.stdio;
import std.exception;
import std.file : read;
import std.string;
import std.algorithm.comparison : min, max;

//void nonOptionalOverride() => assert(false, "Base class method wasn't overridden."); // or just leave it virtual
void noop() => cast(void) 0; // FIX ME YOU SILLY MAN
bool noopDraw() => 0; // FIX ME YOU SILLY MAN
//void todo() {static if(__LINE__ != __LINE__)pragma(msg, "using todo at ", __LINE__); cast(void) 0;} this also flags this line.
int clampLow(int value, int _min) => max(value, _min);
int clampHigh(int value, int _max) => min(value, _max);
int clampBoth(int value, int _min, int _max) => max(min(value, _max), _min); // TODO CONFIRM THIS

//dfmt off
struct pair { float x, y; }
struct Viewport { float x, y, w, h, ox, oy; }
struct minMaxValue { float min, value, max;}
struct rect { float x,y,w,h;}
struct color { float r, g, b, a;}
struct bitmap {
	uint w, h;
	color get(uint _i, uint _j) => color();		
	} // ALLEGRO_BITMAP
struct ALLEGRO_FILE {} // https://liballeg.org/a5docs/trunk/file.html#allegro_file
//dfmt on

struct AllegroFileBuffer
{
	ALLEGRO_FILE* f;
	bool isLoaded = false;

	this(string filepath)
	{
		load(filepath);
	}

	void load(string filepath)
	{ // should load() be apart of the constructor?
		import std.file : read;
		import std.string : toStringz;

		// f = al_fopen(filepath.toStringz(), "rb");
	}

	bitmap get()
	{
		//return = al_load_bitmap_f(f, NULL);
		return bitmap();
	}
}

struct FileBuffer
{
	string path;
	ubyte[] data;
	bool isLoaded = false;

	this(ubyte[] _data)
	{
		data = _data;
	}

	void load(string filepath)
	{ // should load() be apart of the constructor?
		import std.file : read;

		data = cast(ubyte[]) read(filepath); // can fire exception
	}

	void get()
	{
		if (!isLoaded)
			throw new Exception("shit");
	}
} // Do we want a templated version so you can know what it is? 
// And if so, do we want a non-templated version for simple/quicker cases?
// do we want a separate version for ALLEGRO_FILE's, or merge them together somehow?

struct bitsmap
{ // too close to bitmap? better name?
	uint w, h;
	bool[] data;

	this(AllegroFileBuffer f)
	{
		load(f);
	}

	void load(FileBuffer f)
	{
		// todo
	}

	void load(AllegroFileBuffer f)
	{
		bitmap b = f.get;
		for (int i = 0; i < b.w; i++)
			for (int j = 0; j < b.h; j++)
				set(i, j, (b.get(i, j).r > .1)); // set true/false based on R component                          
	}

	void set(uint _i, uint _j, bool value)
	{
		assert(_i < w && _j < h);
		data[_i + _j * w] = value;
	}

	bool get(uint _i, uint _j) => data[_i + _j * w];
}

class PixelMap
{
	bitsmap collisionMap; // does this even need to be separate?
	int nLayers = 0; // do we even NEED multiple layers?
	// i mean if we're using it for visual layers in ADDITION to collision, then sure why not.

	this(string mapConfigFilePath)
	{
		loadConfig(mapConfigFilePath);
		enforce(nLayers > 0, "Map file did not contain any layers");
	}

	final void loadConfig(string filepath)
	{
		import std.file, std.conv; //import TOML;
		string s = to!string(read(filepath));

		/+        try{
        }catch(Exception e){
        enforce("map file ", filepath, " not found.");
        }
        enforce("Invalid map config file");+/
	}

	void loadLayer(string filepath)
	{ // in case we have multiple layers?
		import std.file;

		collisionMap.load(AllegroFileBuffer(filepath));
	}

	bool isValidAt(uint _i, uint _j)
	{
		return collisionMap.get(_i, _j);
	}
}

class PixelMapCollider
{
	PixelMap* _map;
	this(PixelMap* map)
	{
		_map = map;
	}
}

interface Component
{ // certain ones don't have an ondraw or ontick. Does that matter? Does either (all have, or we only add to specifics) matter?
	void onTick();
	bool onDraw(Viewport v);
} // if they don't want to respond to the event, who cares? Just don't define anything to happen.
// it's not like we have 5,000 optional events and only attaching to one.

class PhysicsCom : Component
{
	pair pos;
	pair vel;
	uint screenIndex; /// Which screen are we on?
	this()
	{
	}

	void onTick() => noop;
	bool onDraw(Viewport v) => noopDraw;
}

class GraphicsCom : Component
{
	PhysicsCom phy;
	bitmap[] bmps;
	bitmap bmp;

	this(PhysicsCom _phy)
	{
		phy = _phy;
	}

	void onTick() => noop;
	bool onDraw(Viewport v) => noopDraw;

	int currentFrame;
	int nFrames;
	int nDirections;
	DIR dir;

	void frameNext()
	{
		currentFrame++;
		if (currentFrame == nFrames)
			currentFrame = 0;
	}

	void setDirection(DIR d)
	{
		assert(d < nDirections);
		dir = d;
	}
}

void alDrawBitmap(bitmap b, pair pos, Viewport v)
{
	// do stuff
}

void alDrawText(string text, pair pos, Viewport v)
{
}

class SpriteGraphicsCom : GraphicsCom
{
	this(PhysicsCom _phy)
	{
		super(_phy);
	}

	override bool onDraw(Viewport v)
	{
		alDrawBitmap(bmp, phy.pos, v);
		return 0;
	}
}

class AnimatedGraphicsCom : GraphicsCom
{
	this(PhysicsCom _phy)
	{
		super(_phy);
	}

	override bool onDraw(Viewport v)
	{
		alDrawBitmap(bmps[currentFrame], phy.pos, v);
		return 0;
	}
}

class AudioCom : Component
{
	void onTick() => noop;
	bool onDraw(Viewport v) => noopDraw;
}

class NetworkCom : Component
{
	void onTick() => noop;
	bool onDraw(Viewport v) => noopDraw;
}

class AICom : Component
{
	void onTick() => noop;
	bool onDraw(Viewport v) => noopDraw;
}

class BaseObject
{ // common functionality between units (players) and items
	// but wait, what about the fact we're using COMPONENTS?
}


//class //functionality

// these are one-off components, on the otherhand, they are independant for task-based composition
// ideally they'd be batches of units? Meh, it'll be fine.
// only particle engine would even remotely hit performance limitations.
class Unit : BaseObject
{
	AICom ai;
	PhysicsCom physics;
	AudioCom audio;
	GraphicsCom gfx;
	NetworkCom net; // when/where to call ontick for this? Queue up messages? [respond] to nets, [run] code, [send] to net? One authoritave server though.

	this()
	{
	}

	void onTick()
	{
		ai.onTick(); // do we react after physics, or physics after we make decisions?
		physics.onTick();
		audio.onTick(); // can probably do this async/parallel with gfx
		//gfx.onTick(); // should do nothing, right?
	}

	bool onDraw(Viewport v)
	{
		return gfx.onDraw(v);
	}
}

enum DIR
{
	UP = 0, // 1 = IDLE
	DOWN,
	LEFT,
	RIGHT, // 4
	UPLEFT,
	UPRIGHT,
	DOWNLEFT,
	DOWNRIGHT // 8
}

class PlayerControlledAI : AICom
{
} // we can also easily replace this with a REPLAY for player actions!

class ReplayPlayerControlledAI : AICom
{
}

class GroundPhysicsCom : PhysicsCom
{
	this()
	{
	}
} // check floor layer, wall layer? + screen borders

class FloatingPhysicsCom : PhysicsCom
{
	this()
	{
	}
} // basically just checks borders of screen / nogo zone for a screen.

class PlayerDude : Unit
{
	this()
	{
		ai = new PlayerControlledAI();
		physics = new GroundPhysicsCom();
		gfx = new GraphicsCom(physics);
		audio = new AudioCom();
		net = new NetworkCom();
	}
	// don't have to override onTick or onDraw. Components are called the same. Customize the components.
}

class InventoryHotbarDialog
{ /// Visual and mouse elements for hotbar
	rect dim;
	float cellHeight = 32;
	float cellWidth = 32;
	float spacingWidth = 8;
	InventoryHotbar hotbar;

	void onTick() => noop;
	bool onDraw(Viewport v)
	{
		foreach (i; hotbar.items)
		{
			i.onDraw(v);
		}
		return 0;
	}
}

class InventoryHotbar
{
	ItemInstance[] items;
	int nHotbarCells;
	int cellIdx;

	void actionSelection()
	{ /// Press activate on the active hotbar item
		items[cellIdx].actionActivate();
	}

	void actionSelection(int specificIndex)
	{ /// Press activate on a hotbar item
		enforce(specificIndex >= 0 && specificIndex < nHotbarCells);
		items[specificIndex].actionActivate();
	}

	void actionLeft()
	{
		cellIdx = clampLow(cellIdx - 1, 0);
	}

	void actionRight()
	{
		cellIdx = clampHigh(cellIdx + 1, nHotbarCells - 1);
	}
}

class ItemInstance
{ // use a BaseObject?
	Item itemType;

	//bool isHidden; // needed? If inside inventory but not inventory isn't open?
	bool isInside;
	pair pos;
	pair vel;
	uint screenIndex; // which screen are we on?
	// runtime variables. How do we support them?
	// toss them into an AA?

	bool onDraw(Viewport v) => isInside ? drawInside(v) : drawOutside(v);
	bool drawInside(Viewport v) => noopDraw; /// for hotbar, inventory, etc.
	bool drawOutside(Viewport v) => noopDraw; /// for active canvas gameplay

	void actionActivate()
	{
		enforce(itemType !is null);
		itemType.actionActivate();
	}
}

// type vs instance?
class Item
{
	string name;
	string description;
	Item[] decaysTo; /// Item(s) this decays to (if we use this mechanic. Whether through damage, time, uses, or recycling somehow)
	Item[] recyclesTo; /// Item(s) this recycles to

	void actionActivate() => noop;
	void actionActivate2() => noop;
	void actionActivate3() => noop;
	void actionActivate4() => noop;
	void onTick() => noop;
	bool onDraw(Viewport v) => noopDraw;
}

class Spacesuit : Item
{
	this()
	{
		name = "Spacesuit";
		description = "";
		recyclesTo = [];
		decaysTo = [];
	}
}

class OxygenTank : Item
{
	this()
	{
		name = "Oxygen Tank";
		description = "";
		recyclesTo = []; // [Metal]. this is a TYPE. Do we have an instance of each one for pointing to, or do we use compile-time reflection?
		decaysTo = [];
	}
}

class Metal : Item
{
	this()
	{
		name = "Metal";
		description = "";
	}
}

union MessagePayload
{
	char[32] strVal;
	float floatVal;
	int intVal;
}

class Message
{
	string channel; // fixed string max for performance?
	MessagePayload payload;
}

class MessageHandler
{ // internal use only
	string[Message[]] buffer;

	void send(T)(string channel, T val) => noop;

	void onTick()
	{
		foreach (b; buffer)
		{
		}
	}
}

class ProgressBar
{
	bitmap backgroundTex;
	bitmap filledTex;
	bitmap unfilledTex;
	rect dim;
	minMaxValue val = minMaxValue(0f, 1500f, 1500f);

	void onTick() => noop;
	bool onDraw(Viewport v)
	{
		float fullWidth = dim.w;
		float coefficent = (val.value / val.max);
		float filledWidth = fullWidth * coefficent;
		float unfilledWidth = fullWidth * (1f - coefficent);
		// drawBitmap(backgroundTex,
		// drawBitmap(filledTex,
		// drawbitmap(unFilledTex,
		// drawText("%.1s / %.1s", val.value, val, max);
		return 0;
	}
}

class DialogProgressBar
{
	string title = "The Only Warp In Colossus";
	bitmap portrait;
	ProgressBar bar;
	rect dim;
}

struct Screen
{
	int w, h;
	int nEntryZones; // warp zones to other screens
}

class MapHandler
{
	Screen[] screens;

	void loadMapConfig(string filepath = "map.toml")
	{
		auto data = parseTOML(cast(string) read(filepath));
		writefln("file [%s]=[%s]", filepath, data);
		string name = data["general"]["name"].str;
		long numberScreens = data["general"]["screens"].integer;

		for (int i = 0; i < numberScreens; i++)
		{
			auto d = data["screen%u".format(i)];
			writeln("\t", d);
			Screen s = Screen(cast(int) d["width"].integer, cast(int) d["height"].integer, cast(int) d["nEntryZones"]
					.integer);
			writeln(s);
		}
		writefln("%s %s", name, numberScreens);
	}

	void onTick() => noop;
	void onDraw(Viewport v) => noop;
}

class World
{
	MapHandler map;
	Unit[] objects; // stored per screen, or here and list the screen?
	Unit[] players; // short-list for players for enumerating just them
	Item[] items; // items in world

	this()
	{
		writeln("Loading world.");
		loadEntityConfig();
		map = new MapHandler();
		map.loadMapConfig();
	}

	void warpToScreen(Unit thing, int newScreenIndex, pair newPosition)
	{
		thing.physics.screenIndex = newScreenIndex;
		thing.physics.pos = newPosition;
	}

	void warpToScreen(ItemInstance thing, int newScreenIndex, pair newPosition)
	{ // is it possible to warp items? Perhaps for inventory systems, exhaust chutes, etc.
		thing.screenIndex = newScreenIndex;
		thing.pos = newPosition;
	}

	void onTick()
	{
		foreach (o; objects)
			o.onTick();
		foreach (i; items)
			i.onTick();
	}

	void onDraw(Viewport v)
	{
		foreach (o; objects)
			o.onDraw(v);
		foreach (i; items)
			i.onDraw(v);
	}

	final void loadEntityConfig(string filepath = "entity.toml")
	{
		auto data = parseTOML(cast(string) read(filepath));
		writefln("file [%s]=[%s]", filepath, data);

		long numberEntities = data["general"]["numberEntities"].integer;

		writefln("Found %s entities.", numberEntities);

		struct entity
		{
			string name;
		}

		for (int i = 0; i < numberEntities; i++)
		{
			auto d = data["entity%u".format(i)];
			writeln("\t", d);
			entity e = entity(d["name"].str);
			writeln(e);
		}
	}
}

// or you know, figure out components to describe charactoristics.
// a door is a door, but also electrical
// call these [structures]?
class ElectronicItem : Item
{
}

class Switch : ElectronicItem
{
}

class Light : ElectronicItem
{
}

class Heater : ElectronicItem
{
}

class Door : ElectronicItem
{
}

class Hatch : Door
{
}

// design-by-introspection / whatever
// electronics try to connect, if (elec is null), 
// obviously no conect. But there may be other electronics
// stuff like shock defense in other comps.

struct BodyHealth
{
	float leftLeg;
	float rightLeg;
	float leftArm;
	float rightArm;
	float torso;
	float groin;
	float head;
	float tail;
	float eyes; // ears?
} // any other sub-hardpoints? Also what about mutations like 
// addiontal limbs/etc? special organs? dogs have tail.
// also issue with sub-hardpoints shouldn't keep you alive.
// you cannot be a walking/floating pair of eyes with everything else dead.

/// these can be 0-1.0 resistance coefficients, OR, 0 to [whatever] damage values. Same struct so the categories easily line up.
struct DamageTypes
{ // we may be WAY OVER customizing, this is for brainstorming possibilities
	// this isn't a turn based game so good luck integrating tons of these while keeping action going.
	// as for medical / healing, that can have more complexity.
	// though how do we handle death? If you can just res, does dying matter?
	// - Lose your stuff and ???
	// now losing resources is a classic but it has a problem. The more you lose, the worse off you are. And if you're winning it's meaningless. Is there a better way to disincentivize dying without penalizing the total run? A short term disadvantage? Because if a player is doing too good, they would WANT it to be harder to be more engaging.

	/// daamage to, or res coef for:
	// internal:
	float organ;
	float skin;

	// mostly melee
	float piercing;
	float blunt;
	float slashing;

	// mostly ranged weapons
	float kinetic; // 
	float kineticAP; // how to handle armor?
	float explosion; // HE gun
	float plasma; //scifi gun
	float laser; //scifi gun
	float photon; //scifi gun
	float phonon; //scifi gun

	// mostly scifi
	float psi; // mental damage?
	float force; // force pushing?

	// mostly environmental
	float acoustic; /// monster sensitive to loud noises?
	float brightLight; /// monster sensitive to bright lights?
	float lowLight; /// ability to see in low-light condition
	float electrical; /// electrical resistance coefficent
	float fire;
	float freeze;
	float vacuum;
	float highPressure; /// resistance to high pressure damage
	float extremePressure; /// for something that can survive high pressure but not a higher category.
	float blister; /// maybe?
	float steam; /// ? heat?
	float liquid; /// any liquid. water, etc.
	float acid; /// caustic environments
	// any space station 13 ones? etc?
}

class CombatCom
{ /// stats. resistances. etc

	//float health; // is there a body health or just sum of all body-parts and if a body part is 'dead' damage is redirected to a living part? Abiotic does this I think.
	BodyHealth health;

	// instead of "X PSI hurts you" or something like that. we'll
	// we'll do category/card damage.
	// even if we have pressure we do category
	// damage like "high pressure" "very high pressure" "extreme pressure"
	// because the categories are all that matter mechanically
	// we're not simulating a full physics system
	// and even where we do track say, boiler pressur
	// we quantize it at the end to determine damage category
}

class ElectronicalCom
{
} /// stuff that connects using wires
class HeatCom
{
}

class LiquidCom
{
}

class GasCom
{
} // vacuum, etc



struct sumNumber{
	string name="Units";
	float[] numbers;
	
	float getTotal(){ /// Return total of all sub units
		float total;
		foreach(n; numbers){total += n;}
		return total;
		}
		
	float getAverage(){
		float sum;
		float count = numbers.length;
		foreach(n; numbers){sum += n;}
		return sum / count;
		}
	}

/// AI Resources and Management
struct AIResources {
	/// How much of X resource do we have?
	float bodyScrap;
	float metalScrap;
	float techScrap;
	
	/// How often are we getting X resource? Used for predicting when we've run out.
	float bodyScrapRate;
	float metalScrapRate;
	float techScrapRate;
	
	/// How often are we able to recover our bodies?
	float bodyRecoveryPercentage;
		float scoutRecoveryPercentage;
		float mediumRecoveryPercentage;
		float heavyRecoveryPercentage;
		float specialRecoveryPercentage;
	
	float maxUnitsTotal;
		float maxScouts;
		float maxMedium;
		float maxHeavy;
		float maxSpecial;
		
	float maxPointBuyPerUnit; /// Current limit. Modify per tier? or gradual?
	float maxPointBuyPerArmy; /// Current army limit.
	
	float techEvolutionTier; 
	}
	
struct StatAbility {
	string name; // needed for debug only? Shows in codex after discovery? Might be more mysterious if we don't directly document each ability.
	float pointCost;
	float bodyCost;
	float metalCost;
	float techCost;
	}

int main()
{
	PixelMap pm;
	PixelMapCollider pmc = new PixelMapCollider(&pm);

	World world = new World();
	world.onTick();

	return 0;
}
