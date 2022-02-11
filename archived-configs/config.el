;; Enable vertico
(use-package vertico
  :init
  (vertico-mode)

  ;; Different scroll margin
  ;; (setq vertico-scroll-margin 0)

  ;; Show more candidates
  ;; (setq vertico-count 20)

  ;; Grow and shrink the Vertico minibuffer
  ;; (setq vertico-resize t)

  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  ;; (setq vertico-cycle t)
  )

;; Optionally use the `orderless' completion style. See
;; `+orderless-dispatch' in the Consult wiki for an advanced Orderless style
;; dispatcher. Additionally enable `partial-completion' for file path
;; expansion. `partial-completion' is important for wildcard support.
;; Multiple files can be opened at once with `find-file' if you enter a
;; wildcard. You may also give the `initials' completion style a try.
(use-package orderless
  :init
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (setq orderless-style-dispatchers '(+orderless-dispatch)
  ;;       orderless-component-separator #'orderless-escapable-split-on-space)
  (setq completion-styles '(orderless)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

;; A few more useful configurations...
(use-package emacs
  :init
  ;; Add prompt indicator to `completing-read-multiple'.
  ;; Alternatively try `consult-completing-read-multiple'.
  (defun crm-indicator (args)
    (cons (concat "[CRM] " (car args)) (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

  ;; Emacs 28: Hide commands in M-x which do not work in the current mode.
  ;; Vertico commands are hidden in normal buffers.
  ;; (setq read-extended-command-predicate
  ;;       #'command-completion-default-include-p)

  ;; Enable recursive minibuffers
  (setq enable-recursive-minibuffers t))

(defun rmf/org-mode-setup ()
       (org-indent-mode)
       (visual-line-mode 1))

     ;; Org Mode Configuration ------------------------------------------------------

     (use-package org
       :hook (org-mode . rmf/org-mode-setup)
       :config
  ;;     (setq org-ellipsis " ▾")
          (setq org-ellipsis " ~"))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))


    ;; (setq org-capture-templates
    ;; '(("a" "Appointment" entry (file  "~/Dropbox/Mac/Documents/org/gcal.org" "Appointments")
    ;; "* TODO %?\n:PROPERTIES:\n\n:END:\nDEADLINE: %^T \n %i\n")
    ;; ("n" "Note" entry (file+headline "~/Dropbox/orgfiles/notes.org" "Notes")
    ;; "* Note %?\n%T")
    ;; ("l" "Link" entry (file+headline "~/Dropbox/orgfiles/links.org" "Links")
    ;; "* %? %^L %^g \n%T" :prepend t)
    ;; ("b" "Blog idea" entry (file+headline "~/Dropbox/orgfiles/i.org" "Blog Topics:")
    ;; "* %?\n%T" :prepend t)
    ;; ("t" "To Do Item" entry (file+headline "~/Dropbox/orgfiles/i.org" "To Do Items")
    ;; "* %?\n%T" :prepend t)
    ;; ("j" "Journal" entry (file+datetree "~/Dropbox/journal.org")
    ;; "* %?\nEntered on %U\n  %i\n  %a")
    ;; ("s" "Screencast" entry (file "~/Dropbox/orgfiles/screencastnotes.org")
    ;; "* %?\n%i\n")))

(use-package yasnippet
  :ensure t
  :config
  (use-package yasnippet-snippets
    :ensure t) (yas-reload-all))

  ;; (use-package yasnippet
      ;;   :diminish yas-minor-mode
      ;;   :defer 5
      ;;   :config
      ;;   (setq yas-snippet-dirs '("~/Dropbox/Mackup/emacs-stuff/snippets"))
;;   (yas-global-mode 1)) ;; or M-x yas-reload-all if you've started YASnippet already.


      ;; ;; Silences the warning when running a snippet with backticks (runs a command in the snippet)
      ;; ;; I use backtick commands to get the date for org snippets
      ;; (require 'warnings)
      ;; (add-to-list 'warning-suppress-types '(yasnippet backquote-change))

(use-package which-key
:ensure t
:config
(which-key-mode))
