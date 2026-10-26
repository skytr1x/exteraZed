; python base
(identifier) @variable

(attribute attribute: (identifier) @property)

((identifier) @type
  (#match? @type "^[A-Z].*[a-z]"))

((identifier) @constant
  (#match? @constant "^_*[A-Z][A-Z\\d_]*$"))

(type (identifier) @type)
(generic_type (identifier) @type)

(comment) @comment

(function_definition name: (identifier) @function)
(class_definition name: (identifier) @type)

(call function: (identifier) @function)
(call function: (attribute attribute: (identifier) @function.method))

(decorator "@" @punctuation.special)
(decorator
  "@" @punctuation.special
  [
    (identifier) @function.decorator
    (attribute attribute: (identifier) @function.decorator)
    (call function: (identifier) @function.decorator)
    (call function: (attribute attribute: (identifier) @function.decorator))
  ])

(parameters (identifier) @variable.parameter)
(default_parameter name: (identifier) @variable.parameter)
(typed_parameter (identifier) @variable.parameter)
(typed_default_parameter name: (identifier) @variable.parameter)
(lambda_parameters (identifier) @variable.parameter)
(keyword_argument name: (identifier) @variable.parameter)
(list_splat_pattern (identifier) @variable.parameter)
(dictionary_splat_pattern (identifier) @variable.parameter)

(none) @constant
[(true) (false)] @boolean
(integer) @number
(float) @number
(string) @string
(escape_sequence) @string.escape
(interpolation "{" @punctuation.special "}" @punctuation.special)

(module . (expression_statement (string) @string.doc))
(class_definition body: (block . (expression_statement (string) @string.doc)))
(function_definition body: (block . (expression_statement (string) @string.doc)))

[
  "as" "assert" "async" "await" "break" "class" "continue" "def" "del"
  "elif" "else" "except" "exec" "finally" "for" "from" "global" "if"
  "import" "lambda" "match" "case" "nonlocal" "pass" "print" "raise"
  "return" "try" "while" "with" "yield"
  "and" "in" "is" "not" "or" "is not" "not in"
] @keyword
(type_alias_statement "type" @keyword)

[
  "-" "-=" "!=" "*" "**" "**=" "*=" "/" "//" "//=" "/=" "&" "&=" "%" "%="
  "^" "^=" "+" "->" "+=" "<" "<<" "<<=" "<=" "<>" "=" ":=" "==" ">" ">="
  ">>" ">>=" "|" "|=" "~" "@=" "@"
] @operator

["(" ")" "[" "]" "{" "}"] @punctuation.bracket
["," "." ":" ";"] @punctuation.delimiter

((identifier) @variable.special
  (#any-of? @variable.special "self" "cls"))

((identifier) @type.builtin
  (#any-of? @type.builtin
    "bool" "bytearray" "bytes" "complex" "dict" "float" "frozenset" "int"
    "list" "memoryview" "object" "set" "slice" "str" "tuple" "type"
    "Exception" "BaseException" "ValueError" "TypeError" "KeyError"
    "IndexError" "AttributeError" "RuntimeError" "ImportError" "OSError"))

((call function: (identifier) @function.builtin)
  (#any-of? @function.builtin
    "abs" "all" "any" "ascii" "bin" "breakpoint" "callable" "chr" "compile"
    "delattr" "dir" "divmod" "enumerate" "eval" "exec" "filter" "format"
    "getattr" "globals" "hasattr" "hash" "hex" "id" "input" "isinstance"
    "issubclass" "iter" "len" "locals" "map" "max" "min" "next" "oct" "open"
    "ord" "pow" "print" "property" "range" "repr" "reversed" "round"
    "setattr" "sorted" "staticmethod" "classmethod" "sum" "super" "vars" "zip"))

; exteraGram meta
(module
  (expression_statement
    (assignment
      left: (identifier) @variable.special
      (#any-of? @variable.special
        "__id__" "__name__" "__description__" "__author__" "__version__"
        "__icon__" "__min_version__" "__requirements__"))))

; api classes
((identifier) @type.builtin
  (#any-of? @type.builtin
    "BasePlugin" "HookResult" "HookStrategy" "AppEvent" "MenuItemData"
    "MenuItemType" "Header" "Switch" "Input" "Selector" "Divider" "Text"
    "EditText" "Slider" "BulletinHelper" "AlertDialogBuilder"))

(attribute
  object: (identifier) @_enum
  attribute: (identifier) @constant
  (#any-of? @_enum "HookStrategy" "AppEvent" "MenuItemType"))

; lifecycles and hooks
(function_definition
  name: (identifier) @function.special
  (#match? @function.special
    "^(on_plugin_load|on_plugin_unload|on_app_event|create_settings|pre_request_hook|post_request_hook|on_[a-z_]+_hook)$"))

(call
  function: (attribute
    object: (identifier) @_self
    attribute: (identifier) @function.builtin)
  (#eq? @_self "self")
  (#any-of? @function.builtin
    "log" "add_hook" "remove_hook" "hook_method" "unhook_method"
    "hook_all_methods" "add_on_send_message_hook" "add_menu_item"
    "remove_menu_item" "get_setting" "set_setting" "export_settings"
    "replace_method" "hook_all_constructors"))

; helpers
(call
  function: (identifier) @function.builtin
  (#any-of? @function.builtin
    "log" "run_on_ui_thread" "run_on_queue" "get_last_fragment"
    "get_account_instance" "send_message" "send_text" "find_class"
    "get_private_field" "set_private_field" "jclass" "dynamic_proxy"
    "parse_markdown" "copy_to_clipboard"))

; java classes
(call
  function: (identifier) @_jf
  arguments: (argument_list (string (string_content) @string.special))
  (#any-of? @_jf "jclass" "find_class"))
