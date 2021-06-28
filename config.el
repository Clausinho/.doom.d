;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Claus-Peter Käpplinger"
      user-mail-address "clausi9860@gmail.com")

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
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(setq doom-font (font-spec :family "Hack Nerd Font" :size 13))
doom-variable-pitch-font (font-spec :family "Hack Nerd Font" :size 13)
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(use-package! org
  :init (setq org-directory "~/Dropbox/org"))
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; get rid of noob mode
(menu-bar-mode 0)
;; set org-gcal, so I can read my calender inside Org-Mode PogU
;; TODO maybe get the secret from somewhere safe like pass or gpg2?
;; org-gcal sync
;; ref https://cestlaz.github.io/posts/using-emacs-26-gcal/

;;(require 'org-gcal)

;; Storing my creds in a secret file so I don't commit them here.
(require 'json)
(use-package! org-gcal
  :init (defun get-gcal-config-value (key)
          "Return the value of the json file gcal_secret for key"
          (cdr (assoc key (json-read-file "~/.config/doom/gcal-secret.json")))
          )
  :config (setq org-gcal-client-id (get-gcal-config-value 'org-gcal-client-id)
                org-gcal-client-secret (get-gcal-config-value 'org-gcal-client-secret)
                org-gcal-fetch-file-alist '(((get-gcal-config-value 'org-gcal-email) . "~/Dropbox/org/schedule.org"))
                ))
;; set encryption
;; rsa2048/5DAFDDC4929D17AE
(use-package! org-crypt
  :config (setq org-crypt-disable-auto-save 'encrypt
        org-tags-exclude-from-inheritance (quote ("crypt"))
        org-crypt-key "5DAFDDC4929D17AE"
        )
  )

(org-crypt-use-before-save-magic)
;; now set the org-files
(setq org-agenda-files (directory-files-recursively "~/Dropbox/org/" "^[^()]*org$"))
;; set the todo keywords in org-mode
(setq org-todo-keywords
      '((sequence "TODO(t)" "PROJ(p)" "LOOP(r)" "STRT(s)" "IDEA(i)" "|" "WAIT(w@/@)" "HOLD(h@/@)" "|" "DONE(d)" "KILL(k)")
        (sequence "[ ](T)" "[-](S)" "[?](W)" "|" "[X](D)")
        (sequence "|" "OKAY(o)" "YES(y)" "NO(n)"))
 )
;; set tags to use in org-mode
(setq org-tag-alist '((:startgroup . nil)
                      ("@Rems_Murr_Kreis" . ?r) ("@Tübingen" . ?t)
                      (:endgroup . nil)
                      ("Handy" . ?h) ("pc" . ?p)))
;; prompt for info when task is rescheduled, marked as done or im clocking out
(setq org-log-reschedule 'note
      org-log-done 'note
      org-log-note-clock-out 't
      org-log-into-drawer 't ;; log into LOGBOOK drawer
)
;; initalize org-clock-budget after org-clock is loaded
(use-package! org-clock-budget
  :after (org-clock)
  )
;; org-roam dir
(setq org-roam-directory "~/Dropbox/org/roam")
;; org-roam templates https://www.reddit.com/r/emacs/comments/m3r0d6/orgcapture_vs_orgroamcapture_i_must_have_missedd/
(setq org-roam-capture-templates
      '(("d" "default" plain
         #'org-roam-capture--get-point
         "%?"
         :file-name "%<%Y%m%d%H%M%S>-${slug}"
         :head "#+title: ${title}\n"
         :unnarrowed t)
        ("ll" "link note" plain
         #'org-roam-capture--get-point
         "* %^{Link}"
         :file-name "Inbox"
         :olp ("Links")
         :unnarrowed t
         :immediate-finish)
        ("lt" "link task" entry
         #'org-roam-capture--get-point
         "* TODO %^{Link}"
         :file-name "Inbox"
         :olp ("Tasks")
         :unnarrowed t
         :immediate-finish)))
;; initalize org trello after org mode TODO is this needed?
(use-package! org-trello
  :after (org-mode)
  )
;; set org-refile targets to also go to other files
(setq org-refile-targets
      '((nil :maxlevel . 3)
        (org-agenda-files :maxlevel . 3)))
;; set deft to my org directory TODO how do i fucking use a variable for this
(setq deft-directory "~/Dropbox/org")
;; msmtp config so it automatically chooses the right account from the From: field
(setq sendmail-program "/usr/bin/msmtp"
      send-mail-function 'smtpmail-send-it
      message-sendmail-f-is-evil t
      message-sendmail-extra-arguments '("--read-envelope-from")
      message-send-mail-function 'message-send-mail-with-sendmail)
;; config notmuch to use mbsync
(setq +notmuch-sync-backend 'mbsync)
;;tell org mode to ask me why I reschedule stuff
(setq org-log-reschedule 'note)
(defvar +notmuch-mail-folder "~/mail")
;; tell notmuch to not pop up in a side window
 (after! notmuch (set-popup-rule! "^\\*notmuch-hello" :ignore t))
;; telll notmuch to not lag out my emacs?
 (setq notmuch-show-indent-content nil)


(use-package! org-super-agenda
  :after org-agenda
  :init
  (setq org-super-agenda-groups '((:name "Today"
                                   :time-grid t
                                   :scheduled today)
                                  (:name "Due today"
                                   :deadline today)
                                  (:name "Important"
                                   :priority "A")
                                  (:name "Overdue"
                                   :deadline past)
                                  (:name "Due soon"
                                   :deadline future)
                                  (:name "Big Outcomes"
                                   :tag "bo")))
  :config
  (org-super-agenda-mode)
  )
(use-package! avy
  :init
  ;; allow avy to search through all windows currently on the frame
  (setq avy-all-windows t)
  )
(use-package! calibredb
  :defer t
  :config
  (setq calibredb-root-dir "~/gdrive/books/calibre")
  (setq calibredb-db-dir (expand-file-name "metadata.db" calibredb-root-dir))
  (setq calibredb-library-alist '(("~/gdrive/books/calibre")
                                  ("~/gdrive/books")
                                  ;;("~/Documents/LIB1")
                                  ;;("/Volumes/ShareDrive/Documents/Library/")
                                  ))
  )
;; Optional additional aesthetic changes
;; Adapted from `sanity.el' in Elegant Emacs by Nicolas P. Rougier (rougier)
;; https://github.com/rougier/elegant-emacs

(setq inhibit-startup-screen t)
(setq inhibit-startup-echo-area-message t)
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)
(setq initial-major-mode 'org-mode)
(setq-default indent-tabs-mode nil)
(setq pop-up-windows nil)
(tool-bar-mode 0)
(tooltip-mode  0)
(scroll-bar-mode 0)

;; Optional aditional aesthetic changes
;; Adapted from `elegance.el' in Elegant Emacs by Nicolas P. Rougier (rougier)
;; https://github.com/rougier/elegant-emacs

;; Line cursor and no blink
(set-default 'cursor-type  '(bar . 1))
(blink-cursor-mode 0)

;; Line spacing, can be 0 for code and 1 or 2 for text
(setq-default line-spacing 0)

;; Underline line at descent position, not baseline position
(setq x-underline-at-descent-line t)
