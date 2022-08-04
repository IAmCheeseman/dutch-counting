
typedef DutchNumber = { dutchNum: String, numericalNum: String, wrongAnswer: String }

class NumberGenerator {
    final digits = ["nul", "een", "twee", "drie", "vier", "vijf", "zes", "zeven", "acht", "negen"];
    final teens = ["tien", "elf", "twaaelf", "dertien", "veertien", "vijftien", "zestien", "zeventien", "achttien", "negentien"];
    final tens = ["twintig", "dertig", "veertig", "vijftig", "zestig", "zeventig", "tachig", "negentig"];

    public function new() {}

    public function generate(max: Int): DutchNumber {
        var number: String = "";
        number += Math.round(Math.random() * max);

        var wrongAnswer = "";
        
        var dutchNum = "";
        var numberInt = Std.parseInt(number);

        if ([for (i in 0...10) i].contains(numberInt)) {
            dutchNum = digits[numberInt];
        }
        else if ([for (i in 10...20) i].contains(numberInt)) {
            dutchNum = teens[numberInt - 10];
        }
        else if ([for (i in 20...100) i].contains(numberInt)) {
            var tensIdx = Math.floor((numberInt / 10) - 2);
            var tensPlace = tens[tensIdx];
            // Not sure if there's a better way to do this lmao
            var charCode = StringTools.fastCodeAt(number, 1);
            var index = Std.parseInt(String.fromCharCode(charCode));
            var onesPlace = digits[index];
            
            if (index == 0) {
                dutchNum = tensPlace;
                wrongAnswer = '${dutchNum} is ${number}!';
            }
            else {
                var en = (if ([2, 3].contains(index)) "ën" else "en");
                dutchNum = onesPlace + en + tensPlace;
                wrongAnswer = '${dutchNum} is ${number}!';
                wrongAnswer += '\n${onesPlace} (${String.fromCharCode(charCode)}) + ${en} + ${tensPlace} (${tensIdx + 2}x)';
                wrongAnswer += '\n"ën" is used instead of "en" when the ones place is twee or drie';
            }
        }

        return {
            dutchNum: dutchNum,
            numericalNum: number,
            wrongAnswer: wrongAnswer
        };
    }
}

class Main {
    public static function main() {
        var generator = new NumberGenerator();
        
        haxe.Log.trace("Do you want to translate digits to dutch (1), or dutch to digits? (2)", null);
        var translateDigits = Sys.stdin().readLine() == "1";

        while (true) {
            var number = generator.generate(100);
            if (translateDigits) {
                haxe.Log.trace('\nTranslate ${number.numericalNum}.', null);
            
                var input = Sys.stdin().readLine();

                if (input != number.dutchNum) {
                    haxe.Log.trace('\nWrong!\n${number.wrongAnswer}', null);
                }
                else {
                    haxe.Log.trace('\n${input} is correct!', null);
                }
            }
            else {
                haxe.Log.trace('\nTranslate "${number.dutchNum}".', null);
            
                var input = Sys.stdin().readLine();

                if (input != number.numericalNum) {
                    haxe.Log.trace('\nWrong!\n${number.wrongAnswer}', null);
                }
                else {
                    haxe.Log.trace('\n${input} is correct!', null);
                }
            }
        }
    }
}