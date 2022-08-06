import org.scalatest.funsuite.AnyFunSuite

class MainTest extends AnyFunSuite {
  test("Translating 0-10") {
    assert(Main.translate(1) == "een")
  }

  test("Translating 10-20") {
    assert(Main.translate(11) == "elf")
  }

  test("Translating 20-100") {
    assert(Main.translate(21) == "eenentwintig")
  }
}
