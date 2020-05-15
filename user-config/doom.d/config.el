;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Jetbrains Mono Medium" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-gruvbox)
(setq doom-theme 'doom-nova)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemeted.

(setq doom-modeline-project-detection 'truncate-with-project)
(setq doom-variable-pitch-font (font-spec :family "Cantarell" :size 11))

;; treemacs ....................................................................

(use-package treemacs
  :defer t
  :init
  (setq treemacs-indentation 1
        treemacs-position 'right))

;; org mode ....................................................................

(setq org-ellipsis " ▼ ")
(setq deft-directory "~/org")

;; My Functions ................................................................

(defun aert/insert-comment-separator (&optional title fill-char)
  "Insert a line comment appended with `fill-char` until col 80."
  (interactive)

  ;;-- args
  (unless title (setq title (read-string "Label: ")))
  (unless fill-char (setq fill-char ?.))

  (let (x-max text-prepend x-current fill-count text-fill)
    (setq x-max 80)
    (setq text-prepend "")

    (comment-dwim ())

    ;;-- compute fill-char repeat count
    (setq x-current ( - (point) (line-beginning-position)))
    (setq fill-count (- x-max (+ 1 x-current (length (concat text-prepend title)))))

    ;;-- generate comment
    (setq text-fill (make-string fill-count fill-char))

    (insert text-prepend title " " text-fill)
    )
)

(defun aert/copy-current-line-position-to-clipboard ()
  "Copy current line in file to clipboard as '</path/to/file>:<line-number>'."
  (interactive)
  (let ((path-with-line-number
         (concat (dired-replace-in-string (getenv "HOME") "~" (buffer-file-name)) ":" (number-to-string (line-number-at-pos)))))
    (kill-new path-with-line-number)
    (message (concat path-with-line-number " copied to clipboard"))))

;;--- Binding or leader key as in vim {{{

(defvar my-leader-map (make-sparse-keymap)
  "Keymap for \"leader key\" shortcuts.")

;; binding "," to the keymap
(define-key evil-normal-state-map "," my-leader-map)

;; bindings
(define-key my-leader-map "f" 'counsel-fzf)
(define-key my-leader-map "g" 'counsel-google)
(define-key my-leader-map "p" 'format-all-buffer)
(define-key my-leader-map "a" 'org-agenda)
(define-key my-leader-map "s" 'evil-avy-goto-char-timer)
(define-key my-leader-map "c" 'aert/insert-comment-separator)
(define-key my-leader-map "C" 'aert/copy-current-line-position-to-clipboard)
(define-key my-leader-map "n" '+treemacs/find-file)
(define-key my-leader-map "l" 'swiper-isearch)
(define-key my-leader-map "z" 'hs-hide-level)

;;--- Binding or leader key as in vim }}}
