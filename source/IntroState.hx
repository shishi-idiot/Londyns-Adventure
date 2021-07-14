package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class IntroState extends FlxState
{
	// SLIDE 1
	private var slide1:FlxSprite;

	// SLIDE 2
	private var slide2:FlxSprite;

	// SLIDE 3
	private var slide3:FlxGroup;

	private var curScene:Int = 0;

	var canContinue:Bool = false;

	override public function create():Void
	{
		trace('CUTSCENE LOADED BABY');

		FlxG.camera.fade(FlxColor.BLACK, 1, true);

		FlxG.sound.playMusic("assets/music/storyMusic.ogg");
		FlxG.mouse.visible = false;

		// SLIDE 1
		slide1 = new FlxSprite().loadGraphic(AssetPaths.slide1__png);
		slide1.setGraphicSize(0, FlxG.height);
		slide1.updateHitbox();
		slide1.antialiasing = true;
		add(slide1);

		canContinue = true;
		super.create();
	}

	override public function update(e:Float):Void
	{
		var justSkip:Bool = false;
		var advScene:Bool = false;
		var gamepad = FlxG.gamepads.lastActive;
		if (gamepad != null)
		{
			advScene = gamepad.justPressed.ANY;
			justSkip = gamepad.justPressed.START;
		}

		if (FlxG.keys.justPressed.ENTER || justSkip)
			skip();

		if (canContinue)
		{
			if (FlxG.keys.justPressed.ANY || advScene)
				sceneManager();
		}

		super.update(e);
	}

	private function skip():Void
	{
		FlxG.sound.music.fadeOut(0.4, 0);
		FlxG.camera.fade(FlxColor.BLACK, 0.5, false, function()
		{
			FlxG.switchState(new MenuState());
		});
	}

	private function sceneManager():Void
	{
		switch curScene
		{
			case 0:
				canContinue = false;
				curScene = 0;

				FlxG.switchState(new MenuState());
		}
	}
}
