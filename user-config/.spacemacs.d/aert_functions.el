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

;; keybindings .................................................................

(spacemacs/set-leader-keys "o;" 'aert/insert-comment-separator)
(spacemacs/set-leader-keys "op" 'prettier-js)
(spacemacs/set-leader-keys "ot" 'org-time-stamp)
