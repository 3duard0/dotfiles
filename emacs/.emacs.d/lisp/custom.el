
(defun toggle-eshell-buffer ()
  "Toggle the eshell on and off"
  (interactive)
  (if (string-match "eshell" (buffer-name (current-buffer)))
      (delete-window)
    (let ((buf (eshell)))
      (switch-to-buffer (other-buffer buf))
      (switch-to-buffer-other-window buf))))
