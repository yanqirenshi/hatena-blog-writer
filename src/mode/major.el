;;; -*- coding: utf-8; lexical-binding: t -*-

(define-derived-mode
  hbw                       ;; 作りたいモード名
  nil                       ;; 親モード名
  "hbw"                     ;; モード行に表示するモード名の文字列
  "はてなブログ執筆モード") ;; このモードの説明文字列


(defun hatena-blog-writer ()
  (interactive)
  (let ((b (hatena-blog-writer-ensure-major-mode-buffer)))
    (switch-to-buffer (buffer-name b))
    (hatena-blog-writer-open-major-mode-buffer b)
    (message "Enjoy write blog!")))
