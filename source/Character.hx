package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.text.FlxText;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';

	public static var kills:Int = 0;

	public var holdTimer:Float = 0;

	public function new(x:Float, y:Float, ?character:String = "SUSSSYSYSYYSYSYSYSYYS", playername = "imposter :flushed:", imposter = false,
			?isPlayer:Bool = false)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;
		var tex:FlxAtlasFrames;
		antialiasing = true;
		var playernameText:FlxText = new FlxText(this.x, this.y);

		switch (curCharacter)
		{
			case 'white':
				playernameText.text = playername;
				playernameText.y -= 500;
				tex = Paths.getSparrowAtlas('crewmate');
				frames = tex;
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('walk', 'walk', 24, false);
				animation.addByPrefix('die', 'die', 24, false);
				playAnim('idle');
			case 'SUSSSYSYSYYSYSYSYSYYS':
				trace("wtf");
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
		else
			offset.set(0, 0);
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
