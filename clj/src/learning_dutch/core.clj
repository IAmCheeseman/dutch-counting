(ns learning-dutch.core)

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

(defn generate []
  (let [random 32
        asWord (translate random)]
    (println asWord)))

(defn -main
  [& args]
  (generate))