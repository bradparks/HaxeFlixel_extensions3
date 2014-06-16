package;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.Lib;
import flash.ui.Keyboard;
import flixel.FlxGame;
#if mobile
import fr.hyperfiction.playservices.PlayServices;
#end
/**
 * @author Joshua Granick
 */
class Main extends Sprite 
{
	// Entry point
	public static function main():Void
	{	
		Lib.current.addChild(new Main());
	}
	
	public function new() 
	{
		super();
		
		if (stage != null) 
		{
			init();
		}
		else 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}
	
	private function init(?E:Event):Void 
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		initialize();
		//PlayServices.initialize( );
		//	PlayServices.beginUserInitiated_sign_in( );
		var game:FlxGame = new GameClass();
		addChild(game);
	}
	
	private function initialize():Void 
	{
		
		Lib.current.stage.align = StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
	}
}