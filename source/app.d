/+
    jot downs for adventureGame
    =============================================================================

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

    - dfmt does not support one-liner comments off because it's dumb.
        We can add our own one-liner support and just prune those results.
        https://github.com/dlang-community/dfmt?tab=readme-ov-file#disabling-formatting

        // dfmt off
        // dfmt on
        // dfmt oneoff <---

        but this won't affect Visual Code because of bullshit.

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

struct pair {
	float x, y;
}

struct Viewport {
	float x, y, w, h, ox, oy;
}

struct color { // dfmt oneoff
	float r, g, b, a;
}

struct bitmap { // dfmt oneoff
	uint w, h;
	color get(uint _i, uint _j) {
		return color();
	}
} // ALLEGRO_BITMAP

struct ALLEGRO_FILE {
} // https://liballeg.org/a5docs/trunk/file.html#allegro_file

struct AllegroFileBuffer {
	ALLEGRO_FILE* f;
	bool isLoaded = false;

	this(string filepath) {
		load(filepath);
	}

	final void load(string filepath) { // should load() be apart of the constructor?
		import std.file : read;
		import std.string : toStringz;

		// f = al_fopen(filepath.toStringz(), "rb");
	}

	bitmap get() {
		//return = al_load_bitmap_f(f, NULL);
		return bitmap();
	}
}

struct FileBuffer {
	string path;
	ubyte[] data;
	bool isLoaded = false;

	this(ubyte[] _data) {
		data = _data;
	}

	void load(string filepath) { // should load() be apart of the constructor?
		import std.file : read;

		data = cast(ubyte[]) read(filepath); // can fire exception
	}

	void get() {
		if (!isLoaded)
			throw new Exception("shit");
	}
} // Do we want a templated version so you can know what it is? 
// And if so, do we want a non-templated version for simple/quicker cases?
// do we want a separate version for ALLEGRO_FILE's, or merge them together somehow?

struct bitsmap { // too close to bitmap? better name?
	uint w, h;
	bool[] data;

	this(AllegroFileBuffer f) {
		load(f);
	}

	void load(FileBuffer f) {
		// todo
	}

	void load(AllegroFileBuffer f) {
		bitmap b = f.get;
		for (int i = 0; i < b.w; i++)
			for (int j = 0; j < b.h; j++)
				set(i, j, (b.get(i, j).r > .1)); // set true/false based on R component                          
	}

	void set(uint _i, uint _j, bool value) {
		assert(_i < w && _j < h);
		data[_i + _j * w] = value;
	}

	bool get(uint _i, uint _j) {
		return data[_i + _j * w];
	}
}

class PixelMap {
	bitsmap collisionMap; // does this even need to be separate?
	int nLayers = 0; // do we even NEED multiple layers?
	// i mean if we're using it for visual layers in ADDITION to collision, then sure why not.

	this(string mapConfigFilePath) {
		loadConfig(mapConfigFilePath);
		enforce(nLayers > 0, "Map file did not contain any layers");
	}

	final void loadConfig(string filepath) {
		import std.file, std.conv; //import TOML;
		string s = to!string(read(filepath));

		/+        try{
        }catch(Exception e){
        enforce("map file ", filepath, " not found.");
        }
        enforce("Invalid map config file");+/
	}

	void loadLayer(string filepath) { // in case we have multiple layers?
		import std.file;

		collisionMap.load(AllegroFileBuffer(filepath));
	}

	bool isValidAt(uint _i, uint _j) {
		return collisionMap.get(_i, _j);
	}
}

class PixelMapCollider {
	PixelMap* _map;
	this(PixelMap* map) {
		_map = map;
	}
}

interface Component { // certain ones don't have an ondraw or ontick. Does that matter? Does either (all have, or we only add to specifics) matter?
	void onTick();
	bool onDraw(Viewport v);
} // if they don't want to respond to the event, who cares? Just don't define anything to happen.
// it's not like we have 5,000 optional events and only attaching to one.

class PhysicsCom : Component {
	pair pos;
	this() {
	}

	void onTick() {
	}

	bool onDraw(Viewport v) {
		return 0;
	}
}

class GraphicsCom : Component {
	PhysicsCom phy;
	bitmap[] bmps;
	bitmap bmp;

	this(PhysicsCom _phy) {
		phy = _phy;
	}

	void onTick() {
	}

	bool onDraw(Viewport v) {
		return 0;
	}

	int currentFrame;
	int nFrames;
	int nDirections;

	void frameNext() {
		currentFrame++;
		if (currentFrame == nFrames)
			currentFrame = 0;
	}

	void setDirection(DIR d) {
		assert(d < nDirections);
	}
}

void alDrawBitmap(bitmap b, pair pos, Viewport v) {
	// do stuff
}

class SpriteGraphicsCom : GraphicsCom {
	this(PhysicsCom _phy) {
		super(_phy);
	}

	override bool onDraw(Viewport v) {
		alDrawBitmap(bmp, phy.pos, v);
		return 0;
	}
}

class AnimatedGraphicsCom : GraphicsCom {
	this(PhysicsCom _phy) {
		super(_phy);
	}

	override bool onDraw(Viewport v) {
		alDrawBitmap(bmps[currentFrame], phy.pos, v);
		return 0;
	}
}

class AudioCom : Component {
	void onTick() {
	}

	bool onDraw(Viewport v) {
		return 0;
	}
}

class NetworkCom : Component {
	void onTick() {
	}

	bool onDraw(Viewport v) {
		return 0;
	}
}

class AICom : Component {
	void onTick() {
	}

	bool onDraw(Viewport v) {
		return 0;
	}
}

// these are one-off components, on the otherhand, they are independant for task-based composition
// ideally they'd be batches of units? Meh, it'll be fine.
// only particle engine would even remotely hit performance limitations.
class Unit {
	AICom ai;
	PhysicsCom physics;
	AudioCom audio;
	GraphicsCom gfx;
	NetworkCom net; // when/where to call ontick for this? Queue up messages? [respond] to nets, [run] code, [send] to net? One authoritave server though.

	this() {
	}

	void onTick() {
		ai.onTick(); // do we react after physics, or physics after we make decisions?
		physics.onTick();
		audio.onTick(); // can probably do this async/parallel with gfx
		//gfx.onTick(); // should do nothing, right?
	}

	bool onDraw(Viewport v) {
		return gfx.onDraw(v);
	}
}

enum DIR {
	UP = 0, // 1 = IDLE
	DOWN,
	LEFT,
	RIGHT, // 4
	UPLEFT,
	UPRIGHT,
	DOWNLEFT,
	DOWNRIGHT // 8
}

class PlayerControlledAI : AICom {
} // we can also easily replace this with a REPLAY for player actions!

class ReplayPlayerControlledAI : AICom {
}

class GroundPhysicsCom : PhysicsCom {
	this() {
	}
} // check floor layer, wall layer? + screen borders

class FloatingPhysicsCom : PhysicsCom {
	this() {
	}
} // basically just checks borders of screen / nogo zone for a screen.

class PlayerDude : Unit {
	this() {
		ai = new PlayerControlledAI();
		physics = new GroundPhysicsCom();
		gfx = new GraphicsCom(physics);
		audio = new AudioCom();
		net = new NetworkCom();
	}
	// don't have to override onTick or onDraw. Components are called the same. Customize the components.
}

void parseMapConfig(string filepath = "map.toml") {
	auto data = parseTOML(cast(string) read(filepath));
	writefln("file [%s]=[%s]", filepath, data);
	string name = data["general"]["name"].str;
	long numberScreens = data["general"]["screens"].integer;

	struct screen{
		int w,h;
		int nEntryZones; // warp zones to other screens
		}

	for(int i = 0; i < numberScreens; i++){
		auto d = data["screen%u".format(i)];
		writeln("\t", d);
		screen s = screen(cast(int)d["width"].integer, cast(int)d["height"].integer, cast(int)d["nEntryZones"].integer);
		writeln(s);
		}

	writefln("%s %s", name, numberScreens);
}

void parseEntityConfig(string filepath = "entity.toml") {
	auto data = parseTOML(cast(string) read(filepath));
	writefln("file [%s]=[%s]", filepath, data);

	long numberEntities = data["general"]["numberEntities"].integer;

	struct entity{
		string name;
		}

	for(int i = 0; i < numberEntities; i++){
		auto d = data["entity%u".format(i)];
		writeln("\t", d);
		entity e = entity(d["name"].str);
		writeln(e);
		}

	//writeln(data["objects"]);
	//		pragma(msg, typeof(tomldata["map"]["layer1"]));
	/+foreach (idx, o; tomldata["walker"]["layer1"].array) {
		writeln("----", o);
		for (int j = 0; j < 10; j++) {
			data[idx + 16][j + 16] = cast(int) o[j].integer;
		}
	}+/
}

int main() {
	PixelMap pm;
	PixelMapCollider pmc = new PixelMapCollider(&pm);

	parseMapConfig();
	parseEntityConfig();
	return 0;
}
