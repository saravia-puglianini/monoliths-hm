;;; my.shell.el --- Acciones y menú centralizado en Elisp -*- lexical-binding: t -*-

(defvar my-shell-script-file (expand-file-name "~/monoliths-hm/my.shell.sh")
  "Ruta al script Shell original de monoliths-hm.")

(defun my-shell-get-items ()
  "Obtiene la lista de ítems ejecutando 'dash ~/monoliths-hm/my.shell.sh'."
  (when (file-exists-p my-shell-script-file)
    (let ((raw-output (with-temp-buffer
                        (call-process "dash" my-shell-script-file t nil)
                        (buffer-string)))
          (items nil))
      (dolist (line (split-string raw-output "\n" t))
        (when (string-match "^\\([0-9]+\\)) \\([^ -]+\\)\\(?: - \\(.*\\)\\)?" line)
          (let* ((id (match-string 1 line))
                 (name (match-string 2 line))
                 (desc (or (match-string 3 line) name)))
            (push (list id name desc) items))))
      (nreverse items))))

(defun my-shell-execute-by-id (id)
  "Ejecuta la opción correspondiente al ID."
  (when (file-exists-p my-shell-script-file)
    (call-process-shell-command (format "echo %s | dash %s &" id my-shell-script-file))))

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
        (let ((max-name (length "Acción (Yad)"))
              (max-desc (length "Descripción"))
              (max-btn (length "Acción Hyperbole (Implicit Button)")))
          (dolist (item items)
            (let* ((id (nth 0 item))
                   (name (nth 1 item))
                   (desc (nth 2 item))
                   (btn (format "<exec-shell-cmd \"echo %s | dash %s\">" id my-shell-script-file)))
              (setq max-name (max max-name (length name)))
              (setq max-desc (max max-desc (length desc)))
              (setq max-btn (max max-btn (length btn)))))
          (let ((sep (format "|-%s-+-%s-+-%s-|"
                             (make-string max-name ?-)
                             (make-string max-desc ?-)
                             (make-string max-btn ?-))))
            (insert (format "| %s | %s | %s |\n"
                            (string-pad "Acción (Yad)" max-name)
                            (string-pad "Descripción" max-desc)
                            (string-pad "Acción Hyperbole (Implicit Button)" max-btn)))
            (insert sep "\n")
            (dolist (item items)
              (let* ((id (nth 0 item))
                     (name (nth 1 item))
                     (desc (nth 2 item))
                     (btn (format "<exec-shell-cmd \"echo %s | dash %s\">" id my-shell-script-file)))
                (insert (format "| %s | %s | %s |\n"
                                (string-pad name max-name)
                                (string-pad desc max-desc)
                                (string-pad btn max-btn)))))
            (insert sep "\n"))))
      (goto-char (point-min)))))

(provide 'my.shell)
;;; my.shell.el ends here
