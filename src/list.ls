(defn List
  "List type"
  [head tail]
  (set! this.head head)
  (set! this.tail tail)
  (set! this.length (+ (.-length tail) 1))
  this)

(set! List.prototype.length 0)
(set! List.prototype.tail (Object.create List.prototype))
(set! List.prototype.to-string
      (fn []
        (loop [result ""
               list this]
          (if (empty? list)
            (str "(" (.substr result 1) ")")
            (recur 
             (str result " " (first list))
             (rest list))))))

(defn empty?
  "Returns true if list is empty"
  [list]
  (= (.-length list) 0))

(defn first
  "Return first item in a list"
  [list]
  (.-head list))

(defn rest
  "Returns list of all items excepti first one"
  [list]
  (.-tail list))

(defn cons
  "Creates list with `head` as first item and `tail` as rest"
  [head tail]
  (new List head tail))

(defn list
  "Creates list of the given items"
  []
  (if (= (.-length arguments) 0)
    (Object.create List.prototype)
    (.reduce-right (.call Array.prototype.slice arguments)
                   (fn [tail head] (cons head tail))
                   (list))))

(defn reverse
  "Reverse order of items in the list"
  [source]
  (loop [items (Array)
         source source]
    (if (empty? source)
      (.apply list list items)
      (recur (.concat (Array (first source)) items)
             (rest source)))))

;; Export symbols
(set! exports.empty? empty?)
(set! exports.first first)
(set! exports.head first)
(set! exports.rest rest)
(set! exports.tail rest)
(set! exports.cons cons)
(set! exports.list list)
(set! exports.reverse reverse)
