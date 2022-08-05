
import haxe.Log;

typedef DutchNumber = { dutchNum: String, numericalNum: String, wrongAnswer: String }

class NumberGenerator {
    final ones = ["nul", "een", "twee", "drie", "vier", "vijf", "zes", "zeven", "acht", "negen"];
    final teens = ["tien", "elf", "twaaelf", "dertien", "veertien", "vijftien", "zestien", "zeventien", "achttien", "negentien"];
    final tens = ["twintig", "dertig", "veertig", "vijftig", "zestig", "zeventig", "tachig", "negentig"];

    public function new() {}

    function _getTens(numberStr: String, numberInt: Int): DutchNumber {
        var dutchNum = "";
        var wrongAnswer = "";

        var numberArr = numberStr.split("");

        var tensIdx = if ([for (i in 100...1000) i].contains(numberInt)) 0; else 0;
        var number = Std.parseInt(numberArr[tensIdx] + "0");

        var tensIdx = Math.floor((number / 10) - 2);
        var tensPlace = tens[tensIdx];
        // Not sure if there's a better way to do this lmao
        var index = Std.parseInt(numberArr[numberArr.length - 1]);
        var onesPlace = ones[index];
        
        if (index == 0) {
            dutchNum = tensPlace;
            wrongAnswer = '${dutchNum} is ${numberStr}!';
        }
        else {
            var en = (if ([2, 3].contains(index)) "ën" else "en");
            dutchNum = onesPlace + en + tensPlace;
            wrongAnswer = '${dutchNum} is ${numberStr}!';
            wrongAnswer += '\nTo find out the tens place:';
            wrongAnswer += '\n${onesPlace} (${numberArr[numberArr.length - 1]}) + ${en} + ${tensPlace} (${tensIdx + 2}0)';
            wrongAnswer += '\nDirectly translated, it means "${numberArr[numberArr.length - 1]} and ${tensIdx + 2}0."';
            wrongAnswer += '\n"ën" is used instead of "en" when the ones place is twee or drie';
        }

        return {
            dutchNum: dutchNum,
            numericalNum: numberStr,
            wrongAnswer: wrongAnswer
        };
    }

    public function generate(max: Int): DutchNumber {
        var numberStr: String = "";
        numberStr += Math.round(Math.random() * max + 1) - 1;

        var wrongAnswer = "";
        var dutchNum = "";
        var numberInt = Std.parseInt(numberStr);

        if ([for (i in 0...10) i].contains(numberInt)) {
            dutchNum = ones[numberInt];
            wrongAnswer = '${numberStr} is "${dutchNum}."';
        }
        else if ([for (i in 10...20) i].contains(numberInt)) {
            dutchNum = teens[numberInt - 10];
            wrongAnswer = '${numberStr} is "${dutchNum}."';
        }
        else if ([for (i in 20...100) i].contains(numberInt)) {
            return _getTens(numberStr, numberInt);
        }
        else if ([for (i in 100...1000) i].contains(numberInt)) {
            var numberArr = numberStr.split("");
            var tens: DutchNumber;

            if (numberArr[numberArr.length - 2] != "0") {
                var tensPlace = numberArr[numberArr.length - 2] + numberArr[numberArr.length - 1];
                tens = _getTens(tensPlace, numberInt);
            }
            else {
                var dutchNum = ones[Std.parseInt(numberArr[numberArr.length - 1])];
                tens = {
                    dutchNum: dutchNum,
                    numericalNum: numberStr,
                    wrongAnswer: '${dutchNum} is ${numberArr[numberArr.length - 1]}!'
                };
            }
            
            var hundredsPlace = ones[Std.parseInt(numberArr[0])];
            if (hundredsPlace == "een") hundredsPlace = "";
            if (hundredsPlace == "veer") hundredsPlace = "vier";

            dutchNum = hundredsPlace + 'honderd ' + tens.dutchNum;

            wrongAnswer = tens.wrongAnswer;
            wrongAnswer += '\nTo find out the hundreds place:';
            if (hundredsPlace != "") {
                wrongAnswer += '\n${hundredsPlace} (${numberArr[0]}) + honderd (100)';
            }
            else {
                wrongAnswer += '\nhonderd (100), when it\'s just 100, you omit the "een", so it\'s "honderd," not "eenhonderd".';
            }

            wrongAnswer += '\nAll together, that\'s "${dutchNum}"';
        }

        return {
            dutchNum: dutchNum,
            numericalNum: numberStr,
            wrongAnswer: wrongAnswer
        };
    }
}

class Main {
    public static function main() {
        var generator = new NumberGenerator();
        
        Log.trace("Do you want to translate digits to dutch (1), or dutch to digits? (2)", null);
        var translateDigits = Sys.stdin().readLine() == "1";
        Log.trace("What do you want the max number to be? (10-999)", null);
        var max = Std.parseInt(Sys.stdin().readLine());
        max = Std.int(Math.min(999, Math.max(10, max)));

        while (true) {
            var number = generator.generate(max);
            if (translateDigits) {
                Log.trace('\nTranslate ${number.numericalNum}.', null);
            
                var input = Sys.stdin().readLine();

                if (input != number.dutchNum) {
                    Log.trace('\nWrong!\n${number.wrongAnswer}', null);
                }
                else {
                    Log.trace('\n${input} is correct!', null);
                }
            }
            else {
                Log.trace('\nTranslate "${number.dutchNum}".', null);
            
                var input = Sys.stdin().readLine();

                if (input != number.numericalNum) {
                    Log.trace('\nWrong!\n${number.wrongAnswer}', null);
                }
                else {
                    Log.trace('\n${input} is correct!', null);
                }
            }
        }
    }
}