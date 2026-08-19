;;; my.shell.el --- Acciones y menú centralizado en Elisp -*- lexical-binding: t -*-

(defvar my-shell-script-file (expand-file-name "~/monoliths-hm/my.shell.sh")
  "Ruta al script Shell original de monoliths-hm.")

(defun my-shell-get-items ()
  "Obtiene la lista de ítems ejecutando 'dash ~/monoliths-hm/my.shell.sh'."
  (when (file-exists-p my-shell-script-file)
    (let ((raw-output (with-temp-buffer
                        (call-process "dash" nil t nil my-shell-script-file)
                        (buffer-string)))
          (items nil))
      (dolist (line (split-string raw-output "\n" t))
        ;; Regex mejorada para capturar nombres largos con guiones y descripciones
        (when (string-match "^\\s-*\\([0-9]+\\))\\s-*\\(.*?\\)\\(?:\\s-+-\\s-+\\(.*\\)\\)?$" line)
          (let* ((id (match-string 1 line))
                 (name (string-trim (match-string 2 line)))
                 (desc (if (match-string 3 line)
                           (string-trim (match-string 3 line))
                         name)))
            (push (list id name desc) items))))
      (nreverse items))))

(defun my-shell-execute-by-id (id &optional name)
  "Ejecuta la opción correspondiente al ID en su propio buffer *<name> shell*."
  (when (file-exists-p my-shell-script-file)
    (let* ((actual-name (or name
                            (nth 1 (assoc id (my-shell-get-items)))))
           (buf-name (format "*%s shell*" (or actual-name id)))
           (display (or (getenv "DISPLAY") ":0"))
           (cmd (format "DISPLAY=%s dash %s -q %s" display my-shell-script-file id)))
      (async-shell-command cmd buf-name))))

(defun generate-hyperbole-scratch-menu ()
  "Genera la tabla interactiva de Hyperbole en *scratch* leyendo my.shell.sh."
  (interactive)
  (let ((scratch-buf (get-buffer-create "*scratch*"))
        (items (my-shell-get-items)))
    (when items
      (with-current-buffer scratch-buf
        (erase-buffer)
        (insert ";; ======================================================================\n")
        (insert ";;                 PANEL DE CONTROL INTERACTIVO (HYPERBOLE)             ;;\n")
        (insert ";; Presione M-RET / Action Key en un botón para ejecutar la acción.    ;;\n")
        (insert ";; ======================================================================\n\n")
        (let ((max-name (length "Acción"))
              (max-desc (length "Descripción"))
              (max-btn (length "Acción Hyperbole (Implicit Button)")))
          (dolist (item items)
            (let* ((id (nth 0 item))
                   (name (nth 1 item))
                   (desc (nth 2 item))
                   (btn (format "{ (my-shell-execute-by-id \"%s\" \"%s\") }" id name)))
              (setq max-name (max max-name (length name)))
              (setq max-desc (max max-desc (length desc)))
              (setq max-btn (max max-btn (length btn)))))
          (let ((sep (format "|-%s-+-%s-+-%s-|"
                             (make-string max-name ?-)
                             (make-string max-desc ?-)
                             (make-string max-btn ?-)))
                (fmt (format "| %%-%ds | %%-%ds | %%-%ds |\n" max-name max-desc max-btn)))
            (insert (format fmt "Acción" "Descripción" "Acción Hyperbole (Implicit Button)"))
            (insert sep "\n")
            (dolist (item items)
              (let* ((id (nth 0 item))
                     (name (nth 1 item))
                     (desc (nth 2 item))
                     (btn (format "{ (my-shell-execute-by-id \"%s\" \"%s\") }" id name)))
                (insert (format fmt name desc btn))))
            (insert sep "\n"))))
      (goto-char (point-min)))))

(with-eval-after-load 'hyperbole
  (defib my-shell-menu-action ()
    "Activates a menu action when clicking on its name or anywhere on the row in the *scratch* buffer."
    (when (string= (buffer-name) "*scratch*")
      (save-excursion
        (beginning-of-line)
        (when (looking-at "|\\s-*\\([^|]+\\S-\\)\\s-*|\\s-*[^|]+\\s-*|\\s-*{\\s-*(my-shell-execute-by-id\\s-+\"\\([0-9]+\\)\"")
          (let ((name (match-string 1))
                (id (match-string 2)))
            (ibut:label-set name (match-beginning 1) (match-end 1))
            (hact 'my-shell-execute-by-id id name)))))))

(provide 'my.shell)
;;; my.shell.el ends here
