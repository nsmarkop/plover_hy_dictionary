# Plover Hy Dictionary

[Hy](https://github.com/hylang/hy) dictionary support for [Plover](https://github.com/openstenoproject/plover).

## Installation

Download the latest version of Plover for your operating system from the [releases page](https://github.com/openstenoproject/plover/releases). Only versions 4.0.0.dev1 and higher are supported.

1. Open Plover
2. Navigate to the Plugin Manager tool
3. Select the "plover-hy-dictionary" plugin entry in the list
4. Click install
5. Restart Plover

The same method can be used for updating and uninstalling the plugin.

## Usage

This plugin is based on the [Plover Python Dictionary plugin](https://github.com/benoit-pierre/plover_python_dictionary) so you can reference its documentation.

The main example directly translated to hy for this plugin:

``` lisp
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
```
