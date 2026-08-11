;;; my.amd64gnu+linux.el --- Hyperbole menu for amd64gnu+linux scripts -*- lexical-binding: t -*-

(defvar amd64gnu+linux-script-dir (expand-file-name "~/amd64gnu+linux/"))

(defun amd64gnu+linux-pad (str len)
  "Pad STR with spaces on the right to reach LEN width."
  (let ((s (or str "")))
    (if (>= (length s) len)
        s
      (concat s (make-string (- len (length s)) ?\s)))))

(defun amd64gnu+linux-get-items ()
  "Return a list of menu items (DISPLAY-NAME SCRIPT-NAME IS-MOCK)."
  (let ((files (directory-files amd64gnu+linux-script-dir t "\\.sh$"))
        (items nil))
    (dolist (file files)
      (let* ((basename (file-name-base file))
             (home-link (expand-file-name basename "~"))
             (mock-dir (expand-file-name (concat basename "/mock") "~")))
        (when (and (file-exists-p home-link)
                   (or (file-directory-p home-link)
                       (file-symlink-p home-link)))
          (push (list basename basename nil) items)
          (when (file-directory-p mock-dir)
            (push (list (concat basename " mock") basename t) items)))))
    (nreverse items)))

(defun amd64gnu+linux-execute (script-name &optional mock)
  "Ejecuta ~/amd64gnu+linux/SCRIPT-NAME.sh enviando el comando a un buffer interactivo M-x shell.
Si MOCK es non-nil, añade el argumento \"mock\".
Abre un buffer interactivo tipo shell (*<script-name> shell* o *<script-name> mock shell*) en primer plano y envía la orden."
  (let* ((script (expand-file-name (concat script-name ".sh") amd64gnu+linux-script-dir))
         (buf-name (if mock
                       (format "*%s mock shell*" script-name)
                     (format "*%s shell*" script-name)))
         (cmd (if mock
                  (format "bash %s mock" script)
                (format "bash %s" script)))
         (buf (get-buffer buf-name)))
    (when (file-exists-p script)
      (unless (and buf (comint-check-proc buf))
        (setq buf (shell buf-name))
        (let ((proc (get-buffer-process buf)))
          (when proc
            (comint-send-string proc (concat cmd "\n")))))
      (pop-to-buffer buf))))

(defun generate-hyperbole-scratch-amd64gnu+linux-menu ()
  "Genera la tabla interactiva de Hyperbole en *scratch* para amd64gnu+linux."
  (interactive)
  (let ((scratch-buf (get-buffer-create "*scratch*"))
        (items (amd64gnu+linux-get-items)))
    (when items
      (with-current-buffer scratch-buf
        (goto-char (point-max))
        (insert "\n;; ======================================================================\n")
        (insert ";;               PANEL DE CONTROL AMD64 GNU+LINUX (HYPERBOLE)           ;;\n")
        (insert ";; Presione M-RET / Action Key en un botón para ejecutar la acción.    ;;\n")
        (insert ";; ======================================================================\n\n")
        (let ((max-name (length "Acción"))
              (max-desc (length "Descripción"))
              (max-btn (length "Acción Hyperbole (Implicit Button)")))
          (dolist (item items)
            (let* ((disp (nth 0 item))
                   (script-name (nth 1 item))
                   (is-mock (nth 2 item))
                   (btn (if is-mock
                            (format "{ (amd64gnu+linux-execute \"%s\" t) }" script-name)
                          (format "{ (amd64gnu+linux-execute \"%s\") }" script-name))))
              (setq max-name (max max-name (length disp)))
              (setq max-desc (max max-desc (length disp)))
              (setq max-btn (max max-btn (length btn)))))
          (let ((sep (format "|-%s-+-%s-+-%s-|"
                             (make-string max-name ?-)
                             (make-string max-desc ?-)
                             (make-string max-btn ?-))))
            (insert (format "| %s | %s | %s |\n"
                            (amd64gnu+linux-pad "Acción" max-name)
                            (amd64gnu+linux-pad "Descripción" max-desc)
                            (amd64gnu+linux-pad "Acción Hyperbole (Implicit Button)" max-btn)))
            (insert sep "\n")
            (dolist (item items)
              (let* ((disp (nth 0 item))
                     (script-name (nth 1 item))
                     (is-mock (nth 2 item))
                     (btn (if is-mock
                              (format "{ (amd64gnu+linux-execute \"%s\" t) }" script-name)
                            (format "{ (amd64gnu+linux-execute \"%s\") }" script-name))))
                (insert (format "| %s | %s | %s |\n"
                                (amd64gnu+linux-pad disp max-name)
                                (amd64gnu+linux-pad disp max-desc)
                                (amd64gnu+linux-pad btn max-btn)))))
            (insert sep "\n"))))
      (goto-char (point-min)))))

(with-eval-after-load 'hyperbole
  (defib amd64gnu+linux-menu-action ()
    "Activates a menu action when clicking on its name in the *scratch* buffer."
    (when (string= (buffer-name) "*scratch*")
      (save-excursion
        (beginning-of-line)
        (when (looking-at "|\\s-*\\([^|]+\\S-\\)\\s-*|\\s-*[^|]+\\s-*|\\s-*{\\s-*(amd64gnu\\+linux-execute\\s-+\\\"\\([^\"]+\\)\\\"\\(?:\\s-+\\(t\\)\\)?\\s-*)\\s-*}")
          (let ((disp (match-string 1))
                (script-name (match-string 2))
                (mock (match-string 3)))
            (ibut:label-set disp (match-beginning 1) (match-end 1))
            (hact 'amd64gnu+linux-execute script-name (when (equal mock "t") t))))))))

(provide 'my.amd64gnu+linux)
;;; my.amd64gnu+linux.el ends here
