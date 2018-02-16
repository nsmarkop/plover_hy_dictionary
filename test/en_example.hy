(setv *longest-key* 2)
(setv *show-stroke-steno* "STR*")

(defn lookup [strokes]
  "
  Get the translation that the provided strokes would output.

  :param strokes: A tuple of strokes to look up translations for.
  :return: The translation. A KeyError will be thrown if the lookup failed.
  "
  (assert (<= (len strokes) *longest-key*) (% "%d/%d" ((len strokes) *longest-key*)))
  (if (!= *show-stroke-steno* (nth strokes 0))
    (raise KeyError))
  (if (= (len strokes) 1)
    " "
    (nth strokes 1)))

(defn reverse-lookup [text]
  "
  Get the strokes that would result in the provided text.

  :param text: The text to look up strokes for.
  :return: An array of stroke tuples. An empty array if the reverse lookup failed.
  "
  [])
