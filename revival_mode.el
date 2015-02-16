(defcustom max-ring-killed-buffer-size 50
  "number of killed buffer path record")

(defvar killed-buffer-history () 
  " killed buffer history")

(defun insert-into-buffer-killed-history ()
  (interactive)
  " insert into the killed buffer ring the path of the buffer at the newest index to potentially reload it later."
  (if (buffer-file-name)
      (add-to-history 'killed-buffer-history (buffer-file-name))))

(defun revival-buffer (path)
  " revival a buffer precedently killed"
  (interactive
   (list (read-string (format"reload file (default %s): " (car killed-buffer-history)) nil 'killed-buffer-history (car killed-buffer-history)))
   )
  (find-file path)
  )

(define-minor-mode revival-mode
  "back alive killed buffer"
  :lighter " revival"
  :global t
  (add-hook 'kill-buffer-hook 'insert-into-buffer-killed-history)
  )

(provide 'revival-mode)
