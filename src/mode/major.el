;;; -*- coding: utf-8; lexical-binding: t -*-

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; hatena-blog-writer メジャーモード定義
;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;
;; キーマップ
;;
(defvar hatena-blog-writer-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "l")   #'hbw-command-load)
    (define-key map (kbd "r")   #'hbw-command-refresh)
    (define-key map (kbd "R")   #'hbw-command-refresh-all)
    (define-key map (kbd "d")   #'hbw-command-diff)
    (define-key map (kbd "k")   #'hbw-command-remove)
    (define-key map (kbd "RET") #'hbw-command-open)
    (define-key map (kbd "q")   #'hbw-command-quit)
    (define-key map (kbd "?")   #'hbw-command-help)
    map)
  "hatena-blog-writer-mode のキーマップ")

;;
;; メジャーモード定義
;;
(define-derived-mode
  hatena-blog-writer-mode
  special-mode
  "hbw-mode"
  "はてなブログ執筆モード"
  (hl-line-mode 1))

;;
;; フック
;;
(defun hbw--mode-setup ()
  "メジャーモード初期化時のセットアップ"
  (message "Enjoy write blog!"))

(add-hook 'hatena-blog-writer-mode-hook #'hbw--mode-setup)

;;
;; エントリーポイント
;;
(defun hatena-blog-writer ()
  "hatena-blog-writer メジャーモードを起動する"
  (interactive)
  (let ((buffer (hatena-blog-writer-ensure-major-mode-buffer)))
    (hatena-blog-writer-render-buffer buffer)
    (switch-to-buffer buffer)))
