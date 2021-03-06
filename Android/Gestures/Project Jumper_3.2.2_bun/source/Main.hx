﻿package;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;
import flixel.FlxGame;
import flixel.FlxG;
import flixel.FlxState;
#if mobile
import fr.hyperfiction.hypertouch.HyperTouch;

import fr.hyperfiction.hypertouch.events.GestureTapEvent;
import fr.hyperfiction.hypertouch.events.TransformGestureEvent;
import fr.hyperfiction.hypertouch.events.GestureLongPressEvent;
#end

class Main extends Sprite 
{
	var gameWidth:Int = 640; // Width of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var gameHeight:Int = 480; // Height of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var initialState:Class<FlxState> = PlayState; // The FlxState the game starts with.
	var zoom:Float = -1; // If -1, zoom is automatically calculated to fit the window dimensions.
	var framerate:Int = 60; // How many frames per second the game should run at.
	var skipSplash:Bool = false; // Whether to skip the flixel splash screen that appears in release mode.
	var startFullscreen:Bool = true; // Whether to start the game in fullscreen on desktop targets
	
	// You can pretty much ignore everything from here on - your code should go in your states.
	
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
		
		setupGame();
	}
	
	private function setupGame():Void
	{
		#if mobile
        var hyp = HyperTouch.getInstance();
        hyp.add( TAP( 1 , 1 ));//Single Tap
        hyp.add( TAP( 2 , 1 ));//Two Fingers Taps
        hyp.add( GESTURE_SWIPE );//Swipe Gesture
        hyp.add( LONGPRESS );//Swipe Gesture
		
        Lib.current.stage.addEventListener( GestureTapEvent.TAP , FTap );
       Lib.current.stage.addEventListener( GestureLongPressEvent.LONG_PRESS , FLongPress );
       //Lib.current.stage.addEventListener( TransformGestureEvent.GESTURE_SWIPE , FSwipeTrace);
		FlxG.stage.addEventListener( TransformGestureEvent.GESTURE_SWIPE , FSwipeTrace);
		
		
        #end
		
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (zoom == -1)
		{
			var ratioX:Float = stageWidth / gameWidth;
			var ratioY:Float = stageHeight / gameHeight;
			zoom = Math.min(ratioX, ratioY);
			gameWidth = Math.ceil(stageWidth / zoom);
			gameHeight = Math.ceil(stageHeight / zoom);
		}

		addChild(new FlxGame(gameWidth, gameHeight, initialState, zoom, framerate, framerate, skipSplash, startFullscreen));
	}
	#if mobile
    public function FSwipeTrace(e : TransformGestureEvent = null):Void
    {
		
        trace("Swipe!");
		//zoom = 2;
		//FlxG.log("Swipe");
		//FlxG.switchState(new MenuState());
		//FlxG.debugger.visible = false;
       // trace(e.direction);
		
    }
 
    private function FLongPress(e : GestureLongPressEvent = null):Void
    {
        trace("longPress");
    }
    private function FTap(e : GestureTapEvent = null):Void
    {
        trace("tap-pos: ["+e.stageX+","+e.stageY+"]");
    }
 
    #end
}