(ns learning-dutch.core
  (:gen-class :main true))

; Every number!
(def digits ["nul", "een", "twee", "drie", "vier", "vijf", "zes", "zeven", "acht", "negen"])
(def teens ["tien", "elf", "twaaelf", "dertien", "veertien", "vijftien", "zestien", "zeventien", "achttien", "negentien"])
(def tens ["twintig", "dertig", "veertig", "vijftig", "zestig", "zeventig", "tachig", "negentig"])

(defn translate [x]
  (cond
    (< x 10) (get digits x)
    (and (> x 10) (< x 20)) (get teens (- x 10))
    (and (> x 20) (< x 100)) (let [tensPlace (int (Math/floor (- (/ x 10) 2)))
                                   tensPlace (get tens tensPlace)
                                   charCode (second (seq (str x)))
                                   index (Character/digit charCode 10)
                                   onesPlace (get digits index)] (if (= index 0) tensPlace (str onesPlace (if (contains? #{2 3} index) "ën" "en") tensPlace)))))

(defn ask [question]
  (println question)
  (read-line))

(defn generate [mode]
  (let [random (rand-int 100)
        asWord (translate random)
        input (ask (if (= mode "1") (str "What does " random " mean in dutch?") (str "What is " asWord " as digit?")))]
    (if (if (= mode "1") (= input asWord) (= input (str random))) (println "Congratulations!") (println "Your family name was put to shame.."))
    (println "---")))

(defn -main
  [& args]
      (def mode (ask "Do you want to translate digits to dutch (1), or dutch to digits? (2)"))
      (if (not (contains? #{"1" "2"} mode)) (throw (new Exception "Mode isn't 1 or 2. Illegal.")))
  (while true (generate mode)))