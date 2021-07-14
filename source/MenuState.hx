package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class MenuState extends FlxState
{
	override public function create():Void
	{
		trace('happy birthday');
		trace("BOOTED UP");

		FlxG.camera.fade(FlxColor.BLACK, 1, true);

		FlxG.sound.playMusic('assets/music/mainTheme.ogg');

		var title:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.titlescreen__png);
		title.setGraphicSize(0, FlxG.height);
		title.updateHitbox();
		title.antialiasing = true;
		add(title);

		persistentUpdate = false;

		super.create();
	}

	override public function update(e:Float):Void
	{
		var pressedAny:Bool = false;
		var gamepad = FlxG.gamepads.lastActive;
		if (gamepad != null)
			pressedAny = gamepad.justPressed.ANY;

		if (FlxG.keys.justPressed.ANY || pressedAny)
			FlxG.switchState(new PlayState());

		super.update(e);
	}
}
