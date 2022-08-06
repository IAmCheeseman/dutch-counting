
typedef DutchNumber = { dutchNum: String, numericalNum: String, wrongAnswer: String }

class NumberGenerator {
    final ones = ["nul", "een", "twee", "drie", "vier", "vijf", "zes", "zeven", "acht", "negen"];
    final teens = ["tien", "elf", "twaaelf", "dertien", "veertien", "vijftien", "zestien", "zeventien", "achttien", "negentien"];
    final tens = ["twintig", "dertig", "veertig", "vijftig", "zestig", "zeventig", "tachig", "negentig"];

    public function new() {}

    function _getTens(numberStr: String, numberInt: Int): DutchNumber {
        var dutchNum = "";
        var wrongAnswer = "";

        var number = Std.parseInt(numberStr.charAt(0) + "0");

        var tensIdx = Math.floor((number / 10) - 2);
        var tensPlace = tens[tensIdx];
        var index = Std.parseInt(numberStr.charAt(numberStr.length - 1));
        var onesPlace = ones[index];
        var tensPlaceNum = tensIdx + 2;
        
        if (index == 0) {
            dutchNum = tensPlace;
            wrongAnswer = '${dutchNum} is ${numberStr}!';
        } else {
            var en = (if ([2, 3].contains(index)) "ën" else "en");
            dutchNum = onesPlace + en + tensPlace;
            wrongAnswer = '${dutchNum} is ${numberStr}!';
            wrongAnswer += '\nTo find out the tens place:';
            wrongAnswer += '\n${onesPlace} (${numberStr.charAt(numberStr.length)}) + ${en} + ${tensPlace} (${tensPlaceNum}0)';
            wrongAnswer += '\nDirectly translated, it means "${numberStr.charAt(numberStr.length - 1)} and ${tensPlaceNum}0."';
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
        } else if ([for (i in 10...20) i].contains(numberInt)) {
            dutchNum = teens[numberInt - 10];
            wrongAnswer = '${numberStr} is "${dutchNum}."';
        } else if ([for (i in 20...100) i].contains(numberInt)) {
            return _getTens(numberStr, numberInt);
        } else if ([for (i in 100...1000) i].contains(numberInt)) {
            var tens: DutchNumber;

            if (numberStr.charAt(numberStr.length - 2) != "0") {
                var tensPlace = numberStr.charAt(numberStr.length - 2) + numberStr.charAt(numberStr.length - 1);
                tens = _getTens(tensPlace, numberInt);
            } else {
                var dutchNum = ones[Std.parseInt(numberStr.charAt(numberStr.length - 1))];
                tens = {
                    dutchNum: dutchNum,
                    numericalNum: numberStr,
                    wrongAnswer: '${dutchNum} is ${numberStr.charAt(numberStr.length - 1)}!'
                };
            }
            
            var hundredsPlace = ones[Std.parseInt(numberStr.charAt(0))];
            hundredsPlace = if (hundredsPlace == "een") "" else hundredsPlace;

            dutchNum = hundredsPlace + 'honderd ' + tens.dutchNum;

            wrongAnswer = tens.wrongAnswer;
            wrongAnswer += '\nTo find out the hundreds place:';
            if (hundredsPlace != "") {
                wrongAnswer += '\n${hundredsPlace} (${numberStr.charAt(0)}) + honderd (100)';
            } else {
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