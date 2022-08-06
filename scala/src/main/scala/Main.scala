import scala.io.StdIn.readLine
import scala.util.Random

object Main {
  private val DIGITS = List("nul", "een", "twee", "drie", "vier", "vijf", "zes", "zeven", "acht", "negen")
  private val TEENS = List("tien", "elf", "twaaelf", "dertien", "veertien", "vijftien", "zestien", "zeventien", "achttien", "negentien")
  private val TENS = List("twintig", "dertig", "veertig", "vijftig", "zestig", "zeventig", "tachig", "negentig")

  def translate(x: Int): String = {
    if (x < 10) {
      DIGITS(x)
    } else if (x > 10 && x < 20) {
      TEENS(x - 10)
    } else {
      val tensIdx = Math.floor(x / 10 - 2).toInt
      val idx = Character.digit(x.toString.charAt(1), 10)
      val onesPlace = DIGITS(idx)

      if (idx == 0) TENS(tensIdx)
      else s"$onesPlace${if (List(2, 3).contains(idx)) "ën" else "en"}${TENS(tensIdx)}"
    }
  }

  def ask(q: String): String = {
    println(q)
    readLine()
  }

  def generate(mode: Int): Unit = {
    val random = Random.nextInt(100)
    val toWord = translate(random)
    val input = ask(if (mode == 1) s"What is $random in Dutch??????" else s"What is $toWord as number??????")

    if (if (mode == 1) toWord == input else random.toString == input)
      println("Congratulations!")
    else
      println("Seems like your inner dumbass answered this time...")
  }

  def main(args: Array[String]): Unit = {
    println("Hello! Do you want to translate digits to dutch (1), or dutch to digits? (2)")

    val mode = readLine()

    if (!List("1", "2").contains(mode))
      throw new Exception("Sussy Balls Amogus!!!! Why are you dumb! Only input is 1 and 2....")

    while (true) {
      generate(mode.toInt)
      println("---")
    }
  }
}