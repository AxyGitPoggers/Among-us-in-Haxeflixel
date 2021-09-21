package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.ui.FlxButton;

class MainMenuState extends FlxState
{
	var buttons:Array<String> = ['offline', 'quit'];

	// public var screencenter:FlxObject = new FlxObject();
	var screencenter:FlxPoint; // try using a FlxPoint for something like this instead? So that you don't inherit loads of stuff you don't need from FlxObject
	var camFollow:FlxObject;
	var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;

	override public function create()
	{
		// screencenter.screenCenter();
		screencenter = new FlxPoint(FlxG.width / 2, FlxG.height / 2); // sets the X and Y values to half the screen width and half the screen height

		super.create();
		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);
		FlxG.camera.follow(camFollow, null, 0.1);
		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);
		var tex = Paths.getSparrowAtlas('menu_assets');
		for (i in 0...buttons.length)
		{
			var menuItem:FlxSprite = new FlxSprite(0, 60 + (i * 160));
			menuItem.frames = tex;
			menuItem.animation.addByPrefix('idle', buttons[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', buttons[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItem.screenCenter(X);
			menuItems.add(menuItem);
			add(menuItems);
			menuItem.scrollFactor.set(0.8, 0.8);
			menuItem.antialiasing = true;
		}
		camFollow.setPosition(screencenter.x, screencenter.y);
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		// This causes a crash and your menu doesn't load, because you haven't assigned any music to FlxG.sound.music

		/*if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}*/

		if (!selectedSomethin)
		{
			if (FlxG.keys.justPressed.UP)
			{
				changeItem(-1);
			}

			if (FlxG.keys.justPressed.DOWN)
			{
				changeItem(1);
			}
			if (FlxG.keys.justPressed.ENTER)
			{
				// what is Character.hx? just looking
				FlxG.switchState(new TestPlayState());

				/* You don't need this! :)

				if (buttons[curSelected] == 'donate')
				{
					#if linux
					Sys.command('/usr/bin/xdg-open', ["https://ninja-muffin24.itch.io/funkin", "&"]);
					#else
					FlxG.openURL('https://ninja-muffin24.itch.io/funkin');
					#end
				}*/
			}
		}
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);
			}

			spr.updateHitbox();
		});
	}
}
