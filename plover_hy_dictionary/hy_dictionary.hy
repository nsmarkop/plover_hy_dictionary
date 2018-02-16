(import hy)
(import [plover-python-dictionary [PythonDictionary]])

(setv *dict-module-name* "internal-plover-hy-dictionary-module-name")

(defclass HyDictionary [PythonDictionary]
  "A dictionary that supports Hy."

  (defn -load [self filename]
    "
    Performs the initial load of a dictionary.

    :param filename: The file path to the dictionary. 
    "
    ; TODO: Just keep using an arbitrary module name?
    ;       If I use '' then python dictionaries stop working.
    (setv mod (hy.importer.import-file-to-module *dict-module-name* filename))

    ; The remainder is from PythonDictionary but has to be repeated
    ; due to the current code structure of that class.
    (self.-load-longest-key mod)
    (self.-load-lookup mod)
    (self.-load-reverse-lookup mod)
    ())

  (defn -load-longest-key [self module]
    "
    Loads the longest key value from a loaded dictionary.

    :param module: The loaded module for the dictionary.
    "
    (setv self.-longest-key (getattr module "LONGEST_KEY" None))
    (if (or (not (isinstance self.-longest-key int)) (<= self.-longest-key 0))
      (raise (ValueError (% "missing or invalid *longest-key* constant: %s\n" (str self.-longest-key)))))
    ())

  (defn -load-lookup [self module]
    "
    Loads the lookup function from a loaded dictionary.

    :param module: The loaded module for the dictionary.
    "
    (setv self.-lookup (getattr module "lookup" None))
    (if (not (isinstance self.-lookup (type (fn [x] x))))
      (raise (ValueError (% "missing or invalid \"lookup\" function: %s\n" (str self.-lookup)))))
    ())

  (defn -load-reverse-lookup [self module]
    "
    Loads the reverse lookup function from a loaded dictionary.

    :param module: The loaded module for the dictionary.
    "
    (setv self.-reverse-lookup (getattr module "reverse_lookup" None))
    (if (not (isinstance self.-reverse-lookup (type (fn [x] x))))
      (raise (ValueError (% "missing or invalid \"reverse_lookup\" function: %s\n" (str self.-reverse-lookup)))))
    ()))
