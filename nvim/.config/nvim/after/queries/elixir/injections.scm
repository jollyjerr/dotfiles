;; The query pattern looks for a function call named "execute" that contains
;; a single string argument. It then captures the content of that string
;; and injects the 'sql' language parser into it.


; (call ; [10, 4] - [10, 28]
;   target: (identifier) ; [10, 4] - [10, 11]
;   (arguments ; [10, 11] - [10, 28]
;     (string ; [10, 12] - [10, 27]
;       (quoted_content)))) ; [10, 13] - [10, 26]
; (call ; [11, 4] - [13, 8]
;   target: (identifier) ; [11, 4] - [11, 11]
;   (arguments ; [11, 11] - [13, 8]
;     (string ; [11, 12] - [13, 7]
;       (quoted_content))))))))) ; [11, 15] - [13, 4]


(
  (call
    target: (identifier) @function
    (arguments
      (string (quoted_content) @injection.content)
    )
  )
  (#eq? @function "execute")
  (#set! injection.language "sql")
)
