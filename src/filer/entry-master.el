;;; -*- coding: utf-8; lexical-binding: t -*-

(defun hbw--ensure-entry-object (data)
  "DATA が旧 XML ノード形式なら hbw-entry に変換、既に hbw-entry ならそのまま返す"
  (cond ((hbw-entry-p data) data)
        ;; 旧形式: XML ノード (entry ATTRS CHILDREN...)
        ((and (listp data) (eq 'entry (car data)))
         (hbw-entry-from-xml data))
        (t (error "不明なエントリーデータ形式: %S" data))))

(defun hatena-blog-writer-load-entry-master (user blog entry-id)
  "master.el から hbw-entry オブジェクトを読み込む。旧XML形式は自動変換。"
  (let* ((user-id (hbw--extract-id user))
         (blog-id (hbw--extract-id blog))
         (filename (hatena-blog-writer.entry.file-name.at-id "master" user-id blog-id entry-id)))
    (when (file-exists-p filename)
      (with-temp-buffer
        (insert-file-contents filename)
        (let ((data (read (buffer-string))))
          (hbw--ensure-entry-object data))))))

;;;
;;; hatena-blog-writer-load-all-entry-master
;;;
(defun hatena-blog-writer-load-all-entry-master (user blog)
  "全エントリーの master を読み込んで hbw-entry のリストを返す"
  (let ((entry-dirs (hatena-blog-writer-find-entry-dirs user blog)))
    (cl-loop for entry-id in entry-dirs
             for entry = (hatena-blog-writer-load-entry-master user blog entry-id)
             when entry
             collect entry)))
