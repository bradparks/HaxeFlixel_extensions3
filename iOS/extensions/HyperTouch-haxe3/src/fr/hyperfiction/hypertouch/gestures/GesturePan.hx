package fr.hyperfiction.hypertouch.gestures;

import fr.hyperfiction.hypertouch.enums.GesturePhases;
import fr.hyperfiction.hypertouch.HyperTouch;
import fr.hyperfiction.hypertouch.gestures.AGesture;
import fr.hyperfiction.hypertouch.events.TransformGestureEvent;


/**
 * ...
 * @author shoe[box]
 */
@:build( ShortCuts.mirrors( ) )
class GesturePan extends AGesture{

	// -------o constructor

		/**
		* constructor
		*
		* @param
		* @return	void
		*/
		public function new() {
			super( );
		}

	// -------o public



	// -------o protected

		/**
		*
		*
		* @private
		* @return	void
		*/
		override private function _activate( ) : Void{

			#if android
			_java_instance = getInstance( );
			#end

			#if cpp
			set_callback_pan( _onPan );
			#end

			#if ios
			HyperTouch.HyperTouch_activate( 3 , 1 );
			#end

		}

		/**
		*
		*
		* @private
		* @return	void
		*/
		private function _onPan( a : Array<Dynamic> ) : Void{
			var ev = new TransformGestureEvent( GESTURE_PAN , a[1] , a[2] , 1.0 , 1.0 , 1.0 );
				ev.phase = _translate_phase( a[ 0 ] );

			#if android
				ev.pressure = a[5];
			#end

			stage_emit( ev );

		}

	// -------o misc

	// -------o JNI

		#if android

		/**
		*
		*
		* @public
		* @return	void
		*/
		@JNI
		static public function getInstance( ) : GesturePan{

		}

		#end

	// -------o CPP

		#if cpp

		/**
		*
		*
		* @public
		* @return	void
		*/
		@CPP("hypertouch")
		public function set_callback_pan( f : Array<Dynamic>->Void ) : Void {

		}

		#end
}