package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxStringUtil;
import admob.AD;
import flixel.ui.FlxButton;
#if mobile
import fr.hyperfiction.hypertouch.HyperTouch;

import fr.hyperfiction.hypertouch.events.GestureTapEvent;
import fr.hyperfiction.hypertouch.events.TransformGestureEvent;
import fr.hyperfiction.hypertouch.events.GestureLongPressEvent;

//fb
//import fr.hyperfiction.HypFacebook;
//import fr.hyperfiction.*;
//end fb
//tw
/*import fr.hyperfiction.twitter.HypTwitter;
import fr.hyperfiction.twitter.*;
import fr.hyperfiction.oauth.*;
import fr.hyperfiction.oauth.OAuth;
import fr.hyperfiction.utils.*;
import fr.hyperfiction.twitter.TwitterConnectProtocol;
*/
//end tw
//cb
import extension.haxeChartboost.HaxeChartboost;
//end cb
//iap
import extension.iap.IAP;
import extension.iap.IAPEvent;
import flash.events.Event;
import flash.events.MouseEvent;
import haxe.xml.Fast;
//end iap
//gc
import extension.gamecenter.GameCenter;
import extension.gamecenter.GameCenterEvent;

//gc
#end

/**
 * ...
 * @author David Bell
 */
class MenuState extends FlxState 
{
	// How many menu options there are.
	public static inline var OPTIONS:Int = 3;
	public static inline var TEXT_SPEED:Float = 600;
	
	// Augh, so many text objects. I should make arrays.
	private var _text1:FlxText;
	private var _text2:FlxText;
	private var _text3:FlxText;
	private var _text4:FlxText;
	private var _text5:FlxText;  
	
	private var _pointer:FlxSprite;
	
	// This will indicate what the pointer is pointing at
	private var _option:Int;     
	#if mobile
	public function FSwipeTrace(e : TransformGestureEvent = null):Void {
		AD.hide();
	}
	#end
	//fb
    /* private var buton1fb:FlxButton;
	
	private var fbpermissionarray:Array<String>;//=["publish_actions"];
	private var fbpermissionarrayread:Array<String>;//=["publish_actions"];
	
	private  var fb  : HypFacebook;*/
		//end fb
		//tw
	/*	private var _onError			: String->Void;
	private var _onAskPin			: Void->Void;
	private var _onConnect			: Void->Void;
	
	private var buton1tw:FlxButton;
private var t:HypTwitter;*/
		//end tw

		//cb
private var buton1cb:FlxButton;
private var buton2cb:FlxButton;
		//end cb
		//iap
		private var buton1iap:FlxButton;
		//endiap
		//gc
private var buton1gc:FlxButton;
private var buton2gc:FlxButton;
		//gc
	override public function create():Void 
	{
		//fb
       /* fbpermissionarray = ["publish_actions"];
		fbpermissionarrayread=["email"];
		buton1fb = new FlxButton(100, 100, "share", onbuton1fb);
		add(buton1fb);
		fb = new HypFacebook( "1420285291578270" );
		connectToFacebook( );*/
		//end fb

		//tw
		/*buton1tw = new FlxButton(100, 100, "Tweet", onbuton1tw);
	add(buton1tw);
t = new HypTwitter( );
        // t.consumerKey = "ZL3htKq4xiF3ffc0uT0zGhhci";//"vqECwljUP6AxWXRt1pLpTAJsE";    
        //  t.consumerSecret = "AI2EDaHzhHAO2UTxfE5rXqBQikjJUSbPlHFjZ8arft7ryNJ4tn";//"cCHPUn4yGNsaPO2KW2cq7Tn906K7Kp0fsdUgAEFAFnUZlSEqOr";
		//first app in jos
		   t.consumerKey ="vqECwljUP6AxWXRt1pLpTAJsE";    
          t.consumerSecret = "cCHPUn4yGNsaPO2KW2cq7Tn906K7Kp0fsdUgAEFAFnUZlSEqOr";
		  var connector = t.connect( _onConnect , _onError , _onAskPin );
*/
		//end tw

		//cb
		HaxeChartboost.init("4f7b433509b6025804000002", "dd2d41b69ac01b80f443f5b6cf06096d457f82bd");
buton1cb = new FlxButton(100, 100, "cb", onbuton1cb);
	add(buton1cb);
	buton2cb = new FlxButton(200, 200, "more apps", onbuton2cb);
	add(buton2cb);
		//end cb

		//iap
initializeIAP();
buton1iap = new FlxButton(200, 100, "purchase", onbuton1iap);
	add(buton1iap);
		//endiap

		//gc
buton1gc = new FlxButton(300, 100, " GameCenter sign in", onbuton1gc);
	add(buton1gc);
	buton2gc = new FlxButton(300, 200, "submit score", onbuton2gc);
	add(buton2gc);
	initializeGC();
		//endgc
		#if mobile
		FlxG.stage.addEventListener( TransformGestureEvent.GESTURE_SWIPE , FSwipeTrace);
		#end
		
		FlxG.mouse.visible = false;
		FlxG.state.bgColor = 0xFF101414;
		
		// Each word is its own object so we can position them independantly
		_text1 = new FlxText( -220, FlxG.height / 4, 320, "Project");
		_text1.moves = true;
		_text1.size = 40;
		_text1.color = 0xFFFF00;
		_text1.antialiasing = true;
		_text1.velocity.x = TEXT_SPEED;
		add(_text1);
		
		// Base everything off of text1, so if we change color or size, only have to change one
		_text2 = new FlxText(FlxG.width - 50, FlxG.height / 2.5, 320, "Jumper");
		_text2.moves = true;
		_text2.size = _text1.size;
		_text2.color = _text1.color;
		_text2.antialiasing = _text1.antialiasing;
		_text2.velocity.x = - TEXT_SPEED;
		add(_text2);
		
		// Set up the menu options
		_text3 = new FlxText(FlxG.width * 2 / 3, FlxG.height * 2 / 3, 150, "Play");
		_text4 = new FlxText(FlxG.width * 2 / 3, FlxG.height * 2 / 3 + 30, 150, "Visit NIWID");
		_text5 = new FlxText(FlxG.width * 2 / 3, FlxG.height * 2 / 3 + 60, 150, "Visit flixel.org");
		_text3.color = _text4.color = _text5.color = 0xAAFFFF00;
		_text3.size = _text4.size = _text5.size = 16;
		_text3.antialiasing = _text4.antialiasing = _text5.antialiasing = true;
		add(_text3);
		add(_text4);
		add(_text5);
		
		_pointer = new FlxSprite();
		_pointer.loadGraphic("assets/art/pointer.png");
		_pointer.x = _text3.x - _pointer.width - 10;
		add(_pointer);
		_option = 0;
		AD.init("a15356b2d877c2a", AD.LEFT, AD.TOP, AD.BANNER_PORTRAIT,false);
		AD.show();
		super.create();
	}

	
	override public function update():Void 
	{
		if (FlxG.mouse.wheel != 0)
		{
			FlxG.camera.zoom += (FlxG.mouse.wheel / 10);
		}
		
		// Stop the texts when they reach their designated position
		if (_text1.x > FlxG.width / 5)	
		{
			_text1.velocity.x = 0;
		}
		
		if (_text2.x < FlxG.width / 2.5) 
		{
			_text2.velocity.x = 0;
		}
		
		// this is the goofus way to do it. An array would be way better
		switch(_option)    
		{
			case 0:
				_pointer.y = _text3.y;
			case 1:
				_pointer.y = _text4.y;
			case 2:
				_pointer.y = _text5.y;
		}
		
		if (FlxG.keys.justPressed.UP)
		{
			// A goofy format, because % doesn't work on negative numbers
			_option = (_option + OPTIONS - 1) % OPTIONS; 
			FlxG.sound.play("assets/sounds/menu" + Reg.SoundExtension, 1, false);
		}
		
		if (FlxG.keys.justPressed.DOWN)
		{
			_option = (_option + OPTIONS + 1) % OPTIONS;
			FlxG.sound.play("assets/sounds/menu" + Reg.SoundExtension, 1, false);
		}
		
		if (FlxG.keys.anyJustPressed(["SPACE", "ENTER", "C"]))
		{
			switch (_option) 
			{
				case 0:
					FlxG.cameras.fade(0xff969867, 1, false, startGame);
					FlxG.sound.play("assets/sounds/coin" + Reg.SoundExtension, 1, false);
				case 1:
					FlxG.openURL("http://chipacabra.blogspot.com");
				case 2:
					FlxG.openURL("http://flixel.org");
			}
		}
		
		super.update();
	}
	//fb
/*private function onbuton1fb():Void {
		//fb.call( DIALOG( "share" ) );
		 var h = new Map( );
        //h.set( "message" , "Test Request");
        //h.set( "to" , "<fb user id>");
       // fb.call( REQUEST_DIALOG( h ) );
	   
	 //  var h = new Hash<String>( );
        h.set("name","Facebook extension for NME");
        h.set("caption","Build great social apps and get more installs with Haxe/NME.");
        h.set("description","The Facebook extension for NME makes it easier and faster to develop Facebook integrated apps build with Haxe");
        h.set("link","http://www.nme.io");
        h.set("picture","https://raw.github.com/fbsamples/ios-3.x-howtos/master/Images/iossdk_logo.png");
        fb.call( FEED_DIALOG( h ) );
		
		
		//function graphApi( ) : Void {
       // var h = new Hash<String>( );
        //h.set( "score", "42" );
        //fb.call( GRAPH_REQUEST("/<fb user id>/scores", h ,POST) );
   // }
		
	}
	
	    function connectToFacebook( ) : Void {
           // fb = new HypFacebook( "1420285291578270" );
            var session_is_valid = fb.connect( false ); // false to disallow login UI
	//}
	

            if( session_is_valid ) {
                _doFacebookStuff( );
            } else {
                fb.addEventListener( HypFacebookEvent.OPENED, _onFbOpened );
                fb.connect( true ); // true to allow login UI
				
            }
        }

    function _onFbOpened( _ ) {
            fb.removeEventListener( HypFacebookEvent.OPENED, _onFbOpened );
            _doFacebookStuff( );
        }

    function _doFacebookStuff( ) {
            fb.addEventListener( HypFacebookRequestEvent.GRAPH_REQUEST_RESULTS, _onGraphResults );
            fb.call( GRAPH_REQUEST("/me") );
			trace("facebook, ajunge aici");
			  fb.requestNew_publish_permissions( ["publish_actions"] );
			  fb.call( GRAPH_REQUEST("/me") );
        }
        function _onGraphResults( event : HypFacebookRequestEvent ) : Void {
        trace( 'sResult:'+event.sResult );//here you find your user id specific to app
    }
*/
	//end fb
	//tw
/*private function onbuton1tw():Void {
		t.call( REQUEST(
                        POST ,
                        HypTwitter.TWEET_UPDATE ,
                        null,
						new Params( "status",Std.string( Math.random()) )
                    )
            );
	}*/
	//end tw
	//cb
private function onbuton1cb():Void{
	HaxeChartboost.OpenIntersetial(); 
}
private function onbuton2cb():Void{
	HaxeChartboost.Moregames();
}
	//end cb
//GC
private function onbuton1gc():Void{
	//show gamecenter
	GameCenter.authenticate();
}
private function onbuton2gc():Void{
	//submit score
	GameCenter.reportScore("1",100);
	GameCenter.showLeaderboard("1");
}
private function initializeGC():Void{
GameCenter.addEventListener(GameCenterEvent.AUTH_SUCCESS,onauthsuccess);
GameCenter.addEventListener(GameCenterEvent.AUTH_FAILURE,onauthfailure);
GameCenter.addEventListener(GameCenterEvent.SCORE_SUCCESS,onscoresuccess);
GameCenter.addEventListener(GameCenterEvent.SCORE_FAILURE,onscorefailure);
GameCenter.addEventListener(GameCenterEvent.ACHIEVEMENT_SUCCESS,onachievementsuccess);
GameCenter.addEventListener(GameCenterEvent.ACHIEVEMENT_FAILURE,onachievementfailure);
}

private function onauthsuccess(e:GameCenterEvent):Void
{}
private function onauthfailure(e:GameCenterEvent):Void
{}
private function onscoresuccess(e:GameCenterEvent):Void
{}
private function onscorefailure(e:GameCenterEvent):Void
{}
private function onachievementsuccess(e:GameCenterEvent):Void
{}
private function onachievementfailure(e:GameCenterEvent):Void
{}
//end GC
	//IAP.
	
	public function onbuton1iap():Void
	{
		IAP.purchase("com.paala.10gems");
	}
	function initializeIAP() 
	{
		// Google License key: 
		//TODO: Put in config or anywhere
		#if android
		//var licenseKey:String = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAv2pAdZ0dPy0sr/75E7U4oSYzDLZ7/Vn8YcfR6SN7R60Ew6chHTzRDWxr2XKjgjs3DixwFgcd5YAEv4zWcQfZSSwrOdjycF/5TUAbbfESWAZgB9UDz0NLl5KXaf+HitTlyshAGq7zpsGA52nsu0B/5JF7Sau27Ul1tzTYBWqiOaOEzjfJJppYxbjjTde/wmsEJ2SjqvoSX0zVM3lxpGGNXkvsPBdK8uT8/WU9w5iD2gW0PNsVbPYP2ceF5Q+mPkCef5XNS+nj5nkFHO3oA2Da4Ep4UELg2iQ7uHN0vFcTTJ3KLovZHWLS6ID72OwzfLtpEO/rzT6nKslDfiWz8oU9jwIDAQAB";
		//pt com.paala.testhaxe
		//var licenseKey:String="MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAw032vC+gDjKOKQEN1EQwrNCngWFWvQvIP/5RL8e3VBi+nvQ8NOW45Gv5gN/MUqTvqDZ5PywCsWMQibd46H8dHFi9uQDo1CtBnfkfqq6lYi4i1LMu6EDFWs7ksGJTMV/H6tq03H4ENJBXPMgjD7S4kM9SsybEEE7nzQe10QEAFDQmKKjnHF30pufCKcK0oKN2egdzb3P+pvBpRzw7OpIVV+oUcmaxytca1TsH7GWy9lm7KXRInuczyAXTxkoxVbuQto55Ef0j6Yh7FMgjrXU9uFpVu4JzoWPUN4ZobYx++P60SeuQhVTF8xIX0Csu9laK7o7wMfhb90dkoW7LDptPdwIDAQAB";
		var licenseKey:String="MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvaljj3iz4xVUYjeIJ9eWoXkgmyPitp4lsaytK9HD9DIkE+jkirpEAeI/BZD6YKAuUpy5B/DHs1Tx8lm4xfklaNuHPZ2YAC8RzkoWujcT1S4bt6WccT5imH8xlql//YLyW9MRSYtSSqfFVeygxEC9iHbm0+vWAOgVK0nHc/B9vYfijyStTY7o2XyJ03u9G7v40DPU/znVYh07+G96n9BGMWtyiULbqxSfjwPNbwrrpdWZ/VHY0SjBr/lNBov1YXzxCU5mMsPqcrUMPi8YF80nyT9ApU2p5IqnZ5SrNRV9DBg/Watm8rBtipVs/kbxLRYahIVlgo52YuwR4lfR2FKzewIDAQAB";
		
		#else
		var licenseKey:String = "";
		#end
		
		IAP.addEventListener(IAPEvent.PURCHASE_INIT, onPurchaseInit);
		IAP.addEventListener(IAPEvent.PURCHASE_INIT_FAILED, onPurchaseInitFailed);
		
		IAP.addEventListener(IAPEvent.PURCHASE_SUCCESS, onPurchaseSuccess);
		IAP.addEventListener(IAPEvent.PURCHASE_FAILURE, onPurchaseFail);
		IAP.addEventListener(IAPEvent.PURCHASE_CANCEL, onPurchaseCancel);
		
		IAP.addEventListener(IAPEvent.PURCHASE_CONSUME_SUCCESS, onConsumeSuccess);
		IAP.addEventListener(IAPEvent.PURCHASE_CONSUME_FAILURE, onConsumeFail);
		
		IAP.addEventListener(IAPEvent.PRODUCTS_RESTORED, onPurchasesRestored);
		IAP.addEventListener(IAPEvent.PRODUCTS_RESTORED_WITH_ERRORS, onPurchasesRestoredWithErrors);
		IAP.addEventListener(IAPEvent.PURCHASE_PRODUCT_DATA_COMPLETE, onStoreDataArrived);
		IAP.addEventListener(IAPEvent.DOWNLOAD_START, onProductDownloadStart);
		IAP.addEventListener(IAPEvent.DOWNLOAD_COMPLETE, onProductDownloadComplete);
		IAP.addEventListener(IAPEvent.DOWNLOAD_PROGRESS, onProductDownloadProgress);
		
		IAP.addEventListener(IAPEvent.PURCHASE_QUERY_INVENTORY_COMPLETE, onQueryInventoryComplete);
		IAP.addEventListener(IAPEvent.PURCHASE_QUERY_INVENTORY_FAILED, onQueryInventoryFailed);
		
		
		IAP.initialize(licenseKey);
		
		trace("IAP: Available: " + IAP.available);
	}
	
	private function onPurchaseInit(e:IAPEvent):Void 
	{
		trace(e.type);
		getStoreDataFromIAP();
	}
	
	private function onPurchaseInitFailed(e:Event):Void 
	{
		trace(e.type);
		getStoreDataFromModel();
	}
	
	private function onProductDownloadStart(e:IAPEvent):Void 
	{
		trace(e.type + " - " + e.productID + " - TR: " + e.transactionID); 
	}
	
	private function onProductDownloadComplete(e:IAPEvent):Void 
	{
		trace(e.type + " - " + e.productID + " - TR: " + e.transactionID); 
		trace("Path: " + e.downloadPath);
		trace("Version: " + e.downloadVersion);
	}
	
	private function onProductDownloadProgress(e:IAPEvent):Void 
	{
		trace(e.type + " - " + e.productID + " - TR: " + e.transactionID); 
		trace("Path: " + e.downloadPath);
		trace("Version: " + e.downloadVersion);
		trace("Progress: " + e.downloadProgress);
	}
	
	private function onStoreDataArrived(e:IAPEvent):Void 
	{
		trace("onStoreDataArrived");
		
		
		if (IAP.inventory != null) {
			trace("IAP.inventory: " + IAP.inventory);
			trace("IAP.inventory.productDetailsMap: " + IAP.inventory.productDetailsMap);
			trace("IAP.inventory.purchaseMap: " + IAP.inventory.purchaseMap);
		}
		
		//setStoreData(e.productsData);
	}
	
	private function onQueryInventoryComplete(e:IAPEvent):Void 
	{
		trace(e.type);
		trace("Products Data: ");
		var pr:IAProduct;
		
		if (e.productsData != null) {
			trace("All products at once: " + e.productsData.length);
			for (i in 0...e.productsData.length) {
				pr = e.productsData[i];
				trace("productID: " + pr.productID);
				trace("localizedTitle: " + pr.localizedTitle);
				trace("localizedDescription: " + pr.localizedDescription);
				trace("price: " + pr.price);
				trace("----");
			}
			
			trace(".");
		}
		
		trace(".");
		
		if (IAP.inventory != null) {
			trace("IAP.inventory: " + IAP.inventory);
			trace("IAP.inventory.productDetailsMap: " + IAP.inventory.productDetailsMap);
			trace("IAP.inventory.purchaseMap: " + IAP.inventory.purchaseMap);
			
			if (IAP.inventory.purchaseMap.exists("android.test.purchased")) {
				IAP.consume(IAP.inventory.purchaseMap.get("android.test.purchased"));
			}
		}
		
		if (e.productsData.length > 0) {
			//setStoreData(e.productsData);
		} else {
			trace("No productsData, calling model");
			//getStoreDataFromModel();
			
		}
		
	}
	
	/*private function setStoreData(productsData:Array<IAProduct>):Void {
		
		//var model:GameModel = GameModel.getInstance();
		var order:Array<String> = model.data.node.storeItems.att.order.split(",");
		
		
		var map:Map<String, StoreItemData> = new Map<String, StoreItemData>();

		var storeElems:Xml = model.data.node.storeItems.x;
		
		var fastEl:Fast;
		var xmlEl:Xml;
		for (elt in productsData) {
			xmlEl = model.getXmlEl(storeElems, elt.productID);
			
			if (xmlEl != null) {
				fastEl = new Fast(xmlEl);
				map.set(elt.productID, {id:elt.productID, thumb:ScreenUtils.getBitmapData(fastEl.att.thumb), description:elt.localizedTitle + " " + elt.price, reward:(fastEl.has.reward)? Std.parseInt(fastEl.att.reward) : null} );
			}
			
		}
		
		this.data = map;
		var itmPill:StoreItemPill;
		var datum:StoreItemData;
		for (i in 0...order.length) {
			datum = data.get(order[i]);
			
			itmPill = new StoreItemPill(datum.id, datum.thumb, datum.description);
			itemsHolder.addChild(itmPill);
			
			itmPill.x = i * (ScreenUtils.scaleFloat(5) + itmPill.width);
			itemsHolder.addChild(itmPill);
			
			itmPill.addEventListener(MouseEvent.CLICK, onItemSelected);
		}
		
	}*/
	
	private function onQueryInventoryFailed(e:IAPEvent):Void
	{
		trace(e.type);
		getStoreDataFromModel();
	}
	
	private function onPurchaseSuccess(e:IAPEvent):Void 
	{
		trace(e.type + " - productID: " + e.productID);
		_text1.text="Purchase succes";
		/*if (data.exists(e.productID)) {
			var prod:StoreItemData = data.get(e.productID);
			// If the item has a reward it means that it's consumable
			if (prod.reward != null) {
				
				#if android
				//test
				
				//trace("sending test consume for " + e.purchase + " - payload: " + e.purchase.developerPayload);
				IAP.consume(e.purchase);
				
				#else
				
				onConsumeSuccess(e);
				
				#end
				
			}
			
		}*/
		
	}
	
	private function onPurchaseFail(e:IAPEvent):Void 
	{
		trace(e.type + " - productID: " + e.productID + " - message: " + e.message);
	}
	
	private function onPurchaseCancel(e:IAPEvent):Void 
	{
		trace(e.type + " - productID: " + e.productID);
	}
	
	private function onConsumeSuccess(e:IAPEvent):Void 
	{
		trace(IAPEvent.PURCHASE_CONSUME_SUCCESS + " - productID: " + e.productID);
		
		/*if (data.exists(e.productID)) {
			var prod:StoreItemData = data.get(e.productID);
			// If the item has a reward it means that it's consumable
			if (prod.reward != null) {
				//GameUserData.getInstance().gold += prod.reward;
				
				// Locally erase the product from the inventory
				IAP.inventory.erasePurchase(e.productID);
			}
		}*/
		
	}
	
	private function onConsumeFail(e:IAPEvent):Void 
	{
		trace(e.type + " - productID: " + e.productID + " - message: " + e.message);
	}
	
	private function onPurchasesRestored(e:IAPEvent):Void 
	{
		trace(e.type);
	}
	
	private function onPurchasesRestoredWithErrors(e:IAPEvent):Void 
	{
		trace(e.type);
	}
	
	private function getStoreDataFromIAP() :Void {
		trace("getStoreDataFromIAP");
		
		/*var orderArr:Array<String> = GameModel.getInstance().data.node.storeItems.att.order.split(",");
		#if ios
		IAP.requestProductData (orderArr);
		#elseif android
		IAP.queryInventory (true, orderArr);
		#end*/
	}
	
	private function getStoreDataFromModel():Void {
		trace("getStoreDataFromModel");
		
		/*var productsArray:Array<IAProduct> = [];
		
		var model:GameModel = GameModel.getInstance();
		
		var fastEl:Fast;
		
		for (fastEl in model.data.node.storeItems.elements) {
			
			productsArray.push( { productID: fastEl.att.id, localizedTitle: fastEl.att.title, price: fastEl.att.price } );
			
		}
		
		setStoreData(productsArray);*/
		
	}
	
	function testPurchase_NoIAP(productID:String) 
	{
		trace("PURCHASE WITHOUT IAP - productID: " + productID);
		//var prod:StoreItemData = data.get(productID);
		//if (prod.reward != null) //GameUserData.getInstance().gold += prod.reward;
	}
	//end IAP
	private function startGame():Void
	{
		FlxG.switchState(new PlayState());
	}
}