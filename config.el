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
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; init noob mode
(menu-bar-mode 1)
;; set org-gcal, so I can read my calender inside Org-Mode PogU
;; TODO maybe get the secret from somewhere safe like pass or gpg2?
;; org-gcal sync
;; ref https://cestlaz.github.io/posts/using-emacs-26-gcal/

(require 'org-gcal)

;; Storing my creds in a secret file so I don't commit them here.
(require 'json)
(use-package! org-gcal
:init (defun get-gcal-config-value (key)
  "Return the value of the json file gcal_secret for key"
  (cdr (assoc key (json-read-file "~/.config/doom/gcal-secret.json")))
  )
:config (setq org-gcal-client-id (get-gcal-config-value 'org-gcal-client-id)
      org-gcal-client-secret (get-gcal-config-value 'org-gcal-client-secret)
      org-gcal-fetch-file-alist '((get-gcal-config-value 'org-gcal-email . "~/Dropbox/org/schedule.org"))
                                 ))
;; now set the org-files
(setq org-agenda-files (directory-files-recursively "~/Dropbox/org/" "^[^()]*org$"))
;; initalize org-clock-budget after org-clock is loaded
(use-package! org-clock-budget
  :after (org-clock)
  )
;; org-roam dir
(setq org-roam-directory "~/Dropbox/org/roam")
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
;;(setq sendmail-program "/usr/bin/msmtp"
;;      send-mail-function 'smtpmail-send-it
;;      message-sendmail-f-is-evil t
;;      message-sendmail-extra-arguments '("--read-envelope-from")
;;      message-send-mail-function 'message-send-mail-with-sendmail)
;; config notmuch to use mbsync
;;(setq +notmuch-sync-backend 'mbsync)
