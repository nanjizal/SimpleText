package;
#if js
import js.Browser;
import js.html.CanvasElement;
#end
import kha.System;
import Ksimple;
class Main {
    public static function main() {
        System.init({title: "kSimple", width: 1024, height: 768, samplesPerPixel: 4}
            , function() {
                new Ksimple();
            });
    }
}