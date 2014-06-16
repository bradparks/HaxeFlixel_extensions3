package fr.hyperfiction.hypertouch.events;

import fr.hyperfiction.hypertouch.HyperTouch;
import fr.hyperfiction.hypertouch.enums.GesturePhases;
import fr.hyperfiction.hypertouch.enums.GestureTypes;
import fr.hyperfiction.hypertouch.enums.SwipeDirections;
import flash.events.Event;

/**
 * ...
 * @author shoe[box]
 */

class TransformGestureEvent extends Event{

	public var gesture_type	: GestureTypes;
	public var offsetX		: Float;
	public var offsetY		: Float;
	public var rotation		: Float;
	public var scaleX		: Float;
	public var scaleY		: Float;
	public var velocityX	: Float;
	public var velocityY	: Float;
	#if android
	public var pressure : Float;
	#end

	public var phase : GesturePhases;
	public var direction : SwipeDirections;

	public static inline var GESTURE_PINCH	: String = 'GESTURE_PINCH';
	public static inline var GESTURE_PAN	: String = 'GESTURE_PAN';
	public static inline var GESTURE_ROTATE	: String = 'GESTURE_ROTATE';
	public static inline var GESTURE_SWIPE	: String = 'GESTURE_SWIPE';

	// -------o constructor

		/**
		* constructor
		*
		* @param
		* @return	void
		*/
		public function new(
								gesture_type : GestureTypes ,
								offsetX      : Float = 0.0 ,
								offsetY      : Float = 0.0 ,
								scaleX       : Float = 0.0 ,
								scaleY       : Float = 0.0 ,
								rotation     : Float = 0.0 ,
								velocityX    : Float = 0.0,
								velocityY    : Float = 0.0
							) {
			super( Std.string( gesture_type) );
			this.gesture_type = gesture_type;
			this.offsetX      = offsetX;
			this.offsetY      = offsetY;
			this.scaleX       = scaleX;
			this.scaleY       = scaleY;
			this.rotation     = rotation;
			this.velocityX    = velocityX;
			this.velocityY    = velocityY;
		}

	// -------o public

		/**
		*
		*
		* @public
		* @return	void
		*/
		override public function clone( ) : TransformGestureEvent {
			return new TransformGestureEvent( gesture_type , offsetX , offsetY , scaleX , scaleY , rotation , velocityX , velocityY );
		}

	// -------o protected

	// -------o misc

}