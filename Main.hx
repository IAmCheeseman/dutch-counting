import NumberGenerator.DutchNumber;
import haxe.Log;


class Main {
    public static function prompt(number: DutchNumber, translateDigits: Bool): String {
        Log.trace('\nTranslate ${if (translateDigits) number.numericalNum else number.dutchNum}.', null);
        return Sys.stdin().readLine();
    }

    public static function main(): Void {
        var generator = new NumberGenerator();
        
        Log.trace("Do you want to translate digits to dutch (1), or dutch to digits? (2)", null);
        var translateDigits = Sys.stdin().readLine() == "1";
        Log.trace("What do you want the max number to be? (10-999)", null);
        var max = Std.parseInt(Sys.stdin().readLine());
        max = Std.int(Math.min(999, Math.max(10, max)));

        while (true) {
            var number = generator.generate(max);
            var input = prompt(number, translateDigits);

            if (if (translateDigits) input != number.dutchNum else input != number.numericalNum) {
                Log.trace('\nWrong!\n${number.wrongAnswer}', null);
            }
            else {
                Log.trace('\n${input} is correct!', null);
            }
        }
    }
}