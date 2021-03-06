(defun dict-translate ()
  (interactive)
  (let ((tword (dict-lookup (thing-at-point 'word))))
    (other-window 1)
    (setq bounds (bounds-of-thing-at-point 'word))
    (setq pos1 (car bounds))
    (setq pos2 (cdr bounds))
    (delete-region pos1 pos2)
    (insert tword)
    )
  )


(defun dict-lookup (word)
  (switch-to-buffer-other-window "*map*")
  (goto-char (point-min))

  (if (search-forward-regexp (format "^%s -> " word) nil t)
       (thing-at-point 'word)
       
    (let ((trans-word (read-from-minibuffer (format "Enter translation for %s: " word))))
	  (goto-char (point-max))
	  (insert (format "\n%s -> %s" word trans-word))
	  (symbol-value 'trans-word)
	  )
    ) 
  )


(defun dict-load ()
  (interactive)
  (switch-to-buffer-other-window "*map*")
  (insert-file-contents (read-file-name "Enter dictionary filename: "))
  (other-window 1)
  )
