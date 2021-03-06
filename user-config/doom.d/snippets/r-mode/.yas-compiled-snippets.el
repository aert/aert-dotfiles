;;; Compiled snippets and support files for `r-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'r-mode
                     '(("wil" "wilcox.test(${1:x}, ${0:y})" "wil" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/wil" nil nil)
                       ("wh" "while($1) {\n  $2\n}" "wh" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/wh" nil nil)
                       ("vapply" "vapply(${1:list}, ${2:function}, ${0:type})" "vapply" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/vapply" nil nil)
                       ("tt" "t.test(${1:x}, ${0:y})" "tt" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/tt" nil nil)
                       ("tapply" "tapply(${1:vector}, ${2:index}, ${0:function})" "tapply" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/tapply" nil nil)
                       ("source" "source('${0:file}')\n" "source" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/source" nil nil)
                       ("sapply" "lapply(${1:list}, ${0:function})" "sapply" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/sapply" nil nil)
                       ("ret" "return($0)\n" "ret" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/ret" nil nil)
                       ("req" "require(${0:package})" "req" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/req" nil nil)
                       ("rapply" "rapply(${1:list}, ${0:function})\n" "rapply" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/rapply" nil nil)
                       ("pl" "plot(${1:x}, ${0:y})" "pl" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/pl" nil nil)
                       ("ml" "mlply(${1:matrix}, ${0:function})" "ml" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/ml" nil nil)
                       ("md" "mdply(${1:matrix}, ${0:function})" "md" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/md" nil nil)
                       ("mat" "matrix(${1:data}, nrow = ${2:rows}, ncol = ${0:cols})\n" "mat" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/mat" nil nil)
                       ("mapply" "mapply(${1:function}, ${0:...})" "mapply" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/mapply" nil nil)
                       ("ma" "maply(${1:matrix}, ${0:function})" "ma" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/ma" nil nil)
                       ("m_" "m_ply(${1:matrix}, ${0:function})\n" "m_" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/m_" nil nil)
                       ("ll" "llply(${1:list}, ${0:function})" "ll" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/ll" nil nil)
                       ("lib" "library(${0:package})" "lib" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/lib" nil nil)
                       ("li" "list(${0:items})" "li" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/li" nil nil)
                       ("ld" "ldply(${1:list}, ${0:function})" "ld" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/ld" nil nil)
                       ("lapply" "lapply(${1:list}, ${0:function})" "lapply" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/lapply" nil nil)
                       ("la" "laply(${1:list}, ${0:function})" "la" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/la" nil nil)
                       ("l_" "l_ply(${1:list}, ${0:function})\n" "l_" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/l_" nil nil)
                       ("kvt" "kv.test(${1:x}, ${0:y})" "kvt" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/kvt" nil nil)
                       ("img" "${1:(jpeg,bmp,png,tiff)}(filename = '${2:filename}', width = $3, height = $4, unit = '$5')\n${0:plot}\ndev.off()\n" "img" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/img" nil nil)
                       ("if" "if (${1:condition}) {\n  $0\n}" "if" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/if" nil nil)
                       ("ggp" "ggplot(${1:data}, aes(${0:aesthetics}))" "ggp" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/ggp" nil nil)
                       ("fun" "${1:name} <- function (${2:variables}) {\n  $0\n}" "fun" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/fun" nil nil)
                       ("fte" "var.test(${1:x}, ${0:y})" "fte" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/fte" nil nil)
                       ("for" "for (${1:item} in ${2:list}) {\n  $3\n}\n" "for" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/for" nil nil)
                       ("fis" "fisher.test(${1:x}, ${0:y})" "fis" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/fis" nil nil)
                       ("el" "else {\n  $0\n}" "el" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/el" nil nil)
                       ("ei" "else if (${1:condition}) {\n  $0\n}\n" "ei" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/ei" nil nil)
                       ("dl" "dlply(${1:frame}, ${2:variables}, ${0:function})" "dl" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/dl" nil nil)
                       ("df" "${1:name}[${2:rows}, ${0:cols}]" "df" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/df" nil nil)
                       ("dd" "ddply(${1:frame}, ${2:variables}, ${0:function})" "dd" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/dd" nil nil)
                       ("da" "daply(${1:frame}, ${2:variables}, ${0:function})" "da" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/da" nil nil)
                       ("d_" "d_ply(${1:frame}, ${2:variables}, ${0:function})\n" "d_" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/d_" nil nil)
                       ("cor" "cor.test(${1:x}, ${0:y})" "cor" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/cor" nil nil)
                       ("chi" "chisq.test(${1:x}, ${0:y})" "chi" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/chi" nil nil)
                       ("c" "c(${0:items})" "c" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/c" nil nil)
                       ("apply" "apply(${1:array}, ${2:margin}, ${0:function})" "apply" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/apply" nil nil)
                       ("al" "alply(${1:array}, ${2:margin}, ${0:function})" "al" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/al" nil nil)
                       ("ad" "adply(${1:array}, ${2:margin}, ${0:function})" "ad" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/ad" nil nil)
                       ("aa" "aaply(${1:array}, ${2:margin}, ${0:function})" "aa" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/aa" nil nil)
                       ("a_" "a_ply(${1:array}, ${2:margin}, ${0:function})\n" "a_" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/a_" nil nil)
                       ("#!" "#!/usr/bin/env Rscript\n" "#!" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/r-mode/#!" nil nil)))


;;; Do not edit! File generated at Mon May  8 02:40:52 2017
