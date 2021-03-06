;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package);

;;(package! telega)
;; included in pdf module of doom
;;(package! pdf-tools)

;;(package! org-vcard)
;;(package! emacs-w3m)
;;(package! ebdb)
;;(package! gnorb)
;;(package! ebdb-gnorb)

;; included in biblio module of doom
;;(package! ivy-bibtex)
;; (package! org-gcal) might be included in dooms calendar module

;; budget my fucking time
(package! org-clock-budget
  :recipe (:host github :repo "Fuco1/org-clock-budget")
  )
;; TODO check out this package more
;;(package! org-clock-convenience)
;; clock in with counsel
(package! counsel-org-clock)
;; add support for trello TODO check how to config
(package! org-trello)
;; drill is anki for org
(package! org-drill)
;; super-agenda can group items
(package! org-super-agenda)

;; query language for org mode
(package! org-ql)
;; web archiver
(package! org-board)
;; more snippets more fun
(package! yasnippet-snippets)
;; getting academic citations from evil google
(package! gscholar-bibtex)
;; note taking scripts
(package! vulpea
  :recipe (:host github
           :repo "d12frosted/vulpea")
  )
;; google contact integration maybe?
(package! google-contacts)
;; vdir is like maildir but for contacts and calendars
(package! vdirel)
  ;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;(unpin! pinned-package)
;; ...or multiple packages
;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;(unpin! t)
