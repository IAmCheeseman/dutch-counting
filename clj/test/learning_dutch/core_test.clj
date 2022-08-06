(ns learning-dutch.core-test
  (:require [clojure.test :refer :all]
            [learning-dutch.core :refer :all]))

(deftest a-test
  (testing "Simple Translation (1-10)"
    (is (= (translate 1) "een")))
  (testing "Translation (10-20"
    (is (= (translate 11) "elf")))
  (testing "Advanced Translation"
    (is (= (translate 21) "eenentwintig"))))
