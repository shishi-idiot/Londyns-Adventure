package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	var map:FlxOgmo3Loader;
	var walls:FlxTilemap;
	var box:FlxSprite;

	override public function create()
	{
		FlxG.camera.fade(FlxColor.BLACK, 1, true);

		FlxG.sound.playMusic('assets/music/platformMusic.ogg');

		FlxG.camera.follow(box, TOPDOWN, 1);

		var bg:FlxSprite = new FlxSprite();
		bg.loadGraphic('assets/images/cavern/cavernBackground.png');
		add(bg);

		super.create();

		map = new FlxOgmo3Loader('assets/data/stageData/cavern.ogmo', 'assets/data/stageData/cavern.json');
		walls = map.loadTilemap(AssetPaths.tiles__png, "walls");
		walls.follow();
		walls.setTileProperties(1, FlxObject.ANY);
		walls.setTileProperties(2, FlxObject.NONE);
		add(walls);

		box = new FlxSprite(200, 200);
		box.loadGraphic('assets/images/londyn-sprites.png', true, 100, 100);
		box.animation.add('idle', [0, 1, 2, 3]);
		box.animation.play('idle');
		add(box);

		map.loadEntities(placeEntities, 'entities');
	}

	function placeEntities(entity:EntityData):Void
	{
		if (entity.name == "player")
		{
			box.setPosition(entity.x, entity.y);
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.collide(box, walls);

		if (FlxG.keys.justPressed.SPACE)
			box.velocity.y -= 500;

		if (FlxG.keys.pressed.RIGHT)
		{
			box.x += 1;
			box.flipX = false;
		}

		if (FlxG.keys.pressed.LEFT)
		{
			box.x -= 1;
			box.flipX = true;
		}
	}
}
