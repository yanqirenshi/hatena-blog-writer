;;; -*- coding: utf-8; lexical-binding: t -*-

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; hbw-entry のファイル保存
;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;
;;;; ファイルパス生成
;;;;
(defun hatena-blog-writer.entry.dir-name (user-id blog-id entry-id)
  "エントリーのディレクトリパスを返す（なければ作成）"
  (let ((dir-name (hatena-blog-writer.entry.dir.ensure user-id blog-id entry-id)))
    (unless (file-exists-p dir-name)
      (make-directory dir-name))
    dir-name))

(defun hatena-blog-writer.entry.file-name.at-id (type user-id blog-id entry-id)
  "TYPE (\"master\" or \"contents\") に応じたファイルパスを返す"
  (format "%s/%s"
          (hatena-blog-writer.entry.dir-name user-id blog-id entry-id)
          (cond ((string= "master" type) "master.el")
                ((string= "contents" type) "contents.md")
                (t (error "Bad type: %s" type)))))

(defun hbw-entry-file-path (type entry)
  "hbw-entry オブジェクトからファイルパスを返す"
  (hatena-blog-writer.entry.file-name.at-id type
                                             (hbw-entry-hatena-id entry)
                                             (hbw-entry-blog-id entry)
                                             (hbw-entry-id entry)))

;;;;
;;;; master の保存
;;;;
(defun hatena-blog-writer.entry.save.master (entry)
  "hbw-entry オブジェクトを master.el として保存する。
引数が XML entry の場合は hbw-entry に変換してから保存する。"
  (let ((obj (if (hbw-entry-p entry)
                 entry
               (hbw-entry-from-xml entry))))
    (let ((file (hbw-entry-file-path "master" obj)))
      (with-temp-buffer
        (setq save-buffer-coding-system 'utf-8-unix)
        (insert (format "%S" obj))
        (write-file file)))
    obj))

;;;;
;;;; contents の保存
;;;;
(defun hatena-blog-writer.entry.save.contents (entry)
  "hbw-entry オブジェクトの title と content を contents.md として保存する。
引数が XML entry の場合は hbw-entry に変換してから保存する。"
  (let ((obj (if (hbw-entry-p entry)
                 entry
               (hbw-entry-from-xml entry))))
    (let ((file (hbw-entry-file-path "contents" obj)))
      (with-temp-buffer
        (setq save-buffer-coding-system 'utf-8-unix)
        (insert (format "%s\n" (hbw-entry-title obj)))
        (insert (format "%s"   (hbw-entry-content obj)))
        (write-file file)))
    obj))
