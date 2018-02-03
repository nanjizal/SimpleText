package;
import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.Color;
import kha.Assets;
import kha.Image;
import kha.input.Keyboard;
import kha.input.KeyCode;
import kha.input.Mouse;
import kha.input.KeyCode;
import simpleText.SimpleText;
class Ksimple {
	public var txt:         SimpleText;
    public var txtAlign:    SimpleText;
    public var txtSize:     SimpleText;
    public var txtAdvanceX: SimpleText;
    public var txtAdvanceY: SimpleText;
    public var txtSelector: SimpleText;
    public var txtAccuracy: SimpleText;
    public var txtWrapWidth: SimpleText;
    public var allTxt: Array<SimpleText> = [];
    public var x: Int = -1;
    public var y: Int = -1;
    public var change:      Int->Int->Void;
    public var down:        Int->Int->Void;
    public var up:          Int->Int->Void;
    public var rightDown:   Int->Int->Void;
    public var rightUp:     Int->Int->Void;
    public var enable:      Bool = true;
    public var content:     String = 
"My voice is a wall of glass
On the both side of the wall it's all the same

The roof is consisted of umbrella-shaped beams
The world is an embroidered web 
I'm a spider that don't spew silk
cling on to intertwining iron bars
Accidentally chocked my fly to death
Buried it in the oblivion sky

Fed on chitchat 
I'm now becoming a skinny,
wind up bird";

    public function onMouseDown( button: Int, x: Int, y: Int ): Void {
        if( !enable ) return;
        if( button == 0 && down      != null ) down( x, y );
        if (button == 1 && rightDown != null ) rightDown( x, y );
    }
    public function onMouseUp( button: Int, x: Int, y: Int ): Void {
        //trace('mouse button UP');
        if( !enable ) return;
        if (button == 0 && up != null ) up( x, y );
        if (button == 1 && rightUp != null ) rightUp( x, y );
    }
    public function onMouseMove( x: Int, y: Int, cx: Int, cy: Int ): Void {
        if( !enable ) return;
        if( x > 0 && y > 0 && change != null ) change( x, y );
    }
    var key: Int;
    function keyDown( keyCode: Int ):Void{
        key = keyCode;
        if( !enable ) return;
        switch( keyCode ){
            case 8:
                txt.content = txt.content.substr( 0,txt.content.length-2 );
                txt.dirty = true;
            case _:
                //
        }
    }
    function keyUp( keyCode: Int  ):Void{ 
        if( !enable ) return;
        trace( keyCode );
    }
    public function new() {
        Assets.loadEverything( loadAll );
    }
    function loadAll(){
        setup();
        System.notifyOnRender( render );
        Scheduler.addTimeTask( update, 0, 1 / 60 );
    }
    public function setup(){
        createMainText();
        createAlignText();
        createAdvanceX();
        createAdvanceY();
        createSelectionType();
        createSelectAccuracy();
        createWrapWidth();
        createTxtSize();
        Keyboard.get().notify( keyDown, keyUp, pressListener );
        Mouse.get().notify( onMouseDown, onMouseUp, onMouseMove, null, null );// wheelListener, leaveListener );
        change = checkTextHit;
        down = changeTextField;
        dirty();
    }
    function createMainText(){
        var fontStyle: AbstractFontStyle = {   font:       Assets.fonts.Arimo_Regular
                                    ,   size:       20
                                    ,   color:      Color.Blue
                                    ,   alpha:      0.8
                                    ,   range:      new AbstractRange( { begin: 0, end: content.length } )
                                    ,   dAdvanceX:  5.
                                    ,   dAdvanceY:  20.
                                    ,   hAlign:     RIGHT
                                    };
        txt =  new SimpleText({ x: 10., y: 10.
                            , fontStyle: fontStyle
                            , content: content
                            , wrapWidth: 400
                            , highLightColor: Color.White, highLightAlpha: 0.9
                            , bgHighLightColor: Color.Black, bgHighLightAlpha: 1.
                            , bgColor: Color.White
                            , highLight: true });
        allTxt.push( txt );
    }
    function createAdvanceX(){
        var fontStyle: AbstractFontStyle = {   font:       Assets.fonts.Arimo_Regular
                                    ,   size:       20
                                    ,   color:      Color.Blue
                                    ,   alpha:      0.8
                                    ,   range:      null
                                    ,   dAdvanceX:  5.
                                    ,   dAdvanceY:  20.
                                    ,   hAlign:     RIGHT
                                    };
        txtAdvanceX = new SimpleText({ x: 600., y: 200
                            , fontStyle: fontStyle
                            , content: 'dAdvanceX
 -1.5
 -1
 0
 1
 1.5
 2
 2.5
 3
 3.5
 4
 4.5
 5.
'
                            , wrapWidth: 300
                            , highLightColor: Color.White, highLightAlpha: 0.9
                            , bgHighLightColor: Color.Black, bgHighLightAlpha: 1.
                            , bgColor: Color.White
                            , highLight: true });
        allTxt.push( txtAdvanceX );
    }
    function createAdvanceY(){
        var fontStyle: AbstractFontStyle = {   font:       Assets.fonts.Arimo_Regular
                                    ,   size:       20
                                    ,   color:      Color.Blue
                                    ,   alpha:      0.8
                                    ,   range:      null
                                    ,   dAdvanceX:  5.
                                    ,   dAdvanceY:  20.
                                    ,   hAlign:     RIGHT
                                    };
        txtAdvanceY = new SimpleText({ x: 800., y: 200
                            , fontStyle: fontStyle
                            , content: 'dAdvanceY
 3
 5
 10
 12
 16
 20
 25
 30
'
                            , wrapWidth: 300
                            , highLightColor: Color.White, highLightAlpha: 0.9
                            , bgHighLightColor: Color.Black, bgHighLightAlpha: 1.
                            , bgColor: Color.White
                            , highLight: true });
        allTxt.push( txtAdvanceY );
    }
    function createAlignText(){
        var fontStyle: AbstractFontStyle = {   font:       Assets.fonts.Arimo_Regular
                                    ,   size:       20
                                    ,   color:      Color.Blue
                                    ,   alpha:      0.8
                                    ,   range:      new AbstractRange( { begin: 0, end: content.length } )
                                    ,   dAdvanceX:  5.
                                    ,   dAdvanceY:  20.
                                    ,   hAlign:     CENTRE
                                    };
        txtAlign = new SimpleText({ x: 550., y: 10.
                            , fontStyle: fontStyle
                            , content: ' LEFT CENTRE RIGHT JUSTIFY '
                            , wrapWidth: 600
                            , highLightColor: Color.White, highLightAlpha: 0.9
                            , bgHighLightColor: Color.Black, bgHighLightAlpha: 1.
                            , bgColor: Color.White
                            , highLight: true });
        allTxt.push( txtAlign );

    }
    function createSelectionType(){
        var fontStyle: AbstractFontStyle = {   font:       Assets.fonts.Arimo_Regular
                                    ,   size:       20
                                    ,   color:      Color.Blue
                                    ,   alpha:      0.8
                                    ,   range:      new AbstractRange( { begin: 0, end: content.length } )
                                    ,   dAdvanceX:  5.
                                    ,   dAdvanceY:  20.
                                    ,   hAlign:     CENTRE
                                    };
        txtSelector = new SimpleText({ x: 550., y: 50.
                            , fontStyle: fontStyle
                            , content: ' CHARACTER WORD LINE '
                            , wrapWidth: 600
                            , highLightColor: Color.White, highLightAlpha: 0.9
                            , bgHighLightColor: Color.Black, bgHighLightAlpha: 1.
                            , bgColor: Color.White
                            , highLight: true });
        allTxt.push( txtSelector );
    }
    function createSelectAccuracy(){
        var fontStyle: AbstractFontStyle = {   font:       Assets.fonts.Arimo_Regular
                                    ,   size:       20
                                    ,   color:      Color.Blue
                                    ,   alpha:      0.8
                                    ,   range:      new AbstractRange( { begin: 0, end: content.length } )
                                    ,   dAdvanceX:  5.
                                    ,   dAdvanceY:  20.
                                    ,   hAlign:     CENTRE
                                    };
        txtAccuracy = new SimpleText({ x: 550., y: 75.
                            , fontStyle: fontStyle
                            , content: ' WITHIN CLOSE '
                            , wrapWidth: 600
                            , highLightColor: Color.White, highLightAlpha: 0.9
                            , bgHighLightColor: Color.Black, bgHighLightAlpha: 1.
                            , bgColor: Color.White
                            , highLight: true });
        allTxt.push( txtAccuracy );
    }
    function createTxtSize(){
        var fontStyle: AbstractFontStyle = {   font:       Assets.fonts.Arimo_Regular
                                    ,   size:       20
                                    ,   color:      Color.Blue
                                    ,   alpha:      0.8
                                    ,   range:      new AbstractRange( { begin: 0, end: content.length } )
                                    ,   dAdvanceX:  5.
                                    ,   dAdvanceY:  2.
                                    ,   hAlign:     CENTRE
                                    };
        txtSize = new SimpleText({ x: 550., y: 150.
                            , fontStyle: fontStyle
                            , content: 'Size 8 10 12 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 35 '
                            , wrapWidth: 450
                            , highLightColor: Color.White, highLightAlpha: 0.9
                            , bgHighLightColor: Color.Black, bgHighLightAlpha: 1.
                            , bgColor: Color.White
                            , highLight: true });
        allTxt.push( txtSize );
    }
    function createWrapWidth(){
        var fontStyle: AbstractFontStyle = {   font:       Assets.fonts.Arimo_Regular
                                    ,   size:       20
                                    ,   color:      Color.Blue
                                    ,   alpha:      0.8
                                    ,   range:      new AbstractRange( { begin: 0, end: content.length } )
                                    ,   dAdvanceX:  5.
                                    ,   dAdvanceY:  20.
                                    ,   hAlign:     CENTRE
                                    };
        txtWrapWidth = new SimpleText({ x: 550., y: 120.
                            , fontStyle: fontStyle
                            , content: ' 250 300 350 400 450 500 520 '
                            , wrapWidth: 600
                            , highLightColor: Color.White, highLightAlpha: 0.9
                            , bgHighLightColor: Color.Black, bgHighLightAlpha: 1.
                            , bgColor: Color.White
                            , highLight: true });
        allTxt.push( txtWrapWidth );
    }
    function pressListener( str: String ){
        trace( 'pressed ' + str + key );
        txt.content += str;
        dirty();
    }
    function changeTextField( x: Int, y: Int ){
        var alignment = txtAlign.hitString( x, y, Selection.WORD, Hit.WITHIN, true );
        if( alignment != '' ) { 
            trace( 'alignment change to ' + alignment );
            switch( alignment ){
                case 'LEFT':
                    txt.fontStyle.hAlign = HAlign.LEFT;
                case 'RIGHT':
                    txt.fontStyle.hAlign = HAlign.RIGHT;
                case 'CENTRE':
                    txt.fontStyle.hAlign = HAlign.CENTRE;
                case 'JUSTIFY':
                    txt.fontStyle.hAlign = HAlign.JUSTIFY;
                case _:
                    //
            }
            dirty();
        }
        var selector = txtSelector.hitString( x, y, Selection.WORD, Hit.WITHIN, true );
        if( selector != '' ) { 
            trace( 'selection change to ' + alignment );
            switch( selector ){
                case 'CHARACTER':
                    selection = CHARACTER;
                case 'WORD':
                    selection = WORD;
                case 'LINE':
                    selection = LINE;
                case _:
                    //
            }
            dirty();
        }
        var accuracy = txtAccuracy.hitString( x, y, Selection.WORD, Hit.WITHIN, true );
        if( accuracy != '' ) { 
            trace( 'selection accuracy change to ' + alignment );
            switch( accuracy ){
                case 'WITHIN':
                    accurate = WITHIN;
                case 'CLOSE':
                    accurate = CLOSE;
                case _:
                    //
            }
            dirty();
        }
        var wrapWidth = txtWrapWidth.hitString( x, y, Selection.WORD, Hit.WITHIN, true );
        if( wrapWidth != '' ) { 
            var no = Std.parseFloat( wrapWidth );
            if( !Math.isNaN( no ) ){
                txt.wrapWidth = no;
                dirty();
            } else {
                txtAdvanceX.highLightRange = null;
            }
        }
        var fontSize = txtSize.hitString( x, y, Selection.WORD, Hit.WITHIN, true );
        if( fontSize != '' ) { 
            var no = Std.parseFloat( fontSize );
            if( !Math.isNaN( no ) ){
                txt.fontStyle.size = Std.int( no );
                dirty();
            } else {
                txtAdvanceX.highLightRange = null;
            }
        }

        var dadvancex = txtAdvanceX.hitString( x, y, Selection.LINE, Hit.WITHIN, true );
        if( dadvancex != '' ){
            var no = Std.parseFloat( dadvancex );
            if( !Math.isNaN( no ) ){
                txt.fontStyle.dAdvanceX = no;
                dirty();
            } else {
                txtAdvanceX.highLightRange = null;
            }
        }
        var dadvancey = txtAdvanceY.hitString( x, y, Selection.LINE, Hit.WITHIN, true );
        if( dadvancey != '' ){
            var no = Std.parseFloat( dadvancey );
            if( !Math.isNaN( no ) ){
                txt.fontStyle.dAdvanceY = no;
                dirty();
            } else {
                txtAdvanceY.highLightRange = null;
            }
        }
    }
    function dirty(){
        for( t in allTxt ) t.dirty = true;
    }
    var selection: Selection = LINE;
    var accurate: Hit = WITHIN;
    function checkTextHit( x: Int, y: Int ){
        var highlight = true;
        var hit       = accurate;
        var str = txt.hitString( x, y, selection, hit, highlight );
        if( str != '' ) { 
            trace( 'hit '+ selection + ' = '  + str );
            dirty();
        }
    }
    function update(): Void {
    }
    function render( framebuffer: Framebuffer ):Void {
        if( !txt.dirty ) return;
        var g2 = framebuffer.g2;
        g2.begin();
        g2.clear( Color.fromValue( 0xff000000 ) );
        g2.color = Color.White;
        g2.opacity = 1.;
        var count: Int = 0;
        for( t in allTxt ) {
            t.render( g2 );
        }
        g2.end();
    }
}