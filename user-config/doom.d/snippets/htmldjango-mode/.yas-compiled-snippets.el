;;; Compiled snippets and support files for `htmldjango-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'htmldjango-mode
                     '(("{" "{{ $1 }}\n" "{" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/{" nil nil)
                       ("wordwrap" "wordwrap:$0" "wordwrap" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/wordwrap" nil nil)
                       ("with" "{% with $1 as $2 %}\n  $0\n{% endwith %}\n\n\n\n" "with" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/with" nil nil)
                       ("widthratio" "{% widthratio ${1:this_value} ${2:max_value} ${0:100} %}" "widthratio" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/widthratio" nil nil)
                       ("urlizetrunc" "urlizetrunc:$0" "urlizetrunc" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/urlizetrunc" nil nil)
                       ("url" "{% url $1 as $0 %}" "url" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/url" nil nil)
                       ("truncatewordshtml" "truncatewords_html:$0" "truncatewordshtml" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/truncatewordshtml" nil nil)
                       ("truncatewords" "truncatewords:$0" "truncatewords" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/truncatewords" nil nil)
                       ("trans" "{% trans \"${0:string}\" %}" "trans" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/trans" nil nil)
                       ("time" "time:\"$0\"" "time" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/time" nil nil)
                       ("stringformat" "stringformat:\"$0\"" "stringformat" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/stringformat" nil nil)
                       ("ssi" "{% ssi $0 %}" "ssi" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/ssi" nil nil)
                       ("spaceless" "{% spaceless %}$0{% endspaceless %}" "spaceless" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/spaceless" nil nil)
                       ("slice" "slice:\"$0\"" "slice" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/slice" nil nil)
                       ("removetags" "removetags:\"$0\"" "removetags" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/removetags" nil nil)
                       ("regroup" "{% regroup $1 by $2 as $0 %}" "regroup" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/regroup" nil nil)
                       ("pluralize" "pluralize:\"$0\"" "pluralize" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/pluralize" nil nil)
                       ("now" "{% now \"${0:jS F Y H:i}\" %}" "now" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/now" nil nil)
                       ("load" "{% load $0 %}" "load" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/load" nil nil)
                       ("lengthis" "length_is:\"$0\"" "lengthis" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/lengthis" nil nil)
                       ("join" "join:\"$0\"" "join" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/join" nil nil)
                       ("include" "{% include \"$0\" %}" "include" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/include" nil nil)
                       ("ifnotequal" "{% ifnotequal $1 $2 %}\n  $0\n{% endifnotequal %}" "ifnotequal" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/ifnotequal" nil nil)
                       ("ifequal" "{% ifequal $1 $2 %}\n  $0\n{% endifequal %}" "ifequal" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/ifequal" nil nil)
                       ("ifchanged" "{% ifchanged %}$1{% endifchanged %}" "ifchanged" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/ifchanged" nil nil)
                       ("if" "{% if $1 %}\n  $0\n{% endif %}" "if" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/if" nil nil)
                       ("getdigit" "get_digit:\"$0\"" "getdigit" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/getdigit" nil nil)
                       ("for" "{% for $1 in $2 %}\n  $0\n{% endfor %}" "for" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/for" nil nil)
                       ("floatformat" "floatformat:\"$0\"" "floatformat" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/floatformat" nil nil)
                       ("firstof" "{% firstof $1 %}" "firstof" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/firstof" nil nil)
                       ("filter" "{% filter $1 %}\n  $0\n{% endfilter %}" "filter" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/filter" nil nil)
                       ("extends" "{% extends \"${0:base.html}\" %}" "extends" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/extends" nil nil)
                       ("empty" "{% empty %}\n$0" "empty" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/empty" nil nil)
                       ("el" "{% else %}\n  $1" "el" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/el" nil nil)
                       ("eif" "{% elif $1 %}\n  $0" "eif" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/eif" nil nil)
                       ("divisibleby" "divisibleby:\"$0\"" "divisibleby" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/divisibleby" nil nil)
                       ("dictsortrev" "dictsortreversed:\"$0\"" "dictsortrev" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/dictsortrev" nil nil)
                       ("dictsort" "dictsort:\"$0\"" "dictsort" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/dictsort" nil nil)
                       ("defaultifnone" "default_if_none:\"$0\"" "defaultifnone" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/defaultifnone" nil nil)
                       ("default" "default:\"$0\"" "default" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/default" nil nil)
                       ("debug" "{% debug %}" "debug" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/debug" nil nil)
                       ("date" "date:\"$0\"" "date" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/date" nil nil)
                       ("cycle" "{% cycle ${1:val1} ${2:val2} ${3:as $4} %}" "cycle" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/cycle" nil nil)
                       ("cut" "cut:\"$0\"" "cut" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/cut" nil nil)
                       ("comment" "{% comment %}\n  $0\n{% endcomment %}" "comment" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/comment" nil nil)
                       ("center" "center:\"$0\"" "center" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/center" nil nil)
                       ("block" "{% block $1 %}\n  $0\n{% endblock %}" "block" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/block" nil nil)
                       ("autoescape" "{% autoescape ${1:off} %}\n  $0\n{% endautoescape %}" "autoescape" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/autoescape" nil nil)
                       ("add" "add:\"$0\"" "add" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/add" nil nil)
                       ("%%" "{% ${1:tag_name} %}\n$0\n{% end$1 %}" "%%" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/%%" nil nil)
                       ("%" "{% $1 %}" "%" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/%" nil nil)
                       ("#" "{# ${0:comment} #}" "#" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/htmldjango-mode/#" nil nil)))


;;; Do not edit! File generated at Mon May  8 02:40:51 2017
